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
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../main.dart';
import 'MainApp.dart';
import 'SignIn.dart';

List<String> Control = List<String>.generate(10000, (i) => "");
String globalTitle = '';
int SurveyQuestions;
String formattedDate;
bool _saving = false;
int incNoOfAnswers = 0;
String noOfAnswers = '';

class MakeSurvey extends StatefulWidget {
  @override
  _MakeSurveyState createState() => new _MakeSurveyState();
}

class _MakeSurveyState extends State<MakeSurvey>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String currentSurveyTitle;
  TextEditingController surveyTitleController = new TextEditingController();
  PageController _pageController;
  String _now;
  Timer _everySecond;

  List<String> countries = <String>[
    'Belgium',
    'France',
    'Italy',
    'Germany',
    'Spain',
    'Portugal'
  ];
  var _selectedChoiceIndex = 0;

  Widget singleItemList(int index) {
    //Item item = itemList[index];

    return Container(
      color: Colors.transparent,
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
                      makeSurveyQuestions[index].questionTitle,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width / 20,
                          fontFamily: "WorkSansBold"),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 100,
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.words,
                  cursorColor: Colors.red,
                  style: TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      backgroundColor: Colors.red,
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
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() {
    mainCurrentIndex = 3;
    Navigator.of(context).pop();
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => MainApplication()));
  }

  Future getData() async {
    await new Future.delayed(const Duration(seconds: 0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: new Text(globalTitle), //new Text(globalTitle),
            backgroundColor: Color.fromRGBO(19, 46, 99, 10),
          ),
          body: ModalProgressHUD(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      //itemExtent: MediaQuery.of(context).size.height / 4,
                      itemCount: makeSurveyQuestions.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            //mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                makeSurveyQuestions[index].questionTitle,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 15),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 40,
                              ),
                              (!makeSurveyQuestions[index].questionType)
                                  ? TextField(
                                      autofocus: false,
                                      onChanged: (text) {
                                        Control[index] = text;
                                      },
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      style: TextStyle(
                                        fontFamily: "WorkSansSemiBold",
                                        color: Color.fromRGBO(19, 46, 99, 10),
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                35,
                                      ),
                                      decoration: InputDecoration(
                                          labelText: "Answer the question",
                                          hintText: "Answer the question",
                                          alignLabelWithHint: true,
                                          labelStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(48, 51, 86, 10),
                                            fontSize: 16,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color.fromRGBO(
                                                      19, 46, 99, 10),
                                                  style: BorderStyle.solid))))
                                  : Column(
                                      children: makeSurveyQuestions[index]
                                          .questionChoice
                                          .map((t) => RadioListTile(
                                                title: Text("$t"),
                                                value: t,
                                                groupValue: Control[index],
                                                onChanged: (val) {
                                                  setState(() {
                                                    Control[index] = val;
                                                  });
                                                },
                                              ))
                                          .toList(),
                                    ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    (makeSurveyQuestions.length >= 2)
                        ? MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            highlightColor: Colors.black,
                            splashColor: Theme.Colors.loginGradientStart,
                            color: Color.fromRGBO(19, 46, 99, 10),
                            minWidth: MediaQuery.of(context).size.width / 2.5,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 20,
                                    fontFamily: "WorkSansBold"),
                              ),
                            ),
                            onPressed: () {
                              _saveSurveyAnswer();
                            },
                          )
                        : Text('')
                  ],
                ),
              ),
            ),
            inAsyncCall: _saving,
            progressIndicator: CircularProgressIndicator(),
          ),
        ),
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
    getSurvey();
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

  void getSurvey() async {
    DBRef4.child('SurveyAnswerCount')
        .child('count')
        .once()
        .then((DataSnapshot dataSnapShot) {
      int values = dataSnapShot.value;
      noOfAnswers = "$values";
      incNoOfAnswers = ++values;
    });
    DBRef2.child('surveydetails')
        .child('count')
        .once()
        .then((DataSnapshot dataSnapShot) {
      SurveyQuestions = dataSnapShot.value;
    });
    DBRef2.child('surveydetails')
        .child('SurveyTitle')
        .once()
        .then((DataSnapshot dataSnapShot) {
      globalTitle = dataSnapShot.value;
    });
    print(globalTitle);

    DBRef2.child('survey').once().then((DataSnapshot dataSnapShot) {
      print(dataSnapShot.value[1]["Title"]);
      print(dataSnapShot.value[1]["Type"]);
      print(dataSnapShot.value[1]["Choices"][1]["Choice"]);
      int count = 0;
      Question question;
      for (int i = 0; i < SurveyQuestions; ++i) {
        question = new Question();
        question.questionChoice = new List<String>();
        question.questionTitle = dataSnapShot.value[i]["Title"];
        question.questionType = dataSnapShot.value[i]["Type"];
        question.questionChoicesnumber = dataSnapShot.value[i]["NoOfChoices"];
        if (question.questionType) {
          for (int j = 0; j < question.questionChoicesnumber; ++j) {
            question.questionChoice
                .add(dataSnapShot.value[i]["Choices"][j]["Choice"]);
          }
        }
        makeSurveyQuestions.add(question);

        count++;
      }
      print(count);
    });
  }

  Future sendAnswers(String count, int i) async {
    DBRef4.child('SurveyAnswer').child(noOfAnswers).child(count).set({
      "Answer": Control[i],
    });
  }

  void _saveSurveyAnswer() async {
    new Future.delayed(new Duration(seconds: 0), () {
      setState(() {
        _saving = true;
      });
    });

    DateTime now = DateTime.now();
    formattedDate = DateFormat('EEE d MMM, kk:mm ').format(now);
    DBRef4.child('SurveyAnswer').child(noOfAnswers).set({
      "Name":
          mainEmployee.employeeFirstName + ' ' + mainEmployee.employeeLastName,
      "Time": formattedDate,
      "Email": mainEmployee.employeeEmail
    });
    for (int i = 0; i < makeSurveyQuestions.length; i++) {
      await new Future.delayed(const Duration(seconds: 1));
      await sendAnswers(i.toString(), i);
    }

    DBRef.child('SurveyAnswerCount').set({'count': incNoOfAnswers});
    new Future.delayed(new Duration(seconds: 0), () {
      setState(() {
        _saving = false;
      });
    });
    mainCurrentIndex = 3;
    Navigator.of(context).pop();
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => MainApplication()));
  }
}
