
import 'package:flutter/material.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

class RowColumnTest extends StatefulWidget {
  RowColumnTest({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RowColumnTestState createState() => _RowColumnTestState();
}

class _RowColumnTestState extends State<RowColumnTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Container(
            color: Colors.yellowAccent,
            width: displayWidth(context),
            child: Row(children: <Widget>[

              Text('s'),
              Text('ss'),

            ],
            ),
          ),
          Container(
            color: Colors.red,
            width: displayWidth(context) * 0.25,
            child: Text(
              'Box width 25% of screen width and text size 3% of screen width',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: displayWidth(context) * 0.03),
            ),
          ),

          Container(
            color: Colors.green,
            width: displayWidth(context) * 0.5,
            child: Text(
              'Box width 50% of screen width and text size 6% of screen width',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: displayWidth(context) * 0.06),
            ),
          ),
          Container(
            color: Colors.blue,
            width: displayWidth(context),
            child: Text(
              'Box width equal to screen width and text size 10% of screen width',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: displayWidth(context) * 0.1),
            ),
          ),
        ],
      ),

    );
  }
}
//Column(
//children: <Widget>[
//

//
//
//),