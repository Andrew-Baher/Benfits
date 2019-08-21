import 'package:flutter/material.dart';

import '../main.dart';

const String _hr = "EVA HR";

String _you = mainEmployee.employeeFirstName+' '+mainEmployee.employeeLastName;

class ChatMessage extends StatelessWidget {
  final String text ;
  final bool state;
  ChatMessage({this.text,this.state});

  @override
  Widget build(BuildContext context) {
    setUser();
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(
              backgroundColor: Color.fromRGBO(19, 46, 99, 10),
              foregroundColor: Colors.white,
              child: new Text((state)?_hr[0]:_you[0]),
            ),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text((state)?_hr:_you,style: Theme.of(context).textTheme.subhead),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(text,style: Theme.of(context).textTheme.subtitle,),
              )
            ],
          )
        ],
      ),
    );
  }
}

void setUser() {
  if(mainEmployee.employeeAuthority=='Manager')
    _you=currentChat;
}