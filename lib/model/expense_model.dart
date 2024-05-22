import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uid = Uuid();
final formatter = DateFormat.yMd();

// ! enum is a set of constant name value where we add predefined possible value
enum Category { food, travel, work, leisure }

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class ExpenseModel {
  String id;
  String title;
  double amount;
  DateTime datetime;
  Category category;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.datetime,
    required this.category,
  }) : id = uid.v4();

  String get formattedDate => formatter.format(datetime);
}

class ExpenseBucket {
  final Category category;
  final List<ExpenseModel> expenseModel;
  ExpenseBucket(this.category, this.expenseModel);

  ExpenseBucket.forCategory(List<ExpenseModel> allExpenses, this.category)
      : expenseModel = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenseModel) {
      sum += expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}
