//food_gallery.dart



// dependency files
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/BLoC/shoppingCart_bloc.dart';
import 'package:foodgallery/src/DataLayer/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/FoodItemWithDocIDViewModel.dart';
import 'package:foodgallery/src/DataLayer/NewIngredient.dart';
import 'package:foodgallery/src/screens/shoppingCart/widgets/FoodImage_inShoppingCart.dart';
import 'package:logger/logger.dart';
//import 'package:neumorphic/neumorphic.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


//sizeConstantsList


// SCREEN FILES AND MODLE FILES AND UTILITY FILES.
import 'package:foodgallery/src/screens/ingredients_more/more_ingredients.dart';
import 'package:foodgallery/src/DataLayer/IngredientItem.dart';
import 'package:foodgallery/src/DataLayer/SizeConstants.dart';
import 'package:foodgallery/src/DataLayer/OrderTypeSingleSelect.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
//import 'package:foodgallery/src/screens/foodItemDetailsPage/Widgets/FoodDetailImage.dart';
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
  int _currentOrderTypeIndex=0;
  bool showFullOrderType = true;

  final addressController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    addressController.dispose();
    super.dispose();
  }



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
    Order thisOrder = shoppingCartBloc.getCurrentOrder;

//    priceByQuantityANDSize = oneFood.itemPrice;



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
//                      Navigator.pop(context);
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
                        child: SingleChildScrollView(
                          child: Container(
                              height: displayHeight(context) -
                                  MediaQuery
                                      .of(context)
                                      .padding
                                      .top -
                                  kToolbarHeight,
                              child: Column(
                                children: <Widget>[
                                  Container(


//                                      alignment: Alignment.bottomCenter,
                                    height: displayHeight(context) / 1.2,
                                    //width:displayWidth(context) / 1.5, /* 3.8*/
                                    width: displayWidth(context)
                                        - displayWidth(context) /
                                            5 /* this is about the width of yellow side menu */
                                    ,
//                  color:Colors.lightGreenAccent,
                                    margin: EdgeInsets.fromLTRB(
                                        12, displayHeight(context) / 11, 10, 5),


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



                                        // THIS CHILD COLUMNS HOLDS THE CONTENTS OF THIS PAGE. BEGINS HERE.

                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[

//                                          /WWW??
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
                                                                'Shopping Cart',
                                                                style: TextStyle(
                                                                  fontSize: 30,
                                                                  fontWeight: FontWeight
                                                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                                                  color: Color(
                                                                      0xff000000),
                                                                )
                                                            ),
                                                          ),

                                                          CustomPaint(
                                                            size: Size(0, 19),
                                                            painter: LongHeaderPainterAfter(
                                                                context),
                                                          ),


                                                        ]
                                                    ),

                                                  ),

                                                  // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
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


                                                  // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                                                ],
                                              ),
                                            ),

                                            // IMAGES OF FOODS   QUANTITY TIMES PUT HERE

                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 5),
//                                                      padding::::
                                              color: Colors.white,
                                              height: displayHeight(context) / 4,
                                              width: displayWidth(context)
                                                  - displayWidth(context) /
                                                      5, /* this is about the width of yellow side menu */

//                                            width: displayWidth(context) * 0.57,
                                              child: _buildQuantityTimesofFood(
                                                  oneOrder),

                                            ),



                                            /*
                                            * INITIAL CHOOSE ORDER TYPE BEGINS HERE.*/

