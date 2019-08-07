import 'dart:convert';
import 'dart:io';

import 'package:employees_benefits/models/BenefitDetails.dart';
import 'package:employees_benefits/style/theme.dart' as Theme;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

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
  TextEditingController benefitDescriptionController = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isChecked = true;

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
    Future<File> image;

    Future uploadPic(BuildContext context) async{
      String fileName = Path.basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
      showInSnackBar('New benefit picture uploaded successfully !!');
    }

    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(24),
            child: Center(
                child: Column(
                  children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                        child: RaisedButton(
                          color: Colors.transparent,
                          onPressed: () { //TODO: SetState for raised button with picked image
                            image = ImagePicker.pickImage(source: ImageSource.gallery)
                              .whenComplete(() {
                            setState(() {
                              _image = image as File;
                            });
                          });
                          },
                           child: new Text(
                            "Pick Gallery Image",
                             style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                  ),
                ),
                  SizedBox(
                  height: MediaQuery.of(context).size.height / 25,
                  ),
                  TextField(
                    autofocus: false,
                    obscureText: false,
                    style: TextStyle(
                        fontFamily: "WorkSansSemiBold", fontSize: 22.0, color: Color.fromRGBO(19, 46, 99, 10)),
                    keyboardType: TextInputType.text,
                    focusNode: myFocusNodeBenefitTitle,
                    controller: benefitTitleController,
                    decoration: InputDecoration(
                      labelText: "BenefitTitle",
                      hintText: "Benefit Title",
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(48, 51, 86, 10),
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.green,
                              style: BorderStyle.solid))),
                  ),
                  SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                  ),
                  TextField(
                  autofocus: false,
                  focusNode: myFocusNodeBenefitDescription,
                  controller: benefitDescriptionController,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(
                      fontFamily: "WorkSansSemiBold", fontSize: 22.0, color: Color.fromRGBO(19, 46, 99, 10)),
                  maxLines: 5,
                  decoration: InputDecoration(
                      labelText: "BenefitDescription",
                      hintText: "Benefit Description",
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(48, 51, 86, 10),
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.green,
                              style: BorderStyle.solid))),
                ),
                  SizedBox(
                  height: MediaQuery.of(context).size.height / 25,
                ),
                  Row(
                    children: <Widget>[
                     Text(
                          'Assign to: ',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                        ),
                   ],
                   //TODO: Add listView like this: ListView(
                   //                          scrollDirection: Axis.vertical,
                   //                          children: companies.map((text) => CheckboxListTile(
                   //                          title: Text(text),
                   //                          value: _isChecked,
                   //                          onChanged: (val) {
                   //                            setState(() {
                   //                              _isChecked = val;
                   //                            });
                   //                          },
                   //                          )).toList(),
                   //                      ),
                 ),

                  SizedBox(
                  height: MediaQuery.of(context).size.height / 500,
                ),
                  ButtonTheme(
                  //elevation: 4,
                  //color: Colors.green,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 5),
                      decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Theme.Colors.loginGradientStart,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                        BoxShadow(
                          color: Theme.Colors.loginGradientEnd,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                      ],
                      gradient: new LinearGradient(
                          colors: [
                            Theme.Colors.loginGradientEnd,
                            Theme.Colors.loginGradientStart
                          ],
                          begin: const FractionalOffset(0.2, 0.2),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                      child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: Theme.Colors.loginGradientEnd,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "WorkSansBold"),
                          ),
                        ),
                        onPressed: _onSaveNewBenefitPress),
                  ),
                ),
              ],
            )),
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
            color: Colors.white, fontSize: 16.0, fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Theme.Colors.loginGradientStart,
      duration: Duration(seconds: 3),
    ));
  }


  void _onSaveNewBenefitPress() async {
    String newBenefitTitle = benefitTitleController.text;
    String newBenefitDescription = benefitDescriptionController.text;
    List<String> newBenefitCompaniesIDs = null; //TODO: Get from listview

    _saveData(new BenefitDetails(
        newBenefitTitle, "", newBenefitDescription, newBenefitCompaniesIDs));
    _loadData();
    showInSnackBar("Your data is sent successfully !!");
    await new Future.delayed(const Duration(seconds: 3));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainApplication()),
    );
  }



}

_reviver(Object key, Object value) {
  if (key != null && value is Map) return new BenefitDetails.fromJson(value);
  return value;
}

const jsonCodec = const JsonCodec(reviver: _reviver);


_saveData(BenefitDetails newBenefit) async {
  var json = jsonCodec.encode(newBenefit);

  final url = 'https://employees-benifits-app.firebaseio.com/benefitsDetails.json';
  final httpClient = new Client();
  var response = await httpClient.post(url, body: json);
}

_loadData() async {
  final url = 'https://employees-benifits-app.firebaseio.com/benefitsDetails.json';
  final httpClient = new Client();
  var response = await httpClient.get(url);

  Map benefits = jsonCodec.decode(response.body);

}

hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return val;
}


