import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Messages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState2();
  }
}

class _MyAppState2 extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                },
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    size: MediaQuery.of(context).size.width / 14,
                  ),
                  title: Text(
                    'Ramy Francis',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Your problem is solved'),
                ),
              ),
              Divider(
                color: Colors.black,
                height: MediaQuery.of(context).size.width / 100,
              ),
              GestureDetector(
                onTap: () {
                },
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    size: MediaQuery.of(context).size.width / 14,
                  ),
                  title: Text(
                    'Andrew',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Help me please !!!'),
                ),
              ),
            ],
          )),
    );
  }
}