//                                            showFullOrderType

                                            Container(
//                                        width: displayWidth(context) /1.8,
                                              width: displayWidth(context) / 1.1,
                                              child:
                                              AnimatedSwitcher(
                                                duration: Duration(milliseconds: 1000),
//
                                                child: showFullOrderType? animatedWidgetShowFullOrderType():
                                                animatedWidgetShowSelectedOrderType(),

                                              ),


                                            ),



                                            /*
                                            * INITIAL CHOOSE ORDER TYPE ENDS HERE.*/


                                            /*  TOP CONTAINER IN THE STACK WHICH IS VISIBLE ENDS HERE. */



                                            Container(
                                              color:Colors.white,
//                                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                        width: displayWidth(context) /1.8,
                                              width: displayWidth(context) / 1.1,
                                              child:
                                              AnimatedSwitcher(
                                                duration: Duration(milliseconds: 500),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
                                                child: oneOrder.deliveryTypeIndex ==1 ?
                                                animatedUnObscuredTextInputContainer()
                                                    :oneOrder.deliveryTypeIndex ==2?
                                                animatedUnObscuredTextInputContainer():
                                                animatedObscuredTextInputContainer(),


                                              ),


                                            ),

                                            //xxxx






                                          ],
                                        )


                                    ),
                                  ),

                                ],
                              )


                          ),
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

  Widget animatedWidgetShowFullOrderType() {
    return
      Container(
        height: displayHeight(context) / 20 /* HEIGHT OF CHOOSE ORDER TYPE TEXT PORTION */ +  displayHeight(context) /7 /* HEIGHT OF MULTI SELECT PORTION */,
        child: Column(
          children: <Widget>[
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
                                'Choose Order Type',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
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

  Widget animatedWidgetShowSelectedOrderType() {

    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return StreamBuilder(
        stream: shoppingCartbloc.getCurrentOrderTypeSingleSelectStream,
        initialData: shoppingCartbloc.getCurrentOrderType,

        builder: (context, snapshot)
        {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Container(child: Text('Null'));
          }
          else {
            List<OrderTypeSingleSelect> allOrderTypesSingleSelect = snapshot.data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

            print('orderTypes: $allOrderTypesSingleSelect');
            OrderTypeSingleSelect selectedOne = allOrderTypesSingleSelect
                .firstWhere((oneOrderType) => oneOrderType.isSelected == true);
            _currentOrderTypeIndex = selectedOne.index;


            String orderTypeName = selectedOne.orderType;
            String orderIconName = selectedOne.orderIconName;
            String borderColor = selectedOne.borderColor;
            const Color OrderTypeIconColor=Color(0xff070707);




            return Container(
              width: displayWidth(context) / 1.1,
              height: displayHeight(context) / 12,
              color: Color(0xffffffff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                                'Choose Order Type',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),

                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForanimatedWidgetShowSelectedOrderType(
                                context),
                          ),

                        ]
                    ),

                  ),
                  // THE ABOVE PART DEALS WITH LINES AND TEXT,
                  // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:

                  Container(

                    width: 100,
                    height: displayHeight(context) /10,
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
                    child:
                    OutlineButton(
                      color: Color(0xff000000),

//          elevation: 2.5,
                      // RoundedRectangleBorder
//          shape: CircleBorder(
                      shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(
                          color:Color(0xff000000),
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      child:Container(
//                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .start
                          ,
//                          crossAxisAlignment: CrossAxisAlignment
//                              .center,
//                          AA
                          children: <Widget>[

                            new Container(

//                                width: displayWidth(context) * 0.09,
//                                height: displayWidth(context) * 0.11,

                              width:  90,
                              height: displayHeight(context) /15,
//                decoration: new BoxDecoration(
//                  color: Colors.orange,
//                  shape: BoxShape.circle,
//                ),
                              decoration: BoxDecoration(
                                border: Border.all(
//                    color: Colors.black,
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0,

                                ),
                                shape: BoxShape.circle,
//                    borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
//                padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),


                              child: Icon(
                                getIconForName(orderTypeName),
                                color: Colors.black,
                                size: displayHeight(context) /24,

                              ),
                            ),

                            Container(

                              alignment: Alignment.center,
                              child: Text(
                                orderTypeName, style:
                              TextStyle(
                                  color:Colors.red,

                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {

                        //final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                        //shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(x,index,_currentOrderTypeIndex);

                        setState(() {
                          showFullOrderType = !showFullOrderType;
                        });


                      },
                    ),
                    // : Container for 2nd argument of ternary condition ends here.

                  )



                  //ZZZZ


                ],
              ),
            );
          }
        }
    );
  }

  Widget animatedUnObscuredTextInputContainer(){

    print('at animated Un Obscured Text Input Container');
    return
      Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                                      padding::::
          color:Colors.white,
//                                            height: 200,
          height: displayHeight(context) /4,
          width: displayWidth(context)
              - displayWidth(context) / 5,
//                                            width: displayWidth(context) * 0.57,

          child: _buildShoppingCartInputFields()


      );


  }

  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print('at animated Obscured Text Input Container');
    return
      AbsorbPointer(
        child: Opacity(
          opacity:0.8,
          child: Container(
//            Colors.white.withOpacity(0.10),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                                      padding::::
              color:Colors.white,
//                                            height: 200,
              height: displayHeight(context) /4,
              width: displayWidth(context)
                  - displayWidth(context) /
                      5,
//                                            width: displayWidth(context) * 0.57,
              /*
                                                    child:  AbsorbPointer(
                                                      child: _buildShoppingCartInputFields()
                                                  ),
                                                  */
              child: _buildShoppingCartInputFields()


          ),
        ),
      );
  }


  Widget _buildQuantityTimesofFood(Order qTimes) {
//   height: 40,
//   width: displayWidth(context) * 0.57,


//    final foodItemDetailsbloc = BlocProvider.of<ShoppingCartBloc>(context);
    if ((qTimes.foodItemName == '') && (qTimes.quantity == 0)) {
      print('Order has no data');
      print('this will never happen don\'t worry');
//        return Center(child: new LinearProgressIndicator());
      return Container(child: Text('Null'));
    }
    else {
      int quantity = qTimes.quantity;
      String OrderedFoodItemName = qTimes.foodItemName;
      String OrderedFoodImageURL = qTimes.foodItemImageURL;

//      final String imageURLBig;
//      final String foodItemName;
      final List<NewIngredient> selectedIngredients =qTimes.ingredients;
      final double price = qTimes.unitPrice;

      return Container(

        color: Colors.green,

        child: ListView.builder(
          scrollDirection: Axis.horizontal,

          reverse: false,

          shrinkWrap: false,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
          itemCount: quantity,

          itemBuilder: (_, int index) {
            return FoodImageInShoppingCart(
                OrderedFoodImageURL,OrderedFoodItemName,selectedIngredients,price,index
            );
//          oneMultiSelectInDetailsPage(foodItemPropertyOptions[index],
//            index);
          },
        ),


        // M VSM ORG VS TODO. ENDS HERE.
      );
    }
  }


  Widget _buildOrderTypeSingleSelectOption(){
//   height: 40,
//   width: displayWidth(context) * 0.57,


    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return StreamBuilder(
        stream: shoppingCartbloc.getCurrentOrderTypeSingleSelectStream,
        initialData: shoppingCartbloc.getCurrentOrderType,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Container(child: Text('Null'));
          }
          else {
            List<OrderTypeSingleSelect> allOrderTypesSingleSelect = snapshot.data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

            print('orderTypes: $allOrderTypesSingleSelect');
            OrderTypeSingleSelect selectedOne = allOrderTypesSingleSelect.firstWhere((oneOrderType) =>oneOrderType.isSelected==true);
            _currentOrderTypeIndex = selectedOne.index;


            return ListView.builder(
              scrollDirection: Axis.horizontal,

//              reverse: true,

              shrinkWrap: false,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
              itemCount: allOrderTypesSingleSelect.length,

              itemBuilder: (_, int index) {
                return oneSingleDeliveryType(
                    allOrderTypesSingleSelect[index],
                    index);
              },
            );
          }
        }

      // M VSM ORG VS TODO. ENDS HERE.
    );

  }


  Widget _buildShoppingCartInputFields(){

    //    CustomerInformation
    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

    return StreamBuilder(
        stream: shoppingCartBloc.getCurrentCustomerInformationStream,
        initialData: shoppingCartBloc.getCurrentCustomerInfo,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Container(child: Text('Null'));
          }
          else {

            CustomerInformation currentUser =  snapshot.data;

            return Center(

                child: Container(
//                  color: Colors.green,
//                    color:Colors.white.withOpacity(0.9),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        Container(
                            alignment: Alignment.center,

                            child: Text('Enter user address',
                              style: TextStyle(
                                color:
                                Color(0xffFC0000),
                                fontSize: 30,
                              ),)
                        ),


                        // CUSTOMER LOCATION ADDRESS CONTAINER BEGINS HERE.
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 0),
                          decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(

                              color: Color(0xffBCBCBD),
                              style: BorderStyle.solid,
                              width: 2.0,


                            ),

                            boxShadow: [
                              BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                  color: Color(0xffFFFFFF),
                                  blurRadius: 10.0,
                                  offset: Offset(0.0, 2.0))
                            ],


                            color: Color(0xffFFFFFF),
//                                      Colors.black54
                          ),

