import 'package:expand_tracker/Data/expense_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Models/Expense_items.dart';

class HiveDatabase {
  // reference of box
  final _mybox = Hive.box("expense_database2");

  // write data
  void saveData(List<ExpensItem> allExpense) {
    List<List<dynamic>> allExpenseFormeted = [];
    // convert all item to storbale fom of database
    for (var expense in allExpense) {
      List<dynamic> ExpenseFormated = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];
      allExpenseFormeted.add(ExpenseFormated);
    }
    _mybox.put("All_EXPENSES", allExpenseFormeted);
  }

  //read data
  List<ExpensItem> readdata() {
    List savedExpense = _mybox.get("All_EXPENSES") ?? [];
    List<ExpensItem> allExpense = [];
    //collect indivual data
    for (int i = 0; i < savedExpense.length; i++) {
      String name = savedExpense[i][0];
      String amount = savedExpense[i][1];
      var dateTime2 = savedExpense[i][2];
      ExpensItem expense =
          ExpensItem(name: name, amount: amount, dateTime: savedExpense[i][2]);
      allExpense.add(expense);
    }
    return allExpense;
  }
}
