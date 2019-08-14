import 'package:employees_benefits/models/BenefitDetails.dart';
import 'package:firebase_database/firebase_database.dart';

class Category {
  String _categoryName;
  String _categoryImage;
  List<Category> _subCategories;
  List<BenefitDetails> _benefits;

  Category(this._categoryName, this._categoryImage, this._subCategories,
      this._benefits);

  List<BenefitDetails> get benefits => _benefits;

  List<Category> get subCategories => _subCategories;

  String get categoryImage => _categoryImage;

  String get categoryName => _categoryName;

  toJson() {
    return {
      "categoryName": _categoryName,
      "categoryImage": _categoryImage,
      "subCategories": _subCategories,
      "benefits": _benefits,
    };
  }

  Category.fromSnapshot(DataSnapshot snapshot)
      : _categoryName = snapshot.value["categoryName"],
        _categoryImage = snapshot.value["categoryImage"],
        _subCategories = snapshot.value["subCategories"],
        _benefits = snapshot.value["benefits"];

  Category.map(dynamic obj) {
    this._categoryName = obj['employeeID'];
    this._categoryImage = obj['employeeFirstName'];
    this._subCategories = obj['employeeLastName'];
    this._benefits = obj['employeePhoneNumber'];
  }
}
