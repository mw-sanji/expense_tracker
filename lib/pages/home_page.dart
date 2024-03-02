import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/utils/colors.dart';
import 'package:expense_tracker/widgets/expense_tile.dart';
import 'package:expense_tracker/widgets/graph.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _namecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).initData();
  }

  void save() {
    if (_namecontroller.text.isNotEmpty && _amountcontroller.text.isNotEmpty) {
      Expense expense = Expense(
          name: _namecontroller.text,
          expense: _amountcontroller.text,
          dateTime: DateTime.now());
      Provider.of<ExpenseData>(context, listen: false).addExpense(expense);

      _amountcontroller.clear();
      _namecontroller.clear();
    }
    Navigator.pop(context);
  }

  void cancel() {
    Navigator.pop(context);
    _amountcontroller.clear();
    _namecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: AllColors.secondaryColor,
                    title: const Text("Add Expense",
                        style: TextStyle(color: Colors.white)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AllColors.primaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: _namecontroller,
                              decoration: const InputDecoration(
                                  hintText: "Enter Expense Name",
                                  hintStyle: TextStyle(color: Colors.white70),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AllColors.primaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: _amountcontroller,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: "Enter Expense Amount",
                                  hintStyle: TextStyle(color: Colors.white70),
                                  border: InputBorder.none),
                            ),
                          ),
                        )
                      ],
                    ),
                    actions: [
                      MaterialButton(
                          onPressed: save,
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          )),
                      MaterialButton(
                          onPressed: cancel,
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
          backgroundColor: AllColors.primaryColor,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25, top: 25),
                  child: Center(
                      child: Text(
                    "ExpenseTracker",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Graph(startOfThewWeek: value.getNearestSunday()),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.getAllExpenses().length,
                    itemBuilder: (context, index) {
                      return value.getAllExpenses().isEmpty
                          ? const Center(
                              child: Text(
                              "Add an Expense by clicking on + Button below",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ))
                          : ExpenseTile(
                              namecontroller: _namecontroller,
                              amountcontroller: _amountcontroller,
                              deleteAction: (context) {
                                value.deleteExpenses(
                                    value.getAllExpenses()[index]);
                              },
                              expenseData: value.getAllExpenses()[index],
                              name: value.getAllExpenses()[index].name,
                              expense: value.getAllExpenses()[index].expense,
                              date: value.getAllExpenses()[index].dateTime);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
