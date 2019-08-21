import 'dart:convert';

import 'package:employees_benefits/models/Employee.dart';
import 'package:employees_benefits/style/theme.dart' as Theme;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import 'MainApp.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => new _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final DBRef = FirebaseDatabase.instance.reference();
  Employee emp = mainEmployee;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //Palette
  static int primary = hexStringToHexInt('080c2d');
  static int primaryDark = hexStringToHexInt('#000004');
  static int primaryLight = hexStringToHexInt('#303356');

  static Color loginGradientStart = Color(primaryLight);
  static Color loginGradientEnd = Color(primaryDark);

  //Controllers
  TextEditingController editedFirstNameController = new TextEditingController();
  TextEditingController editedLastNameController = new TextEditingController();
  TextEditingController editedEmailController = new TextEditingController();
  TextEditingController editedPasswordController = new TextEditingController();
  TextEditingController editedPhoneController = new TextEditingController();
  TextEditingController editedPositionController = new TextEditingController();

  Future<bool> _onBackPressed() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => MainApplication()));
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 100000),
        color: Colors.white,
        child: new Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(19, 46, 99, 10),
            title: new Text("Edit profile"),
          ),
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: ListView(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width / 200),
            children: <Widget>[
              DrawerHeader(
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.edit,
                        color: Color.fromRGBO(19, 46, 99, 10),
                        size: 40.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 70,
                      ),
                      Text(
                        'Edit Profile',
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
                height: MediaQuery.of(context).size.height / 50,
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width / 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 30,
                        ),
                        Text(
                          'Edit First Name',
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
                      controller: editedFirstNameController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 24.0,
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
                height: MediaQuery.of(context).size.height / 70,
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width / 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 30,
                        ),
                        Text(
                          'Edit Last Name',
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
                      controller: editedLastNameController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: MediaQuery.of(context).size.width / 20,
                          color: Color.fromRGBO(19, 46, 99, 10)),
                      decoration: InputDecoration(
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
                height: MediaQuery.of(context).size.height / 70,
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.phone_iphone,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width / 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 30,
                        ),
                        Text(
                          'Edit Phone Number',
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
                      controller: editedPhoneController,
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
                height: MediaQuery.of(context).size.height / 70,
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.person_pin,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width / 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 30,
                        ),
                        Text(
                          'Edit Position',
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
                      controller: editedPositionController,
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
                height: MediaQuery.of(context).size.height / 70,
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.person_pin,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width / 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 30,
                        ),
                        Text(
                          'Edit Position',
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
                      controller: editedPositionController,
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
                height: MediaQuery.of(context).size.height / 70,
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width / 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 30,
                        ),
                        Text(
                          'Edit Email',
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
                      controller: editedEmailController,
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
                height: MediaQuery.of(context).size.height / 70,
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.lock,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width / 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 30,
                        ),
                        Text(
                          'Edit Password',
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
                      obscureText: true,
                      controller: editedPasswordController,
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
                height: MediaQuery.of(context).size.height / 70,
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
                      "SAVE",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontFamily: "WorkSansBold"),
                    ),
                  ),
                  onPressed: _onSaveButtonPressed),
            ],
          ),
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();

    Employee employee = mainEmployee;

    //Initialize TextFields with the employee's data
    editedFirstNameController.text = employee.employeeFirstName;
    editedLastNameController.text = employee.employeeLastName;
    editedPhoneController.text = employee.employeePhoneNumber;
    editedEmailController.text = employee.employeeEmail;
    editedPasswordController.text = employee.employeePassword;
    editedPositionController.text = employee.employeePosition;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _onSaveButtonPressed() async {
    String firstName = editedFirstNameController.text;
    String lastName = editedLastNameController.text;
    String email = editedEmailController.text;
    String password = editedPasswordController.text;
    String phoneNo = editedPhoneController.text;
    String position = editedPositionController.text;

    DBRef.child('employees').child(mainEmployeeCompanyID).update({
      "employeeFirstName": firstName,
      "employeeLastName": lastName,
      "employeePhoneNumber": phoneNo,
      "employeeEmail": email,
      "employeePassword": password,
      "employeePosition": position,
      "employeeAuthority": 'User',
      "employeeApprovalStatus": false
    });

    showInSnackBar('Data saved successfully !');
    await Future.delayed(const Duration(seconds: 2), () {});
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MainApplication()));
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromRGBO(48, 51, 86, 10),
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }
}

hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return val;
}
