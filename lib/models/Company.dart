import 'package:firebase_database/firebase_database.dart';

import 'BenefitDetails.dart';

class Company {
  String _companyID;
  String _companyName;
  String _companyAddress;
  List<BenefitDetails> _companyBenefits;

  Company(this._companyID, this._companyName, this._companyAddress,
      this._companyBenefits);

  List<BenefitDetails> get companyBenefits => _companyBenefits;

  String get companyAddress => _companyAddress;

  String get companyName => _companyName;

  String get companyID => _companyID;

  toJson() {
    return {
      "companyID": _companyID,
      "companyName": _companyName,
      "companyAddress": _companyAddress,
      "companyBenefits": _companyBenefits,
    };
  }

  Company.fromSnapshot(DataSnapshot snapshot)
      : _companyID = snapshot.value["companyID"],
        _companyName = snapshot.value["companyName"],
        _companyAddress = snapshot.value["companyAddress"],
        _companyBenefits = snapshot.value["companyBenefits"];

  Company.map(dynamic obj) {
    this._companyID = obj['companyID'];
    this._companyName = obj['companyName'];
    this._companyAddress = obj['companyAddress'];
    this._companyBenefits = obj['companyBenefits'];
  }
}
