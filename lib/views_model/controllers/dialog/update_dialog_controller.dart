import 'dart:developer';
import 'package:expense_app/models/update/update_expense.dart';
import 'package:expense_app/views_model/controllers/dialog/save_dialog_controller.dart';
import 'package:expense_app/views_model/services/database_sql.dart';
import 'package:get/get.dart';

class UpdateDataDialogController extends SaveDialogController {
  UpdateDataDialogController({required this.updateData});
  final UpdateExpense updateData;

  @override
  void onInit() {
    super.onInit();
    super.product.text = updateData.product.toString();
    super.price.text = updateData.price.toString();
    update();
  }

  Future<void> updateExpenseData() async {
    UpdateExpense data = UpdateExpense(
      id: updateData.id,
      product: product.text,
      price: double.parse(price.text),
    );

    final dbUser = await SQLDatabase().db;
    try {
      dbUser.rawUpdate("UPDATE expenses SET product=?,price=? WHERE id=?",
          [data.product, data.price, data.id]).whenComplete(() {
        Get.snackbar("Message", 'Data Updated');
        product.clear();
        price.clear();
      });
    } catch (e) {
      log(e.toString());
      Get.snackbar("Message", 'Error');
    }
  }
}
