import 'package:expand_tracker/Data/hive_database.dart';
import 'package:expand_tracker/Models/Expense_items.dart';
import 'package:flutter/material.dart';

import 'date_time.dart';

class ExpenseData extends ChangeNotifier {
  //list of all expense
  List<ExpensItem> overallExpenselist = [];

  //get all expense
  List<ExpensItem> getAllExpenselist() {
    return overallExpenselist;
  }

  //prepre data to display

  final db = HiveDatabase();
  void prepareData() {
    if (db.readdata().isNotEmpty) {
      overallExpenselist = db.readdata();
    }
  }

//enter new exoense
  void addNewExpense(ExpensItem newExpense) {
    overallExpenselist.add(newExpense);

    notifyListeners();
    db.saveData(overallExpenselist);
  }

  //delete expense
  void deleteExpense(ExpensItem expense) {
    overallExpenselist.remove(expense);

    notifyListeners();
    db.saveData(overallExpenselist);
  }

  //get weekday from datetime object

  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thr";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return '';
    }
  }

  //get the date for start of week

  DateTime startOfWeekDate() {
    DateTime today = DateTime.now();
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    return startOfWeek;
  }

  //summary of the day total

  Map<String, double> calculateDailysummaryExpense() {
    Map<String, double> dailyExpenseSummary = {
      //date(ddmmyy) = amountotalfor the day
    };
    for (var expense in overallExpenselist) {
      String date = convertDatetimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
