import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  /*var _enteredTitle = '';
  void _saveTitleInput(String inputValue) {
    _enteredTitle = inputValue;
  }*/

  final _titleController =
      TextEditingController(); //* Use this controller for saving information written by the user
  final _numberController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _submitEspenseData() {
    final enteredAmount =
        double.tryParse(_numberController.text); // tryParse('hello') => null
    final amountIsInvalid = (enteredAmount == null || enteredAmount <= 0);

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // show error message
    }
  }

  void _presentDatePicker() async {
    //* Please pay attention to that async it lets you wait for some stuff happenning inside the function
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _numberController
        .dispose(); //* Always dispose the controller after using it
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            // onChanged: _saveTitleInput,
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  // onChanged: _saveTitleInput,
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                  //maxLength: 50,
                  decoration: const InputDecoration(
                    prefixText: 'KRW ',
                    label: Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No Selected Date'
                        : formatter.format(_selectedDate!),
                  ), //*This line is a bit weird to understand but has a lot of sense.
                  //* Check section 5 module 114 min 7:00
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(Icons.calendar_month),
                  )
                ],
              ))
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _submitEspenseData,
                child: const Text("Save expense"),
              )
            ],
          )
        ]));
  }
}
