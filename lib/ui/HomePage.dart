import 'package:carousel_pro/carousel_pro.dart';
import 'package:employees_benefits/models/ColorLoader.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';

List<String> LastImages;
List<Color> colors = new List<Color>();

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState0();
  }
}

class _MyAppState0 extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    colors.add(Colors.blue);
    colors.add(Colors.yellow);
    colors.add(Colors.blue);
    colors.add(Colors.yellow);
    LastImages = new List<String>();
    getLastImages();
  }

  Future getData() async {
    await new Future.delayed(const Duration(seconds: 0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Container(
      child: Center(
        child: new Container(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child:(LastImages.length == 0)
                ? ColorLoader(colors: colors, duration: Duration(milliseconds: 3000))
                :  Carousel(
              images: [
                Image.network(LastImages[0], fit: BoxFit.fill),
                Image.network(LastImages[1], fit: BoxFit.fill),
                Image.network(LastImages[2], fit: BoxFit.fill),
                Image.network(LastImages[3], fit: BoxFit.fill),
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

void getLastImages() {
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
    for (int i = currentBenefitId-1; i > currentBenefitId-5; --i) {
        LastImages.add(dataSnapShot.value[i]["benefitImage"]);
        count++;
    }
    print(count);
  });
}
