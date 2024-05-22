import 'dart:io';

import 'package:expense_app_with_new_version/view_model/expense_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/expense_model.dart';

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({super.key});

  @override
  State<NewExpenseScreen> createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? category;

  Future<void> _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
      initialDate: now,
    );
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void showDialogs() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        useSafeArea: true,
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  _save() {
    final enterAmount = double.tryParse(_amountController.text);

    final amountIsInvalid = enterAmount == null || enterAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null ||
        category == null) {
      showDialogs();
      return;
    }
    final expenseModel = ExpenseModel(
      title: _titleController.text.trim(),
      amount: enterAmount,
      datetime: _selectedDate!,
      category: category!,
    );
    Provider.of<ExpenseViewModel>(context, listen: false)
        .addExpense(expenseModel);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(builder: (context, constrant) {
      final width = constrant.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboard + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TitleFieldWidget(
                            isDarkMode: isDarkMode,
                            titleController: _titleController),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: AmountFieldWidget(
                            isDarkMode: isDarkMode,
                            amountController: _amountController),
                      ),
                    ],
                  ),
                if (width <= 600)
                  TitleFieldWidget(
                      isDarkMode: isDarkMode,
                      titleController: _titleController),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton<Category?>(
                        value: category,
                        hint: const Text("Category"),
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            category = value;
                          });
                        },
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                          ),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: Icon(
                              Icons.calendar_month,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                if (width <= 600)
                  Row(
                    children: [
                      Expanded(
                        child: AmountFieldWidget(
                            isDarkMode: isDarkMode,
                            amountController: _amountController),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                          ),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: Icon(
                              Icons.calendar_month,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (width <= 600)
                      DropdownButton<Category?>(
                        value: category,
                        hint: const Text("Category"),
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            category = value;
                          });
                        },
                      ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _save,
                      child: const Text('Save Expense'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class AmountFieldWidget extends StatelessWidget {
  const AmountFieldWidget({
    super.key,
    required this.isDarkMode,
    required TextEditingController amountController,
  }) : _amountController = amountController;

  final bool isDarkMode;
  final TextEditingController _amountController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixText: '\$ ',
        label: Text('Amount'),
      ),
    );
  }
}

class TitleFieldWidget extends StatelessWidget {
  const TitleFieldWidget({
    super.key,
    required this.isDarkMode,
    required TextEditingController titleController,
  }) : _titleController = titleController;

  final bool isDarkMode;
  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
      controller: _titleController,
      maxLength: 50,
      decoration: const InputDecoration(
        label: Text('Title'),
      ),
    );
  }
}
