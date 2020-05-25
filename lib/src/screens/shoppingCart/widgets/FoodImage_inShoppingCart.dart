


import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodgallery/src/DataLayer/NewIngredient.dart';



//LOCAL RESOURCES
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

class FoodImageInShoppingCart extends StatelessWidget {



  final String imageURLBig;
  final String foodItemName;
  final List<NewIngredient> selectedIngredients;
  final double price;
  final int index;

//  OrderedFoodImageURL,OrderedFoodItemName,selectedIngredients,price
  FoodImageInShoppingCart(
      this.imageURLBig,
      this.foodItemName,
      this.selectedIngredients,
      this.price,
      this.index,
      );

  @override
  Widget build(BuildContext context) {

    if(index==0) {
      return Container(
        color: Color(0xffF4F6CE),
//      height: displayHeight(context)/4,
        height: displayWidth(context) / 3.8,
        width:displayWidth(context)/5,
        margin: EdgeInsets.fromLTRB(
            0, 12, 12, 5),
//      padding: EdgeInsets.fromLTRB(
//          0, 12, 12, 5),


        child: Transform.translate(
          offset: Offset(-displayWidth(context) / 15, 0),
          child: Container(
            padding: EdgeInsets.fromLTRB(
                0, 12, 0, 0),

            //  child: Card(


//      INCREAS THE DIVIDER TO MOVE THE IMAGE TO THE RIGHT
            // -displayWidth(context)/9
            child:
            Row(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      width: displayWidth(context) / 6,
                      height: displayWidth(context) / 6.6,

                      // INCREASE THE HEIGHT TO MAKE THE IMAGE CONTAINER MORE SMALLER.

                      decoration: new BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,

                      child:
                      ClipOval(
                        child: CachedNetworkImage(
                          width: displayWidth(context) / 5.9,
                          height: displayWidth(context) / 6.5,
                          imageUrl: imageURLBig,
//                    fit: BoxFit.scaleDown,cover,scaleDown,fill
                          fit: BoxFit.fill,
//
                          placeholder: (context,
                              url) => new CircularProgressIndicator(),
                        ),
                      ),

                    ),
                  ],
                ),

                Container(
                  alignment: Alignment.topCenter,
                    child:Text('$price'+
                        '\u20AC',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight
                              .normal,
//                                                      color: Colors.white
                          color: Colors
                              .black,

                        ),),
                )
              ],
            ),

          ),
        ),
      );
    }

    else{
      return Container(
        color:Color(0xffF4F6CE),
//      height: displayHeight(context)/4,
        height:displayWidth(context)/3.8,
        width:displayWidth(context)/5,
        margin: EdgeInsets.fromLTRB(
            displayWidth(context)/17, 12, 12, 5),





//      padding: EdgeInsets.fromLTRB(
//          0, 12, 12, 5),


        child:ClipRect(
          child: Transform.translate(
            offset:Offset(-displayWidth(context)/15,0),
            child: Container(
//              width:200,
              padding: EdgeInsets.fromLTRB(
          0, 12, 0, 0),

              //  child: Card(

//          decoration: new BoxDecoration(
//            color: Colors.orange,
//            shape: BoxShape.rectangle,
//          ),






//      INCREAS THE DIVIDER TO MOVE THE IMAGE TO THE RIGHT
              // -displayWidth(context)/9
              child:
              Row(
                children: <Widget>[
                  Container(

                    color:Colors.blue,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          width: displayWidth(context) / 6,
                          height: displayWidth(context) / 6.6,

                          // INCREASE THE HEIGHT TO MAKE THE IMAGE CONTAINER MORE SMALLER.

                          decoration: new BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,

                          child:
                          ClipOval(
                            child:CachedNetworkImage(
                              width: displayWidth(context)/5.9,
                              height:displayWidth(context)/6.5,
                              imageUrl: imageURLBig,
//                    fit: BoxFit.scaleDown,cover,scaleDown,fill
                              fit: BoxFit.fill,
//
                              placeholder: (context, url) => new CircularProgressIndicator(),
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),

                  Container(
                    color:Colors.redAccent,

                    width: 200,
                    alignment: Alignment.topCenter,
                    child:Text('$price'+
                        '\u20AC',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight
                              .normal,
//                                                      color: Colors.white
                          color: Colors
                              .black,

                        )),
                  )


                ],
              ),

            ),
          ),
        ),
      );
    }
  }
}

