import 'package:employees_benefits/models/ColorLoader.dart';
import 'package:employees_benefits/style/theme.dart' as Theme;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import 'MainApp.dart';

bool _saving = false;

class NewComplaint extends StatefulWidget {
  @override
  _NewComplaint createState() => new _NewComplaint();
}

class _NewComplaint extends State<NewComplaint>
    with SingleTickerProviderStateMixin {
  //Palette
  static int primary = hexStringToHexInt('080c2d');
  static int primaryDark = hexStringToHexInt('#000004');
  static int primaryLight = hexStringToHexInt('#303356');

  static Color loginGradientStart = Color(primaryLight);
  static Color loginGradientEnd = Color(primaryDark);

  TextEditingController ComplaintDetailsController =
      new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _saving = false;
    ComplaintDetailsController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    Future sendComplaint(BuildContext context) async {
      new Future.delayed(new Duration(seconds: 0), () {
        setState(() {
          _saving = true;
        });
      });
      setState(() {});

      if (ComplaintDetailsController.text == '') {
        showInSnackBar('Please fill this field !');
      } else {
        String empFullName = mainEmployee.employeeFirstName +
            ' ' +
            mainEmployee.employeeLastName;
        /*DBRef5.child('ComplaintsCount')
            .child('count')
            .once()
            .then((DataSnapshot dataSnapShot) {
          currentComplaintIndex = dataSnapShot.value;
          currentComplaintIndexString = "$currentComplaintIndex";
          print(currentComplaintIndex);
        });*/
        DateTime now = DateTime.now();
        String ComplaintID = DateFormat('EEE d MMM yy, kk:mm:ss ').format(now);
        DBRef5.child('ComplaintsDetails')
            .child(ComplaintID)
            .set({
          "ComplaintDescription": ComplaintDetailsController.text,
          "EmployeeEmail": mainEmployee.employeeEmail.toString(),
          "EmployeeName": empFullName,
        });
        //nextComplaintIndex = currentComplaintIndex + 1;
        //DBRef5.child('ComplaintsCount').set({'count': nextComplaintIndex});
        showInSnackBar('Your complaint is sent successfully !');

        //Sending email to HR Manager
        bool registered = false;
        String username = 'bbbba7785@gmail.com';
        String password = 'ah67@#nm12';

        final smtpServer = gmail(username, password);
        String employeeFullName = mainEmployee.employeeFirstName +
            ' ' +
            mainEmployee.employeeLastName;

        final message = Message()
          ..from = Address(mainEmployee.employeeEmail)
          ..recipients.add('bbbba7785@gmail.com')
          //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
          //..bccRecipients.add(Address('bccAddress@example.com'))
          ..subject = 'Complaint from ' + employeeFullName
          ..text = 'Dear Benefits Manager,'
                  '\n\n'
                  'You have a complaint from ' +
              employeeFullName +
              '.' +
              '\n\n'
                  'The details of the complaint are as follows:\n\n'
                  '${ComplaintDetailsController.text}\n\n'
                  'Thank you,\n\n'
                  'Regards,\n\n'
                  '$employeeFullName';
        try {
          final sendReport = await send(message, smtpServer);
          showDialog(
            context: context,
            // ignore: deprecated_member_use
            child: new AlertDialog(
              title: new Text("Done"),
              content: new Text(
                  "Your complaint is sent successfully to benefits manager!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    mainCurrentIndex = 3;
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => MainApplication()));
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
              title: new Text("Complaint sending Failed !"),
              content: new Text(
                  "There is an error in sending an Email, try again later"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    mainCurrentIndex = 3;
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => MainApplication()));
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
      ComplaintDetailsController.text = '';
      new Future.delayed(new Duration(seconds: 0), () {
        setState(() {
          _saving = false;
        });
      });
    }

    Future<bool> _onBackPressed() {
      mainCurrentIndex = 3;
      Navigator.of(context).pop();
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => MainApplication()));
    }

    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Send new complaint'),
          backgroundColor: Color.fromRGBO(19, 46, 99, 10),
        ),
        body: ModalProgressHUD(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(24),
                child: Center(
                    child: Column(
                  children: <Widget>[
                    TextField(
                      autofocus: false,
                      controller: ComplaintDetailsController,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 22.0,
                          color: Color.fromRGBO(19, 46, 99, 10)),
                      maxLines: 5,
                      decoration: InputDecoration(
                          labelText: "Your complaint here...",
                          hintText: "Enter complaint",
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(48, 51, 86, 10),
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(19, 46, 99, 10),
                                  style: BorderStyle.solid))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 500,
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
                            color: Color.fromRGBO(19, 46, 99, 10),
                            minWidth: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 30,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "Send complaint",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "WorkSansBold"),
                              ),
                            ),
                            onPressed: () {
                              sendComplaint(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
          inAsyncCall: _saving,
          progressIndicator: CircularProgressIndicator(),
        ),
      ),
    );
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
