import 'package:flutter/material.dart';

import '../../../model/expense_model.dart';

class ExpensesWidget extends StatelessWidget {
  const ExpensesWidget({
    super.key,
    required this.expenses,
  });

  final ExpenseModel expenses;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenses.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text("\$${expenses.amount.toStringAsFixed(2)}"),
                const Spacer(),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(categoryIcon[expenses.category])),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expenses.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
