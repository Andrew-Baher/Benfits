import 'dart:convert';

import 'package:employees_benefits/models/Employee.dart';
import 'package:employees_benefits/models/Question.dart';
import 'package:employees_benefits/style/theme.dart' as Theme;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AddQuetionsToSurvey.dart';

import 'NewBenefit.dart';
import 'SignIn.dart';

Question q;
List<String> choicesItems = List<String>.generate(10000, (i) => "");

//questions.add(q);
class AddQuetionToBenefit extends StatefulWidget {
  @override
  _AddQuetionToBenefitState createState() {
    q = new Question();
    q.questionChoicesnumber = 0;
    q.questionType = false;
    q.questionChoice=new List<String>();
    return new _AddQuetionToBenefitState();
  }
}

class _AddQuetionToBenefitState extends State<AddQuetionToBenefit>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<DropdownMenuItem<String>> listDrop = [];
  List<String> drop = [
    'Text',
    'Choices',
  ];
  String selected = null;

  void loadData() {
    listDrop = [];
    listDrop = drop
        .map((val) => new DropdownMenuItem(
      child: new Text(val),
      value: val,
    ))
        .toList();
  }

  TextEditingController questionTitleController = new TextEditingController();
  PageController _pageController;

  Widget singleItemList(int index) {
    //Item item = itemList[index];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text("Choice ${index + 1}")),
          Expanded(
            flex: 3,
            child: TextField(
              onChanged: (text) {
                choicesItems[index] = text;
                print("Choice ${index + 1}: $text");
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 500),
      color: Colors.white,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(19, 46, 99, 10),
          title: new Text('Add question to survey'),
        ),
        backgroundColor: Colors.transparent,
        body: ListView(
            padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.width / 200),
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Container(
                  width: 300.0,
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        value: selected,
                        items: listDrop,
                        hint: new Text('Choose type of question'),
                        onChanged: (value) {
                          selected = value;
                          setState(() {
                            if (selected == 'Choices') {
                              q.questionType = true;
                              q.questionChoicesnumber = 2;
                            } else {
                              q.questionType = false;
                              q.questionChoicesnumber = 0;
                            }
                          });
                        },
                      ),
                    ),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width / 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 30,
                        ),
                        Text(
                          'Question title',
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
                      controller: questionTitleController,
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
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: q.questionChoicesnumber,
                  itemBuilder: (context, index) {
                    return singleItemList(index);
                  }),
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
                      "Add question",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 20,
                          fontFamily: "WorkSansBold"),
                    ),
                  ),
                  onPressed: _onAddquestionButtonPress),
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  if (q.questionType) {
                    showInSnackBar('Choice is removed');
                    q.questionChoicesnumber--;
                    setState(() {});
                  } else
                    showInSnackBar(
                        'You can not remove choice unless you choose choices from above');
                },
                icon: Icon(Icons.remove),
                label: Text('choice'),
              ),
              FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  if (q.questionType) {
                    showInSnackBar('Choice is added');
                    q.questionChoicesnumber++;
                    setState(() {});
                  } else
                    showInSnackBar(
                        'You can not add choice unless you choose choices from above');
                },
                icon: Icon(Icons.add),
                label: Text('choice'),
              ),
            ],
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

  void _onAddquestionButtonPress() async {
    q.questionTitle = questionTitleController.text;
    if (q.questionType)
      for (int i = 0; i < q.questionChoicesnumber; ++i) {
        q.questionChoice.add(choicesItems[i]);
      }
    questions.add(q);
    print(questions.length);
    Navigator.of(context).pop();
  }
}
