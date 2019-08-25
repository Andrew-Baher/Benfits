class Complaint {
  String employeeEmail;
  String complaintDescription;
  String employeeFullName;

  Complaint(
      this.employeeEmail, this.complaintDescription, this.employeeFullName);

  Map toJson() {
    return {
      "employeeEmail": employeeEmail,
      "complaintDescription": complaintDescription,
      "EmployeeName": employeeFullName
    };
  }

  Complaint.fromJson(Map<String, dynamic> json)
      : employeeEmail = json['employeeEmail'],
        complaintDescription = json['complaintDescription'],
        employeeFullName = json['EmployeeName'];
}
