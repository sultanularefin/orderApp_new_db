// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
//import 'package:foodgallery/src/models/SizeConstants.dart';


class CustomClipperTest extends StatefulWidget {
  @override
  _CustomClipperState createState() => _CustomClipperState();
}

class _CustomClipperState extends State<CustomClipperTest> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Clipping test:'),

          ),
          body:
          Transform.translate(
            offset:Offset(-displayWidth(context) * 0.50,0),
            child:Container(
//              alignment: Alignment.centerLeft,

//              width: 100,
//              alignment:Alignment(-displayWidth(context)/90,1.0),
              // /52 INCREASE TO MOVE right. in both places.
//          width: displayWidth(context) * 0.30,

//          fit: BoxFit.fitHeight,
              child:
              ClipRect(
                key: UniqueKey(),
                clipper:CustomRect(),
                clipBehavior: Clip.hardEdge,
                child: Container(
//          width: 100,
//        height: 100,

//              alignment: Alignment(-2.0,-1.0),
                  child: ClipOval(
                    key: UniqueKey(),
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(


                      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/foodgalleryarefin.appspot.com/o/foodItems%2FSALAATTI%2FitemNamefQv0az.png?alt=media&token=7a068aed-772c-4296-92c7-e5b1cb2a695c',
                    ),


                  ),

                ),
              ),


//          alignment: Alignment(-1.0,-1.0),

            ),
          )
      ),

    );
  }
}


class CustomRect extends CustomClipper<Rect>{
  @override
  Rect getClip(Size size) {
    print('at get Clip');
//    Rect rect = Rect.fromLTRB(100, 0.0, size.width, size.height);
    Rect rect = Rect.fromLTWH(100, 0.0, size.width, size.height);
    return rect;
    // TODO: implement getClip
  }
  @override
  bool shouldReclip(CustomRect oldClipper) {
    // TODO: implement shouldReclip
    //    return true;
    return false;
  }
}

