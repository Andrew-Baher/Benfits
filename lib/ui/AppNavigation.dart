import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';
import 'EditProfile.dart';

class HomeNavigation extends StatelessWidget {
  final int current;

  HomeNavigation(this.current);

  @override
  Widget build(BuildContext context) {
    if (current == 0)
      return MaterialApp(
        title: 'Eva pharma',
        home: HomePage(),
      );
    else if (current == 1)
      return MaterialApp(
        title: 'Eva pharma',
        home: Benefits(),
      );
    else if (current == 2)
      return MaterialApp(
        title: 'Eva pharma',
        home: Messages(),
      );
    return MaterialApp(
      title: 'Eva pharma',
      home: More(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState0();
  }
}

class _MyAppState0 extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: new Container(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: Carousel(
              images: [
                //TODO: Get the 3/4 latest benefits from db
                Image.asset('assets/BTech.jpeg', fit: BoxFit.fill),
                Image.asset('assets/EyeGlasses.jpeg', fit: BoxFit.fill),
                Image.asset('assets/FadyJewelry.jpeg', fit: BoxFit.fill),
                Image.asset('assets/ScalingUp.jpeg', fit: BoxFit.fill),
              ],
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotColor: Colors.white,
              indicatorBgPadding: 5.0,
              dotBgColor: Color.fromRGBO(48, 51, 86, 10),
              borderRadius: true,
            ),
          ),
        ),
      ),
    );
  }
}

class Benefits extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState1();
  }
}

class _MyAppState1 extends State<Benefits> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.count(
          // Create a grid with 3 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 8 widgets that display their index in the List.
          children: List.generate(items.length, (index) {
            return Center(
              child: Column(
                children: [
                  Text(
                    items[index],
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CurrentBenefit(items[index])));
                    },
                    child: Image.asset(assets[index],
                        height: MediaQuery.of(context).size.width / 3.5,
                        width: MediaQuery.of(context).size.width / 3.5),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

List<String> items = [
  'Shopping',
  'Transportation',
  'Medical',
  'Vacation',
  'Hotels',
  'Restaurants',
  'Grocery',
  'Dessert'
];

List<String> assets = [
  'assets/Shopping.png',
  'assets/Mwslaat.png',
  'assets/Medicals.png',
  'assets/Vacations.png',
  'assets/Hotels.png',
  'assets/Restaurants.png',
  'assets/Grocery.png',
  'assets/Dessert.png',
];

class CurrentBenefit extends StatefulWidget {
  String currentBenefit;

  CurrentBenefit(String item) {
    this.currentBenefit = item;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new CurrentBenefitState();
  }
}

class CurrentBenefitState extends State<CurrentBenefit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(widget.currentBenefit),
      ),
      body: new GridView.extent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
          mainAxisSpacing: MediaQuery.of(context).size.width / 50,
          crossAxisSpacing: MediaQuery.of(context).size.width / 50,
          children: _buildBenefitassets(3)),
    );
  }
}

List<Widget> _buildBenefitassets(numberOfTiles) {
  List<Container> containers =
      new List<Container>.generate(numberOfTiles, (int index) {
    return new Container(
      child: new Image.asset(
        benefitassets[index],
        fit: BoxFit.fill,
      ),
    );
  });
  return containers;
}

List<String> benefitassets = [
  'assets/Shopping_AlFady.jpeg',
  'assets/Shopping_BlueEyes.jpeg',
  'assets/Shopping_BTech.jpeg',
];

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

class More extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState3();
  }
}

class _MyAppState3 extends State<More> {
  int _currentIndex = mainCurrentIndex;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => new EditProfile()));
            },
            child: ListTile(
              leading: Icon(
                Icons.person,
                size: MediaQuery.of(context).size.width / 16,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: ListTile(
              leading: Icon(
                Icons.settings,
                size: MediaQuery.of(context).size.width / 16,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: ListTile(
              leading: Icon(
                Icons.priority_high,
                size: MediaQuery.of(context).size.width / 16,
              ),
              title: Text(
                'Complaints',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: ListTile(
              leading: Icon(
                Icons.person_pin,
                size: MediaQuery.of(context).size.width / 16,
              ),
              title: Text(
                'About us',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: ListTile(
              leading: Icon(
                Icons.power_settings_new,
                size: MediaQuery.of(context).size.width / 16,
              ),
              title: Text(
                'Log out',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
