import 'dart:convert';
import 'dart:io';

import 'package:employees_benefits/models/BenefitDetails.dart';
import 'package:employees_benefits/style/theme.dart' as Theme;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import '../main.dart';
import 'MainApp.dart';

class NewBenefit extends StatefulWidget {
  @override
  _NewBenefit createState() => new _NewBenefit();
}

class _NewBenefit extends State<NewBenefit>
    with SingleTickerProviderStateMixin {
  //Palette
  static int primary = hexStringToHexInt('080c2d');
  static int primaryDark = hexStringToHexInt('#000004');
  static int primaryLight = hexStringToHexInt('#303356');

  static Color loginGradientStart = Color(primaryLight);
  static Color loginGradientEnd = Color(primaryDark);

  //FocusNodes and Controllers
  final FocusNode myFocusNodeBenefitTitle = FocusNode();
  final FocusNode myFocusNodeBenefitDescription = FocusNode();

  TextEditingController benefitTitleController = new TextEditingController();
  TextEditingController benefitDescriptionController =
  new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isChecked = true;
  bool progressIndicatorVisible = false;
  var url;

  List<DropdownMenuItem<String>> listDrop = [];
  List<String> drop = [
    'Shopping',
    'Transportation',
    'Medical',
    'Vacation',
    'Hotels',
    'Restaurants',
    'Grocery',
    'Dessert'
  ];
  String selected = null;

  void loadData() {
    listDrop = [];
    listDrop = drop
        .map((val) =>
    new DropdownMenuItem(
      child: new Text(val),
      value: val,
    ))
        .toList();
  }

  //List of companies
  List<String> companies = [
    "CompanyName1",
    "CompanyName2",
    "CompanyName3",
    "CompanyName4"
  ];

  @override
  Widget build(BuildContext context) {
    File _image;
    loadData();
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        mainImg = image;
      });
    }

    Future uploadPic(BuildContext context) async {
      progressIndicatorVisible = true;
      setState(() {});
      String fileName = Path.basename(mainImg.path);
      StorageReference firebaseStorageRef =
      FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(mainImg);
      var downloadingurl =
      await (await uploadTask.onComplete).ref.getDownloadURL();
      url = downloadingurl.toString();
      final DBRef = FirebaseDatabase.instance.reference();

      DBRef.child('Benefitscount')
          .child('count')
          .once()
          .then((DataSnapshot dataSnapShot) {
        currentBenefitId = dataSnapShot.value;
        currentBenefitIdString = "$currentBenefitId";
        print(currentBenefitId);
      });
      DBRef.child('benefitsDetails').child(currentBenefitIdString).set({
        "benefitDescription": benefitDescriptionController.text,
        "benefitTitle": benefitTitleController.text,
        "benefitCategory": selected,
        "benefitImage": url,
      });
      nextBenefitId = currentBenefitId + 1;
      DBRef.child('Benefitscount').set({'count': nextBenefitId});
      progressIndicatorVisible = false;
      setState(() {});
      showInSnackBar('New benefit picture uploaded successfully !!');
    }

    Future<bool> _onBackPressed() {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => MainApplication()));
    }

    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Add new benefit'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(24),
              child: Center(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Visibility(
                          visible: progressIndicatorVisible,
                          child: new CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 3,
                          child: (mainImg != null)
                              ? Image.file(
                            mainImg,
                            fit: BoxFit.fill,
                          )
                              : Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHMTdy8vRGufRwCJ1RerUThoTalVNSd0Q3jDGGQ89DrjUiNZeZNw",
                            fit: BoxFit.fill,
                          ),
                          /*RaisedButton(
                          color: Colors.transparent,
                          onPressed: () { //TODO: SetState for raised button with picked image
                            getImage();
                          },
                           child: (_image!=null)?Image.file(
                             _image,
                             fit: BoxFit.fill,
                           ):new Text(
                            "Pick Gallery Image",
                             style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),*/
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 25,
                      ),
                      Container(
                          width: 300.0,
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                value: selected,
                                items: listDrop,
                                hint: new Text('Select Category of Benefit'),
                                onChanged: (value) {
                                  selected = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 30,
                      ),
                      TextField(
                        autofocus: false,
                        focusNode: myFocusNodeBenefitTitle,
                        controller: benefitTitleController,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 22.0,
                            color: Color.fromRGBO(19, 46, 99, 10)),
                        maxLines: 1,
                        decoration: InputDecoration(
                            labelText: "Benefit Title",
                            hintText: "Benefit Title",
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(48, 51, 86, 10),
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.green,
                                    style: BorderStyle.solid))),
                      ),
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 30,
                      ),
                      TextField(
                        autofocus: false,
                        focusNode: myFocusNodeBenefitDescription,
                        controller: benefitDescriptionController,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 22.0,
                            color: Color.fromRGBO(19, 46, 99, 10)),
                        maxLines: 5,
                        decoration: InputDecoration(
                            labelText: "Benefit Description",
                            hintText: "Benefit Description",
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(48, 51, 86, 10),
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.green,
                                    style: BorderStyle.solid))),
                      ),
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 25,
                      ),
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 500,
                      ),
                      Center(
                        child: Row(
                          children: <Widget>[
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              highlightColor: Colors.black,
                              splashColor: Theme.Colors.loginGradientStart,
                              color: Colors.green,
                              minWidth: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 2.5,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Upload pic",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: "WorkSansBold"),
                                ),
                              ),
                              onPressed: () {
                                uploadPic(context);
                              },
                            ),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 20,
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              highlightColor: Colors.black,
                              splashColor: Theme.Colors.loginGradientStart,
                              color: Colors.green,
                              minWidth: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 2.5,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 30,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Attach pic",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: "WorkSansBold"),
                                ),
                              ),
                              onPressed: () {
                                getImage();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Theme.Colors.loginGradientStart,
      duration: Duration(seconds: 3),
    ));
  }
}

hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return val;
}
