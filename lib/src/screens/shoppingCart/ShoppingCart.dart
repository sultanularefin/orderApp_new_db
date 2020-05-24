//food_gallery.dart



// dependency files
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/BLoC/shoppingCart_bloc.dart';
import 'package:foodgallery/src/DataLayer/FoodItemWithDocIDViewModel.dart';
import 'package:foodgallery/src/DataLayer/NewIngredient.dart';
import 'package:foodgallery/src/screens/shoppingCart/widgets/FoodImage_inShoppingCart.dart';
import 'package:logger/logger.dart';
//import 'package:neumorphic/neumorphic.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

//sizeConstantsList


// SCREEN FILES AND MODLE FILES AND UTILITY FILES.
import 'package:foodgallery/src/screens/ingredients_more/more_ingredients.dart';
import 'package:foodgallery/src/DataLayer/IngredientItem.dart';
import 'package:foodgallery/src/DataLayer/SizeConstants.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import 'package:foodgallery/src/screens/foodItemDetailsPage/Widgets/FoodDetailImage.dart';
import './../../DataLayer/FoodItemWithDocID.dart';
import './../../DataLayer/Order.dart';
import 'package:foodgallery/src/DataLayer/FoodPropertyMultiSelect.dart';
//import './../../DataLayer/itemData.dart';


//import './../../shared/category_Constants.dart' as Constants;


// Blocks

import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';

final Firestore firestore = Firestore();



class ShoppingCart extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;
//  final FoodItem oneFoodItemData;


//  FoodItemWithDocID oneFoodItem =new FoodItemWithDocID(


  ShoppingCart({Key key, this.child}) : super(key: key);

  @override
  _ShoppingCartState createState() => new _ShoppingCartState();


//  _FoodItemDetailsState createState() => _FoodItemDetailsState();



}


class _ShoppingCartState extends State<ShoppingCart> {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  String _currentSize;
  int _itemCount = 1;


//  color: Color(0xff34720D),
//  VS 0xffFEE295 3 0xffFEE295 false
//  ORG 0xff739DFA 4 0xff739DFA false


  @override
  void initState() {
//    setDetailForFood();
//    retrieveIngredientsDefault();
    super.initState();
  }


  double tryCast<num>(dynamic x, {num fallback }) {
    print(" at tryCast");
    print('x: $x');

    bool status = x is num;

    print('status : x is num $status');
    print('status : x is dynamic ${x is dynamic}');
    print('status : x is int ${x is int}');
    if (status) {
      return x.toDouble();
    }

    if (x is int) {
      return x.toDouble();
    }
    else if (x is double) {
      return x.toDouble();
    }


    else
      return 0.0;
  }


