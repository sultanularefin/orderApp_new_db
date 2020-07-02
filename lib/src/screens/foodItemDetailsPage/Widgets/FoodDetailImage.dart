import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


//LOCAL RESOURCES
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

class FoodDetailImage extends StatelessWidget {



  final String imageURLBig;
  final String foodItemName;
  FoodDetailImage(this.imageURLBig,this.foodItemName);

  @override
  Widget build(BuildContext context) {

    return
      Transform.translate(
        offset:Offset(-displayWidth(context)/10,0),

//      INCREAS THE DIVIDER TO MOVE THE IMAGE TO THE RIGHT
        // -displayWidth(context)/9
        child:

        Neumorphic(
          curve: Neumorphic.DEFAULT_CURVE,
          style: NeumorphicStyle(
            shape: NeumorphicShape
                .concave,
            depth: 8,
            lightSource: LightSource.left,
            boxShape: NeumorphicBoxShape.circle(),
            color: Colors.white,
            shadowDarkColor: Colors.orange,

//          boxShape:NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(15)),
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Hero(
              tag: foodItemName,
              child:
              ClipOval(
                child:CachedNetworkImage(
                  height:displayHeight(context)/4.3,
                  width: displayWidth(context)/3.3,

                  imageUrl: imageURLBig,
//                    fit: BoxFit.scaleDown,cover,scaleDown,fill
                  fit: BoxFit.fill,
//
                  placeholder: (context, url) => new CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ),
      );
  }
}

