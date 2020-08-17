import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


//LOCAL RESOURCES
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

class HistoryDetailImage extends StatelessWidget {



  final String formattedOrderPlacementDatesTimeOnly3;
  final String orderBy3;
  double totalPrice3;
  DateTime startDate3;
//  DateTime

//  oneFireBaseOrder.formattedOrderPlacementDatesTimeOnly2,
//  oneFireBaseOrder.orderBy
  HistoryDetailImage(this.formattedOrderPlacementDatesTimeOnly3,this.orderBy3,this.startDate3,this.totalPrice3);

//  startDate2.toString()+'__$totalPrice2',

  @override
  Widget build(BuildContext context) {

    print('formattedOrderPlacementDatesTimeOnly2: $formattedOrderPlacementDatesTimeOnly3');

    print('orderBy2: $orderBy3');

    print('startDate3: ${startDate3.toString()}');

    print('totalPrice3: $totalPrice3');
    



    String itemImage2 = (orderBy3.toLowerCase() == 'delivery') ?
    'assets/orderBYicons/delivery.png' :
    (orderBy3.toLowerCase() == 'phone') ?
    'assets/phone.png': (orderBy3.toLowerCase() == 'takeaway')
        ? 'assets/orderBYicons/takeaway.png'
        : 'assets/orderBYicons/diningroom.png';
    return

      Container(
        child: Hero(
//          tag: formattedOrderPlacementDatesTimeOnly3,
          tag: startDate3.toString()+'__$totalPrice3',

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

