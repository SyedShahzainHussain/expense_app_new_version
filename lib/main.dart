import 'package:expense_app_with_new_version/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_model/expense_view_model.dart';
import 'views/expenses/expenses.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpenseViewModel(),
      child: MaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: SAppTheme.lightTheme,
        darkTheme: SAppTheme.darkTheme,
        home: const Expenses(),
      ),
    );
  }
}
