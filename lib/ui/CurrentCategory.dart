import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';
import 'MainApp.dart';
String globalCurrentBenefit;
List<String> Categoryassets ;
bool once ;
class CurrentCategory extends StatefulWidget {
  String currentBenefit;

  CurrentCategory(String item) {
    this.currentBenefit = item;
    globalCurrentBenefit=item;
    once=true;
    Categoryassets=[];
  }

  @override
  State<StatefulWidget> createState() {
    final DBRef = FirebaseDatabase.instance.reference();

    DBRef.child('Benefitscount').child('count').once().then((DataSnapshot dataSnapShot)
    {
      currentBenefitId=dataSnapShot.value;
      print(currentBenefitId);
    });


    DBRef.child('benefitsDetails').once().then((DataSnapshot dataSnapShot)
    {
      print(dataSnapShot.value[1]["benefitImage"]);
      print(dataSnapShot.value[1]["benefitCategory"]);
      int count=0;
      for(int i=1;i<currentBenefitId;++i)
      {
        if(dataSnapShot.value[i]["benefitCategory"]==globalCurrentBenefit) {
          Categoryassets.add(dataSnapShot.value[i]["benefitImage"]);
          count++;
        }
      }
      print(count);

    });
    return new CurrentCategoryState();
  }
}

class CurrentCategoryState extends State<CurrentCategory> {
  Future<bool> _onBackPressed() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MainApplication()));
  }

  Future getData() async {
    await new Future.delayed(const Duration(seconds: 0));
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        appBar: AppBar(
          title: new Text(widget.currentBenefit),
        ),
        body: new GridView.extent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
            mainAxisSpacing: MediaQuery.of(context).size.width / 50,
            crossAxisSpacing: MediaQuery.of(context).size.width / 50,
            children: _buildCategorytassets(Categoryassets.length)),
      ),
    );
  }
}

List<Widget> _buildCategorytassets(numberOfTiles) {
  List<Container> containers =
      new List<Container>.generate(numberOfTiles, (int index) {
    return new Container(
      child: new Image.network(
        Categoryassets[index],
        fit: BoxFit.fill,
      ),
    );
  });
  return containers;
}