//                                  color: Color(0xffFFFFFF),
                          width: displayWidth(context) / 2.5,
                          height: displayHeight(context) / 24,
                          padding: EdgeInsets.only(
                              left: 4, top: 3, bottom: 3, right: 3),
                          child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(

                                height: 25,
                                width: 5,
                                margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                child: Icon(
//                                          Icons.add_shopping_cart,
                                  Icons.location_on,

                                  size: 28,
                                  color: Color(0xffBCBCBD),
                                ),


                              ),

                              Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                alignment: Alignment.center,
                                width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                // do it in both Container
                                child: TextField(
                                  controller: addressController,

                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    focusColor: Colors.red,
//                                                            fillColor: Colors.red,
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                    border: InputBorder.none,
                                    hintText: 'Enter delivery location',
                                    hintStyle: TextStyle(
                                        color: Color(0xffFC0000), fontSize: 17),

//                                      currentUser
//                                        labelText: 'Search about meal.'
                                  ),

                                  onChanged: (text) {
                                    //RRRR

                                    final shoppingCartBloc = BlocProvider.of<
                                        ShoppingCartBloc>(context);
//
                                    shoppingCartBloc.setAddressForOrder(text);

                                    setState(() => showFullOrderType = false);
                                  },

                                  onTap: () {
                                    setState(() => showFullOrderType = false);
                                  },
                                  /*

                                                            onEditingComplete: (){
                                                              logger.i('onEditingComplete  of condition 4');
                                                              print('called onEditing complete');
                                                              setState(() => _searchString = "");
                                                            },



                                                            onSubmitted: (String value) async {
                                                              await showDialog<void>(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Thanks!'),
                                                                    content: Text ('You typed "$value".'),
                                                                    actions: <Widget>[
                                                                      FlatButton(
                                                                        onPressed: () { Navigator.pop(context); },
                                                                        child: const Text('OK'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                          */


                                  style: TextStyle(
                                      color: Color(0xffFC0000), fontSize: 16),
                                ),

                              )

