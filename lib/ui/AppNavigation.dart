import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';
import 'Benefits.dart';
import 'Chats.dart';
import 'EditProfile.dart';
import 'HomePage.dart';
import 'Messages.dart';
import 'More.dart';

class AppNavigation extends StatelessWidget {
  final int current;

  AppNavigation(this.current);

  @override
  Widget build(BuildContext context) {
    if (current == 0)
      return MaterialApp(
        title: 'Eva pharma',
        home: HomePage(),
      );
    else if (current == 1)
      return MaterialApp(
        title: 'Eva pharma',
        home: Benefits(),
      );
    else if (current == 2)
      return MaterialApp(
          title: 'Eva pharma',
          home: (mainEmployee.employeeAuthority == "Manager")
              ? Messages()
              : Chats());
    return MaterialApp(
      title: 'Eva pharma',
      home: More(),
    );
  }
}
