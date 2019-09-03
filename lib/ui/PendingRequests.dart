import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../main.dart';
import '../models/Employee.dart';
import 'MainApp.dart';
import 'PendingRequestsApprovals.dart';

class PendingRequests extends StatefulWidget {
  @override
  _PendingRequestsState createState() => new _PendingRequestsState();
}


int currIndex;

class _PendingRequestsState extends State<PendingRequests> {
  //Palette
  static int primary = hexStringToHexInt('080c2d');
  static int primaryDark = hexStringToHexInt('#000004');
  static int primaryLight = hexStringToHexInt('#303356');

  static Color loginGradientStart = Color(primaryLight);
  static Color loginGradientEnd = Color(primaryDark);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    pendingEmployees = new List<Employee>();
    getPendingEmps();
  }

  Future getData() async {
    await new Future.delayed(const Duration(seconds: 0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getData();
    Future<bool> _onBackPressed() {
      mainCurrentIndex=3;
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => MainApplication()));
    }

    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Show pending requests'),
          backgroundColor: Color.fromRGBO(19, 46, 99, 10),
        ),
        body: new MaterialApp(
          home: ListView.builder(
              itemExtent: MediaQuery.of(context).size.height / 15,
              itemCount: pendingEmployees.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      size: MediaQuery.of(context).size.width / 12,
                    ),
                    title: Text(
                      //Employee first name + last name
                      '${pendingEmployees[index].employeeFirstName + ' ' + pendingEmployees[index].employeeLastName}',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 20),
                    ),
                    subtitle: Text(pendingEmployees[index].employeePosition),
                  ),
                  onTap: () {
                    currIndex=index;
                    _openPendingRequestApprovals();

                  },
                );
              },
            ),

        ),
      ),
    );
  }
  _openPendingRequestApprovals(){
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => new PendingRequestsApprovals(
            pendingEmployees[currIndex])));
  }
}

getPendingEmps() async {
  //Get all employees from firebase
  final url = 'https://employees-benifits-app.firebaseio.com/employees.json';
  final httpClient = new Client();
  var response = await httpClient.get(url);

  Map employees = jsonCodec.decode(response.body);
  List<dynamic> emps = employees.values.toList();

  print(emps.length);

  //Check employees with employeeApprovalStatus = false
  for (int i = 0; i < emps.length; i++)
    if (emps[i].employeeApprovalStatus.toString() == 'false') {
      pendingEmployees.add(new Employee(
          emps[i].employeeID,
          emps[i].employeeFirstName,
          emps[i].employeeLastName,
          emps[i].employeeEmail,
          emps[i].employeePassword,
          emps[i].employeePhoneNumber,
          emps[i].employeeCompanyID,
          emps[i].employeePosition,
          emps[i].employeeAuthority,
          emps[i].employeeApprovalStatus));
    }
}

hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return val;
}

_reviver(Object key, Object value) {
  if (key != null && value is Map) return new Employee.fromJson(value);
  return value;
}

const jsonCodec = const JsonCodec(reviver: _reviver);
