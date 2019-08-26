import 'dart:convert';
import 'dart:io';

import 'package:employees_benefits/models/Employee.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../main.dart';
import 'ForgetPassword.dart';
import 'SignUp.dart';

final List<Color> colors = new List<Color>();
bool _saving = false;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => new _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //Controllers
  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  static Employee neededEmployee;

  @override
  void initState() {
    super.initState();
    colors.add(Color.fromRGBO(19, 46, 99, 10));
    colors.add(Colors.yellow);
    colors.add(Color.fromRGBO(19, 46, 99, 10));
    colors.add(Colors.yellow);
    _saving = false;
    loginEmailController.text = '';
    loginPasswordController.text = '';
    setState(() {});
  }

  Future<bool> _onBackPressed() {
    //TODO: Add message box of exiting app
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: MediaQuery.of(context).size.width / 7,
        child: Image.asset('assets/EvapharmaLogo.png'),
      ),
    );

    final email = TextField(
      keyboardType: TextInputType.emailAddress,
      controller: loginEmailController,
      autofocus: false,
      style: TextStyle(
          fontFamily: "WorkSansSemiBold",
          fontSize: 24.0,
          color: Color.fromRGBO(19, 46, 99, 10)),
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: loginPasswordController,
      style: TextStyle(
          fontFamily: "WorkSansSemiBold",
          fontSize: 24.0,
          color: Color.fromRGBO(19, 46, 99, 10)),
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: _onSignInButtonPress,
        padding: EdgeInsets.all(12),
        color: Color.fromRGBO(19, 46, 99, 10),
        child:
            Text('Log In', style: TextStyle(color: Colors.white, fontSize: 24)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Color.fromRGBO(19, 46, 99, 10), fontSize: 18),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ForgetPassword()));
      },
    );

    final dontHaveAnAccount = FlatButton(
      child: Text(
        'Don\'t\ have an account',
        style: TextStyle(color: Color.fromRGBO(19, 46, 99, 10), fontSize: 18),
      ),
      onPressed: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUp()))
      },
    );

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: new WillPopScope(
        onWillPop: _onBackPressed,
        child: new Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          body: ModalProgressHUD(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: <Widget>[
                  logo,
                  SizedBox(height: MediaQuery.of(context).size.height / 25),
                  email,
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  password,
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  loginButton,
                  forgotLabel,
                  dontHaveAnAccount,
                ],
              ),
            ),
            inAsyncCall: _saving,
            progressIndicator: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  void _onSignInButtonPress() async {
    final key = encrypt.Key.fromUtf8('my 32 length key................');
    final iv = encrypt.IV.fromLength(16);

    mainCurrentIndex = 0;
    new Future.delayed(new Duration(seconds: 0), () {
      setState(() {
        _saving = true;
      });
    });
    if (loginEmailController.text == '' || loginPasswordController.text == '') {
      showInSnackBar('Please enter your email and password !');
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
      for (int i = 0; i < emps.length; i++) {
        //Get Encrypted pass from database
        String empEncriptedPassFromDB = emps[i].employeePassword;
        print("Encr from db: " + empEncriptedPassFromDB + '\n');

        final encrypter = Encrypter(AES(key));

        //Encrypt entered password
        String loginPass = loginPasswordController.text;
        final encrypted = encrypter.encrypt(loginPass, iv: iv);
        print("Newly Encr: " + encrypted.base64);

        if (emps[i].employeeEmail == loginEmailController.text &&
            //compare 2 encryption
            empEncriptedPassFromDB.toString() == encrypted.base64 &&
            emps[i].employeeApprovalStatus == true) {
          mainEmployee = emps[i];
          mainEmployeeCompanyID = mainEmployee.employeeCompanyID.toString();
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => mainAPP));
        } else if (emps[i].employeeEmail == loginEmailController.text &&
            empEncriptedPassFromDB.toString() == encrypted.base64 &&
            emps[i].employeeApprovalStatus == false)
          showInSnackBar("You haven't been approved yet !");
        else {
          showInSnackBar('Incorrect email or password ! Please try again.');
          setState(() {});
        }
      }

      //TRIALS for debugging
      print(emps[0].employeeFirstName);
      print("Employees length: " + employees.length.toString());
    }

    loginEmailController.text = '';
    loginPasswordController.text = '';
    new Future.delayed(new Duration(seconds: 0), () {
      setState(() {
        _saving = false;
      });
    });
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

_reviver(Object key, Object value) {
  if (key != null && value is Map) return new Employee.fromJson(value);
  return value;
}

const jsonCodec = const JsonCodec(reviver: _reviver);
