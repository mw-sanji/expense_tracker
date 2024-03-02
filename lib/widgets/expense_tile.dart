import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/utils/colors.dart';
import 'package:expense_tracker/widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ExpenseTile extends StatefulWidget {
  final Expense expenseData;
  final String name;
  final String expense;
  final DateTime date;
  void Function(BuildContext)? deleteAction;
  TextEditingController namecontroller;
  TextEditingController amountcontroller;
  ExpenseTile(
      {super.key,
      required this.name,
      required this.expense,
      required this.date,
      required this.expenseData,
      required this.deleteAction,
      required this.namecontroller,
      required this.amountcontroller});

  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              showDialog(
                context: context,
                builder: (context) {
                  widget.namecontroller.text = widget.expenseData.name;
                  return DialogBox(
                      expense: widget.expenseData,
                      namecontroller: widget.namecontroller,
                      amountcontroller: widget.amountcontroller);
                },
              );
            },
            icon: Icons.edit_outlined,
            backgroundColor: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
          SlidableAction(
            onPressed: widget.deleteAction,
            icon: Icons.delete_outline,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
        ]),
        child: Container(
          decoration: BoxDecoration(
              color: AllColors.secondaryColor,
              borderRadius: BorderRadius.circular(5)),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${widget.date.day}/${widget.date.month}/${widget.date.year}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            trailing: Text(
                NumberFormat.simpleCurrency(locale: "hi-IN")
                    .format(double.parse(widget.expense)),
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
