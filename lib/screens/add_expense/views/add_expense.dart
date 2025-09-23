import 'package:expense_repository/expense_repository.dart';
import 'package:expenses_tracker_project/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:expenses_tracker_project/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:expenses_tracker_project/screens/add_expense/views/category_creation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController amountController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  //DateTime selectedDate = DateTime.now(); //fecha seleccionada

  late Expense expense;
  bool isLoading = false;

  @override
  void initState() {
    dateController.text = DateFormat(
      'dd/MM/yyyy',
    ).format(DateTime.now()); //fecha actual
    expense = Expense.empty;
    expense.expenseId = const Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
         if(state is CreateExpenseSuccess) {
          Navigator.pop(context, expense);
        } else if(state is CreateExpenseLoading) {
          setState(() {
            isLoading = true; 
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
            builder: (context, state) {
              if (state is GetCategoriesSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Agregar gasto',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: amountController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              FontAwesomeIcons.dollarSign,
                              size: 16,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        controller: categoryController,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        onTap: () {},
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              expense.category == Category.empty
                                  ? Colors.white
                                  : Color(expense.category.color),
                          prefixIcon:
                              expense.category == Category.empty
                                  ? Icon(
                                    FontAwesomeIcons.list,
                                    size: 16,
                                    color: Colors.grey,
                                  )
                                  : Image.asset(
                                    'assets/${expense.category.icon}.png',
                                    scale: 2,
                                  ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              var newCategory = await getCategoryCreation(
                                context,
                              );
                              setState(() {
                                state.categories.insert(0, newCategory);
                              });
                            },
                            icon: Icon(
                              FontAwesomeIcons.plus,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: 'Categoria',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        //color: Colors.red,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: state.categories.length,
                            itemBuilder: (context, int i) {
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      expense.category = state.categories[i];
                                      categoryController.text =
                                          state.categories[i].name;
                                    });
                                  },
                                  leading: Image.asset(
                                    'assets/${state.categories[i].icon}.png',
                                    scale: 2,
                                  ),
                                  title: Text(state.categories[i].name),
                                  tileColor: Color(state.categories[i].color),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: dateController,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: expense.date,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );

                          if (newDate != null) {
                            setState(() {
                              dateController.text = DateFormat(
                                'dd/MM/yyyy',
                              ).format(newDate);
                              // selectDate = newDate;
                              expense.date = newDate;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            FontAwesomeIcons.calendarDays,
                            size: 16,
                            color: Colors.grey,
                          ),
                          hintText: 'Fecha',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: kToolbarHeight,
                        child: isLoading ? const Center(child: CircularProgressIndicator()) : TextButton(
                          onPressed: () {
                            setState(() {
                              expense.amount = int.parse(amountController.text);
                            });

                            context.read<CreateExpenseBloc>().add(
                              CreateExpense(expense),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Guardar',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
