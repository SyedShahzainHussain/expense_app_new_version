import 'package:expense_app_with_new_version/view_model/expense_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget/expense_widget.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseViewModel>(
      builder: (context, data, _) => data.expenseList.isEmpty
          ? const Center(
              child: Text("No Expenses Found!"),
            )
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: data.expenseList.length,
              itemBuilder: (context, index) {
                final expenses = data.expenseList;
                return Dismissible(
                  
                  background: Container(
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        borderRadius: BorderRadius.circular(4.0)),
                    margin: const EdgeInsets.only(
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ), // Background color when swiping
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) =>
                      data.clearExpense(expenses[index], context),
                  key: ValueKey(expenses[index]),
                  child: ExpensesWidget(expenses: expenses[index]),
                );
              }),
    );
  }
}
