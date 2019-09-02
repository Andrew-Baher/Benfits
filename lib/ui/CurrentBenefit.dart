import 'dart:io';

import 'package:csv/csv.dart';
import 'package:employees_benefits/models/Question.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import 'ApplyForBenefit.dart';

List<List<dynamic>> rows;
List<dynamic> row;
int noOfAnswers;
bool _saving;
int noOfQuestions;

class CurrentBenefit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new CurrentBenfitState();
  }
}

class CurrentBenfitState extends State<CurrentBenefit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

      DBRef2.child('benefit' + mainCurrentBenefitID).once().then((DataSnapshot dataSnapShot) {
        print(dataSnapShot.value);
        print(dataSnapShot.value["1"]["Title"]);
        //print(dataSnapShot.value[1]["Type"]);
        //print(dataSnapShot.value[1]["Choices"][1]["Choice"]);
        print(dataSnapShot.value["AnswersCount"]["count"]);
        print(dataSnapShot.value["QuestionsCount"]["count"]);
        noOfAnswers = dataSnapShot.value["AnswersCount"]["count"];
        noOfQuestions = dataSnapShot.value["QuestionsCount"]["count"];
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text(mainCurrentBenefitTitle),
        backgroundColor: Color.fromRGBO(19, 46, 99, 10),
      ),
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Image.network(
                        mainCurrentBenefitImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 25,
                  ),
                  Divider(
                    color: Colors.black,
                    height: MediaQuery.of(context).size.width / 100,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 25,
                  ),
                  Text(
                    mainCurrentBenefitDescription,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width / 15,
                        fontFamily: "WorkSansBold",
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 25,
                  ),
                  (mainEmployee.employeeAuthority == "Manager")
                      ? (mainCurrentBenefitApply)
                          ? Center(
                              child: Row(
                                children: <Widget>[
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    highlightColor: Colors.black,
                                    //splashColor: Theme.Colors.loginGradientStart,
                                    color: Color.fromRGBO(19, 46, 99, 10),
                                    minWidth:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "Send\nresults",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20,
                                            fontFamily: "WorkSansBold"),
                                      ),
                                    ),
                                    onPressed: () {
                                      sendResults();
                                      //saveBenefit(context);
                                    },
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 15,
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    highlightColor: Colors.black,
                                    //splashColor: Theme.Colors.loginGradientStart,
                                    color: Color.fromRGBO(19, 46, 99, 10),
                                    minWidth:
                                        MediaQuery.of(context).size.width / 2.5,
                                    height:
                                        MediaQuery.of(context).size.height / 30,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "Delete\nBenefit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20,
                                            fontFamily: "WorkSansBold"),
                                      ),
                                    ),
                                    onPressed: () {
                                      sendResults();
                                      deleteBenefit();
                                      //getImage();
                                    },
                                  ),
                                ],
                              ),
                            )
                          : MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              highlightColor: Colors.black,
                              //splashColor: Theme.Colors.loginGradientStart,
                              color: Color.fromRGBO(19, 46, 99, 10),
                              minWidth: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 30,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Delete\nBenefit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      fontFamily: "WorkSansBold"),
                                ),
                              ),
                              onPressed: () {
                                deleteBenefit();
                                //getImage();
                              },
                            )
                      : (mainCurrentBenefitApply)
                          ? MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              highlightColor: Colors.black,
                              //splashColor: Theme.Colors.loginGradientStart,
                              color: Color.fromRGBO(19, 46, 99, 10),
                              minWidth: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 30,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Apply for\nBenefit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      fontFamily: "WorkSansBold"),
                                ),
                              ),
                              onPressed: () {
                                //getImage();
                                makeBenefitQuestions=new List<Question>();
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                        new ApplyForBenefit()));
                              },
                            )
                          : Text("")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void sendResults() async {
    new Future.delayed(new Duration(seconds: 0), () {
      _saving = true;
    });

    rows= new List<List<dynamic>>();
    DBRef4.child('BenefitAnswer'+mainCurrentBenefitID).once().then((DataSnapshot dataSnapShot) async {
      print(dataSnapShot.value);
      print(dataSnapShot.value[1]["Email"]);
      print(dataSnapShot.value[0]['0']["Answer"]);
      print(dataSnapShot.value[0]['1']["Answer"]);
      print(noOfQuestions);
      print(noOfAnswers);
      //print(noOfAnswers);
      //print(noOfQuestions);
      row = new List();
      row.add("Survey Title:");
      row.add(mainCurrentBenefitTitle);
      row.add("Created at:");
      row.add(mainCurrentBenefitID);
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

  void deleteBenefit() {
    DBRef4.child('benefitsDetails').child(mainCurrentBenefitID).update({
      "benfitActive": false,
    });

    new Future.delayed(new Duration(seconds: 10), () {
      setState(() {
        _saving = false;
      });
    });
  }
}
