import 'dart:convert';

import 'package:employees_benefits/models/MessageDetails.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Key;
import '../main.dart';

List<String> names;
List<String> mails;
List<String> messages;
bool _saving=true;
class Messages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState2();
  }
}

class _MyAppState2 extends State<Messages> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(new Duration(seconds: 0), () {
      setState(() {
        _saving = true;
      });
    });
    names = new List<String>();
    mails = new List<String>();
    messages = new List<String>();
    getmessage();
    new Future.delayed(new Duration(seconds: 0), () {
      setState(() {
        _saving = false;
      });
    });
  }

  Future getData() async {
    new Future.delayed(new Duration(seconds: 0), () {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return MaterialApp(
      home: Scaffold(
        body: ModalProgressHUD(
          child: ListView.builder(
            itemExtent: MediaQuery.of(context).size.height / 15,
            itemCount: names.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    size: MediaQuery.of(context).size.width / 14,
                  ),
                  title: Text(
                    //Employee first name + last name
                    names[index],
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20),
                  ),
                  subtitle: Text(messages[index]),
                ),
                onTap: () {
                  currentChatName = names[index];
                  currentChatMail = mails[index];
                  mainAppState.openAnotherTab(7);
                },
              );
            },
          ),
          inAsyncCall: _saving,
          progressIndicator: CircularProgressIndicator(),),
      ),
    );
  }
  void getmessage() async {
    new Future.delayed(new Duration(seconds: 0), () {
      setState(() {
        _saving = true;
      });
    });
    /*DBRef.child('Messagescount')
        .child('count')
        .once()
        .then((DataSnapshot dataSnapShot) {
      currentMessageId = dataSnapShot.value;
      print("ID" + currentMessageId.toString());
    });*/

    final url =
        'https://employees-benifits-app.firebaseio.com/MessagesDetails.json';
    final httpClient = new Client();
    var response = await httpClient.get(url);
    var mess = jsonCodec.decode(response.body);
    print("size = ");
    print (mess.length);
    List<dynamic> mes = mess.values.toList();
    print("size2 = ");
    print (mes.length);
    //print(emps[1].employeeEmail);
    //print(mess[1]);
    for (int i = mess.length-1; i >= 0; --i) {
      if (!mails.contains(mes[i].employeeEmail)) {
        names.add(mes[i].employeetName);
        mails.add(mes[i].employeeEmail);
        messages.add(mes[i].messageDescription);
      }
    }

    /*DBRef.child('MessagesDetails').once().then((DataSnapshot dataSnapShot) {
     // print(dataSnapShot.value[1]["EmployeeEmail"]);
     // print(dataSnapShot.value[1]["MessageDescription"]);
      int count = 0;
      for (int i = mess.length-1; i > 0; --i) {
        if (!mails.contains(dataSnapShot.value[i]["EmployeeEmail"])) {
          names.add(dataSnapShot.value[i]["EmployeeName"]);
          mails.add(dataSnapShot.value[i]["EmployeeEmail"]);
          messages.add(dataSnapShot.value[i]["MessageDescription"]);
          count++;
        }
      }
      print(count);
    });*/
  }

}

_reviver(Object key, Object value) {
  if (key != null && value is Map) return new MessageDetails.fromJson(value);
  return value;
}

const jsonCodec = const JsonCodec(reviver: _reviver);