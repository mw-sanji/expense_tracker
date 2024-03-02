import 'package:expense_tracker/data/bar%20graph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Graph extends StatefulWidget {
  final DateTime startOfThewWeek;
  const Graph({super.key, required this.startOfThewWeek});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    double Max(ExpenseData value, String sunday, String monday, String tuesday,
        String wednesday, String thursday, String friday, String saturday) {
      List<double> total = [
        value.calculateTotalExpenses()[sunday] ?? 0,
        value.calculateTotalExpenses()[monday] ?? 0,
        value.calculateTotalExpenses()[tuesday] ?? 0,
        value.calculateTotalExpenses()[wednesday] ?? 0,
        value.calculateTotalExpenses()[thursday] ?? 0,
        value.calculateTotalExpenses()[friday] ?? 0,
        value.calculateTotalExpenses()[saturday] ?? 0,
      ];
      total.sort();
      double? max = 100;
      max = total.last * 1.1;
      return max == 0 ? 100 : max;
    }

    double calculateTotal(
        ExpenseData value,
        String sunday,
        String monday,
        String tuesday,
        String wednesday,
        String thursday,
        String friday,
        String saturday) {
      List<double> total = [
        value.calculateTotalExpenses()[sunday] ?? 0,
        value.calculateTotalExpenses()[monday] ?? 0,
        value.calculateTotalExpenses()[tuesday] ?? 0,
        value.calculateTotalExpenses()[wednesday] ?? 0,
        value.calculateTotalExpenses()[thursday] ?? 0,
        value.calculateTotalExpenses()[friday] ?? 0,
        value.calculateTotalExpenses()[saturday] ?? 0,
      ];
      double totalExpense = 0;
      for (int i = 0; i < total.length; i++) {
        totalExpense += total[i];
      }
      return totalExpense;
    }

    String sunday = ExpenseData()
        .FormattedDate(widget.startOfThewWeek.add(const Duration(days: 0)));
    String monday = ExpenseData()
        .FormattedDate(widget.startOfThewWeek.add(const Duration(days: 1)));
    String tuesday = ExpenseData()
        .FormattedDate(widget.startOfThewWeek.add(const Duration(days: 2)));
    String wednesday = ExpenseData()
        .FormattedDate(widget.startOfThewWeek.add(const Duration(days: 3)));
    String thursday = ExpenseData()
        .FormattedDate(widget.startOfThewWeek.add(const Duration(days: 4)));
    String friday = ExpenseData()
        .FormattedDate(widget.startOfThewWeek.add(const Duration(days: 5)));
    String saturday = ExpenseData()
        .FormattedDate(widget.startOfThewWeek.add(const Duration(days: 6)));
    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  const Text(
                    "Week Total: ",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                      NumberFormat.simpleCurrency(locale: "hi-IN").format(
                          calculateTotal(value, sunday, monday, tuesday,
                              wednesday, thursday, friday, saturday)),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Container(
              height: 220,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: BarGraph(
                  sunAmount: value.calculateTotalExpenses()[sunday] ?? 0,
                  monAmount: value.calculateTotalExpenses()[monday] ?? 0,
                  tueAmount: value.calculateTotalExpenses()[tuesday] ?? 0,
                  wedAmount: value.calculateTotalExpenses()[wednesday] ?? 0,
                  thuAmount: value.calculateTotalExpenses()[thursday] ?? 0,
                  friAmount: value.calculateTotalExpenses()[friday] ?? 0,
                  satAmount: value.calculateTotalExpenses()[saturday] ?? 0,
                  maxY: Max(value, sunday, monday, tuesday, wednesday, thursday,
                      friday, saturday)),
            ),
          ],
        );
      },
    );
  }
}
