import 'dart:async';
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

import 'AddQuetionToSurvey.dart';
import 'AddSurvey.dart';
import 'SignIn.dart';

class AddQuetionsToSurvey extends StatefulWidget {
  String surveyTitle;

  AddQuetionsToSurvey(String title) {
    this.surveyTitle = title;
  }

  @override
  _AddQuetionsToSurveyState createState() => new _AddQuetionsToSurveyState();
}

class _AddQuetionsToSurveyState extends State<AddQuetionsToSurvey>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String currentSurveyTitle;
  TextEditingController surveyTitleController = new TextEditingController();
  PageController _pageController;
  String _now;
  Timer _everySecond;

  Widget singleItemList(int index) {
    //Item item = itemList[index];

    return Container(
      child: Row(
        children: [
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
                      questions[index].questionTitle,
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
                (!questions[index].questionType)
                    ? Text('text')
                    : Text('Choices'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 500),
      color: Colors.white,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(19, 46, 99, 10),
          title: new Text(widget.surveyTitle),
        ),
        backgroundColor: Colors.transparent,
        body: ListView(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width / 200),
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return singleItemList(index);
                  }),
            ]),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => new AddQuetionToSurvey()));
            }),
      ),
    );
  }

  @override
  initState() {
    super.initState();

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
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }
}
