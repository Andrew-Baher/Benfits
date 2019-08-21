import 'dart:convert';

import 'package:employees_benefits/models/Employee.dart';
import 'package:employees_benefits/models/Question.dart';
import 'package:employees_benefits/style/theme.dart' as Theme;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import 'AddQuetionsToSurvey.dart';
import 'SignIn.dart';

List<Question> questions;

class AddSurvey extends StatefulWidget {
  @override
  _AddSurveyState createState() => new _AddSurveyState();
}

class _AddSurveyState extends State<AddSurvey>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController surveyTitleController = new TextEditingController();

  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 500),
      color: Colors.white,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(19, 46, 99, 10),
          title: new Text("Create survey"),
        ),
        backgroundColor: Colors.transparent,
        body: ListView(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.width / 200),
          children: <Widget>[
            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.mode_edit,
                      color: Color.fromRGBO(19, 46, 99, 10),
                      size: MediaQuery.of(context).size.width / 12,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 70,
                    ),
                    Text(
                      'Make a survey',
                      style: TextStyle(
                          color: Color.fromRGBO(19, 46, 99, 10),
                          fontSize: MediaQuery.of(context).size.width / 16,
                          fontFamily: "WorkSansBold"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            GestureDetector(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.title,
                        color: Colors.black,
                        size: MediaQuery.of(context).size.width / 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 30,
                      ),
                      Text(
                        'Survey title',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width / 20,
                            fontFamily: "WorkSansBold"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70,
                  ),
                  TextField(
                    controller: surveyTitleController,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.words,
                    style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: MediaQuery.of(context).size.width / 20,
                        color: Color.fromRGBO(19, 46, 99, 10)),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      hasFloatingPlaceholder: false,
                      border: UnderlineInputBorder(),
                      //hoverColor: Colors.black,
                      //focusColor: Colors.black,
                      fillColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                highlightColor: Colors.black,
                splashColor: Theme.Colors.loginGradientStart,
                color: Color.fromRGBO(19, 46, 99, 10),
                minWidth: 70,
                height: MediaQuery.of(context).size.height / 30,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Create survey",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontFamily: "WorkSansBold"),
                  ),
                ),
                onPressed: _onCreateSurveyButtonPress),
          ],
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    questions=new List<Question>();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
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

  void _onCreateSurveyButtonPress() async {
    String surveyTitle = surveyTitleController.text;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => new AddQuetionsToSurvey(surveyTitle)));
  }
}
