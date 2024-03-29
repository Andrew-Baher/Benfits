import 'package:employees_benefits/models/Employee.dart';
import 'package:employees_benefits/style/theme.dart' as Theme;
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../main.dart';
import 'PendingRequests.dart';

Employee employee;
String pendingEmployeeCompanyID;

// ignore: must_be_immutable
class PendingRequestsApprovals extends StatefulWidget {
  Employee pendingEmployee;

  PendingRequestsApprovals(Employee employee) {
    this.pendingEmployee = employee;
  }

  @override
  _PendingRequestsApprovalsState createState() =>
      new _PendingRequestsApprovalsState();
}

class _PendingRequestsApprovalsState extends State<PendingRequestsApprovals> {
  final DBRef = FirebaseDatabase.instance.reference();
  Employee emp = mainEmployee;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //Controllers
  TextEditingController editedFirstNameController = new TextEditingController();
  TextEditingController editedLastNameController = new TextEditingController();
  TextEditingController editedEmailController = new TextEditingController();
  TextEditingController editedPhoneController = new TextEditingController();
  TextEditingController editedPositionController = new TextEditingController();

  Future<bool> _onBackPressed() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => new PendingRequests()));
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Pending requests approvals'),
            backgroundColor: Color.fromRGBO(19, 46, 99, 10),
          ),
          body: new MaterialApp(
              home: Scaffold(
              body: Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
      color: Colors.white,
      child: ListView(
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
                      'Review Profile',
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
                    enabled: false,
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
                    enabled: false,
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
                    enabled: false,
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
                    enabled: false,
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
                    enabled: false,
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
              height: MediaQuery.of(context).size.height / 30,
            ),
            Center(
              child: Row(
                children: <Widget>[
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      highlightColor: Colors.black,
                      splashColor: Theme.Colors.loginGradientStart,
                      color: Colors.green,
                      minWidth: MediaQuery.of(context).size.width / 2.5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "ACCEPT",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "WorkSansBold"),
                        ),
                      ),
                      onPressed: _onAcceptButtonPressed),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 15,
                  ),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      highlightColor: Colors.black,
                      splashColor: Theme.Colors.loginGradientStart,
                      color: Colors.red,
                      minWidth: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.height / 30,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "DECLINE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "WorkSansBold"),
                        ),
                      ),
                      onPressed: _onDeclineButtonPressed),
                ],
              ),
            ),
          ],
        ),
      ),
    ),),),);
  }

  @override
  initState() {
    super.initState();
    employee = widget.pendingEmployee;

    //Initialize TextFields with the employee's data
    editedFirstNameController.text = employee.employeeFirstName;
    editedLastNameController.text = employee.employeeLastName;
    editedPhoneController.text = employee.employeePhoneNumber;
    editedEmailController.text = employee.employeeEmail;
    editedPositionController.text = employee.employeePosition;
  }

  void _onAcceptButtonPressed() async {
    //Decrypting password
    final key = encrypt.Key.fromUtf8('my 32 length key................');
    final iv = encrypt.IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final decryptPass = encrypter.decrypt64(employee.employeePassword, iv: iv);
    print(decryptPass);

    //Sending Email
    String username = 'bbbba7785@gmail.com';
    String password = 'ah67@#nm12';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'bbbba7785@gmail.com')
      ..recipients.add(employee.employeeEmail)
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Approved Evapharma signup'
      ..text = 'Dear ${employee.employeeFirstName} '
          '${employee.employeeLastName},\n\n'
          'Thank you for signing up for Evapharma mobile application.\n\n'
          'Congratulations,your signup request has been accepted.\n\n'
          'You can now login using the following credentials:\n\n'
          'Username: ${employee.employeeEmail}\n'
          'Password: $decryptPass\n\n'
          'Thank you,\n\n'
          'Regards,\n\n'
          'Evapharma H.R.';
    //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      DBRef.child('employees')
          .child(employee.employeeCompanyID)
          .update({'employeeApprovalStatus': true});
      showInSnackBar('Request accepted !');
    } catch (e) {
      showInSnackBar('email not sent !');
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

    await Future.delayed(const Duration(seconds: 1), () {});
    Navigator.of(context).pop();
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => new PendingRequests()));

  }

  void _onDeclineButtonPressed() async {
    String username = 'bbbba7785@gmail.com';
    String password = 'ah67@#nm12';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'bbbba7785@gmail.com')
      ..recipients.add(employee.employeeEmail)
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Declined Evapharma signup'
      ..text = 'Dear ${employee.employeeFirstName} '
          '${employee.employeeLastName},\n\n'
          'Thank you for signing up for Evapharma mobile application.\n\n'
          'We are very sorry, your signup request has been rejected.\n\n'
          'Kindly, please contact the benefits team-HR department.\n\n'
          'Thank you,\n\n'
          'Regards,\n\n'
          'Evapharma H.R.';
    //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      DBRef.child('employees').child(employee.employeeCompanyID).remove();
      showInSnackBar('Request accepted !');
    } catch (e) {
      showInSnackBar('email not sent !');
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

    showInSnackBar('Request declined !');
    await Future.delayed(const Duration(seconds: 1), () {});
    Navigator.of(context).pop();
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => new PendingRequests()));
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

hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return val;
}
