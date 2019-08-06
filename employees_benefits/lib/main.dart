import 'package:employees_benefits/ui/SignIn.dart';
import 'package:flutter/material.dart';

import 'models/Employee.dart';

int mainCurrentIndex = 0;
Employee mainEmployee;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Login | Sign Up',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SignIn(),
    );
  }
}
