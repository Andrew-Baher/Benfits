import 'package:csv/csv.dart';
import 'package:employees_benefits/models/Question.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';
import 'EditProfile.dart';
import 'NewBenefit.dart';
import 'PendingRequests.dart';
import 'SignIn.dart';

bool hasAuth;
bool IsSurvey = false;
int NoOfAnswers;

class More extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState3();
  }
}

class _MyAppState3 extends State<More> {
  Future getData() async {
    await new Future.delayed(const Duration(seconds: 0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getData();
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
                  if (mainEmployee.employeeAuthority.toString() == "User") {
                    mainAppState.openAnotherTab(8);
                  } else {
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
                  mainAppState.openAnotherTab(11);
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
                visible: IsSurvey&&(!hasAuth),
                child: GestureDetector(
                  onTap: () {
                    makeSurveyQuestions=new List<Question>();
                    mainAppState.openAnotherTab(10);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.assignment,
                      size: MediaQuery.of(context).size.width / 16,
                    ),
                    title: Text(
                      'Make a survey',
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
                    if(IsSurvey){
                      showDialog(
                          context: context,
                          child: new AlertDialog(
                            title: new Text("A survey is already here"),
                            content: new Text("There is already a survey. "
                                "\n You can't make 2 surveys at the same time."),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Finish Survey \nand send results'),
                                onPressed: () {
                                },
                              ),
                              FlatButton(
                                child: Text('Send me results\nby mail'),
                                onPressed: () {
                                },
                              ),
                            ],
                          ));
                    }else
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

  getCsv() async {
    DBRef2.child('surveydetails')
        .child('count')
        .once()
        .then((DataSnapshot dataSnapShot) {
      NoOfAnswers = dataSnapShot.value;
    });
    List<List<dynamic>> rows = List<List<dynamic>>();
    for (int i = 0; i < 2; i++) {
      List<dynamic> row = List();
      row.add('Andrew');
      row.add('male');
      row.add('22');
      rows.add(row);
    }
    String file;
    String csv = const ListToCsvConverter().convert(rows);
    print(csv);
    /*await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
    bool checkPermission = await SimplePermissions.checkPermission(
        Permission.WriteExternalStorage);
    if (checkPermission) {
//store file in documents folder

      String dir = (await getExternalStorageDirectory()).absolute.path +
          "/documents";
      file = "$dir";
      File f = new File(file + "filename.csv");

// convert rows to String and write as csv file

      String csv = const ListToCsvConverter().convert(rows);
      print(csv);
      f.writeAsString(csv);
    }*/
  }

  @override
  void initState() {
    super.initState();
    DBRef.child('surveydetails')
        .child('IsSurvey')
        .once()
        .then((DataSnapshot dataSnapShot) {
      IsSurvey = dataSnapShot.value;
    });
    hasAuth = false;
    if (mainEmployee.employeeAuthority == "Manager") hasAuth = true;
  }
}
