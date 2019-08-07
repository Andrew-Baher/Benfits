import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState0();
  }
}

class _MyAppState0 extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: new Container(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: Carousel(
              images: [
                //TODO: Get the 3/4 latest benefits from db
                Image.asset('assets/BTech.jpeg', fit: BoxFit.fill),
                Image.asset('assets/EyeGlasses.jpeg', fit: BoxFit.fill),
                Image.asset('assets/FadyJewelry.jpeg', fit: BoxFit.fill),
                Image.asset('assets/ScalingUp.jpeg', fit: BoxFit.fill),
              ],
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotColor: Colors.white,
              indicatorBgPadding: 5.0,
              dotBgColor: Color.fromRGBO(48, 51, 86, 10),
              borderRadius: true,
            ),
          ),
        ),
      ),
    );
  }
}
