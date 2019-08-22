import 'package:employees_benefits/style/theme.dart' as Theme;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';

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
  Widget build(BuildContext context) {
    Future sendComplaint(BuildContext context) async {
      DBRef5.child('ComplaintsCount')
          .child('count')
          .once()
          .then((DataSnapshot dataSnapShot) {
        currentComplaintIndex = dataSnapShot.value;
        currentComplaintIndexString = "$currentComplaintIndex";
        print(currentComplaintIndex);
      });
      DBRef5.child('ComplaintsDetails').child(currentComplaintIndexString).set({
        "ComplaintDescription": ComplaintDetailsController.text,
        "EmployeeEmail": mainEmployee.employeeEmail.toString(),
      });
      nextComplaintIndex = currentComplaintIndex + 1;
      DBRef5.child('ComplaintsCount').set({'count': nextComplaintIndex});
    }

    return new WillPopScope(
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Send new complaint'),
          backgroundColor: Color.fromRGBO(19, 46, 99, 10),
        ),
        body: Center(
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
                            borderRadius: BorderRadius.all(Radius.circular(4)),
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
                            showInSnackBar(
                                'Your complaint is sent successfully !');
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
