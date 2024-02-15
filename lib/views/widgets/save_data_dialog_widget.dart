import 'package:expense_app/views/components/text_component.dart';
import 'package:expense_app/views/components/textfield_component.dart';
import 'package:expense_app/views_model/controllers/dialog/datetime_controller.dart';
import 'package:expense_app/views_model/controllers/dialog/save_dialog_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SaveDataDialog extends StatelessWidget {
  SaveDataDialog({super.key});

  final dateTimeController = Get.put(DateTimeController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaveDialogController>(
        init: SaveDialogController(),
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
                        keyboardType: TextInputType.number,
                        hintText: 'Price'),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => TextComponent(
                            text: dateTimeController.dateTime.value)),
                        TextButton.icon(
                            onPressed: () {
                              dateTimeController.dateTimePickerDialog(context);
                            },
                            icon: const Icon(Icons.edit),
                            label: const TextComponent(text: 'Edit')),
                      ],
                    ),
                  ),
                  TextFieldComponent(
                      controller: controller.location,
                      border: const UnderlineInputBorder(),
                      hintText: 'Location'),
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
                    controller.insertExpenseData();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: const Color.fromARGB(255, 37, 82, 118)),
                  child: const TextComponent(text: "Save", color: Colors.white),
                ),
              ),
            ],
          );
        });
  }
}
