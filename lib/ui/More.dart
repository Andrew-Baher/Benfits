import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';
import 'EditProfile.dart';
import 'NewBenefit.dart';
import 'PendingRequests.dart';
import 'SignIn.dart';

bool hasAuth;

class More extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState3();
  }
}

class _MyAppState3 extends State<More> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  mainAppState.openAnotherTab(5);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    size: MediaQuery.of(context).size.width / 16,
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: MediaQuery.of(context).size.width / 16,
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if(mainEmployee.employeeAuthority.toString() == "User"){
                    mainAppState.openAnotherTab(8);
                  }
                  else {
                    mainAppState.openAnotherTab(9);
                  }
                },
                child: ListTile(
                  leading: Icon(
                    Icons.priority_high,
                    size: MediaQuery.of(context).size.width / 16,
                  ),
                  title: Text(
                    'Complaints',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: ListTile(
                  leading: Icon(
                    Icons.person_pin,
                    size: MediaQuery.of(context).size.width / 16,
                  ),
                  title: Text(
                    'About us',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Visibility(
                visible: hasAuth,
                child: GestureDetector(
                  onTap: () {
                    mainAppState.openAnotherTab(3);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.assignment_ind,
                      size: MediaQuery.of(context).size.width / 16,
                    ),

                    title: Text(
                      'Pending Requests',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ), // Appear if user is admin

              Visibility(
                visible: hasAuth,
                child: GestureDetector(
                  onTap: () {
                    mainAppState.openAnotherTab(1);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.add_a_photo,
                      size: MediaQuery.of(context).size.width / 16,
                    ),

                    title: Text(
                      'Add benefit',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ), // Appear if user is admin

              Visibility(
                visible: hasAuth,
                child: GestureDetector(
                  onTap: () {
                    mainAppState.openAnotherTab(2);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.message,
                      size: MediaQuery.of(context).size.width / 16,
                    ),

                    title: Text(
                      'Send a message',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ), // Appear if user is admin

              Visibility(
                visible: hasAuth,
                child: GestureDetector(
                  onTap: () {
                    mainAppState.openAnotherTab(4);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.announcement,
                      size: MediaQuery.of(context).size.width / 16,
                    ),

                    title: Text(
                      'Add a survey',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ), // Appear if user is admin

              GestureDetector(
                onTap: () {
                  mainAppState.openAnotherTab(6);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.power_settings_new,
                    size: MediaQuery.of(context).size.width / 16,
                  ),
                  title: Text(
                    'Log out',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    hasAuth = false;
    if(mainEmployee.employeeAuthority == "Manager")
      hasAuth = true;
  }

}
