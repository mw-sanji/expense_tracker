// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expense_tracker/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/utils/colors.dart';

// ignore: must_be_immutable
class DialogBox extends StatefulWidget {
  Expense expense;
  TextEditingController namecontroller;
  TextEditingController amountcontroller;
  DialogBox({
    Key? key,
    required this.expense,
    required this.namecontroller,
    required this.amountcontroller,
  }) : super(key: key);

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    void update() {
      if (widget.amountcontroller.text.isNotEmpty &&
          widget.namecontroller.text.isNotEmpty) {
        widget.namecontroller.text = widget.expense.name;
        Provider.of<ExpenseData>(context, listen: false).updateExpense(
            widget.expense,
            widget.namecontroller.text,
            widget.amountcontroller.text);
      }
      Navigator.pop(context);
    }

    void cancel() {
      Navigator.pop(context);
    }

    return AlertDialog(
      backgroundColor: AllColors.secondaryColor,
      title: const Text("Add Expense", style: TextStyle(color: Colors.white)),
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
                readOnly: true,
                style: const TextStyle(color: Colors.white),
                controller: widget.namecontroller,
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
                controller: widget.amountcontroller,
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
            onPressed: update,
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
  }
}
