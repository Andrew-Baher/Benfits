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
    return (!state &&
            mainEmployee.employeeAuthority.toString() != state.toString())
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
                          fontSize: MediaQuery.of(context).size.width / 20,
                          decoration: TextDecoration.none,
                          color: Colors.red,
                        )),
                    new Container(
                      margin: const EdgeInsets.only(left: 16.0),
                      child: new Text(
                        text,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 25,
                          decoration: TextDecoration.none,
                          color: Colors.blueGrey,
                        ),
                      ),
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
                new Container(
                  margin: const EdgeInsets.only(left: 16.0),
                  child: new CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 40,
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
                  margin: const EdgeInsets.only(right: 16.0),
                  child: new CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 40,
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
                          fontSize: MediaQuery.of(context).size.width / 20,
                          decoration: TextDecoration.none,
                          color: Colors.black,
                        )),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text(text,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 25,
                            decoration: TextDecoration.none,
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
  if (mainEmployee.employeeAuthority == 'Manager') _you = currentChat;
}
