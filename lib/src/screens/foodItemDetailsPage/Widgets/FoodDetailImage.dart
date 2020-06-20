import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';



//LOCAL RESOURCES
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

class FoodDetailImage extends StatelessWidget {



  final String imageURLBig;
  final String foodItemName;
  FoodDetailImage(this.imageURLBig,this.foodItemName);

  @override
  Widget build(BuildContext context) {

    return Container(

      color:Colors.white,
//      height: displayHeight(context)/4,
      height:displayWidth(context)/3.8,
      width:displayWidth(context)/4.6,
      child:Transform.translate(
        offset:Offset(-displayWidth(context)/18,0),

//      INCREAS THE DIVIDER TO MOVE THE IMAGE TO THE RIGHT
        // -displayWidth(context)/9
        child:
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: displayWidth(context)/3.9,
              height:displayWidth(context)/4.4,

              // INCREASE THE HEIGHT TO MAKE THE IMAGE CONTAINER MORE SMALLER.

              decoration: new BoxDecoration(
//                color: Colors.orange,
                color: Colors.white,

                shape: BoxShape.circle,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Hero(
                tag: foodItemName,
                child:
                ClipOval(
                  child:CachedNetworkImage(
                    width: displayWidth(context)/3.9,
                    height:displayWidth(context)/4.4,
                    imageUrl: imageURLBig,
//                    fit: BoxFit.scaleDown,cover,scaleDown,fill
                    fit: BoxFit.fill,
//
                    placeholder: (context, url) => new CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

