import 'package:expense_tracker/models/expense_model.dart';
import 'package:hive/hive.dart';

class HiveDatabase {
  var db = Hive.box("expense_database");
  List<Expense> readData() {
    List savedItems = db.get("ALL_EXPENSES") ?? [];
    List<Expense> expenses = [];
    for (int i = 0; i < savedItems.length; i++) {
      Expense expense = Expense(
          name: savedItems[i][0],
          expense: savedItems[i][1],
          dateTime: savedItems[i][2]);
      expenses.add(expense);
    }
    return expenses;
  }

  void svaData(List<Expense> expenses) {
    List<List<dynamic>> allformattedExpenses = [];
    for (var expense in expenses) {
      List<dynamic> currentExpense = [
        expense.name,
        expense.expense,
        expense.dateTime
      ];
      allformattedExpenses.add(currentExpense);
    }
    db.put("ALL_EXPENSES", allformattedExpenses);
  }
}
