import 'package:expense_repository/expense_repository.dart';
import 'package:expenses_tracker_project/screens/home/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:expenses_tracker_project/screens/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Color(0xFFE5E5E5),
          onBackground: Colors.black,
          primary: Color(0xFF4ECCA3),
          secondary: Color(0xFF232931),
          tertiary: Color(0xFFEEEEEE),
          outline: Colors.grey,
        ),
      ),
      home: BlocProvider(
        create: (context) => GetExpensesBloc(FirebaseExpenseRepo())..add(GetExpenses()),
        child: const HomeScreen(),
      ),
    );
  }
}
