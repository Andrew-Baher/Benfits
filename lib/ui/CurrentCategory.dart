import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';
import 'MainApp.dart';
import 'CurrentBenefit.dart';

String globalCurrentBenefit;

List<String> categoryImages;

List<String> categoryDescription;

List<String> categoryTitle;

class CurrentCategory extends StatefulWidget {
  String currentBenefit;

  CurrentCategory(String item) {
    this.currentBenefit = item;
    globalCurrentBenefit = item;

  }

  @override
  State<StatefulWidget> createState() {
    return new CurrentCategoryState();
  }
}

class CurrentCategoryState extends State<CurrentCategory> {
  Future<bool> _onBackPressed() {
    mainCurrentIndex=1;
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => MainApplication()));
  }

  @override
  void initState() {
    super.initState();
    categoryImages = new List<String>();
    categoryDescription = new List<String>();
    categoryTitle = new List<String>();
    getImages();
  }

  Future getData() async {
    await new Future.delayed(const Duration(seconds: 0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        appBar: AppBar(
          title: new Text(widget.currentBenefit),
          backgroundColor: Color.fromRGBO(19, 46, 99, 10),

        ),
        body: (categoryImages.length == 0)
            ? Text(
                "No Benefits to display in this category",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width / 15,
                    fontFamily: "WorkSansBold",
                    fontWeight: FontWeight.bold),
              )
            : new GridView.extent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                mainAxisSpacing: MediaQuery.of(context).size.width / 50,
                crossAxisSpacing: MediaQuery.of(context).size.width / 50,
                children: new List<Container>.generate(categoryImages.length,
                    (int index) {
                  return new Container(
                    child: GestureDetector(
                      onTap: () {
                        mainCurrentBenefitImage = categoryImages[index];
                        mainCurrentBenefitDescription =
                            categoryDescription[index];
                        mainCurrentBenefitTitle = categoryTitle[index];
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new CurrentBenefit()));
                      },
                      child: new Image.network(
                        categoryImages[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }),
              ),
      ),
    );
  }
}

void getImages() {
  DBRef2.child('Benefitscount')
      .child('count')
      .once()
      .then((DataSnapshot dataSnapShot) {
    currentBenefitId = dataSnapShot.value;
    print(currentBenefitId);
  });

  DBRef2.child('benefitsDetails').once().then((DataSnapshot dataSnapShot) {
    print(dataSnapShot.value[1]["benefitImage"]);
    print(dataSnapShot.value[1]["benefitCategory"]);
    int count = 0;
    for (int i = 1; i < currentBenefitId; ++i) {
      if (dataSnapShot.value[i]["benefitCategory"] == globalCurrentBenefit) {
        categoryImages.add(dataSnapShot.value[i]["benefitImage"]);
        categoryDescription.add(dataSnapShot.value[i]["benefitDescription"]);
        categoryTitle.add(dataSnapShot.value[i]["benefitTitle"]);
        count++;
      }
    }
    print(count);
  });
}
