import 'package:expense_app/models/update/update_expense.dart';
import 'package:expense_app/views/components/text_component.dart';
import 'package:expense_app/views/components/textfield_component.dart';
import 'package:expense_app/views_model/controllers/dialog/datetime_controller.dart';
import 'package:expense_app/views_model/controllers/dialog/update_dialog_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdateDataDialog extends StatelessWidget {
  UpdateDataDialog({super.key, required this.oldData});
  final UpdateExpense oldData;

  final dateTimeController = Get.put(DateTimeController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateDataDialogController>(
        init: UpdateDataDialogController(updateData: oldData),
        builder: (controller) {
          return AlertDialog.adaptive(
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldComponent(
                      controller: controller.product,
                      border: const UnderlineInputBorder(),
                      hintText: 'Product'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFieldComponent(
                        controller: controller.price,
                        border: const UnderlineInputBorder(),
                        hintText: 'Price'),
                  ),
                  Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextComponent(
                        text: controller.updateData.time.toString()),
                  )),
                  Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextComponent(
                        text: controller.updateData.location.toString()),
                  ))
                ],
              ),
            ),
            insetAnimationCurve: Curves.bounceIn,
            insetAnimationDuration: const Duration(seconds: 3),
            title: TextComponent(
              text: "ADD YOUR TODAY EXPENSE".toLowerCase(),
              fontWeight: FontWeight.w700,
              size: 16.sp,
            ),
            titlePadding: const EdgeInsets.all(20),
            actions: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: const Color.fromARGB(255, 37, 82, 118)),
                  child: const TextComponent(
                    text: "Cancel",
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    controller.updateExpenseData().whenComplete(() {
                      Get.back();
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: const Color.fromARGB(255, 37, 82, 118)),
                  child: const TextComponent(
                    text: "Save",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
