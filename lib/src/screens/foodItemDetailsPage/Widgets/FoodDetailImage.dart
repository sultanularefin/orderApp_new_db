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
//            alignment: Alignment.centerLeft,

            child: Hero(
              tag: foodItemName,

              child:
              Container(
                  width: 190.0,
                  height: 190.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              imageURLBig)
                      )
                  )),

            )


        ),
      );

  }
}

