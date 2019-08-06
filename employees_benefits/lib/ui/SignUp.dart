import 'dart:convert';

import 'package:employees_benefits/models/Employee.dart';
import 'package:employees_benefits/style/theme.dart' as Theme;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'SignIn.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => new _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeFirstName = FocusNode();
  final FocusNode myFocusNodeLastName = FocusNode();
  final FocusNode myFocusNodePhoneNumber = FocusNode();
  final FocusNode myFocusNodeCompanyID = FocusNode();

  TextEditingController signUpEmailController = new TextEditingController();
  TextEditingController signUpFirstNameController = new TextEditingController();
  TextEditingController signUpLastNameController = new TextEditingController();
  TextEditingController signUpPhoneNumberController = new TextEditingController();
  TextEditingController signUpCompanyIDController = new TextEditingController();
  TextEditingController signUpPasswordController = new TextEditingController();
  TextEditingController signUpConfirmPasswordController = new TextEditingController();
  TextEditingController signUpPositionController = new TextEditingController();

  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
      color: Colors.white,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: ListView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.width / 200),
          children: <Widget>[
            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.edit,
                      color: Color.fromRGBO(19, 46, 99, 10),
                      size: MediaQuery.of(context).size.width / 12,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 70,
                    ),
                    Text(
                      'Create an account',
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
                        Icons.person,
                        color: Colors.black,
                        size: MediaQuery.of(context).size.width / 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 30,
                      ),
                      Text(
                        'First Name',
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
                    controller: signUpFirstNameController,
                    keyboardType: TextInputType.text,
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
                        Icons.person,
                        color: Colors.black,
                        size: MediaQuery.of(context).size.width / 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 30,
                      ),
                      Text(
                        'Last Name',
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
                    controller: signUpLastNameController,
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
                        'Phone Number',
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
                    controller: signUpPhoneNumberController,
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
                        'Email',
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
                    controller: signUpEmailController,
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
                        'Position',
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
                    controller: signUpPositionController,
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
                        'Password',
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
                    controller: signUpPasswordController,
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
                      "SIGN UP",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 20,
                          fontFamily: "WorkSansBold"),
                    ),
                  ),
                  onPressed: _onSignUpButtonPress
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //Closing Database
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeFirstName.dispose();
    myFocusNodeLastName.dispose();
    myFocusNodeCompanyID.dispose();
    myFocusNodePhoneNumber.dispose();
    _pageController?.dispose();
    super.dispose();
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

  void _onSignUpButtonPress() async {
    String firstName = signUpFirstNameController.text;
    String lastName = signUpLastNameController.text;
    String email = signUpEmailController.text;
    String password = signUpPasswordController.text;
    String phoneNo = signUpPhoneNumberController.text;
    String companyID = signUpCompanyIDController.text;
    String position = signUpPositionController.text;

    _saveData(new Employee(companyID, firstName, lastName, email, password, phoneNo,
        companyID, position, "User", false));
    _loadData();
    showInSnackBar("Your data is sent successfully !!");
    showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("Sign Up Done !"),
          content: new Text("Wait for the admin to approve. "
              "\n You'll reveice an email as soon as the admin approves."),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignIn()));
              },
            ),
          ],
        ));
  }
}

//TODO: REVISE CODE
_reviver(Object key, Object value) {
  if (key != null && value is Map) return new Employee.fromJson(value);
  return value;
}

const jsonCodec = const JsonCodec(reviver: _reviver);

_loadData() async {
  final url = 'https://employees-benifits-app.firebaseio.com/employees.json';
  final httpClient = new Client();
  var response = await httpClient.get(url);

  Map employees = jsonCodec.decode(response.body);
  List<dynamic> emps = employees.values.toList();

  //TRIALS for debugging
  print(emps[0].employeeFirstName);
  print("Employees length: " + employees.length.toString());
}

_saveData(Employee employee) async {
  var json = jsonCodec.encode(employee);

  final url = 'https://employees-benifits-app.firebaseio.com/employees.json';
  final httpClient = new Client();
  var response = await httpClient.post(url, body: json);
}
