import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:employees_benefits/models/BenefitDetails.dart';
import 'package:employees_benefits/models/ColorLoader.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../main.dart';
import 'CurrentBenefit.dart';

List<String> LastImages;
List<String> LastDescription;
List<String> LastTitle;
List<bool> LastApply;
List<String> LastID;

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
    LastDescription = new List<String>();
    LastTitle = new List<String>();
    LastApply = new List<bool>();
    LastID = new List<String>();
    getLastImages();
    new Future.delayed(new Duration(seconds: 0), () {
      setState(() {
        _saving = false;
      });
    });
  }

  Future getData() async {
    await new Future.delayed(new Duration(seconds: 0), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return ModalProgressHUD(
      child: Container(
        child: (LastImages.length == 0)
            ? Text('')
            : Center(
                child: new Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Carousel(
                      images: [
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              mainCurrentBenefitImage = LastImages[0];
                              mainCurrentBenefitDescription =
                                  LastDescription[0];
                              mainCurrentBenefitTitle = LastTitle[0];
                              mainCurrentBenefitApply = LastApply[0];
                              mainCurrentBenefitID = LastID[0];
                              mainAppState.openAnotherTab(12);
                            },
                            child: Image.network(
                              LastImages[0],
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              mainCurrentBenefitImage = LastImages[1];
                              mainCurrentBenefitDescription =
                                  LastDescription[1];
                              mainCurrentBenefitTitle = LastTitle[1];
                              mainCurrentBenefitApply = LastApply[1];
                              mainCurrentBenefitID = LastID[1];
                              mainAppState.openAnotherTab(12);
                            },
                            child: Image.network(
                              LastImages[1],
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              mainCurrentBenefitImage = LastImages[2];
                              mainCurrentBenefitDescription =
                                  LastDescription[2];
                              mainCurrentBenefitTitle = LastTitle[2];
                              mainCurrentBenefitApply = LastApply[2];
                              mainCurrentBenefitID = LastID[2];
                              mainAppState.openAnotherTab(12);
                            },
                            child: Image.network(
                              LastImages[2],
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              mainCurrentBenefitImage = LastImages[3];
                              mainCurrentBenefitDescription =
                                  LastDescription[3];
                              mainCurrentBenefitTitle = LastTitle[3];
                              mainCurrentBenefitApply = LastApply[3];
                              mainCurrentBenefitID = LastID[3];
                              mainAppState.openAnotherTab(12);
                            },
                            child: Image.network(
                              LastImages[3],
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
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

  Future getLastImages() async {
    /*
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
}*/
    final url =
        'https://employees-benifits-app.firebaseio.com/benefitsDetails.json';
    final httpClient = new Client();
    var response = await httpClient.get(url);
    var mess = jsonCodec.decode(response.body);
    print("size = ");
    print(mess.length);
    List<dynamic> mes = mess.values.toList();
    print("size2 = ");
    print(mes.length);
    print((mes[0].benefitApply));
    //print(emps[1].employeeEmail);
    //print(mess[1]);
    for (int i = mess.length - 1; i > mess.length - 5; --i) {
      LastImages.add(mes[i].benefitImage);
      LastDescription.add(mes[i].benefitDescription);
      LastTitle.add(mes[i].benefitTitle);
      LastApply.add(mes[i].benefitApply);
      LastID.add(mes[i].benefitID);
    }
  }
}

_reviver(Object key, Object value) {
  if (key != null && value is Map) return new BenefitDetails.fromJson(value);
  return value;
}

const jsonCodec = const JsonCodec(reviver: _reviver);
