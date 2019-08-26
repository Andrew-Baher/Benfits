import 'package:carousel_pro/carousel_pro.dart';
import 'package:employees_benefits/models/ColorLoader.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../main.dart';

List<String> LastImages;
List<Color> colors = new List<Color>();
bool _saving = false;

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
    new Future.delayed(new Duration(seconds: 0), () {
      setState(() {
        _saving = true;
      });
    });
    LastImages = new List<String>();
    getLastImages();
    new Future.delayed(new Duration(seconds: 0), () {
      setState(() {
        _saving = false;
      });
    });
  }

  Future getData() async {
    await new Future.delayed(new Duration(seconds: 0), () {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return ModalProgressHUD(
      child: Container(
        child:(LastImages.length==0)?Text('') :Center(
          child: new Container(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: Carousel(
                images: [
                  Image.network(
                    LastImages[0],
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                  Image.network(
                    LastImages[1],
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                  Image.network(
                    LastImages[2],
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                  Image.network(
                    LastImages[3],
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
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
      ),
      inAsyncCall: _saving,
      progressIndicator: CircularProgressIndicator(),
    );
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
      for (int i = currentBenefitId - 1; i > currentBenefitId - 5; --i) {
        LastImages.add(dataSnapShot.value[i]["benefitImage"]);
        count++;
      }
      print(count);
    });
    loadingLastFourImages = false;
    setState(() {});
  }
}
