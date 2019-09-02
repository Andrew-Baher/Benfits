
class ComplaintDetails {
  String _employeeEmail;
  String _employeetName;
  String _complaintDescription;

  ComplaintDetails(
      this._employeeEmail,
      this._employeetName,
      this._complaintDescription,
);


  String get employeeEmail => _employeeEmail;

  String get employeetName => _employeetName;

  String get complaintDescription => _complaintDescription;


  Map toJson() {
    return {
      "EmployeeEmail": _employeeEmail,
      "EmployeeName": _employeetName,
      "ComplaintDescription": _complaintDescription,

    };
  }

  ComplaintDetails.fromJson(Map<String, dynamic> json)
      : _employeeEmail = json['EmployeeEmail'],
        _employeetName = json['EmployeeName'],
        _complaintDescription = json['ComplaintDescription'];

}
