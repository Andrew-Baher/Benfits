import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import 'ChatMessage.dart';

List<ChatMessage> _messages ;
String currentText;
String formattedDate;

class Chats extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatsState();
  }
}

class _ChatsState extends State<Chats> {
  static DateTime now = DateTime.now();
  String Date = DateFormat('EEE d MMM, kk:mm ').format(now);
  final TextEditingController textEditingController =
  new TextEditingController();
  void _handleSubmit(String text) {
    textEditingController.clear();
    ChatMessage chatMessage = new ChatMessage(text: text, state: false, messageTime: Date);
    currentText=text;
    sendMessage();
    setState(() {
      //used to rebuild our widget
      _messages.insert(0, chatMessage);
    });
  }

  Widget _textComposerWidget() {
    return new IconTheme(
      data: new IconThemeData(color: Colors.blue),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "Enter your message"),
                controller: textEditingController,
                onSubmitted: _handleSubmit,
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send, color: Color.fromRGBO(19, 46, 99, 10)),
                onPressed: () => _handleSubmit(textEditingController.text),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future getData() async {
    await new Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _messages = new List<ChatMessage>();
    getChatMessages();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return new Column(
      children: <Widget>[
        new Flexible(
          child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          ),
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: _textComposerWidget(),
        )
      ],
    );
  }
}

void sendMessage()
{
  DateTime now = DateTime.now();
  formattedDate = DateFormat('EEE d MMM, kk:mm ').format(now);
  print(formattedDate);

  DBRef.child('Messagescount')
      .child('count')
      .once()
      .then((DataSnapshot dataSnapShot) {
    currentMessageId = dataSnapShot.value;
    currentMessageIdString = "$currentMessageId";
    print(currentMessageId);
  });
  DBRef.child('MessagesDetails').child(currentMessageIdString).set({
    "MessageDescription": currentText,
    "EmployeeEmail": mainEmployee.employeeEmail,
    "EmployeeName": mainEmployee.employeeFirstName+' '+mainEmployee.employeeLastName,
    "Status":"User",
    "MessageTiming": formattedDate
  });
  nextMessageId = currentMessageId + 1;
  DBRef.child('Messagescount').set({'count': nextMessageId});

}

void getChatMessages() {
  DBRef.child('Messagescount')
      .child('count')
      .once()
      .then((DataSnapshot dataSnapShot) {
    currentMessageId = dataSnapShot.value;
    print("ID"+currentMessageId.toString());
  });

  DBRef.child('MessagesDetails').once().then((DataSnapshot dataSnapShot) {
    print(dataSnapShot.value[1]["EmployeeEmail"]);
    print(dataSnapShot.value[1]["MessageDescription"]);
    int count = 0;
    for (int i = 1; i < currentMessageId; ++i) {
      if (dataSnapShot.value[i]["EmployeeEmail"] ==
          mainEmployee.employeeEmail) {
        ChatMessage chatMessage;
        if (dataSnapShot.value[i]["Status"] == "Manager")
          chatMessage = new ChatMessage(
              text: dataSnapShot.value[i]["MessageDescription"], state: true, messageTime: dataSnapShot.value[i]["MessageTiming"]);
        else
          chatMessage = new ChatMessage(
              text: dataSnapShot.value[i]["MessageDescription"], state: false, messageTime: dataSnapShot.value[i]["MessageTiming"]);

        _messages.insert(0, chatMessage);
        count++;
      }
    }
    print(count);
  });
}