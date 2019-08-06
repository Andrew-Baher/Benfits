import 'package:flutter/material.dart';
import 'package:swipe_button/swipe_button.dart';

class PendingRequests extends StatefulWidget {
  @override
  _PendingRequestsState createState() => new _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  //Palette
  static int primary = hexStringToHexInt('080c2d');
  static int primaryDark = hexStringToHexInt('#000004');
  static int primaryLight = hexStringToHexInt('#303356');

  static Color loginGradientStart = Color(primaryLight);
  static Color loginGradientEnd = Color(primaryDark);

  final primaryGradient = LinearGradient(
    colors: [loginGradientStart, loginGradientEnd],
    stops: [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Colors.transparent,
      elevation: 4.0,
      child: new Container(
        width: (MediaQuery.of(context).size.width) / 1.2,
        height: (MediaQuery.of(context).size.height) / 1.7,
        decoration: new BoxDecoration(
          gradient: LinearGradient(
            colors: [loginGradientStart, loginGradientEnd],
            stops: [0.0, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: new Column(
          children: <Widget>[
            new Container(
              width: (MediaQuery.of(context).size.width) / 1.2,
              height: (MediaQuery.of(context).size.height) / 1.7,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.only(
                    topLeft: new Radius.circular(8.0),
                    topRight: new Radius.circular(8.0)),
                image: DecorationImage(image: AssetImage('assets/BTech.jpeg')),
              ),
            ),
            new Container(
                width: (MediaQuery.of(context).size.width) / 1.2,
                height: ((MediaQuery.of(context).size.height) / 1.7) -
                    (MediaQuery.of(context).size.height) / 2.2,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new SwipeButton(
                      content: Text('Decline'),
                      height: MediaQuery.of(context).size.height / 10,
                      initialPosition: SwipePosition.SwipeLeft,
                      onChanged: (result) {
                        print('onChanged $result');
                      },
                      //TODO: OnClick not found
                    ),
                    new SwipeButton(
                        content: Text('Accept'),
                        height: MediaQuery.of(context).size.height / 10,
                        initialPosition: SwipePosition.SwipeRight,
                        onChanged: (result) {
                          print('onChanged $result');
                        }
                        //TODO: OnClick not found
                        ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return val;
}