//                                  Spacer(),

//                                  Spacer(),

                            ],
                          ),
                        ),

                        // CUSTOMER LOACATION ADDRESS CONTAINER ENDS HERE.

                        // CUSTOMER HOUSE || FLAT NUMBER CONTAINER BEGINS HERE.
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 0),
                          decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(

                              color: Color(0xffBCBCBD),
                              style: BorderStyle.solid,
                              width: 2.0,


                            ),

                            boxShadow: [
                              BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                  color: Color(0xffFFFFFF),
                                  blurRadius: 10.0,
                                  offset: Offset(0.0, 2.0))
                            ],


                            color: Color(0xffFFFFFF),
//                                      Colors.black54
                          ),

//                                  color: Color(0xffFFFFFF),
                          width: displayWidth(context) / 2.5,
                          height: displayHeight(context) / 24,
                          padding: EdgeInsets.only(
                              left: 4, top: 3, bottom: 3, right: 3),
                          child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(

                                height: 25,
                                width: 5,
                                margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                child: Icon(
//                                          Icons.add_shopping_cart,
                                  Icons.home,
                                  size: 28,
                                  color: Color(0xffBCBCBD),
                                ),


                              ),

                              Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                alignment: Alignment.center,
                                width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                // do it in both Container
                                child: TextField(

                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                    border: InputBorder.none,
                                    hintText: 'Enter House/Flat address/number',
                                    hintStyle: TextStyle(
                                        color: Color(0xffFC0000), fontSize: 17),

//                                        labelText: 'Search about meal.'
                                  ),

                                  onChanged: (text) {
                                    final shoppingCartBloc = BlocProvider.of<
                                        ShoppingCartBloc>(context);
//
                                    shoppingCartBloc
                                        .setHouseorFlatNumberForOrder(
                                        text);

                                    setState(() => showFullOrderType = false);
                                  },


                                  onTap: () {
                                    setState(() => showFullOrderType = false);
                                  },
                                  /*

                                                            onEditingComplete: (){
                                                              logger.i('onEditingComplete  of condition 4');
                                                              print('called onEditing complete');
                                                              setState(() => _searchString = "");
                                                            },

                                                            onSubmitted: (String value) async {
                                                              await showDialog<void>(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Thanks!'),
                                                                    content: Text ('You typed "$value".'),
                                                                    actions: <Widget>[
                                                                      FlatButton(
                                                                        onPressed: () { Navigator.pop(context); },
                                                                        child: const Text('OK'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },

                                                            */

                                  style: TextStyle(
                                      color: Color(0xffFC0000), fontSize: 16),
                                ),

                              )

