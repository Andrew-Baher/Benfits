import 'package:employees_benefits/ui/AppNavigation.dart';
import 'package:employees_benefits/ui/Benefits.dart';
import 'package:employees_benefits/ui/CurrentCategory.dart';
import 'package:employees_benefits/ui/EditProfile.dart';
import 'package:employees_benefits/ui/MainApp.dart';
import 'package:employees_benefits/ui/Messages.dart';
import 'package:employees_benefits/ui/More.dart';
import 'package:employees_benefits/ui/SignIn.dart';
import 'package:employees_benefits/ui/SignUp.dart';
import 'package:flutter/material.dart';

import 'models/Employee.dart';

int mainCurrentIndex = 0;
Employee mainEmployee;
String mainEmployeeCompanyID;
bool inNavigation=true;
MainApplication mainAPP=new MainApplication();
MainApplicationState mainAppState=new MainApplicationState();
String currentCategory;

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
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/SignIn': (BuildContext context) => new SignIn(),
        '/MainApplication' : (BuildContext context) => new MainApplication(),
        '/AppNavigation' : (BuildContext context) => new AppNavigation(0),
        '/Benefits' : (BuildContext context) => new Benefits(),
        '/CurrentCategory' : (BuildContext context) => new CurrentCategory(''),
        '/Messages' : (BuildContext context) => new Messages(),
        '/More' : (BuildContext context) => new More(),
        '/SignUp' : (BuildContext context) => new SignUp(),
        '/EditProfile' : (BuildContext context) => new EditProfile()
    },
    );
  }
}
