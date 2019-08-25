import 'dart:convert';

import 'package:employees_benefits/models/Complaint.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

import '../main.dart';
import 'MainApp.dart';

List<Complaint> complaints;

class ManagerComplaints extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManagerComplaintsState();
  }
}

class _ManagerComplaintsState extends State<ManagerComplaints> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    complaints = new List<Complaint>();
    getComplaints();
  }

  Future getData() async {
    await new Future.delayed(const Duration(seconds: 0));
    setState(() {});
  }

  Future<bool> _onBackPressed() {
    mainCurrentIndex=3;
    Navigator.of(context).pop();
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => MainApplication()));
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new  Scaffold(
        appBar: AppBar(
          title: Text('Complaints'),
          backgroundColor: Color.fromRGBO(19, 46, 99, 10),
        ),
        key: _scaffoldKey,
        body: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: complaints.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: MediaQuery.of(context).size.width / 14,
                ),
                title: Text(
                  //Employee first name + last name
                  complaints[index].employeeFullName,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 20),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      complaints[index].complaintDescription,
                      style: TextStyle(
                        fontSize: 24
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                  ],
                ),

              ),
            );
          },
        ),
      ),
    );
  }

  void getComplaints() async {
    DBRef.child('ComplaintsCount')
        .child('count')
        .once()
        .then((DataSnapshot dataSnapShot) {
      currentComplaintIndex = dataSnapShot.value;
      print("ID" + currentComplaintIndex.toString());
    });

    DBRef.child('ComplaintsDetails').once().then((DataSnapshot dataSnapShot) {
      print(dataSnapShot.value[1]["EmployeeEmail"]);
      print(dataSnapShot.value[1]["ComplaintDescription"]);
      for (int i = 1; i < currentComplaintIndex; i++) {
        complaints.add(new Complaint(dataSnapShot.value[i]["EmployeeEmail"],
            dataSnapShot.value[i]["ComplaintDescription"], dataSnapShot.value[i]["EmployeeName"] ));
      }
    });
  }
}

_reviver(Object key, Object value) {
  if (key != null && value is Map) return new Complaint.fromJson(value);
  return value;
}

const jsonCodec = const JsonCodec(reviver: _reviver);
