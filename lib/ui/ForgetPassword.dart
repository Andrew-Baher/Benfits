import 'dart:convert';

import 'package:employees_benefits/models/Employee.dart';
import 'package:employees_benefits/style/theme.dart' as Theme;
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'SignIn.dart';

bool _saving = false;

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => new _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final DBRef = FirebaseDatabase.instance.reference();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeFirstName = FocusNode();
  final FocusNode myFocusNodeLastName = FocusNode();
  final FocusNode myFocusNodePhoneNumber = FocusNode();
  final FocusNode myFocusNodeCompanyID = FocusNode();

  TextEditingController forgetPasswordController = new TextEditingController();

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
          title: new Text("Forget Password"),
        ),
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          child: ListView(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width / 200),
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
                        'Please Enter your Email',
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
                      controller: forgetPasswordController,
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
                      "Send me Email with my password",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 20,
                          fontFamily: "WorkSansBold"),
                    ),
                  ),
                  onPressed: _onSendEmailButtonPress),
            ],
          ),
          inAsyncCall: _saving,
          progressIndicator: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    //Closing Database
    myFocusNodeEmail.dispose();
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
      backgroundColor: Color.fromRGBO(19, 46, 99, 10),
      duration: Duration(seconds: 3),
    ));
  }

  void _onSendEmailButtonPress() async {
    //Decrypting password
    final key = encrypt.Key.fromUtf8('my 32 length key................');
    final iv = encrypt.IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    new Future.delayed(new Duration(seconds: 0), () {
      setState(() {
        _saving = true;
      });
    });

    String email = forgetPasswordController.text;
    Employee currentEmployee;
    bool registered = false;

    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

    if (email == '') {
      showInSnackBar('Please enter your email');
    } else if (!emailValid) {
      showInSnackBar('Enter valid email !');
    } else {
      final url =
          'https://employees-benifits-app.firebaseio.com/employees.json';
      final httpClient = new Client();
      var response = await httpClient.get(url);

      Map employees = jsonCodec.decode(response.body);
      List<dynamic> emps = employees.values.toList();

      //TRIALS for debugging
      print(emps[0].employeeEmail + '\n' + emps[0].employeePassword);

      //Compare the entered email & pass with db
      for (int i = 0; i < emps.length; i++)
        if (emps[i].employeeEmail == forgetPasswordController.text &&
            emps[i].employeeApprovalStatus == true) {
          registered = true;
          currentEmployee = emps[i];

          String username = 'bbbba7785@gmail.com';
          String password = 'ah67@#nm12';

          final smtpServer = gmail(username, password);
          // Use the SmtpServer class to configure an SMTP server:
          // final smtpServer = SmtpServer('smtp.domain.com');
          // See the named arguments of SmtpServer for further configuration
          // options.

          final decryptPass = encrypter.decrypt64(currentEmployee.employeePassword, iv: iv);
          print(decryptPass);

          // Create our message.
          final message = Message()
            ..from = Address(username, 'bbbba7785@gmail.com')
            ..recipients.add(currentEmployee.employeeEmail)
            //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
            //..bccRecipients.add(Address('bccAddress@example.com'))
            ..subject = 'Evapharma password reset'
            ..text = 'Dear ${currentEmployee.employeeFirstName} '
                '${currentEmployee.employeeLastName},\n\n'
                'Your request for resetting password is succefull.\n\n'
                'You can now login using the following credentials:\n\n'
                'Username: ${currentEmployee.employeeEmail}\n'
                'Password: $decryptPass\n\n'
                'Thankyou,\n\n'
                'Regards,\n\n'
                'Evapharma H.R.';
          //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

          try {
            final sendReport = await send(message, smtpServer);
            showDialog(
              context: context,
              // ignore: deprecated_member_use
              child: new AlertDialog(
                title: new Text("Forget password is Done !"),
                content:
                    new Text("You will recieve an Email with your password"),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                  ),
                ],
              ),
            );
          } catch (e) {
            showDialog(
              context: context,
              // ignore: deprecated_member_use
              child: new AlertDialog(
                title: new Text("Forget password Failed !"),
                content: new Text(
                    "There is an error in sending an Email, try again later"),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                  ),
                ],
              ),
            );
            print('Message not sent.');
            for (var p in e.problems) {
              print('Problem: ${p.code}: ${p.msg}');
            }
          }
        }
      if (!registered) showInSnackBar('You are not registered');
    }
  }
}
