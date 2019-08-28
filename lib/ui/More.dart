import 'dart:io';

import 'package:csv/csv.dart';
import 'package:employees_benefits/models/Question.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import 'EditProfile.dart';
import 'NewBenefit.dart';
import 'PendingRequests.dart';
import 'SignIn.dart';

bool hasAuth;
bool IsSurvey = false;
int noOfAnswers;
int noOfQuestions;
List<dynamic> row;
List<List<dynamic>> rows;
String surveyTitle='';
bool _saving=false;
String surveyID;

class More extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState3();
  }
}

class _MyAppState3 extends State<More> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  Future getData() async {
    await new Future.delayed(const Duration(seconds: 0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return MaterialApp(
      home: Scaffold(
          key: _scaffoldKey,
          body: ModalProgressHUD(
            child: ListView(
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
                                    sendResults();
                                    finishSurvey();
                                  },
                                ),
                                FlatButton(
                                  child: Text('Send me results\nby mail'),
                                  onPressed: () {
                                    getSurveyDetails();
                                    new Future.delayed(new Duration(seconds: 1), () {
                                      sendResults();
                                    });
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
            ),
            inAsyncCall: _saving,
            progressIndicator: CircularProgressIndicator(),
          ),
      ),
    );
  }

  void sendResults() async {
    new Future.delayed(new Duration(seconds: 0), () {
      _saving = true;
      Navigator.of(context, rootNavigator: true).pop('');
      setState(() {
        _saving = true;
      });
    });

     rows= new List<List<dynamic>>();
     DBRef4.child('SurveyAnswer'+surveyID).once().then((DataSnapshot dataSnapShot) async {
      print(dataSnapShot.value);
      print(dataSnapShot.value[noOfQuestions-1]["Email"]);
      print(dataSnapShot.value[0]['0']["Answer"]);
      print(dataSnapShot.value[0]['1']["Answer"]);
      print(noOfAnswers);
      print(noOfQuestions);
      row = new List();
      row.add("Survey Title:");
      row.add(surveyTitle);
      row.add("Created at:");
      row.add(surveyID);
      rows.add(row);
      for(int i=0;i<1;i++){
        row = new List();
        row.add("Number");
        row.add("Email");
        row.add("Name");
        row.add("ID");
        row.add("Time");
        for(int j=0;j<noOfQuestions;j++){
          row.add("Question ${j+1}");
        }
        rows.add(row);
      }

      for(int i=0;i<noOfAnswers;i++){
        row = new List();
        row.add("${i+1}");
        row.add(dataSnapShot.value[i]["Email"]);
        row.add(dataSnapShot.value[i]["Name"]);
        row.add(dataSnapShot.value[i]["ID"]);
        row.add(dataSnapShot.value[i]["Time"]);
        for(int j=0;j<noOfQuestions;j++){
          row.add(dataSnapShot.value[i]['${j}']["Answer"]);
        }
        rows.add(row);
      }


      String csv = const ListToCsvConverter().convert(rows);
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('EEE d MMM, kk:mm ').format(now);
      final directory = await getApplicationDocumentsDirectory();
      String currentDirectory=directory.path;
      var file = "$currentDirectory";
      File f = new File(file +" "+ formattedDate + ".csv");
      f.writeAsString(csv);
      FileAttachment ff=new FileAttachment(f);
      String username = 'bbbba7785@gmail.com';
      String password = 'ah67@#nm12';

      final smtpServer = gmail(username, password);
      // Use the SmtpServer class to configure an SMTP server:
      // final smtpServer = SmtpServer('smtp.domain.com');
      // See the named arguments of SmtpServer for further configuration
      // options.

      // Create our message.
      final message = Message()
        ..from = Address(username, 'bbbba7785@gmail.com')
        ..recipients.add('bbbba7785@gmail.com')
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
        ..subject = 'Approved Evapharma signup'
        ..text = 'Dear Benefits manager,\n\n'
            'Kindly find the attached file of answers to your survey.\n\n'
            'Thank you,\n\n'
            'Regards,\n\n'
            'Evapharma Application maker'
        ..attachments=[ff];

      try {
        final sendReport = await send(message, smtpServer);
        new Future.delayed(new Duration(seconds: 0), () {
          setState(() {
            _saving = false;
          });
        });
        showInSnackBar('email sent !');

      } catch (e) {
        new Future.delayed(new Duration(seconds: 0), () {
          setState(() {
            _saving = false;
          });
        });
        showInSnackBar('email not sent !');
        }

    });

  }

  void finishSurvey(){
    DBRef4.child('surveydetails').set({
      "SurveyID":"",
      "IsSurvey": false,
    });


    new Future.delayed(new Duration(seconds: 10), () {
      setState(() {
        _saving = false;
      });
    });

  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Color.fromRGBO(19, 46, 99, 10),
      duration: Duration(seconds: 3),
    ));
  }

  @override
  void initState() {
    super.initState();
    DBRef2.child('surveydetails')
        .child('SurveyID')
        .once()
        .then((DataSnapshot dataSnapShot) {
      surveyID = dataSnapShot.value;
    });

    DBRef4.child('surveydetails')
        .child('IsSurvey')
        .once()
        .then((DataSnapshot dataSnapShot) {
      IsSurvey = dataSnapShot.value;
    });

    hasAuth = false;
    if (mainEmployee.employeeAuthority == "Manager") hasAuth = true;
  }

void getSurveyDetails(){
  DBRef2.child('survey'+surveyID).once().then((DataSnapshot dataSnapShot) {
    print(dataSnapShot.value);
    print(dataSnapShot.value["1"]["Title"]);
    //print(dataSnapShot.value[1]["Type"]);
    //print(dataSnapShot.value[1]["Choices"][1]["Choice"]);
    print(dataSnapShot.value["AnswersCount"]["count"]);
    print(dataSnapShot.value["QuestionsCount"]["count"]);
    noOfAnswers = dataSnapShot.value["AnswersCount"]["count"];
    surveyTitle = dataSnapShot.value["SurveyTitle"]["Title"];
    noOfQuestions = dataSnapShot.value["QuestionsCount"]["count"];});
}
}

