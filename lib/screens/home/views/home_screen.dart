import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:expenses_tracker_project/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:expenses_tracker_project/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:expenses_tracker_project/screens/add_expense/views/add_expense.dart';
import 'package:expenses_tracker_project/screens/home/views/main_screen.dart';
import 'package:expenses_tracker_project/screens/stats/stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: ClipRRect(
        //Para poder darle un borde superior al bottomNavigationBar, lo encerramos en un ClipRRect
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          selectedItemColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Colors.white,
          //Funciones de abajo para mostrar u ocultar los labels
          //showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 3,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.graph_square_fill),
              label: 'Graphs',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create:
                            (context) =>
                                CreateCategoryBloc(FirebaseExpenseRepository()),
                      ),
                      BlocProvider(create: (context) => GetCategoriesBloc(FirebaseExpenseRepository())..add(GetCategories())),
                    ],
                    child: const AddExpense(),
                  ),
            ),
          );
        },
        shape: const CircleBorder(),
        child: Container(
          //Para darle un gradiente circular al FloatingActionButton
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.tertiary,
              ],
              transform: const GradientRotation(pi / 4),
            ),
          ),
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      body: index == 0 ? const MainScreen() : const StatsScreen(),
    );
  }
}