//                                  Spacer(),

//                                  Spacer(),

                            ],
                          ),
                        ),


                        // CUSTOMER HOUSE || FLAT NUMBER CONTAINER ENDS HERE.

                        // CUSTOMER PHONE || MOBILE NUMBER CONTAINER BEGINS HERE.
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 0),
                          decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(

                              color: Color(0xffBCBCBD),
                              style: BorderStyle.solid,
                              width: 2.0,


                            ),

                            boxShadow: [
                              BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                  color: Color(0xffFFFFFF),
                                  blurRadius: 10.0,
                                  offset: Offset(0.0, 2.0))
                            ],


                            color: Color(0xffFFFFFF),
//                                      Colors.black54
                          ),

//                                  color: Color(0xffFFFFFF),
                          width: displayWidth(context) / 2.5,
                          height: displayHeight(context) / 24,
                          padding: EdgeInsets.only(
                              left: 4, top: 3, bottom: 3, right: 3),
                          child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(

                                height: 25,
                                width: 5,
                                margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                child: Icon(
//                                          Icons.add_shopping_cart,
                                  Icons.phone,
                                  size: 28,
                                  color: Color(0xffBCBCBD),
                                ),


                              ),

                              Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                alignment: Alignment.center,
                                width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                // do it in both Container
                                child: TextField(

                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                    border: InputBorder.none,
                                    hintText: 'Enter phone / telephone number',
                                    hintStyle: TextStyle(
                                        color: Color(0xffFC0000), fontSize: 17),

//                                        labelText: 'Search about meal.'
                                  ),

                                  style: TextStyle(
                                      color: Color(0xffFC0000), fontSize: 16),

                                  onChanged: (text) {
                                    print("33: $text");

                                    final shoppingCartBloc = BlocProvider.of<
                                        ShoppingCartBloc>(context);
//
                                    shoppingCartBloc.setPhoneNumberForOrder(
                                        text);

                                    setState(() => showFullOrderType = false);
                                  },


                                  onTap: () {
                                    setState(() => showFullOrderType = false);
                                  },
                                  /*

                                                            onEditingComplete: (){
                                                              logger.i('onEditingComplete  of condition 4');
                                                              print('called onEditing complete');
                                                              setState(() => _searchString = "");
                                                            },

                                                            onSubmitted: (String value) async {
                                                              await showDialog<void>(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Thanks!'),
                                                                    content: Text ('You typed "$value".'),
                                                                    actions: <Widget>[
                                                                      FlatButton(
                                                                        onPressed: () { Navigator.pop(context); },
                                                                        child: const Text('OK'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                              */
                                ),

                              )

//                                  Spacer(),

//                                  Spacer(),

                            ],
                          ),
                        ),


                        // CUSTOMER PHONE || MOBILE NUMBER CONTAINER ENDS HERE.

                        // CUSTOMER LOCATION REACH OUT TIME CONTAINER BEGINS HERE.

                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 0),
                          decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(

                              color: Color(0xffBCBCBD),
                              style: BorderStyle.solid,
                              width: 2.0,


                            ),

                            boxShadow: [
                              BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                  color: Color(0xffFFFFFF),
                                  blurRadius: 10.0,
                                  offset: Offset(0.0, 2.0))
                            ],


                            color: Color(0xffFFFFFF),
