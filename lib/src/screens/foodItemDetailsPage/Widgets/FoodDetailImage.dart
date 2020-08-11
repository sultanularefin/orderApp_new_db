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
        offset:Offset(-displayWidth(context)/16,0),//(-20,0)
        child:
        Container(
//              alignment: Alignment.centerLeft,
          child: Hero(
            tag: foodItemName,
            child:
            ClipOval(
              child:CachedNetworkImage(
                width: displayWidth(context)/2.1,
                height:displayWidth(context)/1.7,
                imageUrl: imageURLBig,
//                    fit: BoxFit.scaleDown,cover,scaleDown,fill
//                    fit: BoxFit.fill,
                fit: BoxFit.contain,
//                fit:BoxFit.cover, contain
//
                placeholder: (context, url) => new CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      );

  }
}

