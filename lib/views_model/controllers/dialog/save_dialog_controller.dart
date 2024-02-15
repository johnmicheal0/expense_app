import 'package:expense_app/models/expense/expense_data_model.dart';
import 'package:expense_app/views_model/controllers/dialog/datetime_controller.dart';
import 'package:expense_app/views_model/services/database_sql.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class SaveDialogController extends DateTimeController {
  Position? _currentPosition;
  String address = '';

  final product = TextEditingController();
  final price = TextEditingController();
  TextEditingController location = TextEditingController();

  @override
  void onInit() {
    getCurrentLocation()
        .then((value) => location = TextEditingController(text: address));
    dateTime.value = DateFormat('EEE MMM dd h mm a').format(DateTime.now());
    update();
    super.onInit();
  }

  Future<String> checkLocationPermission() async {
    var status = await Permission.location.request();
    switch (status) {
      case PermissionStatus.granted:
        return "Location Permission Access Granted";
      case PermissionStatus.denied:
        return "Location Permission denied";
      case PermissionStatus.permanentlyDenied:
        return "Location Permission Permanently denied";
      default:
        return "Failed";
    }
  }

  Future<void> getCurrentLocation() async {
    final status = await checkLocationPermission();
    if (status == "Location Permission Access Granted") {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double latitude = _currentPosition!.latitude;
      double longitude = _currentPosition!.longitude;
      List<Placemark> marks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = marks[0];
      address = "${place.street}, ${place.locality}, ${place.country}";
      update();
    } else {
      Get.snackbar("Message", status);
      checkLocationPermission();
    }
  }

  Future<void> insertExpenseData() async {
    ExpenseDataModel data = ExpenseDataModel(
        product: product.text,
        price: double.parse(price.text),
        date: dateTime.value,
        location: location.text);

    final dbUser = await SQLDatabase().db;
    try {
      await dbUser.rawInsert(
          "INSERT INTO expenses(product,price,date,location)VALUES(?,?,?,?)", [
        data.product,
        data.price,
        data.date,
        data.location,
      ]);
      Get.snackbar("Message", 'Data Inserted');
      product.clear();
      price.clear();
      location.clear();
      Navigator.pop(Get.context!);
    } on Exception catch (_) {
      Get.snackbar("Message", 'Error');
    }
  }
}
