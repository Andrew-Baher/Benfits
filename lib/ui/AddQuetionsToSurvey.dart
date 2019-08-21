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
List<String> Control = List<String>.generate(10000, (i) => "");
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
                      questions[index].questionTitle,
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: new Text(widget.surveyTitle),
          backgroundColor: Color.fromRGBO(19, 46, 99, 10),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  //itemExtent: MediaQuery.of(context).size.height / 4,
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        //mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            questions[index].questionTitle,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width / 15),

                          ),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 40,
                          ),
                          (!questions[index].questionType)
                              ? TextField(
                                  autofocus: false,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    color: Color.fromRGBO(19, 46, 99, 10),
                                    fontSize:
                                        MediaQuery.of(context).size.width / 35,
                                  ),
                                  decoration: InputDecoration(
                                      labelText: "Answer the question",
                                      hintText: "Answer the question",
                                      alignLabelWithHint: true,
                                      labelStyle: TextStyle(
                                        color: Color.fromRGBO(48, 51, 86, 10),
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
                              : Column (
                            children: questions[index].questionChoice
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
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Color.fromRGBO(19, 46, 99, 10),
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
      backgroundColor: Color.fromRGBO(19, 46, 99, 10),
      duration: Duration(seconds: 3),
    ));
  }
}
