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

//      Transform.translate(
//        offset:Offset(-displayWidth(context)/16,0),//(-20,0)
//        child:

      Container(
//              alignment: Alignment.centerLeft,
        child: Hero(
          tag: foodItemName,
          child:
          ClipOval(
            clipper: MyClipper22(),
            child:
            CachedNetworkImage(
//              width: displayWidth(context)/2.1,
//              height:displayHeight(context)/1.2,
              imageUrl: imageURLBig,
//                    fit: BoxFit.scaleDown,cover,scaleDown,fill
                    fit: BoxFit.fill,

              /*
                /// As large as possible while still containing the source entirely within the
                /// target box.
                ///
                /// ![](https://flutter.github.io/assets-for-api-docs/assets/painting/box_fit_contain.png)
                contain,



                /// As small as possible while still covering the entire target box.
                ///
                /// ![](https://flutter.github.io/assets-for-api-docs/assets/painting/box_fit_cover.png)
                cover,*/

//              fit: BoxFit.contain,
//              fit: BoxFit.cover,


//
//
//                fit:BoxFit.cover, contain


//                fit:BoxFit.fitHeight,


//


//                fit:BoxFit.none,

              /// Align the source within the target box (by default, centering) and, if
              /// necessary, scale the source down to ensure that the source fits within the
              /// box.
              ///
              /// This is the same as `contain` if that would shrink the image, otherwise it
              /// is the same as `none`.
              ///
              /// ![](https://flutter.github.io/assets-for-api-docs/assets/painting/box_fit_scaleDown.png)
//              fit:BoxFit.scaleDown,





              placeholder: (context, url) => new CircularProgressIndicator(),
            ),
          ),
        ),
//        ),

      );

  }
}

//class MyClipper extends (){
//
//}

class  MyClipper22 extends CustomClipper<Rect> {

  @override
  Rect getClip(Size size) {
//    return Rect.fromLTWH(left, top, width, height)
//  GOOD OPTION 1
//    return Rect.fromLTWH(-220, 0, 550, 550);

//    return Rect.fromCenter(center: Offset(0, 0),width:190,height:190);
//  GOOD OPTION 2
    return Rect.fromCircle(center: Offset(0, 330),radius:300);

  }
  @override
  bool shouldReclip(oldClipper) => false;
}

