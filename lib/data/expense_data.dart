import 'package:expense_tracker/data/hive/hive_database.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  //list of all expenses
  List<Expense> _allExpenses = [];

  //get list of all expenses
  List<Expense> getAllExpenses() {
    return _allExpenses;
  }

  final db = HiveDatabase();

  //get data from HiveDatabase
  void initData() {
    if (db.readData().isNotEmpty) {
      _allExpenses = db.readData();
    }
  }

  //add an expense
  void addExpense(Expense expense) {
    _allExpenses.add(expense);
    notifyListeners();
    db.svaData(_allExpenses);
  }

  //update expense
  void updateExpense(
      Expense expense, String expenseName, String expenseNumber) {
    for (int i = 0; i < _allExpenses.length; i++) {
      if (_allExpenses[i].name == expense.name) {
        _allExpenses[i].name = expenseName;
        _allExpenses[i].expense = expenseNumber;
        _allExpenses[i].dateTime = DateTime.now();
      }
    }
    notifyListeners();
    db.svaData(_allExpenses);
  }

  //delete expenses
  void deleteExpenses(Expense expense) {
    _allExpenses.remove(expense);
    notifyListeners();
    db.svaData(_allExpenses);
  }

  //get the day from the week
  String getDayofTheWeek(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Sun";
      case 2:
        return "Mon";
      case 3:
        return "Tue";
      case 4:
        return "Wen";
      case 5:
        return "Thu";
      case 6:
        return "Fri";
      case 7:
        return "Sat";
      default:
        return '';
    }
  }

  //get the nearest Sunday
  DateTime getNearestSunday() {
    DateTime? nearestSunday;
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getDayofTheWeek(today.subtract(Duration(days: i))) == "Sun") {
        nearestSunday = today.subtract(Duration(days: i));
      }
    }
    return nearestSunday!;
  }

  //get Date in yyyymmdd format
  String FormattedDate(DateTime dateTime) {
    String year = dateTime.year.toString();
    String month = dateTime.month.toString();
    if (month.length == 1) {
      month = '0' + month;
    }
    String day = dateTime.day.toString();
    if (day.length == 1) {
      day = '0' + day;
    }
    return year + month + day;
  }

  //adds all the daily expenses
  Map<String, double> calculateTotalExpenses() {
    Map<String, double> dailyExpense = {};
    for (var expense in _allExpenses) {
      String date = FormattedDate(expense.dateTime);
      double exp = double.parse(expense.expense);
      if (dailyExpense.containsKey(date)) {
        double currentAmount = dailyExpense[date]!;
        currentAmount += exp;
        dailyExpense[date] = currentAmount;
      } else {
        dailyExpense.addAll({date: exp});
      }
    }
    return dailyExpense;
  }
}
