import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/Employee.dart';
import 'PendingRequestsApprovals.dart';

class PendingRequests extends StatefulWidget {

  @override
  _PendingRequestsState createState() => new _PendingRequestsState();
}

List<Employee> pendingEmployees;

class _PendingRequestsState extends State<PendingRequests> {
  //Palette
  static int primary = hexStringToHexInt('080c2d');
  static int primaryDark = hexStringToHexInt('#000004');
  static int primaryLight = hexStringToHexInt('#303356');

  static Color loginGradientStart = Color(primaryLight);
  static Color loginGradientEnd = Color(primaryDark);

  @override
  void initState() {
    super.initState();
    pendingEmployees = new List<Employee>();
    getPendingEmps();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemExtent: MediaQuery.of(context).size.height / 15,
          itemCount: pendingEmployees.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: MediaQuery.of(context).size.width / 12,
                ),
                title: Text( //Employee first name + last name
                    '${pendingEmployees[index].employeeFirstName + ' ' + pendingEmployees[index].employeeLastName}',
                style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),),
                subtitle: Text(pendingEmployees[index].employeePosition),
              ),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => new PendingRequestsApprovals(pendingEmployees[index])));
              },
            );
          },
        ),
      ),
    );
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
      pendingEmployees.add(new Employee(emps[i].employeeID, emps[i].employeeFirstName, emps[i].employeeLastName,
          emps[i].employeeEmail, emps[i].employeePassword, emps[i].employeePhoneNumber, emps[i].employeeCompanyID,
          emps[i].employeePosition,  emps[i].employeeAuthority,  emps[i].employeeApprovalStatus));
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
