import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CurrentCategory extends StatefulWidget {
  String currentBenefit;

  CurrentCategory(String item) {
    this.currentBenefit = item;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new CurrentCategoryState();
  }
}

class CurrentCategoryState extends State<CurrentCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(widget.currentBenefit),
      ),
      body: new GridView.extent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
          mainAxisSpacing: MediaQuery.of(context).size.width / 50,
          crossAxisSpacing: MediaQuery.of(context).size.width / 50,
          children: _buildCategorytassets(Categoryassets.length)),
    );
  }
}

List<Widget> _buildCategorytassets(numberOfTiles) {
  List<Container> containers =
  new List<Container>.generate(numberOfTiles, (int index) {
    return new Container(
      child: new Image.asset(
        Categoryassets[index],
        fit: BoxFit.fill,
      ),
    );
  });
  return containers;
}

List<String> Categoryassets = [
  'assets/Shopping_AlFady.jpeg',
  'assets/Shopping_BlueEyes.jpeg',
  'assets/Shopping_BTech.jpeg',
];
