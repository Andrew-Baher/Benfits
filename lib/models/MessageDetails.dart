
class MessageDetails {
  String _employeeEmail;
  String _employeetName;
  String _messageDescription;
  String _messageTiming;
  String _Status;


  MessageDetails(
      this._employeeEmail,
      this._employeetName,
      this._messageDescription,
      this._messageTiming,
      this._Status);


  String get employeeEmail => _employeeEmail;

  String get employeetName => _employeetName;

  String get messageDescription => _messageDescription;

  String get messageTiming => _messageTiming;

  String get Status => _Status;

  Map toJson() {
    return {
      "EmployeeEmail": _employeeEmail,
      "EmployeeName": _employeetName,
      "MessageDescription": _messageDescription,
      "MessageTiming": _messageTiming,
      "Status": _Status
    };
  }

  MessageDetails.fromJson(Map<String, dynamic> json)
      : _employeeEmail = json['EmployeeEmail'],
        _employeetName = json['EmployeeName'],
        _messageDescription = json['MessageDescription'],
        _messageTiming = json['MessageTiming'],
        _Status = json['Status'];


}
