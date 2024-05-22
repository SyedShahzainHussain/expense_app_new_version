import 'package:expense_app_with_new_version/model/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseViewModel with ChangeNotifier {
  final List<ExpenseModel> _expenseList = [];
  List<ExpenseModel> get expenseList => [..._expenseList];

  void addExpense(ExpenseModel expenseModel) {
    _expenseList.add(expenseModel);
    notifyListeners();
  }

  void clearExpense(ExpenseModel expenseModel, BuildContext context) {
    final index = _expenseList.indexOf(expenseModel);

    _expenseList.remove(expenseModel);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              _expenseList.insert(index, expenseModel);
              notifyListeners();
            }),
      ),
    );
    notifyListeners();
  }

  double get totalExpense {
    double sum = 0;
    for (final expense in _expenseList) {
      sum += expense.amount;
    }
    return sum;
  }
}
