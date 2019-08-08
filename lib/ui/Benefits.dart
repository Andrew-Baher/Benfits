import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';
import 'CurrentCategory.dart';
import 'MainApp.dart';

class Benefits extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState1();
  }
}

class _MyAppState1 extends State<Benefits> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.count(
          // Create a grid with 3 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 8 widgets that display their index in the List.
          children: List.generate(items.length, (index) {
            return Center(
              child: Column(
                children: [
                  Text(
                    items[index],
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      currentCategory=items[index];
                      mainAppState.openAnotherTab(0);
                    },
                    child: Image.asset(assets[index],
                        height: MediaQuery.of(context).size.width / 3.5,
                        width: MediaQuery.of(context).size.width / 3.5),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

List<String> items = [
  'Shopping',
  'Transportation',
  'Medical',
  'Vacation',
  'Hotels',
  'Restaurants',
  'Grocery',
  'Dessert'
];

List<String> assets = [
  'assets/Shopping.png',
  'assets/Mwslaat.png',
  'assets/Medicals.png',
  'assets/Vacations.png',
  'assets/Hotels.png',
  'assets/Restaurants.png',
  'assets/Grocery.png',
  'assets/Dessert.png',
];

