import 'package:flutter/material.dart';

import '../main.dart';

const String _hr = "EVA HR";

String _you =
    mainEmployee.employeeFirstName + ' ' + mainEmployee.employeeLastName;

class ChatMessage extends StatelessWidget {
  final String text;

  final bool state;

  ChatMessage({this.text, this.state});

  @override
  Widget build(BuildContext context) {
    setUser();
    return (!state)
        ? new Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Text((state) ? _hr : _you,
                        style: TextStyle(
                          fontFamily: '.SF UI Text',
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width / 20,
                          decoration: TextDecoration.none,
                          color: Colors.black,
                        )),
                    new Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(4),
                      child: new Text(
                        text,
                        maxLines: 10,
                        style: TextStyle(
                          fontFamily: '.SF UI Display',
                          fontSize: MediaQuery.of(context).size.width / 25,
                          decoration: TextDecoration.none,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
                new Container(
                  margin: const EdgeInsets.only(left: 8.0),
                  child: new CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 20,
                    backgroundColor: Color.fromRGBO(19, 46, 99, 10),
                    foregroundColor: Colors.white,
                    child: new Text((state) ? _hr[0] : _you[0]),
                  ),
                ),
              ],
            ),
          )
        : new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: new CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 20,
                    backgroundColor: Color.fromRGBO(19, 46, 99, 10),
                    foregroundColor: Colors.white,
                    child: new Text((state) ? _hr[0] : _you[0]),
                  ),
                ),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text((state) ? _hr : _you,
                        style: TextStyle(
                          fontFamily: '.SF UI Text',
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width / 20,
                          decoration: TextDecoration.none,
                          color: Color.fromRGBO(19, 46, 99, 10),
                        )),
                    new Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(4),
                      child: new Text(text,
                          maxLines: 10,
                          style: TextStyle(
                            fontFamily: '.SF UI Display',
                            fontSize: MediaQuery.of(context).size.width / 25,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            color: Colors.blueGrey,
                          )),
                    )
                  ],
                )
              ],
            ),
          );
  }
}

void setUser() {
  if (mainEmployee.employeeAuthority == 'Manager') _you = currentChatName;
}
