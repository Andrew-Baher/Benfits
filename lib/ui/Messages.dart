import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';

List<String> names;
List<String> mails;
List<String> messages;

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
    names = new List<String>();
    mails = new List<String>();
    messages = new List<String>();
    getmessage();
  }

  Future getData() async {
    await new Future.delayed(const Duration(seconds: 0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
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
      ),
    );
  }
}

void getmessage() async {
  DBRef.child('Messagescount')
      .child('count')
      .once()
      .then((DataSnapshot dataSnapShot) {
    currentMessageId = dataSnapShot.value;
    print("ID" + currentMessageId.toString());
  });

  DBRef.child('MessagesDetails').once().then((DataSnapshot dataSnapShot) {
    print(dataSnapShot.value[1]["EmployeeEmail"]);
    print(dataSnapShot.value[1]["MessageDescription"]);
    int count = 0;
    for (int i = currentMessageId - 1; i > 0; --i) {
      if (!mails.contains(dataSnapShot.value[i]["EmployeeEmail"])) {
        names.add(dataSnapShot.value[i]["EmployeeName"]);
        mails.add(dataSnapShot.value[i]["EmployeeEmail"]);
        messages.add(dataSnapShot.value[i]["MessageDescription"]);
        count++;
      }
    }
    print(count);
  });
}
