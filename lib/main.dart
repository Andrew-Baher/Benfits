import 'dart:io';

import 'package:employees_benefits/ui/AppNavigation.dart';
import 'package:employees_benefits/ui/Benefits.dart';
import 'package:employees_benefits/ui/CurrentCategory.dart';
import 'package:employees_benefits/ui/EditProfile.dart';
import 'package:employees_benefits/ui/MainApp.dart';
import 'package:employees_benefits/ui/Messages.dart';
import 'package:employees_benefits/ui/More.dart';
import 'package:employees_benefits/ui/SignIn.dart';
import 'package:employees_benefits/ui/SignUp.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'models/Employee.dart';
import 'models/Question.dart';

int mainCurrentIndex = 0;
Employee mainEmployee;
String mainEmployeeCompanyID;
bool inNavigation=true;
MainApplication mainAPP=new MainApplication();
MainApplicationState mainAppState=new MainApplicationState();
String currentCategory;
File mainImg;
int currentBenefitId;
int currentMessageId;
int nextBenefitId;
int nextMessageId;
int currentComplaintIndex;
int nextComplaintIndex;
String currentBenefitIdString;
String currentMessageIdString;
String currentComplaintIndexString;
String mainCurrentBenefitImage;
String mainCurrentBenefitDescription;
String mainCurrentBenefitTitle;
bool mainCurrentBenefitApply;
String mainCurrentBenefitID;
String currentChatMail;
String currentChatName;
bool loadingLastFourImages=true;
bool isCurrentCategoryEmpty = false;
bool BeneitFromHomeOrCategory=true;
List<Question> makeSurveyQuestions;
List<Question> makeBenefitQuestions;
final DBRef = FirebaseDatabase.instance.reference();
final DBRef2 = FirebaseDatabase.instance.reference();
final DBRef3 = FirebaseDatabase.instance.reference();
final DBRef4 = FirebaseDatabase.instance.reference();
final DBRef5 = FirebaseDatabase.instance.reference();


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    DBRef5.child('ComplaintsCount')
        .child('count')
        .once()
        .then((DataSnapshot dataSnapShot) {
      currentComplaintIndex = dataSnapShot.value;
      currentComplaintIndexString = "$currentComplaintIndex";
      print(currentComplaintIndex);
    });
    /*DBRef.child('Messagescount')
        .child('count')
        .once()
        .then((DataSnapshot dataSnapShot) {
      currentMessageId = dataSnapShot.value;
      currentMessageIdString = "$currentMessageId";
      print(currentMessageId);
    });*/
    DBRef2.child('Benefitscount')
        .child('count')
        .once()
        .then((DataSnapshot dataSnapShot) {
      currentBenefitId = dataSnapShot.value;
      currentBenefitIdString = "$currentBenefitId";
      print(currentBenefitId);
    });

    return new MaterialApp(
      title: 'Login | Sign Up',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SignIn(),
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/SignIn': (BuildContext context) => new SignIn(),
        '/MainApplication' : (BuildContext context) => new MainApplication(),
        '/AppNavigation' : (BuildContext context) => new AppNavigation(0),
        '/Benefits' : (BuildContext context) => new Benefits(),
        '/CurrentCategory' : (BuildContext context) => new CurrentCategory(''),
        '/Messages' : (BuildContext context) => new Messages(),
        '/More' : (BuildContext context) => new More(),
        '/SignUp' : (BuildContext context) => new SignUp(),
        '/EditProfile' : (BuildContext context) => new EditProfile()
    },
    );
  }
}
