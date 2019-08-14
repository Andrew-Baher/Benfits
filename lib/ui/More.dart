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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => new EditProfile()));
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
                onTap: () {},
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => new PendingRequests()));
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => new NewBenefit()));
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


              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignIn()));
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
