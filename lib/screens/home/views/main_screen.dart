import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatelessWidget {
  final List<Expense> expenses;
  const MainScreen({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            //Aqui se muestra el circulo de la foto de perfil y el nombre del usuario, y a la derecha el icono de configuracion
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Se crea un row para poder poner el circulo de la foto de perfil y el nombre del usuario a la izquierda
                Row(
                  children: [
                    //Aqui se muestra el circulo de la foto de perfil
                    Stack(
                      alignment: Alignment.center,
                      children: [ 
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [                                
                                Theme.of(context).colorScheme.secondary,                                
                                Theme.of(context).colorScheme.primary,
                              ],
                              transform: const GradientRotation(pi / 1.5),
                            ),
                          ),
                        ),
                        Icon(
                          CupertinoIcons.person_fill,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    //Aqui se muestra el nombre del usuario
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bienvenido!', 
                        style: TextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.w600, 
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        ),
                        Text('Enrique Valdiviezo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        ),
                      ],
                    ),
                      ],
                    ),
                    //Aqui se muestra el icono de configuracion fuera de las columnas para poder separarlo de las columnas y ponerlo a la derecha
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                        size: 35,
                      ),
                    ),
              ],
            ),
            const SizedBox(height: 20),
            //Contenedor tipo tarjeta para mostrar el balance total
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width /2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.tertiary,
                  ],
                  transform: const GradientRotation(pi / 4),
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    offset: const Offset(5, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Balance Total',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('\$ 5000.00',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                color: Colors.white30,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                CupertinoIcons.arrow_up,
                                size: 15,
                                color: Colors.greenAccent,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ingresos',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '\$ 2750.00', 
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                color: Colors.white30,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                CupertinoIcons.arrow_down,
                                size: 15,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gastos',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '\$ ${expenses.fold<num>(0, (sum, e) => sum + e.amount)}.00',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //Aqui termina el contenedor tipo tarjeta
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Transacciones',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text('Ver todas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  ),
                )
              ]
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, int i) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color(expenses[i].category.color),
                                    shape: BoxShape.circle,
                                  ),
                                  ),
                                  Image.asset('assets/${expenses[i].category.icon}.png', scale: 2),
                                ],
                              ),
                              const SizedBox(width: 12),
                              Text(
                                    expenses[i].category.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                              ),
                            ],
                          ),
                                               
                          Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$${expenses[i].amount}',
                                    style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).colorScheme.onBackground,
                                  ),
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(expenses[i].date),
                                    style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                                  ),
                                ],
                              )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
