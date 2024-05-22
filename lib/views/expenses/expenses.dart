import 'package:expense_app_with_new_version/view_model/expense_view_model.dart';
import 'package:expense_app_with_new_version/views/new_expense_screen/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../chart_screen/chart_screen.dart';
import '../expense_screen/expense_screen.dart';

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    void openAddExpenseOverlay() {
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const NewExpenseScreen();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expenses Tracker App",
        ),
        actions: [
          IconButton(
              onPressed: openAddExpenseOverlay,
              icon: const Icon(
                Icons.add,
              ))
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                // ! Chart
                Consumer<ExpenseViewModel>(
                  builder: (context, value, _) => ChartScreen(
                    expenses: value.expenseList,
                  ),
                ),
                // ! Expense
                const Expanded(child: ExpenseScreen())
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ! Chart
                Consumer<ExpenseViewModel>(
                  builder: (context, value, _) => Expanded(
                    child: ChartScreen(
                      expenses: value.expenseList,
                    ),
                  ),
                ),
                // ! Expense
                const Expanded(child: ExpenseScreen())
              ],
            ),
    );
  }
}