  @override
  Widget build(BuildContext context) {
    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

//    print('totalCartPrice -----------> : $totalCartPrice');
//    print('initialPriceByQuantityANDSize ----------> $initialPriceByQuantityANDSize');

//    logger.w('defaultIngredients: ',bloc.defaultIngredients);

//    List<NewIngredient> defaultIngredients = foodItemDetailsbloc.getDefaultIngredients;
//    List<NewIngredient> unSelectedIngredients = foodItemDetailsbloc
//        .unSelectedIngredients;


//    logger.w('unSelectedIngredients in ShoppingCart line #116 : ',
//        unSelectedIngredients);

//    return Center(
//        child:
//        Text("At Shopping Cart Page: ")
//    );

//    print('totalCartPrice -----------> : $totalCartPrice');
//    print('initialPriceByQuantityANDSize ----------> $initialPriceByQuantityANDSize');

//    logger.w('defaultIngredients: ',bloc.defaultIngredients);

//    List<NewIngredient> defaultIngredients = foodItemDetailsbloc.getDefaultIngredients;
    Order thisOrder  = shoppingCartBloc.getCurrentOrder;



    logger.w('thisOrder : ',
        thisOrder);


    if (thisOrder == null) {
      return Container
        (
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }
    else {


      return Container(

          child: StreamBuilder<Order>(


              stream: shoppingCartBloc.getCurrentOrderStream,
              initialData: shoppingCartBloc.getCurrentOrder,

              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: new LinearProgressIndicator());
                }
                else {
                  print('snapshot.hasData : ${snapshot.hasData}');

                  final Order oneOrder = snapshot.data;


                  return GestureDetector(
                    onTap: () {
                      print('s');
                      Navigator.pop(context);
                      FocusScopeNode currentFocus = FocusScope.of(
                          context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
//                  Navigator.pop(context);

                      }
                    },
                    child:
                    Scaffold(

                      backgroundColor: Colors.white.withOpacity(0.05),
                      // this is the main reason of transparency at next screen.
                      // I am ignoring rest implementation but what i have achieved is you can see.

                      body: SafeArea(


                        // smaller container containing all modal FoodItem Details things.
                        child: Container(
                            height: displayHeight(context) -
                                MediaQuery.of(context).padding.top -
                                kToolbarHeight,
                            child: Column(
                              children: <Widget>[
                                Container(


//                                      alignment: Alignment.bottomCenter,
                                  height: displayHeight(context) / 2.6,
                                  //width:displayWidth(context) / 1.5, /* 3.8*/
                                  width: displayWidth(context)
                                      - displayWidth(context) /
                                          5 /* this is about the width of yellow side menu */
                                     ,
//                  color:Colors.lightGreenAccent,
                                  margin: EdgeInsets.fromLTRB(
                                      12, displayHeight(context)/11, 10, 5),

                                  decoration:
                                  new BoxDecoration(
                                    borderRadius: new BorderRadius
                                        .circular(
                                        10.0),
                                    color: Colors.purple,
                                  ),


                                  child: Neumorphic(
                                    // State of Neumorphic (may be convex, flat & emboss)

                                      boxShape: NeumorphicBoxShape
                                          .roundRect(
                                        BorderRadius.all(
                                            Radius.circular(15)),

                                      ),
                                      curve: Neumorphic.DEFAULT_CURVE,
                                      style: NeumorphicStyle(
                                          shape: NeumorphicShape
                                              .concave,
                                          depth: 8,
                                          lightSource: LightSource
                                              .topLeft,
                                          color: Colors.white
                                      ),

//                    MAX_DEPTH,DEFAULT_CURVE

//
//                      BorderRadius.circular(25),
//                  border: Border.all(

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Container(child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              // THIS ROW HAVE 2 PARTS -> 1ST PART HANDLES THE IMAGES, SOME HEADING TEXT(PRICE AND NAME)
                                              // , 2ND PART(ROW) HANDLES THE
                                              // DIFFERENT SIZES OF PRODUCTS. BEGINS HERE.


                                              Container(
                                                  height: displayHeight(
                                                      context) / 2.6,

                                                  color: Colors.red,
                                                  width: displayWidth(
                                                      context) /
                                                      5,
// INCREASE THE DIVIDER TO MAKE IT MORE SAMLLER. I.E. WIDTH
//                      height: displayHeight(context)*0.50,
//                                    alignment: Alignment.centerLeft,


                                                  //ZZZ
                                                  // Other arguments such as margin, padding etc. (Like `Container`)
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,

//        mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      //pppp




                                                      Container(
                                                        /*
                                color:Colors.blue,
                              width:displayWidth(context)/4.6,
                              */
                                                        padding: EdgeInsets
                                                            .fromLTRB(
                                                            0, 0, 0,
                                                            displayHeight(
                                                                context) /
                                                                25),

                                                        child: FoodImageInShoppingCart(
                                                            oneOrder.foodItemImageURL,
                                                            oneOrder.foodItemName
                                                        ),
                                                      ),


                                                    ],

                                                  )
                                              ),

                                              // THIS ROW HAVE 2 PARTS -> 1ST PART (ROW) HANDLES THE IMAGES, SOME HEADING TEXT(PRICE AND NAME)
                                              // , 2ND PART(ROW) HANDLES THE
                                              // DIFFERENT SIZES OF PRODUCTS.
                                              // ENDS HERE.


                                              // 2ND ROW, FOR FOR OTHER ITEMS, WILL BE A COLUMN ARRAY, BEGINS HERE:

                                              /*
                                              Container(
                                                height: displayHeight(
                                                    context) /
                                                    2.6,
                                                width: displayWidth(
                                                    context) -
                                                    displayWidth(
                                                        context) / 3.7 /* about the width of left most
                            container holding the food Item Image, image name and food item price */
                                                    - displayWidth(
                                                        context) /
                                                        3.8 /* this is about the width of yellow side menu */,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,


//        mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    //pppp

                                                    Container(
                                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                                      padding::::
                                                      color:Colors.white,
                                                      height: 50,
                                                      width: displayWidth(context) * 0.57,
                                                      child:  _buildMultiSelectOptions(),

                                                    ),
                                                    Container(
                                                        child: _buildProductSizes(
                                                            context,
                                                            foodSizePrice)
                                                    ),

//                                  Text('ss'),
                                                    Container(
                                                        height: displayHeight(context) / 9,
                                                        width: displayWidth(context) * 0.57,

                                                        color: Color(0xfffebaca),
//                                                        alignment: Alignment.center,
                                                        child: buildDefaultIngredients(
                                                            context
                                                        )
                                                    ),

                                                    // NEWANIMATEDPOSITIONED HERE BEGINS =><=
                                                    // MORE INGREDIENTS Row BEGINS HERE.
                                                    Container(
                                                      width: displayWidth(context) /1.8,
                                                      child:
                                                      AnimatedSwitcher(
                                                        duration: Duration(milliseconds: 1000),
//
                                                        child: showPressWhenFinishButton? animatedWidgetPressToFinish():
                                                        animatedWidgetMoreIngredientsButton(),

                                                      ),
                                                      // THIS CONTAINER WILL HOLD THE STRING PRESS WHEN FINISH BEGINS HERE.


                                                      // THIS CONTAINER WILL HOLD THE STRING PRESS WHEN FINISH ENDS HERE.
                                                      // todo==>
                                                      // showUnSelectedIngredients displayHeight(context)/7.5
                                                      // THIS CONTAINER WILL HOLD THE MORE INGREDIENTS OUTLINE BUTTON AND ITEM COUNT BEGINS HERE.


                                                      // THIS CONTAINER WILL HOLD THE MORE INGREDIENTS OUTLINE BUTTON AND ITEM COUNT ENDS HERE.
                                                      // MORE INGREDIENTS ROW ENDS HERE.

                                                    )
                                                    // 2ND ROW, FOR FOR OTHER ITEMS, WILL BE A COLUMN ARRAY, ENDS HERE:


                                                  ],
                                                ),
                                              ),

                                              */




                                            ],
                                          )

                                          ),


                                          /*  TOP CONTAINER IN THE STACK WHICH IS VISIBLE ENDS HERE. */


                                        ],
                                      )


                                  ),
                                ),

                              ],
                            )


                        ),
                      ),
                    ),
                  );
                }
              }
          )
      );
    }
  }




}




//  FoodDetailImage








