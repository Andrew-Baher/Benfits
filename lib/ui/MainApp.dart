import 'package:flutter/material.dart';

import '../main.dart';
import 'AppNavigation.dart';
import 'NewBenefit.dart';


class MainApplication extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MainApplicationState();
  }
}

class MainApplicationState extends State<MainApplication> {

  @override
  void initState() {
    super.initState();
    NewBenefit();
  }

  int _currentIndex = mainCurrentIndex;
  final List<Widget> _children = [
    HomeNavigation(0),
    HomeNavigation(1),
    HomeNavigation(2),
    HomeNavigation(3)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Eva pharma', style: TextStyle(color: Colors.white)),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.blue,
              primaryColor: Colors.yellow,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.white))),
          // sets the inactive color of the `BottomNavigationBar`
          child: new BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.dashboard),
                title: new Text('Benefits'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.mail),
                title: new Text('Messages'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.more_vert), title: Text('More'))
            ],
          ),
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
