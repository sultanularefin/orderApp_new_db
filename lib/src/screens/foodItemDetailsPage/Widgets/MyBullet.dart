
import 'package:flutter/material.dart';
class MyBullet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(right: 5),
      width: 10,
      height: 10,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}