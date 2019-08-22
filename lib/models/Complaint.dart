class Complaint {
  String employeeEmail;
  String complaintDescription;


  Complaint(this.employeeEmail, this.complaintDescription);

  Map toJson() {
    return {
      "employeeEmail": employeeEmail,
      "complaintDescription": complaintDescription,
    };
  }

  Complaint.fromJson(Map<String, dynamic> json)
      : employeeEmail = json['employeeEmail'],
        complaintDescription = json['complaintDescription'];
}
