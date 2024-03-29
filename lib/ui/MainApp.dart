import 'dart:io';

import 'package:flutter/material.dart';

import '../main.dart';
import 'AboutUs.dart';
import 'AddSurvey.dart';
import 'AppNavigation.dart';
import 'CurrentBenefit.dart';
import 'CurrentCategory.dart';
import 'EditProfile.dart';
import 'MakeSurvey.dart';
import 'ManagerChat.dart';
import 'ManagerComplaints.dart';
import 'NewBenefit.dart';
import 'NewComplaint.dart';
import 'NewMessage.dart';
import 'PendingRequests.dart';
import 'SignIn.dart';

class MainApplication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return mainAppState = new MainApplicationState();
  }
}

class MainApplicationState extends State<MainApplication> {
  @override
  void initState() {
    super.initState();
    inNavigation = true;
    NewBenefit();
  }

  Future<bool> _onBackPressed() {
    //TODO: Add message box of exiting app
    exit(0);
  }

  int _currentIndex = mainCurrentIndex;
  final List<Widget> _children = [
    AppNavigation(0),
    AppNavigation(1),
    AppNavigation(2),
    AppNavigation(3)
  ];

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Eva pharma', style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromRGBO(19, 46, 99, 10),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Color.fromRGBO(19, 46, 99, 10),
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
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void openAnotherTab(int index) {
    if (index == 0) {
      Navigator.of(context).pop();
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new CurrentCategory(currentCategory)));
    } else if (index == 1) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => new NewBenefit()));
    } else if (index == 2) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => new NewMessage()));
    } else if (index == 3) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => new PendingRequests()));
    }
    else if (index == 4) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => new AddSurvey()));
    }
    else if (index == 5) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => new EditProfile()));
    }else if (index == 6) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => new SignIn()));
    }
    else if (index == 7) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => new ManagerChat()));
    }
    else if (index == 8) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => new NewComplaint()));
    }
    else if (index == 9) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => new ManagerComplaints()));
    }
    else if (index == 10) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => new MakeSurvey()));
    }
    else if (index == 11) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => new AboutUs()));
    }
    else if (index == 12) {
      BeneitFromHomeOrCategory=true;
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => new CurrentBenefit()));
    }
  }
}
