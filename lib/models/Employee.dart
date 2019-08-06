
class Employee {
  String _employeeID;
  String _employeeFirstName;
  String _employeeLastName;
  String _employeeEmail;
  String _employeePassword;
  String _employeePhoneNumber;
  String _employeeCompanyID;
  String _employeePosition;
  String _employeeAuthority;
  bool _employeeApprovalStatus;

  Employee(
      this._employeeID,
      this._employeeFirstName,
      this._employeeLastName,
      this._employeeEmail,
      this._employeePassword,
      this._employeePhoneNumber,
      this._employeeCompanyID,
      this._employeePosition,
      this._employeeAuthority,
      this._employeeApprovalStatus);

  String get employeeCompanyID => _employeeCompanyID;

  String get employeePhoneNumber => _employeePhoneNumber;

  String get employeePassword => _employeePassword;

  String get employeeEmail => _employeeEmail;

  String get employeeFirstName => _employeeFirstName;

  String get employeeID => _employeeID;

  String get employeeLastName => _employeeLastName;

  String get employeePosition => _employeePosition;

  String get employeeAuthority => _employeeAuthority;

  bool get employeeApprovalStatus => _employeeApprovalStatus;

  Map toJson() {
    return {
      "employeeID": _employeeID,
      "employeeFirstName": _employeeFirstName,
      "employeeLastName": _employeeLastName,
      "employeePhoneNumber": _employeePhoneNumber,
      "employeeEmail": _employeeEmail,
      "employeePassword": _employeePassword,
      "employeeCompanyID": _employeeCompanyID,
      "employeePosition": _employeePosition,
      "employeeAuthority": _employeeAuthority,
      "employeeApprovalStatus" : _employeeApprovalStatus
    };
  }

  Employee.fromJson(Map<String, dynamic> json)
      : _employeeID = json['employeeID'],
        _employeeFirstName = json['employeeFirstName'],
        _employeeLastName = json['employeeLastName'],
        _employeePhoneNumber = json['employeePhoneNumber'],
        _employeeEmail = json['employeeEmail'],
        _employeePassword = json['employeePassword'],
        _employeeCompanyID = json['employeeCompanyID'],
        _employeePosition = json['employeePosition'],
        _employeeAuthority = json['employeeAuthority'],
        _employeeApprovalStatus = json['employeeApprovalStatus'];
}
