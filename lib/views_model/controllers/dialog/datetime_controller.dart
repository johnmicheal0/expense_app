import 'package:expense_app/views/components/text_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeController extends GetxController {
  RxString dateTime =
      DateFormat('EEE MMM dd h mm a').format(DateTime.now()).obs;
  late DateTime _setTime;

  dateTimePickerDialog(BuildContext context) {
    return showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        content: SizedBox(
          height: 150.h,
          width: double.infinity,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (val) {
              _setTime = val;
            },
          ),
        ),
        insetAnimationCurve: Curves.bounceIn,
        insetAnimationDuration: const Duration(seconds: 3),
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
                text: "Default",
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              dateTime.value = DateFormat('EEE MMM dd h mm a').format(_setTime);
              Get.back();
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
      ),
    );
  }
}
