import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema",
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  void _openAddExpenseOverlay() {
    //* This is quite interesting because it kind of opens a new screen without having to change the widget
    //* Search about showModalBottomSheet if you forgot, this is quite useful
    showModalBottomSheet(
        context: context, builder: (ctx) => const NewExpense());
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text("The chart"),
          Expanded(
            child: ExpensesList(
              expenses: _registeredExpenses,
            ),
          ),
        ],
      ),
    );
  }
}
