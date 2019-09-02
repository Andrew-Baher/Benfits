
class BenefitDetails {
  String _benefitTitle;
  String _benefitImage;
  String _benefitDescription;
  String _benefitCategory;
  String _benefitID;
  bool _benefitApply;
  bool _benefitActive;

  BenefitDetails(this._benefitTitle, this._benefitImage,
      this._benefitDescription, this._benefitCategory,this._benefitID,this._benefitApply,this._benefitActive);

  String get benefitDescription => _benefitDescription;

  String get benefitImage => _benefitImage;

  String get benefitTitle => _benefitTitle;

  String get benefitCategory => _benefitCategory;

  String get benefitID => _benefitID;

  bool get benefitApply => _benefitApply;

  bool get benefitActive => _benefitActive;


  toJson() {
    return {
      "benefitTitle": _benefitTitle,
      "benefitImage": _benefitImage,
      "benefitDescription": _benefitDescription,
      "benefitCategory": _benefitCategory,
      "benefitID": _benefitID,
      "benefitApply": _benefitApply,
      "benfitActive": _benefitActive,
    };
  }

  BenefitDetails.fromJson(Map<String, dynamic> json)
      : _benefitTitle = json["benefitTitle"],
        _benefitImage = json["benefitImage"],
        _benefitDescription = json["benefitDescription"],
        _benefitCategory = json["benefitCategory"],
        _benefitID = json["benefitID"],
        _benefitApply = json["benefitApply"],
        _benefitActive = json["benfitActive"];

}