//                                      Colors.black54
                          ),

//                                  color: Color(0xffFFFFFF),
                          width: displayWidth(context) / 2.5,
                          height: displayHeight(context) / 24,
                          padding: EdgeInsets.only(
                              left: 4, top: 3, bottom: 3, right: 3),
                          child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(

                                height: 25,
                                width: 5,
                                margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                child: Icon(
//                                          Icons.add_shopping_cart,
                                  Icons.watch_later,
                                  size: 28,
                                  color: Color(0xffBCBCBD),
                                ),


                              ),

                              Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                alignment: Alignment.center,
                                width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                // do it in both Container
                                child: TextField(
                                  keyboardType: TextInputType.number,

                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                    border: InputBorder.none,
                                    hintText: 'Enter reach out time',
                                    hintStyle: TextStyle(
                                        color: Color(0xffFC0000), fontSize: 17),

//                                        labelText: 'Search about meal.'
                                  ),

                                  style: TextStyle(
                                      color: Color(0xffFC0000), fontSize: 16),

                                  onChanged: (text) {
                                    print("0444: $text");


                                    print("33: $text");
                                    final shoppingCartBloc = BlocProvider.of<
                                        ShoppingCartBloc>(context);

                                    shoppingCartBloc.setETAForOrder(text);
                                    setState(() => showFullOrderType = false);
                                  },

                                  onTap: () {
                                    setState(() => showFullOrderType = false);
                                  },
                                  /*



                                                            onEditingComplete: (){
                                                              logger.i('onEditingComplete  of condition 4');
                                                              print('called onEditing complete');
                                                              setState(() => _searchString = "");
                                                            },



                          onSubmitted: (String value) async {
                            await showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Thanks!'),
                                  content: Text ('You typed "$value".'),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () { Navigator.pop(context); },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          */
                                ),

                              )

//                                  Spacer(),

