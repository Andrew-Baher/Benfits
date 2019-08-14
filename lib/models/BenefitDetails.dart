
class BenefitDetails {
  String _benefitTitle;
  String _benefitImage;
  String _benefitDescription;
  List<String> _companiesIDs;

  BenefitDetails(this._benefitTitle, this._benefitImage,
      this._benefitDescription, this._companiesIDs);

  List<String> get companiesIDs => _companiesIDs;

  String get benefitDescription => _benefitDescription;

  String get benefitImage => _benefitImage;

  String get benefitTitle => _benefitTitle;

  toJson() {
    return {
      "benefitTitle": _benefitTitle,
      "benefitImage": _benefitImage,
      "benefitDescription": _benefitDescription,
      "companiesIDs": _companiesIDs,
    };
  }

  BenefitDetails.fromJson(Map<String, dynamic> json)
      : _benefitTitle = json["benefitTitle"],
        _benefitImage = json["benefitImage"],
        _benefitDescription = json["benefitDescription"],
        _companiesIDs = json["companiesIDs"];

  BenefitDetails.map(dynamic obj) {
    this._benefitTitle = obj['benefitTitle'];
    this._benefitImage = obj['benefitImage'];
    this._benefitDescription = obj['benefitDescription'];
    this._companiesIDs = obj['companiesIDs'];
  }
}
