import 'dart:developer';

import 'package:expense_app/models/expense/expense_data_model.dart';
import 'package:expense_app/views_model/services/database_sql.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  Future<List<ExpenseDataModel>> readExpenseData() async {
    update();
    Database dbUser = await SQLDatabase().db;
    try {
      List<Map<String, dynamic>> result =
          await dbUser.rawQuery("SELECT * FROM expenses ORDER BY date DESC");

      List<ExpenseDataModel> expenseList =
          result.map((map) => ExpenseDataModel.fromJson(map)).toList();
      return expenseList;
    } catch (_) {
      return [];
    }
  }

  deleteExpenseData(int id) async {
    Database dbUser = await SQLDatabase().db;
    try {
      dbUser.rawDelete("DELETE FROM expenses WHERE id=?", [id]);
      update();
    } catch (e) {
      log(e.toString());
    }
  }
}
