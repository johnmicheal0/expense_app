import 'package:expense_app/views/components/text_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get.dart';
import 'package:expense_app/models/expense/expense_data_model.dart';
import 'package:expense_app/views/widgets/save_data_dialog_widget.dart';
import 'package:expense_app/views/widgets/update_data_dialog_widget.dart';
import 'package:expense_app/models/update/update_expense.dart';
import 'package:expense_app/views_model/controllers/home/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const TextComponent(
                fontWeight: FontWeight.w700,
                text: "Expense App",
                color: Color.fromARGB(255, 62, 102, 135),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showAdaptiveDialog(
                    context: context,
                    builder: (context) => SaveDataDialog()).whenComplete(
                  () {
                    controller.readExpenseData();
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.readExpenseData();
                },
                child: FutureBuilder<List<ExpenseDataModel>?>(
                  future: controller.readExpenseData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return TextComponent(text: snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              showAdaptiveDialog(
                                      context: context,
                                      builder: (context) => UpdateDataDialog(
                                          oldData: UpdateExpense(
                                              id: data.id!.toInt(),
                                              product: data.product!,
                                              price: data.price!.toDouble(),
                                              time: data.date!,
                                              location: data.location!)))
                                  .whenComplete(
                                      () => controller.readExpenseData());
                            },
                            child: Dismissible(
                              key: ValueKey<int>(data.id!),
                              onDismissed: (v) {
                                controller.deleteExpenseData(data.id!);
                              },
                              background: const Card(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              child: Card(
                                child: ListTile(
                                    title: TextComponent(
                                        text: data.product.toString()),
                                    subtitle: TextComponent(
                                        text: data.price.toString()),
                                    trailing: TextComponent(
                                        text: data.date.toString())),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            )),
      ),
    );
  }
}
