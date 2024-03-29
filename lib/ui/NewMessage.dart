import 'package:employees_benefits/style/theme.dart' as Theme;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../main.dart';
import 'MainApp.dart';
import 'SignIn.dart';

String formattedDate;
String MessageID;


class NewMessage extends StatefulWidget {
  @override
  _NewMessage createState() => new _NewMessage();
}

class _NewMessage extends State<NewMessage>
    with SingleTickerProviderStateMixin {
  bool _saving = false;
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
  TextEditingController MessageDescriptionController =
      new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<DropdownMenuItem<String>> listDrop = [];
  String sendToName;

  List<String> drop = [
    'Send to specific Employee',
    'Send to all Employees',
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

  @override
  Widget build(BuildContext context) {
    loadData();
    Future senddata(BuildContext context, String email, String name) async {
      /*DBRef.child('Messagescount')
          .child('count')
          .once()
          .then((DataSnapshot dataSnapShot) {
        currentMessageId = dataSnapShot.value;
        currentMessageIdString = "$currentMessageId";
        print(currentMessageId);
      });*/
      DBRef.child('MessagesDetails').child(MessageID).set({
        "MessageDescription": MessageDescriptionController.text,
        "EmployeeEmail": email,
        "EmployeeName": name,
        "Status": "Manager",
        "MessageTiming": formattedDate
      });
      //nextMessageId = currentMessageId + 1;
      //DBRef.child('Messagescount').set({'count': nextMessageId});
    }

    Future sendMessage(BuildContext context) async {
      new Future.delayed(new Duration(seconds: 0), () {
        setState(() {

          _saving = true;
        });
      });

      DateTime now = DateTime.now();
      formattedDate = DateFormat('EEE d MMM, kk:mm ').format(now);
      MessageID = DateFormat('EEE d MMM yy, kk:mm:ss ').format(now);
      print(formattedDate);

      final url =
          'https://employees-benifits-app.firebaseio.com/employees.json';
      final httpClient = new Client();
      var response = await httpClient.get(url);

      Map employees = jsonCodec.decode(response.body);
      List<dynamic> emps = employees.values.toList();

      //TRIALS for debugging
      print(emps[0].employeeEmail + '\n' + emps[0].employeePassword);

      if (MessageDescriptionController.text == '') {
        showInSnackBar('Please enter a message body !');
      } else if (selected == 'Send to specific Employee') {
        for (int i = 0; i < emps.length; i++)
          if (emps[i].employeeEmail == EmployeeEmailController.text) {
            sendToName =
                emps[i].employeeFirstName + ' ' + emps[i].employeeLastName;
          }
        /*DBRef.child('Messagescount')
            .child('count')
            .once()
            .then((DataSnapshot dataSnapShot) {
          currentMessageId = dataSnapShot.value;
          currentMessageIdString = "$currentMessageId";
          print(currentMessageId);
        });*/
        DBRef.child('MessagesDetails').child(MessageID).set({
          "MessageDescription": MessageDescriptionController.text,
          "EmployeeEmail": EmployeeEmailController.text,
          "EmployeeName": sendToName,
          "Status": "Manager",
          "MessageTiming": formattedDate
        });
        //nextMessageId = currentMessageId + 1;
        //DBRef.child('Messagescount').set({'count': nextMessageId});

        showInSnackBar('New Message uploaded successfully !!');
      } else {
        //showInSnackBar('Wait till finish');
        //Compare the entered email & pass with db
        for (int i = 0; i < emps.length; i++)
          if (emps[i].employeeEmail != mainEmployee.employeeEmail &&
              emps[i].employeeApprovalStatus == true) {
            await new Future.delayed(const Duration(seconds: 1));
            await senddata(context, emps[i].employeeEmail,
                emps[i].employeeFirstName + ' ' + emps[i].employeeLastName);
          }
        new Future.delayed(new Duration(seconds: 0), () {
          setState(() {
            _saving = false;
          });
        });
        showInSnackBar('All Messages uploaded successfully !!');
      }
      MessageDescriptionController.text="";
      EmployeeEmailController.text="";
      selected=null;
      new Future.delayed(new Duration(seconds: 0), () {
        setState(() {
          _saving = false;
        });
      });
    }

    Future<bool> _onBackPressed() {
      mainCurrentIndex = 3;
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => MainApplication()));
    }

    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Add new Message'),
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
                    Container(
                        width: 300.0,
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              value: selected,
                              items: listDrop,
                              hint: new Text('Send to'),
                              onChanged: (value) {
                                selected = value;
                                setState(() {});
                              },
                            ),
                          ),
                        )),
                    (selected == 'Send to specific Employee')
                        ? TextField(
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(19, 46, 99, 10),
                                        style: BorderStyle.solid))),
                          )
                        : Text(''),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
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
                                "Send message",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "WorkSansBold"),
                              ),
                            ),
                            onPressed: () {

                              sendMessage(context);
                              setState(() {
                                _saving = false;
                              });
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
