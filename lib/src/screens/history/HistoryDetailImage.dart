import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


//LOCAL RESOURCES
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

class HistoryDetailImage extends StatelessWidget {



  final String formattedOrderPlacementDatesTimeOnly2;
  final String orderBy2;

//  oneFireBaseOrder.formattedOrderPlacementDatesTimeOnly2,
//  oneFireBaseOrder.orderBy
  HistoryDetailImage(this.formattedOrderPlacementDatesTimeOnly2,this.orderBy2);

  @override
  Widget build(BuildContext context) {

    String itemImage2 = (orderBy2.toLowerCase() == 'delivery') ?
    'assets/orderBYicons/delivery.png' :
    (orderBy2.toLowerCase() == 'phone') ?
    'assets/phone.png': (orderBy2.toLowerCase() == 'takeaway')
        ? 'assets/orderBYicons/takeaway.png'
        : 'assets/orderBYicons/diningroom.png';
    return

      Container(
        child: Hero(
          tag: formattedOrderPlacementDatesTimeOnly2,
          child:
          Image.asset(
            itemImage2,
            width: 43,
            height:43,
//                              fit: BoxFit.cover,
//                              fit: BoxFit.fill,
//                              fit: BoxFit.contain,
//            fit:BoxFit.fitWidth,
            fit: BoxFit.fill,
//             placeholder: (context, url) => new CircularProgressIndicator(),
          ),


        ),
//        ),

      );

  }
}


class  MyClipper22 extends CustomClipper<Rect> {

  @override
  Rect getClip(Size size) {
//    return Rect.fromLTWH(left, top, width, height)
//  GOOD OPTION 1
//    return Rect.fromLTWH(-220, 0, 550, 550);

//    return Rect.fromCenter(center: Offset(0, 0),width:190,height:190);
//  GOOD OPTION 2
//    return Rect.fromCircle(center: Offset(0, 330),radius:300);

    return Rect.fromCircle(center: Offset(50, 270),radius:240);

  }
  @override
  bool shouldReclip(oldClipper) => false;
}

