import 'dart:convert';
import 'dart:io';

import 'package:employees_benefits/models/BenefitDetails.dart';
import 'package:employees_benefits/style/theme.dart' as Theme;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import '../main.dart';
import 'MainApp.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessage createState() => new _NewMessage();
}

class _NewMessage extends State<NewMessage>
    with SingleTickerProviderStateMixin {
  //Palette
  static int primary = hexStringToHexInt('080c2d');
  static int primaryDark = hexStringToHexInt('#000004');
  static int primaryLight = hexStringToHexInt('#303356');

  static Color loginGradientStart = Color(primaryLight);
  static Color loginGradientEnd = Color(primaryDark);

  //FocusNodes and Controllers
  final FocusNode myFocusNodeEmployeeEmail = FocusNode();
  final FocusNode myFocusNodeMessageDescription = FocusNode();

  TextEditingController EmployeeEmailController = new TextEditingController();
  TextEditingController MessageDescriptionController =  new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();




  @override
  Widget build(BuildContext context) {

    Future sendMessage(BuildContext context) async {
      final DBRef = FirebaseDatabase.instance.reference();

      DBRef.child('Messagescount')
          .child('count')
          .once()
          .then((DataSnapshot dataSnapShot) {
        currentMessageId = dataSnapShot.value;
        currentMessageIdString = "$currentMessageId";
        print(currentMessageId);
      });
      DBRef.child('MessagesDetails').child(currentMessageIdString).set({
        "MessageDescription": MessageDescriptionController.text,
        "EmployeeEmail": EmployeeEmailController.text,
        "Status":"Manager"
      });
      nextMessageId = currentMessageId + 1;
      DBRef.child('Messagescount').set({'count': nextMessageId});

      showInSnackBar('New Message uploaded successfully !!');
    }

    Future<bool> _onBackPressed() {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => MainApplication()));
    }

    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Add new Message'),
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
                        focusNode: myFocusNodeEmployeeEmail,
                        controller: EmployeeEmailController,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 22.0,
                            color: Color.fromRGBO(19, 46, 99, 10)),
                        maxLines: 1,
                        decoration: InputDecoration(
                            labelText: "Employee Email",
                            hintText: "Enter Employee Email",
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
                                    color: Colors.green,
                                    style: BorderStyle.solid))),
                      ),
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 30,
                      ),
                      TextField(
                        autofocus: false,
                        focusNode: myFocusNodeMessageDescription,
                        controller: MessageDescriptionController,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 22.0,
                            color: Color.fromRGBO(19, 46, 99, 10)),
                        maxLines: 5,
                        decoration: InputDecoration(
                            labelText: "Your message",
                            hintText: "Enter message",
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
                                    color: Colors.green,
                                    style: BorderStyle.solid))),
                      ),
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 25,
                      ),
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 500,
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
                              minWidth: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 2.5,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 30,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Send message",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: "WorkSansBold"),
                                ),
                              ),
                              onPressed: () {
                                sendMessage(context);
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
      backgroundColor: Theme.Colors.loginGradientStart,
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
