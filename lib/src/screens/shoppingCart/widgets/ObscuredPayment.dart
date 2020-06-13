
import 'package:flutter/material.dart';


//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';



//LOCAL RESOURCES
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import './ShoppingCartPagePainters.dart';
import './ShoppingCartPagePainters.dart';

//Models:

import 'package:foodgallery/src/DataLayer/models/Order.dart';

/*
Widget animatedObscuredCardSelectContainer(Order priceandselectedCardFunctionality, BuildContext context){
//  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

  print(' < >  <   >    <<        >>  \\    '
      ' Widget name: '
      'animated Obscured Card Select Container()');
  return
    AbsorbPointer(
      child: Opacity(
        opacity:0.2,
        child: Container(
            color: Colors.grey,
            padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                                      padding::::
//              color:Colors.white,
//                                            height: 200,
//              height: displayHeight(context) /6,
            width: displayWidth(context)
                - displayWidth(context) /
                    5,
//                                            width: displayWidth(context) * 0.57,
            /*
                                                    child:  AbsorbPointer(
                                                      child: _buildShoppingCartInputFields()
                                                  ),
                                                  */
            child: _buildShoppingCartCardSelectContainerObscured(priceandselectedCardFunctionality, context)

          //RRRRRR


        ),
      ),
    );
}


Widget _buildShoppingCartCardSelectContainerObscured(Order priceandselectedCardFunctionality, BuildContext context) {


  return
    Container(
      height: displayHeight(context) / 20 /* HEIGHT OF CHOOSE ORDER TYPE TEXT PORTION */ +
          displayHeight(context) /7 /* HEIGHT OF MULTI SELECT PORTION */,
      child: Column(
        children: <Widget>[

          // 1ST CONTAINER HOLDS THE HEADER Payment Method and Line paint begins here.
          Container(
            width: displayWidth(context) / 1.1,
            height: displayHeight(context) / 20,
            color: Color(0xffffffff),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .start
              ,
              crossAxisAlignment: CrossAxisAlignment
                  .center,
              children: <Widget>[


                Container(
                  width: displayWidth(context) /
                      1.5,
                  height: displayHeight(
                      context) / 20,
                  color: Color(0xffffffff),

                  child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start
                      ,
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets
                              .fromLTRB(
                              20, 0, 10, 0),
                          alignment: Alignment
                              .center,
                          child: Text(
                              'Payment Method',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight
                                    .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Colors.redAccent
                                ,
                              )
                          ),
                        ),

                        CustomPaint(
                          size: Size(0, 19),
                          painter: LongPainterForChooseOrderType(
                              context),
                        ),




                      ]
                  ),

                ),

                // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                /*
                                                        Container(
//                                                  alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(
                                                              0, 2, 0, 0),
                                                          width: displayWidth(context) /
                                                              16,
//                                                height: displayHeight(context)/20,
                                                          color: Color(0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0, 200, 0),
                                                            child: Icon(

                                                              Icons.add_shopping_cart,
                                                              size: 30,
                                                              color: Color(0xff54463E),
                                                            ),
                                                          ),


                                                        ),
                                                        */


                // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                ////WWWEEEQQQ




              ],
            ),
          ),

          // 1ST CONTAINER HOLDS THE HEADER Payment Method and Line paint ENDs here.


          // 2ND CONTAINER HOLDS THE total price BEGINS HERE..
          Container(

            margin: EdgeInsets
                .fromLTRB(
                20, 0, 10, 0),
            alignment: Alignment
                .center,
            child: Row(
              children: <Widget>[
                Text(
                    'TOTAL : ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight
                          .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                      color: Colors.redAccent
                      ,
                    )
                ),

                Text(
                    'TOTAL : '+'${
                        priceandselectedCardFunctionality.unitPrice
                            * priceandselectedCardFunctionality.quantity}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight
                          .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                      color: Colors.redAccent
                      ,
                    )
                )
              ],
            ),
          ),
          // 2ND CONTAINER HOLDS THE total price ENDNS HERE..

          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                                      padding::::
            color:Colors.white,
//                                            height: 200,
            height: displayHeight(context) /7,
            width: displayWidth(context)
                - displayWidth(context) /
                    5,
//                                            width: displayWidth(context) * 0.57,
            child:  _buildOrderTypeSingleSelectOption(),

          ),
        ],
      ),
    );

}

 */