//                                  Spacer(),

                            ],
                          ),
                        ),

                        // CUSTOMER LOCATION REACH OUT TIME CONTAINER ENDS HERE.


                      ],
                    )
                )

            );
          }

        }
    );

  }

  IconData getIconForName(String iconName) {

    print ('iconName at getIconForName: $iconName');
    switch(iconName) {
      case 'facebook': {
//        return FontAwesomeIcons.facebook;
        return FontAwesomeIcons.facebook;
      }
      break;

      case 'twitter': {
        return FontAwesomeIcons.twitter;
      }
      break;
      case 'TakeAway': {
        return Icons.work;
      }
      break;
      case 'Delivery': {
        return Icons.local_shipping;
      }
      break;
      case 'Phone': {
        return Icons.phone_in_talk;
      }
      break;
      case 'DinningRoom': {
        return Icons.fastfood;
      }
      break;





      default: {
        return FontAwesomeIcons.home;
      }
    }
  }

  Widget oneSingleDeliveryType (OrderTypeSingleSelect x,int index){

//    String color1 = x.itemTextColor.replaceAll('#', '0xff');

//    Color c1 = Color(int.parse(color1));
//    print('x: ',x.i)

//    IconData x = IconData(int.parse(x.iconDataString),fontFamily: 'MaterialIcons');

    print('x.icondataString: ${x.iconDataString}');
    print('x.orderType: ${x.orderType}');
    print('isSelected check at Shopping Cart Page: ${x.isSelected}');
//    logger.i('isSelected check at Shopping Cart Page: ',x.isSelected);



    String orderTypeName = x.orderType;
    String orderIconName = x.orderIconName;
    String borderColor = x.borderColor;
    const Color OrderTypeIconColor=Color(0xff070707);
    return Container(

//      height:displayHeight(context)/30,
//      width:displayWidth(context)/10,

      child:  index == _currentOrderTypeIndex  ?

      Container(

        width: 150,
        height: displayHeight(context) /7,
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
        child:
        OutlineButton(
          color: Color(0xff000000),

//          elevation: 2.5,
          // RoundedRectangleBorder
//          shape: CircleBorder(
          shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
              color:Color(0xff000000),
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(35.0),
          ),

          child:Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              children: <Widget>[

                new Container(

//                                width: displayWidth(context) * 0.09,
//                                height: displayWidth(context) * 0.11,
                  width:  displayWidth(context)/6.5,
                  height: displayWidth(context)/6.5,
//                decoration: new BoxDecoration(
//                  color: Colors.orange,
//                  shape: BoxShape.circle,
//                ),
                  decoration: BoxDecoration(
                    border: Border.all(
//                    color: Colors.black,
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0,

                    ),
                    shape: BoxShape.circle,
//                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
//                padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),


                  child: Icon(
                    getIconForName(orderTypeName),
                    color: Colors.red,
                    size: displayWidth(context)/9,

                  ),
//
//                child: Icon(IconData(58840, fontFamily: 'MaterialIcons')),
//                Icon(
//                  IconData(x.orderIconName),
//                               color: Colors.red,
//                  size: 36.0,
//                ),
//                child: Icon(IconData(), color: Colors.red), todo

                ),
//              Container(
//
//                alignment: Alignment.center,
//                child: Text(
//                  orderTypeName, style:
//                TextStyle(
//                    color:Colors.white,
//
//                    fontWeight: FontWeight.bold,
//                    fontSize: 16),
//                ),
//              ),

                Container(

                  alignment: Alignment.center,
                  child: Text(
                    orderTypeName, style:
                  TextStyle(
                      color:Colors.red,

                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {

            final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
            shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(x,index,_currentOrderTypeIndex);

//            setState(() {
//              _currentOrderTypeIndex=index;
//            });


          },
        ),
        // : Container for 2nd argument of ternary condition ends here.

      ):

      Container(
        width: 150,
        height: displayHeight(context) /7,
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
        child:
        OutlineButton(
          color: Color(0xff000000),

//          elevation: 2.5,
          shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
              color:Color(0xff000000),
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(35.0),
          ),

          child:Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              children: <Widget>[

                new Container(

//                                width: displayWidth(context) * 0.09,
//                                height: displayWidth(context) * 0.11,
                  width:  displayWidth(context)/6.5,
                  height: displayWidth(context)/6.5,
                  decoration: BoxDecoration(
                    border: Border.all(
//                      color: Colors.red[500],
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0,

                    ),
                    shape: BoxShape.circle,
//                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
//                padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),


                  child: Icon(
                    getIconForName(orderTypeName),
                    color: Colors.grey,
                    size: displayWidth(context)/9,
                  ),
//                child: Icon(
//                  Icons.beach_access,
//                  color: Colors.grey,
//                  size: 36.0,
//                ),

                ),
//              Container(
//
//                alignment: Alignment.center,
//                child: Text(
//                  orderTypeName, style:
//                TextStyle(
//                    color:Colors.white,
//
//                    fontWeight: FontWeight.bold,
//                    fontSize: 16),
//                ),
//              ),

                Container(

                  alignment: Alignment.center,
                  child: Text(
                    orderTypeName, style:
                  TextStyle(
                      color:Colors.red,

                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {

            final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
            shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(x,index,_currentOrderTypeIndex);


//            setState(() {
//              _currentOrderTypeIndex=index;
//            });


          },
        ),




      ),
    );
  }


}

class LongHeaderPainterAfter extends CustomPainter {

  final BuildContext context;
  LongHeaderPainterAfter(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/2.8, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(10, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }



}


class LongPainterForChooseOrderType extends CustomPainter {

  final BuildContext context;
  LongPainterForChooseOrderType(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/2.9, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(10, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}

class LongPainterForanimatedWidgetShowSelectedOrderType extends CustomPainter {

  final BuildContext context;
  LongPainterForanimatedWidgetShowSelectedOrderType(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/3.9, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(10, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}




class LongHeaderPainterBefore extends CustomPainter {


  final BuildContext context;
  LongHeaderPainterBefore(this.context);


  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(-displayWidth(context)/4, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(-10, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}




//  FoodDetailImage








