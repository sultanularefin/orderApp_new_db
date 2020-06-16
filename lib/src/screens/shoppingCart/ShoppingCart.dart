//food_gallery.dart



// dependency files
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/shoppingCart_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';

import 'package:foodgallery/src/screens/shoppingCart/widgets/FoodImage_inShoppingCart.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import 'package:logger/logger.dart';

import 'package:foodgallery/src/DataLayer/models/Order.dart';

// model files

import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/OrderTypeSingleSelect.dart';
import 'package:foodgallery/src/DataLayer/models/PaymentTypeSingleSelect.dart';

// LOCAL SCREEN FILES:

import './widgets/ShoppingCartPagePainters.dart';

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

//  String _currentSize;
//  int _itemCount = 1;
  int _currentOrderTypeIndex = 0; // phone, takeaway, delivery, dinning.
  int _currentPaymentTypeIndex = 2;// PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)
  bool showFullOrderType                  = true;
  bool showUserInputOptionsLikeFirstTime  = true;
  bool showCustomerInformationHeader      = false;
  bool showFullPaymentType                = true;

  bool showEditingCompleteCustomerAddressInformation   = false;
  bool showEditingCompleteCustomerHouseFlatIformation = false;
  bool showEditingCompleteCustomerPhoneIformation     = false;
  bool showEditingCompleteCustomerReachoutIformation  = false;


//  bool showInputtedCustomerIformation = false;

  final addressController         = TextEditingController();
  final houseFlatNumberController = TextEditingController();
  final phoneNumberController     = TextEditingController();
  final etaController             = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
    addressController.dispose();
    houseFlatNumberController.dispose();
    phoneNumberController.dispose();
    etaController.dispose();

  }



//  color: Color(0xff34720D),
//  VS 0xffFEE295 3 0xffFEE295 false
//  ORG 0xff739DFA 4 0xff739DFA false


  /*
  @override
  void initState() {
//    setDetailForFood();
//    retrieveIngredientsDefault();
    super.initState();
  }

  */


  double tryCast<num>(dynamic x, {num fallback }) {
//    print(" at tryCast");
//    print('x: $x');

    bool status = x is num;

//    print('status : x is num $status');
//    print('status : x is dynamic ${x is dynamic}');
//    print('status : x is int ${x is int}');
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

//    Order thisOrder = shoppingCartBloc.getCurrentOrder;

//    priceByQuantityANDSize = oneFood.itemPrice;



//    logger.w('thisOrder : ',
//        thisOrder);


//    if (thisOrder == null) {
//      return Container
//        (
//        alignment: Alignment.center,
//        child: CircularProgressIndicator(),
//      );
//    }
//    else {
    return StreamBuilder<Order>(


        stream: shoppingCartBloc.getCurrentOrderStream,
        initialData: shoppingCartBloc.getCurrentOrder,

        builder: (context, snapshot) {
//            if (snapshot.hasData) {

//              print('snapshot.hasData in main build(BuildContext context) : ${snapshot.hasData}');
          // ---

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Container(
                margin: EdgeInsets.fromLTRB(
                    0, displayHeight(context) / 2, 0, 0),
                child: Center(
                  child: Column(
                    children: <Widget>[

                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: new CircularProgressIndicator(
                                backgroundColor: Colors.lightGreenAccent)
                        ),
                      ),
                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: new CircularProgressIndicator(
                              backgroundColor: Colors.yellow,)
                        ),
                      ),
                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: new CircularProgressIndicator(
                                backgroundColor: Colors.redAccent)
                        ),
                      ),
                    ],
                  ),
                ),

              );
              break;

            case ConnectionState.active:
            default:
              Order oneOrder = snapshot.data;




//              int x = 5;

              CustomerInformation x = oneOrder.ordersCustomer;

//              logger.e(' oneOrder.paymentTypeIndex: ${oneOrder.paymentTypeIndex}');


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
//                      backgroundColor: Colors.white,
                  // this is the main reason of transparency at next screen.
                  // I am ignoring rest implementation but what i have achieved is you can see.

                  body: SafeArea(


                    // smaller container containing all modal FoodItem Details things.

                    // HOW CAN I MAKE  SingleChildScrollView Scrollable.
                    child: SingleChildScrollView(
                      child: Container(
//                          height: displayHeight(context) -
//                              MediaQuery
//                                  .of(context)
//                                  .padding
//                                  .top -
//                              kToolbarHeight,
                        height: displayHeight(context) ,
                        child: Column(
                          children: <Widget>[
                            Container(


//                              alignment: Alignment.bottomCenter,
                              height: displayHeight(context) / 1.12,
                              //width:displayWidth(context) / 1.5, /* 3.8*/
                              width: displayWidth(context)
                                  - displayWidth(context) /
                                      5 /* this is about the width of yellow side menu */
                              ,
//                  color:Colors.lightGreenAccent,
                              margin: EdgeInsets.fromLTRB(
                                  12, displayHeight(context) / 16, 10, 0),


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



                                    // IMAGES OF FOODS   QUANTITY TIMES PUT HERE






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

                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 0, 0, 0),
//                                                      padding::::
                                      color: Colors.amberAccent,
                                      height: displayHeight(context) / 5.2,
                                      width: displayWidth(context)
                                          - displayWidth(context) /
                                              5, /* this is about the width of yellow side menu */

//                                            width: displayWidth(context) * 0.57,
                                      child: _buildQuantityTimesofFood(
                                        /*oneOrder*/),
                                    ),



                                    // work 1
                                    Container(
//                                        width: displayWidth(context) /1.8,
                                      width: displayWidth(context) / 1.1,
                                      child:
                                      AnimatedSwitcher(
                                        duration: Duration(milliseconds: 1000),
//
                                        child: showFullOrderType?
                                        animatedWidgetShowFullOrderType():/*1 */
                                        animatedWidgetShowSelectedOrderType(), /* 2*/
                                        // 1 => displayHeight(context) / 20 + displayHeight(context) / 7
                                        // 2 => height: displayHeight(context) / 9,

                                      ),


                                    ),




                                    /*
                                            * INITIAL CHOOSE ORDER TYPE ENDS HERE.*/







                                    Container(
                                      color:Colors.yellowAccent,
//                                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                        width: displayWidth(context) /1.8,
                                      width: displayWidth(context) / 1.1,
//                                            height: displayHeight(context)/2.5,
                                      // THIS HEIGHT SHOULDN'T BE GIVEN OTHERWISE
                                      // A CERTAIN PORTION OF OF THE CONTAINER
                                      // WITH YELLOW ACCENT BG COLOR IS
                                      // THERE WHEN THE CHILD WIDGETS ARE NOT
                                      // BIG ENOGH LIKE , AS BIG AS displayHeight(context)/2.5,



                                      //Text('AnimatedSwitcher('),
                                      child: AnimatedSwitcher(
                                        duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
                                        child: oneOrder.orderTypeIndex == 0?
                                        _buildShoppingCartInputFieldsUNObscuredTakeAway(oneOrder)
                                            :oneOrder.orderTypeIndex == 1 ?
                                        _buildShoppingCartInputFieldsUNObscured(oneOrder)
                                            :oneOrder.orderTypeIndex == 2 ?
                                        _buildShoppingCartInputFieldsUNObscured (oneOrder):
                                            //OBSCURED NOT REQUIRED SINCE FOR DINNING ROOM OPTION WE WILL HAVE
                                        // WHEN DO YOU WANT THE FOOD ON YOUR TABLE.
//                                        _buildShoppingCartInputFieldsUNObscuredTakeAway(oneOrder)
                                          _buildShoppingCartInputFieldsUNObscuredDinningRoom(oneOrder),
//                                        animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


                                      ),



                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );

          //return Text('${x.toString()}');

          }
        }

      //---
    );
//    }
  }



  Widget test1(Order oneOrder){
//    final Order oneOrder = snapshot.data;
//              _currentPaymentTypeIndex = oneOrder.paymentTypeIndex;


  }


  Widget animatedWidgetShowFullOrderType() {
//    print ('at animatedWidgetShowFullOrderType() ');

    return
      Container(
        height: displayHeight(context) / 20
            /* HEIGHT OF CHOOSE ORDER TYPE TEXT PORTION */
            +  displayHeight(context) /8.5 /* HEIGHT OF MULTI SELECT PORTION */,
//        from 7 to /8.5 on june 03

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
                            painter: LongPainterForChooseOrderTypeUpdated(
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
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
//                                                      padding::::
              color:Colors.white,
//                                            height: 200,
              height: displayHeight(context) /8.5,
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
            OrderTypeSingleSelect selectedOne = allOrderTypesSingleSelect.firstWhere((oneOrderType) =>
            oneOrderType.isSelected==true);
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


  Widget animatedWidgetShowSelectedOrderType() {


    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return Container(
      height: displayHeight(context) / 9,
      child: StreamBuilder(
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

//            print('orderTypes: $allOrderTypesSingleSelect');
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

                                width:  85,
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

                           // only one instance of this animatedWidgetShowSelectedOrderType() IS AVAILABLE AND IN below ().
                          // animatedWidgetShowSelectedOrderType()
                          setState(() {
                            showFullOrderType =
                            !showFullOrderType;

//                            showFullOrderType
                            /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
                            showCustomerInformationHeader = false;
                            showUserInputOptionsLikeFirstTime =true;
                            showFullPaymentType = true; //DEFAULT.


                            showEditingCompleteCustomerAddressInformation=
                            !showEditingCompleteCustomerAddressInformation;

                            showEditingCompleteCustomerHouseFlatIformation=
                            !showEditingCompleteCustomerHouseFlatIformation;

                            showEditingCompleteCustomerPhoneIformation=
                            !showEditingCompleteCustomerPhoneIformation;

                            showEditingCompleteCustomerReachoutIformation=
                            !showEditingCompleteCustomerReachoutIformation;

                            // BELOW LINES COMMENTED ON JUNE 15 2020
//                            showFullPaymentType = !showFullPaymentType;
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
      ),
    );
  }

  /*
  Widget animatedUnObscuredTextInputContainer(Order forUnObscured){

    print('at animated Un Obscured Text Input Container');
    return
      Container(
//            height: displayWidth(context)/2,
//          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
////                                                      padding::::
//          color:Colors.orange,
////                                            height: 200,
//          height: displayHeight(context) /2,
//          width: displayWidth(context)
//              - displayWidth(context) / 5,
//                                            width: displayWidth(context) * 0.57,

            child: _buildShoppingCartInputFieldsUNObscured(forUnObscured)



      );


  }
  */

  Widget animatedObscuredTextInputContainer(CustomerInformation forObscuredCustomerInputDisplay){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print('at animated Obscured Text Input Container');
    return
      AbsorbPointer(
        child: Opacity(
          opacity:0.4,
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
              child: _buildShoppingCartInputFieldsObscured(forObscuredCustomerInputDisplay)


          ),
        ),
      );
  }


  Widget _buildQuantityTimesofFood(/*Order qTimes */) {
//   height: 40,
//   width: displayWidth(context) * 0.57,

    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return StreamBuilder<List<SelectedFood>>(
        stream: shoppingCartbloc.getExpandedFoodsStream,
        initialData: shoppingCartbloc.getExpandedSelectedFood,

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SelectedFood> expandedSelectedFoodInOrder = snapshot.data;


//            logger.e(
//                'selectedFoodListLength: ${qTimes.selectedFoodListLength}');

//    final foodItemDetailsbloc = BlocProvider.of<ShoppingCartBloc>(context);

            if (expandedSelectedFoodInOrder == null) {
              print('Order has no data');
              print('this will never happen don\'t worry');
//        return Center(child: new LinearProgressIndicator());
              return Container(child: Text('expandedSelectedFoodInOrder == Null'));
            }

            //    VIEW MODEL CHANGE THUS CONDITION CHANGE 1.
            /*
    if ((qTimes.foodItemName == '') && (qTimes.quantity == 0)) {
      print('Order has no data');
      print('this will never happen don\'t worry');
//        return Center(child: new LinearProgressIndicator());
      return Container(child: Text('Null'));
    }
    */
            else {
//      int quantity = qTimes.quantity;
//      int quantity = qTimes.selectedFoodInOrder.length;

              List<SelectedFood> allOrderedFoods = expandedSelectedFoodInOrder;
/*
//      int tempItemCount = allOrderedFoods.fold(0, (t, e) => t + e.quantity);

//      const tempAllOptionsState =ChildrensFromData.map((oneQuestion,index) => {
//      const opt1 = Array(oneQuestion.option1.length).fill({...templateOptionsState, key: index + 'o1'})
//      for(let i=0; i<opt1.length;i++){
//        opt1[i]= {key:index+'_o1_'+i,value:false};
//
//        }

//      void forEach(void f(E element)) {
//        for (E element in this) f(element);
//      }
              List<SelectedFood> selectedFoodforDisplay = new List<
                  SelectedFood>();

//      List<SelectedFood> test = makeMoreFoodByQuantity(allOrderedFoods.first);


              allOrderedFoods.forEach((oneFood) {
                print('oneFood details: ===> ===> ');
                print('oneFood: ${oneFood.foodItemName}');
                print('oneFood: ${oneFood.quantity}');
//         print('oneFood: ${oneFood.foodItemName}');
                List<SelectedFood> test = makeMoreFoodByQuantity(oneFood);

                print('MOMENT OF TRUTH: ');
                print(':::: ::: :: $test');
                selectedFoodforDisplay.addAll(test);
              });


//      selectedFoodforDisplay.addAll(test);

              logger.i('|| || || || forDisplay: $selectedFoodforDisplay');
              print('item count : ${selectedFoodforDisplay.length}');

              print('\n\n AM I EXECUTED TWICE  ;;; \n\n ');
//       allOrderedFoods.map((oneFood)=>
//      makeMoreFoodByQuantity(oneFood.quantity));
//      String OrderedFoodItemName = qTimes.foodItemName;
//      String OrderedFoodImageURL = qTimes.foodItemImageURL;

//      final String imageURLBig;
//      final String foodItemName;

//      final List<NewIngredient> selectedIngredients =qTimes.ingredients;
//      final double price = qTimes.unitPrice;

              */
              return Container(

                color: Colors.green,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,

                  reverse: false,

                  shrinkWrap: false,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
//          itemCount: quantity,
                  itemCount: allOrderedFoods.length,
                  // List<SelectedFood> tempSelectedFoodInOrder = totalCartOrder.selectedFoodInOrder;


                  itemBuilder: (_, int index) {
//            return Text('ss');

                    return FoodImageInShoppingCart(
                        allOrderedFoods[index].foodItemImageURL, /*OrderedFoodImageURL,*/
                        allOrderedFoods[index].foodItemName, /*OrderedFoodItemName, */
                        allOrderedFoods[index].selectedIngredients,
                        allOrderedFoods[index].unitPrice,
                        index
                    );
//          oneMultiSelectInDetailsPage(foodItemPropertyOptions[index],
//            index);


                  },
                ),


                // M VSM ORG VS TODO. ENDS HERE.
              );
            }
          }
          else {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Container(child: Text('Null'));
          }
        }
    );
  }


//  animatedShowUserAddressDetailsInLineTakeAway
  Widget animatedShowUserAddressDetailsInLineTakeAway(CustomerInformation currentUserForInline){

//    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);
//
//    return StreamBuilder(
//        stream: shoppingCartbloc.getCurrentOrderTypeSingleSelectStream,
//        initialData: shoppingCartbloc.getCurrentOrderType,
//
//        builder: (context, snapshot)
//        {
//          if (!snapshot.hasData) {
//            print('!snapshot.hasData');
////        return Center(child: new LinearProgressIndicator());
//            return Container(child: Text('Null'));
//          }
//          else {
//            List<OrderTypeSingleSelect> allOrderTypesSingleSelect = snapshot.data;
//
////            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;
//
//            print('orderTypes: $allOrderTypesSingleSelect');
//            OrderTypeSingleSelect selectedOne = allOrderTypesSingleSelect
//                .firstWhere((oneOrderType) => oneOrderType.isSelected == true);
//            _currentOrderTypeIndex = selectedOne.index;
//
//
//            String orderTypeName = selectedOne.orderType;
//            String orderIconName = selectedOne.orderIconName;
//            String borderColor = selectedOne.borderColor;
//            const Color OrderTypeIconColor=Color(0xff070707);



//    currentUserForInline

    return Container(
      width: displayWidth(context) / 1.1,
      height: displayHeight(context) / 21 +  displayHeight(context) / 15,
//      height: displayHeight(context) / 8,
      // CHANGED FROM THIS */*  height: displayHeight(context) / 8, */ TO
      // THIS :  height: displayHeight(context) / 20, ON june  04 2020.
      color: Color(0xffffffff),
      child: Column(
          children: <Widget>[
            Container(
              height: displayHeight(context) / 21,
//              color:Colors.purple,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[


                  Container(
                    width: displayWidth(context) /
                        1.5,
                    height: displayHeight(
                        context) / 21,
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
                                'when you want to receive it',
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





                  //ZZZZ


                ],
              ),
            ),
            // ABOVE ROW CONTROLS THE TEXT AND LINE PAINTER AND EDIT BUTTON.


            // BELOW ROW HANDLES THE CUSTOMER INFORMATION ALONG WITH ICON AND POSSIBLY EDIT BUTTON.
            //HHH

            Container(
              height: displayHeight(context) / 20,
              color:Colors.amber,
              child:    ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: <Widget>[

                  /*
                  RaisedButton(
                    color:Colors.redAccent,
                    highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    splashColor: Color(0xffB47C00),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.address != ''? Container(
                      color:Colors.lightBlueAccent,
                      width:displayWidth(context) /2.6,
                      height:displayHeight(
                          context) / 20,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(

                            width: 30,
//                             height: displayHeight(context) /28,
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child:
                            Icon(Icons.location_on,
                                size: 32.0,
                                color: Colors.black),



                            //final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                            //shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(x,index,_currentOrderTypeIndex);

//                    setState(() {
//                      showFullOrderType = !showFullOrderType;
//                    });




                            // : Container for 2nd argument of ternary condition ends here.

                          ),
                          Expanded(
                            child: Container(
                              color:Colors.red,
//                                  height: displayHeight(context) /28,
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .centerLeft,
                              child: Text(
                                  '${currentUserForInline.address}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
//                                      textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),




                          //ZZZZ


                        ],
                      ),):  Container(
                      width:displayWidth(context) /4.6,
//                              width:displayWidth(context) /5.5
                    ),

                    onPressed: ()=>{
                      setState(() {

                        showEditingCompleteCustomerAddressInformation = !showEditingCompleteCustomerAddressInformation;
                        addressController.text = currentUserForInline.address;

//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),
                  RaisedButton(
                    color:Colors.redAccent,
                    highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    splashColor: Color(0xffB47C00),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.flatOrHouseNumber != ''?
                    Container(
                      color:Colors.brown,
//                       width:displayWidth(context) /2.6,
                      width:displayWidth(context) /4,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.home,
                              size: 32.0,
                              color: Colors.black
                          ),



                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  '${currentUserForInline.flatOrHouseNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),




                          //ZZZZ


                        ],
                      ),):  Container(
//                              width:displayWidth(context) /5.5
//                       width:displayWidth(context) /8,
                      width:displayWidth(context) /4,
                    )
                    ,
                    onPressed: ()=>{
                      setState(() {

                        showEditingCompleteCustomerHouseFlatIformation =
                        !showEditingCompleteCustomerHouseFlatIformation;

                        addressController.text = currentUserForInline.address;
                        houseFlatNumberController.text = currentUserForInline.flatOrHouseNumber;

//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                  // THIS CONTAINER ABOVE IS ABOUT HOUSE OR FLAT NUMBER INFORMATION ENDS HERE.
                  // THIS CONTAINER BELOW IS ABOUT PHONE NUMBER INFORMATION BEGINS HERE.
                  RaisedButton(
                    color:Colors.redAccent,
                    highlightColor: Colors.lightGreenAccent,
//                        highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    splashColor: Color(0xffB47C00),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.phoneNumber != ''?
                    Container(
                      color:Colors.lightGreenAccent,
                      width:displayWidth(context) /3,

                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Icon(Icons.phone,
                              size: 32.0,
                              color: Colors.black)
                          ,


                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  '${currentUserForInline.phoneNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),




                          //ZZZZ


                        ],
                      ),):  Container(
                      width:displayWidth(context) /3,
//                              width:displayWidth(context) /5.5
//                       width:displayWidth(context) /5.9,
                    )
                    ,
                    onPressed: ()=>{
                      setState(() {

                        showEditingCompleteCustomerPhoneIformation =
                        !showEditingCompleteCustomerPhoneIformation;


                        phoneNumberController.text = currentUserForInline.phoneNumber;



//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),
                  */
                  RaisedButton(
                    color:Colors.redAccent,
                    highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    splashColor: Color(0xffB47C00),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.etaTimeInMinutes != -1?
                    Container(
                      color:Colors.red,
//                       width:displayWidth(context) /10,
                      width:displayWidth(context) /4,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.watch,
                              size: 32.0,
                              color: Colors.black
                          ),



                          // : Container for 2nd argument of ternary condition ends here.


                          Container(
                            padding: EdgeInsets
                                .fromLTRB(
                                5, 0, 5, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                '${currentUserForInline.etaTimeInMinutes}',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),




                          //ZZZZ


                        ],
                      ),
                    ):  Container(
                      width:displayWidth(context) /4,
//                       width:displayWidth(context) /10,
                    )

                    // THIS CONTAINER ABOVE IS ABOUT ETA INFORMATION ENDS HERE.
                    ,
                    onPressed: ()=>{
                      setState(() {

                        showEditingCompleteCustomerReachoutIformation =
                        !showEditingCompleteCustomerReachoutIformation;


                        etaController.text = currentUserForInline.etaTimeInMinutes.toString();


//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                  /*
                   Container(
                     height: 50,
                     color: Colors.amber[500],
                     child: const Center(child: Text('Entry B')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   */
                ],
              ),

            )


          ]
      ),
    );
//          }
//        }
//    );
  }
//}

  Widget animatedShowUserAddressDetailsInLine(CustomerInformation currentUserForInline) {

//    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);
//
//    return StreamBuilder(
//        stream: shoppingCartbloc.getCurrentOrderTypeSingleSelectStream,
//        initialData: shoppingCartbloc.getCurrentOrderType,
//
//        builder: (context, snapshot)
//        {
//          if (!snapshot.hasData) {
//            print('!snapshot.hasData');
////        return Center(child: new LinearProgressIndicator());
//            return Container(child: Text('Null'));
//          }
//          else {
//            List<OrderTypeSingleSelect> allOrderTypesSingleSelect = snapshot.data;
//
////            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;
//
//            print('orderTypes: $allOrderTypesSingleSelect');
//            OrderTypeSingleSelect selectedOne = allOrderTypesSingleSelect
//                .firstWhere((oneOrderType) => oneOrderType.isSelected == true);
//            _currentOrderTypeIndex = selectedOne.index;
//
//
//            String orderTypeName = selectedOne.orderType;
//            String orderIconName = selectedOne.orderIconName;
//            String borderColor = selectedOne.borderColor;
//            const Color OrderTypeIconColor=Color(0xff070707);



//    currentUserForInline

    return Container(
      width: displayWidth(context) / 1.1,
      height: displayHeight(context) / 21 +  displayHeight(context) / 15,
//      height: displayHeight(context) / 8,
      // CHANGED FROM THIS */*  height: displayHeight(context) / 8, */ TO
      // THIS :  height: displayHeight(context) / 20, ON june  04 2020.
      color: Color(0xffffffff),
      child: Column(
          children: <Widget>[
            Container(
              height: displayHeight(context) / 21,
//              color:Colors.purple,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[


                  Container(
                    width: displayWidth(context) /
                        1.5,
                    height: displayHeight(
                        context) / 21,
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
                                'Enter user address',
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





                  //ZZZZ


                ],
              ),
            ),
            // ABOVE ROW CONTROLS THE TEXT AND LINE PAINTER AND EDIT BUTTON.


            // BELOW ROW HANDLES THE CUSTOMER INFORMATION ALONG WITH ICON AND POSSIBLY EDIT BUTTON.
            //HHH

            Container(
              height: displayHeight(context) / 20,
              color:Colors.amber,
              child:    ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  RaisedButton(
                    color:Colors.redAccent,
                    highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    splashColor: Color(0xffB47C00),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.address != ''? Container(
                      color:Colors.lightBlueAccent,
                      width:displayWidth(context) /2.6,
                      height:displayHeight(
                          context) / 20,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(

                            width: 30,
//                             height: displayHeight(context) /28,
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child:
                            Icon(Icons.location_on,
                                size: 32.0,
                                color: Colors.black),



                            //final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                            //shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(x,index,_currentOrderTypeIndex);

//                    setState(() {
//                      showFullOrderType = !showFullOrderType;
//                    });




                            // : Container for 2nd argument of ternary condition ends here.

                          ),
                          Expanded(
                            child: Container(
                              color:Colors.red,
//                                  height: displayHeight(context) /28,
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .centerLeft,
                              child: Text(
                                  '${currentUserForInline.address}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
//                                      textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),




                          //ZZZZ


                        ],
                      ),):  Container(
                      width:displayWidth(context) /4.6,
//                              width:displayWidth(context) /5.5
                    ),

                    onPressed: ()=>{
                      setState(() {

                        showEditingCompleteCustomerAddressInformation = !showEditingCompleteCustomerAddressInformation;
                        addressController.text = currentUserForInline.address;

//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),
                  RaisedButton(
                    color:Colors.redAccent,
                    highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    splashColor: Color(0xffB47C00),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.flatOrHouseNumber != ''?
                    Container(
                      color:Colors.brown,
//                       width:displayWidth(context) /2.6,
                      width:displayWidth(context) /4,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.home,
                              size: 32.0,
                              color: Colors.black
                          ),



                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  '${currentUserForInline.flatOrHouseNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),




                          //ZZZZ


                        ],
                      ),):  Container(
//                              width:displayWidth(context) /5.5
//                       width:displayWidth(context) /8,
                      width:displayWidth(context) /4,
                    )
                    ,
                    onPressed: ()=>{
                      setState(() {

                        showEditingCompleteCustomerHouseFlatIformation =
                        !showEditingCompleteCustomerHouseFlatIformation;

                        addressController.text = currentUserForInline.address;
                        houseFlatNumberController.text = currentUserForInline.flatOrHouseNumber;

//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                  // THIS CONTAINER ABOVE IS ABOUT HOUSE OR FLAT NUMBER INFORMATION ENDS HERE.
                  // THIS CONTAINER BELOW IS ABOUT PHONE NUMBER INFORMATION BEGINS HERE.
                  RaisedButton(
                    color:Colors.redAccent,
                    highlightColor: Colors.lightGreenAccent,
//                        highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    splashColor: Color(0xffB47C00),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.phoneNumber != ''?
                    Container(
                      color:Colors.lightGreenAccent,
                      width:displayWidth(context) /3,

                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Icon(Icons.phone,
                              size: 32.0,
                              color: Colors.black)
                          ,


                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  '${currentUserForInline.phoneNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),




                          //ZZZZ


                        ],
                      ),):  Container(
                      width:displayWidth(context) /3,
//                              width:displayWidth(context) /5.5
//                       width:displayWidth(context) /5.9,
                    )
                    ,
                    onPressed: ()=>{
                      setState(() {

                        showEditingCompleteCustomerPhoneIformation =
                        !showEditingCompleteCustomerPhoneIformation;


                        phoneNumberController.text = currentUserForInline.phoneNumber;



//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),
                  RaisedButton(
                    color:Colors.redAccent,
                    highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    splashColor: Color(0xffB47C00),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.etaTimeInMinutes != -1?
                    Container(
                      color:Colors.red,
//                       width:displayWidth(context) /10,
                      width:displayWidth(context) /4,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.watch,
                              size: 32.0,
                              color: Colors.black
                          ),



                          // : Container for 2nd argument of ternary condition ends here.


                          Container(
                            padding: EdgeInsets
                                .fromLTRB(
                                5, 0, 5, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                '${currentUserForInline.etaTimeInMinutes}',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),




                          //ZZZZ


                        ],
                      ),
                    ):  Container(
                      width:displayWidth(context) /4,
//                       width:displayWidth(context) /10,
                    )

                    // THIS CONTAINER ABOVE IS ABOUT ETA INFORMATION ENDS HERE.
                    ,
                    onPressed: ()=>{
                      setState(() {

                        showEditingCompleteCustomerReachoutIformation =
                        !showEditingCompleteCustomerReachoutIformation;


                        etaController.text = currentUserForInline.etaTimeInMinutes.toString();


//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                  /*
                   Container(
                     height: 50,
                     color: Colors.amber[500],
                     child: const Center(child: Text('Entry B')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   */
                ],
              ),

            )


          ]
      ),
    );
//          }
//        }
//    );
  }


// YYYY

  Widget unobscureInputandRestforDinningRoom (Order unObsecuredInputandPayment){


    CustomerInformation currentUser = unObsecuredInputandPayment.ordersCustomer;
    // means
    // 1. Row Holding user's information.
    // 2. means holding the inputFields for User Input.
    // 3. If all 4 inputs are there show user the payment
    return Container(

      height: displayHeight(context)/2.3,
//        height: displayHeight(context)/2.5,
      width: displayWidth(context) / 1.1,
//        height: displayHeight(context) / 2,
      color: Colors.tealAccent,

      child: Column(
        children: <Widget>[


          // 1ST CONTAINER OF INPUTS BEGINS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher


          // COMMENTING THIS FOR TAKE AWAY, WE DON'T NEED ANIMATION HERE.
          /*
          Container(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
              child: (showUserInputOptionsLikeFirstTime == false)?
//      unobscureInputandRest(unObsecuredInputandPayment)

              animatedShowUserAddressDetailsInLineTakeAway(currentUser)


                  :

                  */
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
                              'possible dinning time ',
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
                          painter: LongPainterForChooseOrderTypeAdress(
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
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


          // ),
          // ),

          // 1ST CONTAINER OF INPUTS ENDS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher



          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.
          // BEGINS HERE.

          Container(
//            color:Colors.white38,
            color:Colors.amber,
//            height: displayWidth(context)/2.6,
            height: displayWidth(context)/2.1,
            child: Stack(
              children: <Widget>[
                Positioned(
//                  left:0,
                  // top:20,//displayHeight(context)/10,
                  // initial Case.
//            getNumberOfInputsFilledUp
//            getNumberOfInputsFilledUpDinningRoom

                  bottom:
                  getNumberOfInputsFilledUpDinningRoom (
                      unObsecuredInputandPayment.ordersCustomer) >0
                      ?  22:-10,
                  /*
                  0:
                  getNumberOfInputsFilledUp (
                      unObsecuredInputandPayment.ordersCustomer) <= 2?

                  0:
                  getNumberOfInputsFilledUp (
                      unObsecuredInputandPayment.ordersCustomer) == 3?
                  */

                  // from top to top distance offset related to Starting (top ) of
                  // orance Container.
//                  right:0,
//                  bottom:0,
                  child:
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
                    // zeroORMoreInputsEmpty
                    // zeroORMoreInputsEmptyTakeAway
                    // zeroORMoreInputsEmptyDinningRoom
                    child:
                    zeroORMoreInputsEmptyDinningRoom
                      (unObsecuredInputandPayment.ordersCustomer) == true ?

                    // animatedObscuredPaymentSelectContainerTakeAway
                    // animatedUnObscuredPaymentTypeUnSelectedContainerTakeAway
                    // animatedUnObscuredPaymentUnSelectContainer
                    // animatedObscuredPaymentSelectContainerTakeAway and Dinning Room
                    animatedObscuredPaymentSelectContainerTakeAway
                      (unObsecuredInputandPayment):
                    animatedUnObscuredPaymentTypeUnSelectedContainerTakeAway
                      (unObsecuredInputandPayment),


                  ),
                  // ),

                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  top:
                  0,
//                  displayHeight(context)/4,
//                  getNumberOfInputsFilledUp (
//                      unObsecuredInputandPayment.ordersCustomer) ==4?


//                  displayWidth(context)/2.6 - displayWidth(context)/2,

                  // bottom 0 means full of green Container content shown.

                  child:
                  Container(
//                        alignment:Alignment.topCenter,0


                    // QQQ RoDo height
//                      height: displayWidth(context)/2.6,
                      child: Container(
//                            height: displayWidth(context)/2.6,
//                            height: displayHeight(context) / 3.7,
                        padding: EdgeInsets.fromLTRB(
                            (displayWidth(context)/1.1)/4,
                            15,
                            (displayWidth(context)/1.1)/4,
                            0

//                          horizontal: (displayWidth(context)/1.1)/4,
                        ),
                        color: Colors.green,
                        child: Center(
//                    color:Colors.white.withOpacity(0.9),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[


                                // CUSTOMER LOCATION ADDRESS CONTAINER BEGINS HERE.
//                            showEditingCompleteCustomerAddressInformation
//                            showEditingCompleteCustomerHouseFlatIformation
//                            showEditingCompleteCustomerPhoneIformation
//                            showEditingCompleteCustomerReachoutIformation
//                                showEditingCompleteCustomerAddressInformation BEGINS HERE.
                                /*
                                Container(
                                  child: showEditingCompleteCustomerAddressInformation?
                                  Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
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

                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),


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
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                      currentUser
//                                        labelText: 'Search about meal.'
                                            ),


                                            onChanged: (text) {
                                              //RRRR

                                              print('at address of unobsecured (deliver loc)');

                                              final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//
                                              shoppingCartBloc.setAddressForOrder(text);
                                              if((text.trim().length) >0){
                                                print('at (text.trim().length) >0)');
                                                setState(() =>

                                                {
//                                          showEditingCompleteCustomerAddressInformation = true ,
                                                  showFullOrderType = false,

                                                });
                                              }
                                              else {
                                                setState(() =>

                                                {
                                                  showFullOrderType = false,

//                                                showCustomerInformationHeader = true,

                                                });
                                              }



                                              /*
                                                        setState(() =>
                                                        {
                                                          showFullOrderType = false,
//                                                showCustomerInformationHeader = true,
                                                        }

                                                        );
                                                        */
                                            },

                                            onTap: () {

                                              setState(() =>
                                              {
                                                showFullOrderType = false,

                                              });

                                            },




                                            /*
                                                      onTap: () {

                                                        print('on tap of line # 1607');

                                                        if((currentUser.phoneNumber.trim().length) >0 ||
                                                            (currentUser.flatOrHouseNumber.trim().length) >0 ||
                                                            (currentUser.etaTimeInMinutes != null)  )
                                                        {
                                                          showEditingCompleteCustomerAddressInformation = true;
                                                        } else {
                                                          setState(() =>
                                                          {
                                                            showFullOrderType = false,
//                                        showCustomerInformationHeader = true,
                                                          });
                                                        }
                                                      },
                                                      */
//                                              setState(() =>
//                                              {
//                                                showFullOrderType = false,
////                                                showCustomerInformationHeader = true,
//                                              }

                                            //);
//                                            },
//                                          },


                                            onEditingComplete: () {
                                              print('at editing complete of address ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerAddressInformation =
                                                true
//                                          showInputtedCustomerIformation= true,
                                              }
                                              );
                                            },
                                            /*


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
                                ),

                                */



                                // CUSTOMER LOACATION ADDRESS CONTAINER ENDS HERE.

                                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER BEGINS HERE.

                                //
//                                showEditingCompleteCustomerHouseFlatIformation BEGINS HERE


                                /*
                                Container(

                                  child: showEditingCompleteCustomerHouseFlatIformation?Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
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
                                            controller: houseFlatNumberController,


                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter House/Flat address/number',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                        labelText: 'Search about meal.'
                                            ),

                                            onChanged: (text) {
                                              final shoppingCartBloc = BlocProvider.of<
                                                  ShoppingCartBloc>(context);
//
                                              shoppingCartBloc
                                                  .setHouseorFlatNumberForOrder(text);

                                              setState(() => showFullOrderType = false);
                                              // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                            },
                                            onTap: () {

                                              setState(() =>
                                              {
                                                showFullOrderType = false,

                                              });

                                            },


                                            /*
                                                      onTap: () {


                                                        if ((currentUser.address
                                                            .trim()
                                                            .length) > 0 ||
                                                            (currentUser.flatOrHouseNumber
                                                                .trim()
                                                                .length) > 0 ||
                                                            (currentUser.etaTimeInMinutes !=-1
                                                                )) {
                                                          showEditingCompleteCustomerHouseFlatIformation =
                                                          true;
                                                        } else {
                                                          setState(() =>
                                                          showFullOrderType = false);
                                                        }
                                                      },

                                                      */


                                            onEditingComplete: () {

                                              print('at editing complete of House or Flat Iformation ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerHouseFlatIformation =
                                                true
//                                          showInputtedCustomerIformation= true,
                                              }
                                              );
                                            },
                                            /*



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
                                ),

                                */


                                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER ENDS HERE.

                                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER BEGINS HERE.

                                //  showEditingCompleteCustomerPhoneIformation BEGINS HERE.


                                /*
                                Container(

                                  child: showEditingCompleteCustomerPhoneIformation? Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
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
                                            controller: phoneNumberController,


                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),

                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter phone / telephone number',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

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
                                              // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                            },

                                            /*
                                                      onTap: () {
                                                        if ((currentUser.address
                                                            .trim()
                                                            .length) > 0 ||
                                                            (currentUser.flatOrHouseNumber
                                                                .trim()
                                                                .length) > 0 ||
                                                            (currentUser.etaTimeInMinutes !=-1
                                                                )) {
                                                          showEditingCompleteCustomerHouseFlatIformation =
                                                          true;
                                                        } else {
                                                          setState(() =>
                                                          showFullOrderType = false);
                                                        }
                                                      },
                                                      */

                                            onTap: () {

                                              setState(() =>
                                              {
                                                showFullOrderType = false,

                                              });

                                            },
                                            onEditingComplete: () {
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');

                                              print('at editing complete of Customer Phone Iformation ');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerPhoneIformation =
                                                true
//                                          showInputtedCustomerIformation= true,

                                              }

                                              );
                                            },

/*
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
                                ),

                                */


                                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER ENDS HERE.

                                // CUSTOMER LOCATION REACH OUT TIME CONTAINER BEGINS HERE.

//                                showEditingCompleteCustomerReachoutIformation BEGINS HERE.
                                Container(

                                  child: showEditingCompleteCustomerReachoutIformation ? Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
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

                                            controller:  etaController,



                                            keyboardType: TextInputType.number,
                                            textInputAction: TextInputAction.done,
//
                                            onSubmitted: (_) => FocusScope.of(context).unfocus(),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter when you want your ordered foods',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

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
                                              setState(() {
                                                showFullOrderType = false;

                                                // showFullOrderType
                                                /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                showCustomerInformationHeader = true;
                                                showUserInputOptionsLikeFirstTime =false;
                                                showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                              }


                                              );
                                            },


                                            onTap: () {
                                              if ((currentUser.address
                                                  .trim()
                                                  .length) > 0 ||
                                                  (currentUser.flatOrHouseNumber
                                                      .trim()
                                                      .length) > 0 ||
                                                  (currentUser.phoneNumber.trim()
                                                      .length) > 0 ) {
                                                showEditingCompleteCustomerHouseFlatIformation =
                                                true;
                                              } else {
                                                setState(() {
                                                  showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader = true;
                                                  showUserInputOptionsLikeFirstTime = false;
                                                  showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                                }

                                                );
                                              }
                                            },



//                                            onTap: () {
//                                              setState(() => showFullOrderType = false);
//                                            },
                                            onEditingComplete: () {

                                              print('at editing complete of Customer\'s address ETA Time:');
//                                              setState(() =>
//                                              {
//                                                showEditingCompleteCustomerReachoutIformation =
//                                                true
//                                              }
//                                              );

                                            },


/*

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



                                      ],
                                    ),
                                  ),
                                ),

                                // showEditingCompleteCustomerReachoutIformation ENDS HERE.
                                // CUSTOMER LOCATION REACH OUT TIME CONTAINER ENDS HERE.


                              ],
                            )
                        ),
                      )

                  ),

                )
              ],
            ),
          ),

          // ENDS HERE.
          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.


//            OOOO




          //VVVVVV

          // PAYMENT RELATED CONTAINER INVOKED FROM HERE:

//                        Flexible(
//                          child:

          // 3.


          // 3. ends here.
        ],

        //showInputtedCustomerIformation
      ),
    );
// GGG),

  }

  Widget unobscureInputandRestforTakeAway (Order unObsecuredInputandPayment){


    CustomerInformation currentUser = unObsecuredInputandPayment.ordersCustomer;
    // means
    // 1. Row Holding user's information.
    // 2. means holding the inputFields for User Input.
    // 3. If all 4 inputs are there show user the payment
    return Container(

      height: displayHeight(context)/2.3,
//        height: displayHeight(context)/2.5,
      width: displayWidth(context) / 1.1,
//        height: displayHeight(context) / 2,
      color: Colors.tealAccent,

      child: Column(
        children: <Widget>[


          // 1ST CONTAINER OF INPUTS BEGINS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher


        // COMMENTING THIS FOR TAKE AWAY, WE DON'T NEED ANIMATION HERE.
      /*
          Container(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
              child: (showUserInputOptionsLikeFirstTime == false)?
//      unobscureInputandRest(unObsecuredInputandPayment)

              animatedShowUserAddressDetailsInLineTakeAway(currentUser)


                  :

                  */
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
                                  'when you want to receive your Order',
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
                              painter: LongPainterForChooseOrderTypeAdress(
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
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


            // ),
          // ),

          // 1ST CONTAINER OF INPUTS ENDS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher



          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.
          // BEGINS HERE.

          Container(
//            color:Colors.white38,
            color:Colors.amber,
//            height: displayWidth(context)/2.6,
            height: displayWidth(context)/2.1,
            child: Stack(
              children: <Widget>[
                Positioned(
//                  left:0,
                  // top:20,//displayHeight(context)/10,
                  // initial Case.
//            getNumberOfInputsFilledUp
                  bottom:
                  getNumberOfInputsFilledUpTakeAway (
                      unObsecuredInputandPayment.ordersCustomer) >0
                      ?  22:-10,
                  /*
                  0:
                  getNumberOfInputsFilledUp (
                      unObsecuredInputandPayment.ordersCustomer) <= 2?

                  0:
                  getNumberOfInputsFilledUp (
                      unObsecuredInputandPayment.ordersCustomer) == 3?
                  */

                  // from top to top distance offset related to Starting (top ) of
                  // orance Container.
//                  right:0,
//                  bottom:0,
                  child:
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
                    // zeroORMoreInputsEmpty
                    // zeroORMoreInputsEmptyTakeAway
                    child:
                    zeroORMoreInputsEmptyTakeAway
                      (unObsecuredInputandPayment.ordersCustomer) == true ?

                    // animatedObscuredPaymentSelectContainerTakeAway
                    // animatedUnObscuredPaymentTypeUnSelectedContainerTakeAway
                    // animatedUnObscuredPaymentUnSelectContainer
                    animatedObscuredPaymentSelectContainerTakeAway
                      (unObsecuredInputandPayment):
                    animatedUnObscuredPaymentTypeUnSelectedContainerTakeAway
                      (unObsecuredInputandPayment),


                  ),
                  // ),

                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  top:
                  0,
//                  displayHeight(context)/4,
//                  getNumberOfInputsFilledUp (
//                      unObsecuredInputandPayment.ordersCustomer) ==4?


//                  displayWidth(context)/2.6 - displayWidth(context)/2,

                  // bottom 0 means full of green Container content shown.

                  child:
                  Container(
//                        alignment:Alignment.topCenter,0


                    // QQQ RoDo height
//                      height: displayWidth(context)/2.6,
                      child: Container(
//                            height: displayWidth(context)/2.6,
//                            height: displayHeight(context) / 3.7,
                        padding: EdgeInsets.fromLTRB(
                            (displayWidth(context)/1.1)/4,
                            15,
                            (displayWidth(context)/1.1)/4,
                            0

//                          horizontal: (displayWidth(context)/1.1)/4,
                        ),
                        color: Colors.green,
                        child: Center(
//                    color:Colors.white.withOpacity(0.9),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[


                                // CUSTOMER LOCATION ADDRESS CONTAINER BEGINS HERE.
//                            showEditingCompleteCustomerAddressInformation
//                            showEditingCompleteCustomerHouseFlatIformation
//                            showEditingCompleteCustomerPhoneIformation
//                            showEditingCompleteCustomerReachoutIformation
//                                showEditingCompleteCustomerAddressInformation BEGINS HERE.
                                /*
                                Container(
                                  child: showEditingCompleteCustomerAddressInformation?
                                  Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
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

                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),


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
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                      currentUser
//                                        labelText: 'Search about meal.'
                                            ),


                                            onChanged: (text) {
                                              //RRRR

                                              print('at address of unobsecured (deliver loc)');

                                              final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//
                                              shoppingCartBloc.setAddressForOrder(text);
                                              if((text.trim().length) >0){
                                                print('at (text.trim().length) >0)');
                                                setState(() =>

                                                {
//                                          showEditingCompleteCustomerAddressInformation = true ,
                                                  showFullOrderType = false,

                                                });
                                              }
                                              else {
                                                setState(() =>

                                                {
                                                  showFullOrderType = false,

//                                                showCustomerInformationHeader = true,

                                                });
                                              }



                                              /*
                                                        setState(() =>
                                                        {
                                                          showFullOrderType = false,
//                                                showCustomerInformationHeader = true,
                                                        }

                                                        );
                                                        */
                                            },

                                            onTap: () {

                                              setState(() =>
                                              {
                                                showFullOrderType = false,

                                              });

                                            },




                                            /*
                                                      onTap: () {

                                                        print('on tap of line # 1607');

                                                        if((currentUser.phoneNumber.trim().length) >0 ||
                                                            (currentUser.flatOrHouseNumber.trim().length) >0 ||
                                                            (currentUser.etaTimeInMinutes != null)  )
                                                        {
                                                          showEditingCompleteCustomerAddressInformation = true;
                                                        } else {
                                                          setState(() =>
                                                          {
                                                            showFullOrderType = false,
//                                        showCustomerInformationHeader = true,
                                                          });
                                                        }
                                                      },
                                                      */
//                                              setState(() =>
//                                              {
//                                                showFullOrderType = false,
////                                                showCustomerInformationHeader = true,
//                                              }

                                            //);
//                                            },
//                                          },


                                            onEditingComplete: () {
                                              print('at editing complete of address ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerAddressInformation =
                                                true
//                                          showInputtedCustomerIformation= true,
                                              }
                                              );
                                            },
                                            /*


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
                                ),

                                */



                                // CUSTOMER LOACATION ADDRESS CONTAINER ENDS HERE.

                                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER BEGINS HERE.

                                //
//                                showEditingCompleteCustomerHouseFlatIformation BEGINS HERE


                                /*
                                Container(

                                  child: showEditingCompleteCustomerHouseFlatIformation?Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
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
                                            controller: houseFlatNumberController,


                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter House/Flat address/number',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                        labelText: 'Search about meal.'
                                            ),

                                            onChanged: (text) {
                                              final shoppingCartBloc = BlocProvider.of<
                                                  ShoppingCartBloc>(context);
//
                                              shoppingCartBloc
                                                  .setHouseorFlatNumberForOrder(text);

                                              setState(() => showFullOrderType = false);
                                              // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                            },
                                            onTap: () {

                                              setState(() =>
                                              {
                                                showFullOrderType = false,

                                              });

                                            },


                                            /*
                                                      onTap: () {


                                                        if ((currentUser.address
                                                            .trim()
                                                            .length) > 0 ||
                                                            (currentUser.flatOrHouseNumber
                                                                .trim()
                                                                .length) > 0 ||
                                                            (currentUser.etaTimeInMinutes !=-1
                                                                )) {
                                                          showEditingCompleteCustomerHouseFlatIformation =
                                                          true;
                                                        } else {
                                                          setState(() =>
                                                          showFullOrderType = false);
                                                        }
                                                      },

                                                      */


                                            onEditingComplete: () {

                                              print('at editing complete of House or Flat Iformation ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerHouseFlatIformation =
                                                true
//                                          showInputtedCustomerIformation= true,
                                              }
                                              );
                                            },
                                            /*



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
                                ),

                                */


                                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER ENDS HERE.

                                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER BEGINS HERE.

                                //  showEditingCompleteCustomerPhoneIformation BEGINS HERE.


                                /*
                                Container(

                                  child: showEditingCompleteCustomerPhoneIformation? Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
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
                                            controller: phoneNumberController,


                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),

                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter phone / telephone number',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

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
                                              // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                            },

                                            /*
                                                      onTap: () {
                                                        if ((currentUser.address
                                                            .trim()
                                                            .length) > 0 ||
                                                            (currentUser.flatOrHouseNumber
                                                                .trim()
                                                                .length) > 0 ||
                                                            (currentUser.etaTimeInMinutes !=-1
                                                                )) {
                                                          showEditingCompleteCustomerHouseFlatIformation =
                                                          true;
                                                        } else {
                                                          setState(() =>
                                                          showFullOrderType = false);
                                                        }
                                                      },
                                                      */

                                            onTap: () {

                                              setState(() =>
                                              {
                                                showFullOrderType = false,

                                              });

                                            },
                                            onEditingComplete: () {
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');

                                              print('at editing complete of Customer Phone Iformation ');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerPhoneIformation =
                                                true
//                                          showInputtedCustomerIformation= true,

                                              }

                                              );
                                            },

/*
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
                                ),

                                */


                                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER ENDS HERE.

                                // CUSTOMER LOCATION REACH OUT TIME CONTAINER BEGINS HERE.

//                                showEditingCompleteCustomerReachoutIformation BEGINS HERE.
                                Container(

                                  child: showEditingCompleteCustomerReachoutIformation ? Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
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

                                            controller:  etaController,



                                            keyboardType: TextInputType.number,
                                            textInputAction: TextInputAction.done,
//
                                            onSubmitted: (_) => FocusScope.of(context).unfocus(),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter when you want your ordered foods',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

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
                                              setState(() {
                                                showFullOrderType = false;

                                                // showFullOrderType
                                                /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                showCustomerInformationHeader = true;
                                                showUserInputOptionsLikeFirstTime =false;
                                                showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                              }


                                              );
                                            },


                                            onTap: () {
                                              if ((currentUser.address
                                                  .trim()
                                                  .length) > 0 ||
                                                  (currentUser.flatOrHouseNumber
                                                      .trim()
                                                      .length) > 0 ||
                                                  (currentUser.phoneNumber.trim()
                                                      .length) > 0 ) {
                                                showEditingCompleteCustomerHouseFlatIformation =
                                                true;
                                              } else {
                                                setState(() {
                                                  showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader = true;
                                                  showUserInputOptionsLikeFirstTime = false;
                                                  showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                                }

                                                );
                                              }
                                            },



//                                            onTap: () {
//                                              setState(() => showFullOrderType = false);
//                                            },
                                            onEditingComplete: () {

                                              print('at editing complete of Customer\'s address ETA Time:');
//                                              setState(() =>
//                                              {
//                                                showEditingCompleteCustomerReachoutIformation =
//                                                true
//                                              }
//                                              );

                                            },


/*

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



                                      ],
                                    ),
                                  ),
                                ),

                                // showEditingCompleteCustomerReachoutIformation ENDS HERE.
                                // CUSTOMER LOCATION REACH OUT TIME CONTAINER ENDS HERE.


                              ],
                            )
                        ),
                      )

                  ),

                )
              ],
            ),
          ),

          // ENDS HERE.
          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.


//            OOOO




          //VVVVVV

          // PAYMENT RELATED CONTAINER INVOKED FROM HERE:

//                        Flexible(
//                          child:

          // 3.


          // 3. ends here.
        ],

        //showInputtedCustomerIformation
      ),
    );
// GGG),

  }

  Widget unobscureInputandRest(Order unObsecuredInputandPayment){


    CustomerInformation currentUser = unObsecuredInputandPayment.ordersCustomer;
    // means
    // 1. Row Holding user's information.
    // 2. means holding the inputFields for User Input.
    // 3. If all 4 inputs are there show user the payment
    return Container(

      height: displayHeight(context)/2.3,
//        height: displayHeight(context)/2.5,
      width: displayWidth(context) / 1.1,
//        height: displayHeight(context) / 2,
      color: Colors.tealAccent,

      child: Column(
        children: <Widget>[


          // 1ST CONTAINER OF INPUTS BEGINS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher
          Container(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
              child: (showUserInputOptionsLikeFirstTime == false)?
//      unobscureInputandRest(unObsecuredInputandPayment)

              animatedShowUserAddressDetailsInLine(currentUser)


                  :Container(
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
                                  'Enter user address',
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
                              painter: LongPainterForChooseOrderTypeAdress(
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
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


            ),
          ),

          // 1ST CONTAINER OF INPUTS ENDS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher



          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.
          // BEGINS HERE.

          Container(
//            color:Colors.white38,
            color:Colors.black87,
//            height: displayWidth(context)/2.6,
            height: displayWidth(context)/2.1,
            child: Stack(
              children: <Widget>[
                Positioned(
//                  left:0,
                  // top:20,//displayHeight(context)/10,
                  // initial Case.
                  bottom: getNumberOfInputsFilledUp (
                      unObsecuredInputandPayment.ordersCustomer) <= 1?
                  0:
                  getNumberOfInputsFilledUp (
                      unObsecuredInputandPayment.ordersCustomer) <= 2?
                  0:
                  getNumberOfInputsFilledUp (
                      unObsecuredInputandPayment.ordersCustomer) == 3?

                  -90:-10,
                  // from top to top distance offset related to Starting (top ) of
                  // orance Container.
//                  right:0,
//                  bottom:0,
                  child:
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
                    child:
                    zeroORMoreInputsEmpty
                      (unObsecuredInputandPayment.ordersCustomer) == true ?

                    animatedObscuredPaymentSelectContainer
                      (unObsecuredInputandPayment):
                    animatedUnObscuredPaymentUnSelectContainer
                      (unObsecuredInputandPayment),


                  ),
                  // ),

                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  top:
                  0,
//                  displayHeight(context)/4,
//                  getNumberOfInputsFilledUp (
//                      unObsecuredInputandPayment.ordersCustomer) ==4?


//                  displayWidth(context)/2.6 - displayWidth(context)/2,

                  // bottom 0 means full of green Container content shown.

                  child:
                  Container(
//                        alignment:Alignment.topCenter,0


                    // QQQ RoDo height
//                      height: displayWidth(context)/2.6,
                      child: Container(
//                            height: displayWidth(context)/2.6,
//                            height: displayHeight(context) / 3.7,
                        padding: EdgeInsets.fromLTRB(
                            (displayWidth(context)/1.1)/4,
                            15,
                            (displayWidth(context)/1.1)/4,
                            0

//                          horizontal: (displayWidth(context)/1.1)/4,
                        ),
                        color: Colors.green,
                        child: Center(
//                    color:Colors.white.withOpacity(0.9),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[


                                // CUSTOMER LOCATION ADDRESS CONTAINER BEGINS HERE.
//                            showEditingCompleteCustomerAddressInformation
//                            showEditingCompleteCustomerHouseFlatIformation
//                            showEditingCompleteCustomerPhoneIformation
//                            showEditingCompleteCustomerReachoutIformation
//                                showEditingCompleteCustomerAddressInformation BEGINS HERE.
                                Container(
                                  child: showEditingCompleteCustomerAddressInformation?
                                  Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
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

                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),


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
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                      currentUser
//                                        labelText: 'Search about meal.'
                                            ),


                                            onChanged: (text) {
                                              //RRRR

                                              print('at address of unobsecured (deliver loc)');

                                              final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//
                                              shoppingCartBloc.setAddressForOrder(text);
                                              if((text.trim().length) >0){
                                                print('at (text.trim().length) >0)');
                                                setState(()

                                                {
//                                          showEditingCompleteCustomerAddressInformation = true ,
                                                showFullOrderType = false;
//                                                showFullOrderType = false;
                                                // showFullOrderType
                                                /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader = true;
                                                  showUserInputOptionsLikeFirstTime = false;
                                                  showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.

                                                });
                                              }
                                              else {
                                                setState(()

                                                {
                                                  showFullOrderType = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader = true;
                                                  showUserInputOptionsLikeFirstTime = false;
                                                  showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.

//                                                showCustomerInformationHeader = true,

                                                });
                                              }



                                              /*
                                                        setState(() =>
                                                        {
                                                          showFullOrderType = false,
//                                                showCustomerInformationHeader = true,
                                                        }

                                                        );
                                                        */
                                            },

                                            onTap: () {

                                              setState(()
                                              {
                                                showFullOrderType = false;
                                                // showFullOrderType = false;
                                                // showFullOrderType
                                                /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                showCustomerInformationHeader = true;
                                                showUserInputOptionsLikeFirstTime = false;
                                                showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.

                                              });

                                            },




                                            /*
                                                      onTap: () {

                                                        print('on tap of line # 1607');

                                                        if((currentUser.phoneNumber.trim().length) >0 ||
                                                            (currentUser.flatOrHouseNumber.trim().length) >0 ||
                                                            (currentUser.etaTimeInMinutes != null)  )
                                                        {
                                                          showEditingCompleteCustomerAddressInformation = true;
                                                        } else {
                                                          setState(() =>
                                                          {
                                                            showFullOrderType = false,
//                                        showCustomerInformationHeader = true,
                                                          });
                                                        }
                                                      },
                                                      */
//                                              setState(() =>
//                                              {
//                                                showFullOrderType = false,
////                                                showCustomerInformationHeader = true,
//                                              }

                                            //);
//                                            },
//                                          },


                                            onEditingComplete: () {
                                              print('at editing complete of address ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerAddressInformation =
                                                true
//                                          showInputtedCustomerIformation= true,
                                              }
                                              );
                                            },
                                            /*


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
                                ),



                                // CUSTOMER LOACATION ADDRESS CONTAINER ENDS HERE.

                                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER BEGINS HERE.

                                //
//                                showEditingCompleteCustomerHouseFlatIformation BEGINS HERE

                                Container(

                                  child: showEditingCompleteCustomerHouseFlatIformation?Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
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
                                            controller: houseFlatNumberController,


                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter House/Flat address/number',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                        labelText: 'Search about meal.'
                                            ),

                                            onChanged: (text) {
                                              final shoppingCartBloc = BlocProvider.of<
                                                  ShoppingCartBloc>(context);
//
                                              shoppingCartBloc
                                                  .setHouseorFlatNumberForOrder(text);

                                              setState((){
                                                showFullOrderType = false;
                                                // showFullOrderType = false;
                                                // showFullOrderType
                                                /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
                                                showCustomerInformationHeader = true;
                                                showUserInputOptionsLikeFirstTime = false;
                                                showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                              }
                                              );
                                              // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                            },
                                            onTap: () {

                                              setState(()
                                              {
                                                showFullOrderType = false;
                                                // showFullOrderType = false;
                                                // showFullOrderType
                                                /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
                                                showCustomerInformationHeader = true;
                                                showUserInputOptionsLikeFirstTime = false;
                                                showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.

                                              });

                                            },


                                            /*
                                                      onTap: () {


                                                        if ((currentUser.address
                                                            .trim()
                                                            .length) > 0 ||
                                                            (currentUser.flatOrHouseNumber
                                                                .trim()
                                                                .length) > 0 ||
                                                            (currentUser.etaTimeInMinutes !=-1
                                                                )) {
                                                          showEditingCompleteCustomerHouseFlatIformation =
                                                          true;
                                                        } else {
                                                          setState(() =>
                                                          showFullOrderType = false);
                                                        }
                                                      },

                                                      */


                                            onEditingComplete: () {

                                              print('at editing complete of House or Flat Iformation ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerHouseFlatIformation =
                                                true
//                                          showInputtedCustomerIformation= true,
                                              }
                                              );
                                            },
                                            /*



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
                                ),


                                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER ENDS HERE.

                                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER BEGINS HERE.

                                //  showEditingCompleteCustomerPhoneIformation BEGINS HERE.

                                Container(

                                  child: showEditingCompleteCustomerPhoneIformation? Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
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
                                            controller: phoneNumberController,


                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),

                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter phone / telephone number',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

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

                                              setState((){
                                                showFullOrderType
                                                = false;
                                                // showFullOrderType = false;
                                                // showFullOrderType
                                                /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                showCustomerInformationHeader = true;
                                                showUserInputOptionsLikeFirstTime = false;
                                                showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                              }
                                              );
                                              // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                            },

                                            /*
                                                      onTap: () {
                                                        if ((currentUser.address
                                                            .trim()
                                                            .length) > 0 ||
                                                            (currentUser.flatOrHouseNumber
                                                                .trim()
                                                                .length) > 0 ||
                                                            (currentUser.etaTimeInMinutes !=-1
                                                                )) {
                                                          showEditingCompleteCustomerHouseFlatIformation =
                                                          true;
                                                        } else {
                                                          setState(() =>
                                                          showFullOrderType = false);
                                                        }
                                                      },
                                                      */

                                            onTap: () {

                                              setState(()
                                              {
                                                showFullOrderType
                                                = false;
                                                // showFullOrderType = false;
                                                // showFullOrderType
                                                /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                showCustomerInformationHeader = true;
                                                showUserInputOptionsLikeFirstTime = false;
                                                showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
//                                                showFullOrderType = false,

                                              });

                                            },
                                            onEditingComplete: () {
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');

                                              print('at editing complete of Customer Phone Iformation ');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerPhoneIformation =
                                                true
//                                          showInputtedCustomerIformation= true,

                                              }

                                              );
                                            },

/*
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
                                ),


                                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER ENDS HERE.

                                // CUSTOMER LOCATION REACH OUT TIME CONTAINER BEGINS HERE.

//                                showEditingCompleteCustomerReachoutIformation BEGINS HERE.
                                Container(

                                  child: showEditingCompleteCustomerReachoutIformation ? Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
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

                                            controller:  etaController,



                                            keyboardType: TextInputType.number,
                                            textInputAction: TextInputAction.done,
//
                                            onSubmitted: (_) => FocusScope.of(context).unfocus(),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter reach out time',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

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
                                              setState(() {
                                                // showFullOrderType = false;
                                                showFullOrderType
                                                = false;
                                                // showFullOrderType = false;
                                                // showFullOrderType
                                                /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                showCustomerInformationHeader = true;
                                                showUserInputOptionsLikeFirstTime = false;
                                                showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                              }

                                              );
                                            },


                                            onTap: () {
                                              if ((currentUser.address
                                                  .trim()
                                                  .length) > 0 ||
                                                  (currentUser.flatOrHouseNumber
                                                      .trim()
                                                      .length) > 0 ||
                                                  (currentUser.phoneNumber.trim()
                                                      .length) > 0 ) {
                                                showEditingCompleteCustomerHouseFlatIformation =
                                                true;
                                              } else {
                                                setState((){

                                                  // showFullOrderType = false;
                                                  showFullOrderType
                                                  = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader = true;
                                                  showUserInputOptionsLikeFirstTime = false;
                                                  showFullPaymentType  = true; // default.// NOTHING TO DO WITH INPUT FIELDS.;
                                                }
//                                                }
//                                                showFullOrderType = false


                                                );
                                              }
                                            },



//                                            onTap: () {
//                                              setState(() => showFullOrderType = false);
//                                            },
                                            onEditingComplete: () {

                                              print('at editing complete of Customer\'s address ETA Time:');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerReachoutIformation =
                                                true
                                              }
                                              );

                                            },


/*

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



                                      ],
                                    ),
                                  ),
                                ),

                                // showEditingCompleteCustomerReachoutIformation ENDS HERE.
                                // CUSTOMER LOCATION REACH OUT TIME CONTAINER ENDS HERE.




                              ],
                            )
                        ),
                      )

                  ),

                )
              ],
            ),
          ),

          // ENDS HERE.
          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.


//            OOOO




          //VVVVVV

          // PAYMENT RELATED CONTAINER INVOKED FROM HERE:

//                        Flexible(
//                          child:

          // 3.


          // 3. ends here.
        ],

        //showInputtedCustomerIformation
      ),
    );
// GGG),

  }


  Widget _buildShoppingCartInputFieldsUNObscuredDinningRoom(Order unObsecuredInputandPayment){
    CustomerInformation x = unObsecuredInputandPayment.ordersCustomer;
    //if(getOneOrdercustomerInfoFieldsNotEmpty(x)!=0){

    CustomerInformation currentUser =  x;

    print('currentUser.address: ${currentUser.address}');
    print('currentUser.flatOrHouseNumber: ${currentUser.flatOrHouseNumber}');
    print('currentUser.phoneNumber: ${currentUser.phoneNumber}');
    print('currentUser.etaTimeInMinutes: ${currentUser.etaTimeInMinutes}');

//    animatedObscuredTextInputContainer
//    if((showEditingCompleteCustomerAddressInformation == true)||
//        (showEditingCompleteCustomerHouseFlatIformation == true)||
//        (showEditingCompleteCustomerPhoneIformation == true)||
//        (showEditingCompleteCustomerReachoutIformation == true)){

//    return unobscureInputandRestforTakeAway(unObsecuredInputandPayment);
    return unobscureInputandRestforDinningRoom(unObsecuredInputandPayment);


    /*
      return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
      child: (showFullOrderType == false)?
      unobscureInputandRest(unObsecuredInputandPayment)

          :unobsuredEsleFirstTime(unObsecuredInputandPayment),
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


    );
     */


  }
  Widget _buildShoppingCartInputFieldsUNObscuredTakeAway(Order unObsecuredInputandPayment){
    CustomerInformation x = unObsecuredInputandPayment.ordersCustomer;
    //if(getOneOrdercustomerInfoFieldsNotEmpty(x)!=0){

    CustomerInformation currentUser =  x;

    print('currentUser.address: ${currentUser.address}');
    print('currentUser.flatOrHouseNumber: ${currentUser.flatOrHouseNumber}');
    print('currentUser.phoneNumber: ${currentUser.phoneNumber}');
    print('currentUser.etaTimeInMinutes: ${currentUser.etaTimeInMinutes}');

//    animatedObscuredTextInputContainer
//    if((showEditingCompleteCustomerAddressInformation == true)||
//        (showEditingCompleteCustomerHouseFlatIformation == true)||
//        (showEditingCompleteCustomerPhoneIformation == true)||
//        (showEditingCompleteCustomerReachoutIformation == true)){

    return
      unobscureInputandRestforTakeAway(unObsecuredInputandPayment);


    /*
      return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
      child: (showFullOrderType == false)?
      unobscureInputandRest(unObsecuredInputandPayment)

          :unobsuredEsleFirstTime(unObsecuredInputandPayment),
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


    );
     */



  }

  // work 3
  Widget _buildShoppingCartInputFieldsUNObscured(Order unObsecuredInputandPayment){

    CustomerInformation x = unObsecuredInputandPayment.ordersCustomer;
    //if(getOneOrdercustomerInfoFieldsNotEmpty(x)!=0){

    CustomerInformation currentUser =  x;

    print('currentUser.address: ${currentUser.address}');
    print('currentUser.flatOrHouseNumber: ${currentUser.flatOrHouseNumber}');
    print('currentUser.phoneNumber: ${currentUser.phoneNumber}');
    print('currentUser.etaTimeInMinutes: ${currentUser.etaTimeInMinutes}');

//    animatedObscuredTextInputContainer
//    if((showEditingCompleteCustomerAddressInformation == true)||
//        (showEditingCompleteCustomerHouseFlatIformation == true)||
//        (showEditingCompleteCustomerPhoneIformation == true)||
//        (showEditingCompleteCustomerReachoutIformation == true)){

    return
      unobscureInputandRest(unObsecuredInputandPayment);


    /*
      return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
      child: (showFullOrderType == false)?
      unobscureInputandRest(unObsecuredInputandPayment)

          :unobsuredEsleFirstTime(unObsecuredInputandPayment),
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


    );
     */




  }


  Widget _buildShoppingCartInputFieldsObscured( CustomerInformation ObscuredDisplay){

    //    CustomerInformation
//  final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//
//  return StreamBuilder(
//      stream: shoppingCartBloc.getCurrentCustomerInformationStream,
//      initialData: shoppingCartBloc.getCurrentCustomerInfo,
//
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) {
//          print('!snapshot.hasData');
////        return Center(child: new LinearProgressIndicator());
//          return Container(child: Text('Null'));
//        }
//        else {

    CustomerInformation currentUser =  ObscuredDisplay;
    // THIS INFORMATION ABOVE IS NOT USED NOW.

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
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
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

                            setState(() {
                              // showFullOrderType = false;
                              showFullOrderType
                              = false;
                              // showFullOrderType = false;
                              // showFullOrderType
                              /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }
//                            showFullOrderType = false;
                            );
                          },

                          onTap: () {
                            setState(() {
                              // showFullOrderType = false;
                              showFullOrderType
                              = false;
                              // showFullOrderType = false;
                              // showFullOrderType
                              /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }

                            );
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
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
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

                            setState((){

                                // showFullOrderType = false;
                                showFullOrderType
                                = false;
                                // showFullOrderType = false;
                                // showFullOrderType
                                /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                showCustomerInformationHeader = false;
                                showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;

                                showFullPaymentType  = true; // default.// NOTHING TO DO WITH INPUT FIELDS.



//                              showFullOrderType = false;
                            });
                          },


                          onTap: () {
                            setState(() {


//                              showFullOrderType = false;

                              // showFullOrderType = false;
                              showFullOrderType
                              = false;
                              // showFullOrderType = false;
                              // showFullOrderType
                              /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.

//                              showFullOrderType = false;
                            });
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
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
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

                            setState(() {
                              showFullOrderType = false;
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }


                            );
                          },


                          onTap: () {
                            setState(() {
                              showFullOrderType = false;

//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }
                            );
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
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => FocusScope.of(context).unfocus(),

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
                            setState((){ showFullOrderType = false;

//                            showCustomerInformationHeader = false;
                            showCustomerInformationHeader = true;
                            showFullPaymentType  = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            showUserInputOptionsLikeFirstTime = false;
                            });
                          },

                          onTap: () {
                            setState(() {
                              showFullOrderType = false;
//                              showCustomerInformationHeader = false;
                              showUserInputOptionsLikeFirstTime = false;
                              showCustomerInformationHeader = true;
                              showFullPaymentType = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }
                            );
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





  Widget animatedUnObscuredPaymentTypeUnSelectedContainerTakeAway(Order unObsecuredInputandPayment){

    print('at animated Un Obscured Card UnSelect Container');
    return
      Column(
        children: <Widget>[
          Container(
//          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                                      padding::::
              color:Colors.white,
//                                            height: 200,
//          height: displayHeight(context) /3,
              width: displayWidth(context)
                  - displayWidth(context) / 5,
//                                            width: displayWidth(context) * 0.57,

              // Work 5.
              child: Container(child:
              AnimatedSwitcher(
                duration: Duration(milliseconds: 3000),
//
                // animatedWidgetShowSelectedPaymentType
                // _buildShoppingCartPaymentMethodsUNObscuredUnSelected
                // animatedWidgetShowSelectedPaymentType
                // _buildShoppingCartPaymentMethodsUNObscuredUnSelected
                // animatedWidgetShowSelectedPaymentTypeTakeAway
                // _buildShoppingCartPaymentMethodsUNObscuredUnSelectedTakeAway
                child: showFullPaymentType==false ? animatedWidgetShowSelectedPaymentTypeTakeAway():
                _buildShoppingCartPaymentMethodsUNObscuredUnSelectedTakeAway(unObsecuredInputandPayment),
              ),
              )
            //HHHH


          ),

          Container(
//            alignment: Alignment.center,
            /*
    padding: EdgeInsets.fromLTRB(displayWidth(context)/3,
                0, 0, 0),
            */
            child:
            AnimatedSwitcher(
              duration: Duration(milliseconds: 1000),
//
              // animatedUnObscuredCancelPayButtonTakeAway
              // animatedObscuredCancelPayButtonTakeAway
              // animatedUnObscuredCancelPayButton
              // animatedObscuredCancelPayButton
              child: showFullPaymentType==false ?
              animatedUnObscuredCancelPayButtonTakeAway(unObsecuredInputandPayment):
              animatedObscuredCancelPayButtonTakeAway(unObsecuredInputandPayment)

              ,

            ),
          ),


        ],
      );


  }


  Widget animatedUnObscuredPaymentUnSelectContainer(Order unObsecuredInputandPayment){

    print('at animated Un Obscured Card UnSelect Container');
    return
      Column(
        children: <Widget>[
          Container(
//          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                                      padding::::
              color:Colors.white,
//                                            height: 200,
//          height: displayHeight(context) /3,
              width: displayWidth(context)
                  - displayWidth(context) / 5,
//                                            width: displayWidth(context) * 0.57,




              // Work 5.
              child: Container(child:
              AnimatedSwitcher(
                duration: Duration(milliseconds: 3000),
//
                child: showFullPaymentType==false ? animatedWidgetShowSelectedPaymentType():
                _buildShoppingCartPaymentMethodsUNObscuredUnSelected(unObsecuredInputandPayment)
                ,

              ),





              )
            //HHHH


          ),

          Container(
//            alignment: Alignment.center,
            /*
    padding: EdgeInsets.fromLTRB(displayWidth(context)/3,
                0, 0, 0),
            */
            child:
            AnimatedSwitcher(
              duration: Duration(milliseconds: 1000),
//
              child: showFullPaymentType==false ?
              animatedUnObscuredCancelPayButton(unObsecuredInputandPayment):
              animatedObscuredCancelPayButton(unObsecuredInputandPayment)

              ,

            ),
          ),


        ],
      );


  }


  Widget animatedObscuredCancelPayButtonTakeAway(Order CancelPaySelect){
    //  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Cancel Pay Button()');
    return
      AbsorbPointer(
        child: Opacity(
          opacity:0.2,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: OutlineButton(
                    onPressed: (){ print('Cancel Pressed');

                    return Navigator.pop(context,true);
                    },
                    child: Text('Cancel',style: TextStyle(color: Colors.red,fontSize: 30),),
                    shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color:Colors.red,
                        style: BorderStyle.solid,
                        width: 3.6,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),

                ),
                SizedBox(width: displayWidth(context)/12,),
                Container(
                  child: OutlineButton(
                    onPressed: (){

                      print('on Pressed of Pay');
                      return Navigator.pop(context,false);


                    },
                    child: Text('Pay',style: TextStyle(color: Colors.green,fontSize: 30),),
                    shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color:Colors.green,
                        style: BorderStyle.solid,
                        width: 3.6,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),

                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget animatedObscuredCancelPayButton(Order CancelPaySelect){
//  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Cancel Pay Button()');
    return
      AbsorbPointer(
        child: Opacity(
          opacity:0.2,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: OutlineButton(
                    onPressed: (){ print('Cancel Pressed');

                    return Navigator.pop(context,true);
                    },
                    child: Text('Cancel',style: TextStyle(color: Colors.red,fontSize: 30),),
                    shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color:Colors.red,
                        style: BorderStyle.solid,
                        width: 3.6,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),

                ),
                SizedBox(width: displayWidth(context)/12,),
                Container(
                  child: OutlineButton(
                    onPressed: (){

                      print('on Pressed of Pay');
                      return Navigator.pop(context,false);


                    },
                    child: Text('Pay',style: TextStyle(color: Colors.green,fontSize: 30),),
                    shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color:Colors.green,
                        style: BorderStyle.solid,
                        width: 3.6,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),

                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget animatedUnObscuredCancelPayButtonTakeAway(Order CancelPaySelect){
    //  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Cancel Pay Button()');
    return
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: OutlineButton(
                onPressed: (){
                  print('on Pressed of Cancel');
                  return Navigator.pop(context,true);
                },
                child: Text('Cancel',style: TextStyle(color: Colors.red,fontSize: 30),),
                shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(
                    color: Colors.red,
                    style: BorderStyle.solid,
                    width: 3.6,
                  ),
                  borderRadius: BorderRadius.circular(35.0),
                ),
              ),

            ),
            SizedBox(width: displayWidth(context)/12,),
            Container(
              child: OutlineButton(
                onPressed: (){
                  print('on Pressed of Pay');
                  return Navigator.pop(context,false);
                },
                child: Text('Pay',style: TextStyle(color: Colors.green,fontSize: 30),),
                shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(
                    color:Colors.green,
                    style: BorderStyle.solid,
                    width: 3.6,
                  ),
                  borderRadius: BorderRadius.circular(35.0),
                ),
              ),

            ),
          ],
        ),
      );
  }


  Widget animatedUnObscuredCancelPayButton(Order CancelPaySelect){
//  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Cancel Pay Button()');
    return
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: OutlineButton(
                onPressed: (){
                  print('on Pressed of Cancel');
                  return Navigator.pop(context,true);
                },
                child: Text('Cancel',style: TextStyle(color: Colors.red,fontSize: 30),),
                shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(
                    color: Colors.red,
                    style: BorderStyle.solid,
                    width: 3.6,
                  ),
                  borderRadius: BorderRadius.circular(35.0),
                ),
              ),

            ),
            SizedBox(width: displayWidth(context)/12,),
            Container(
              child: OutlineButton(
                onPressed: (){
                  print('on Pressed of Pay');
                  return Navigator.pop(context,false);
                },
                child: Text('Pay',style: TextStyle(color: Colors.green,fontSize: 30),),
                shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(
                    color:Colors.green,
                    style: BorderStyle.solid,
                    width: 3.6,
                  ),
                  borderRadius: BorderRadius.circular(35.0),
                ),
              ),

            ),
          ],
        ),
      );

  }




  Widget animatedWidgetShowSelectedPaymentTypeTakeAway(){
    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return Container(
      height: displayHeight(context) / 9,
      child: StreamBuilder(
          stream: shoppingCartbloc.getCurrentPaymentTypeSingleSelectStream,
          initialData: shoppingCartbloc.getCurrentPaymentType,

          builder: (context, snapshot)
          {
            if (!snapshot.hasData) {
              print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
              return Container(child: Text('Null'));
            }
            else {
              List<PaymentTypeSingleSelect> allPaymentTypesSingleSelect = snapshot.data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

//            print('orderTypes: $allOrderTypesSingleSelect');
              PaymentTypeSingleSelect selectedOne = allPaymentTypesSingleSelect
                  .firstWhere((onePaymentType) => onePaymentType.isSelected == true);

              _currentPaymentTypeIndex = selectedOne.index;
              logger.e('selectedOne.index',selectedOne.index);
              logger.e('selectedOne.isSelected',selectedOne.isSelected);



              String orderTypeName = selectedOne.paymentTypeName;
              String orderIconName = selectedOne.paymentIconName;
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
                                  'Payment Method',
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
                                height: displayHeight(context) /14,
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
                                  size: displayHeight(context) /30,

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
//                          final ShoppingCartBlock = BlocProvider.of<ShoppingCartBloc>(context);
//                          ShoppingCartBlock.setPaymentTypeSingleSelectOptionForOrder(selectedOne,4,_currentOrderTypeIndex);

                          setState(() {

                            showFullPaymentType = !showFullPaymentType;
//                            _currentPaymentTypeIndex= 4;
//                            showFullOrderType = !showFullOrderType;
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
      ),
    );
  }
  Widget animatedWidgetShowSelectedPaymentType() {

    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return Container(
      height: displayHeight(context) / 9,
      child: StreamBuilder(
          stream: shoppingCartbloc.getCurrentPaymentTypeSingleSelectStream,
          initialData: shoppingCartbloc.getCurrentPaymentType,

          builder: (context, snapshot)
          {
            if (!snapshot.hasData) {
              print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
              return Container(child: Text('Null'));
            }
            else {
              List<PaymentTypeSingleSelect> allPaymentTypesSingleSelect = snapshot.data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

//            print('orderTypes: $allOrderTypesSingleSelect');
              PaymentTypeSingleSelect selectedOne = allPaymentTypesSingleSelect
                  .firstWhere((onePaymentType) => onePaymentType.isSelected == true);

              _currentPaymentTypeIndex = selectedOne.index;
              logger.e('selectedOne.index',selectedOne.index);
              logger.e('selectedOne.isSelected',selectedOne.isSelected);



              String orderTypeName = selectedOne.paymentTypeName;
              String orderIconName = selectedOne.paymentIconName;
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
                                  'Payment Method',
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
                                height: displayHeight(context) /14,
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
                                  size: displayHeight(context) /30,

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
//                          final ShoppingCartBlock = BlocProvider.of<ShoppingCartBloc>(context);
//                          ShoppingCartBlock.setPaymentTypeSingleSelectOptionForOrder(selectedOne,4,_currentOrderTypeIndex);

                          setState(() {

                            showFullPaymentType = !showFullPaymentType;
//                            _currentPaymentTypeIndex= 4;
//                            showFullOrderType = !showFullOrderType;
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
      ),
    );
  }

  Widget _buildShoppingCartPaymentMethodsUNObscuredUnSelectedTakeAway(Order unObsecuredInputandPayment){
    //XYZ
    return
      Container(
        color: Colors.blueGrey,
        height: displayHeight(context) / 20 /* HEIGHT OF CHOOSE ORDER TYPE TEXT PORTION */ +  displayHeight(context) /7 /* HEIGHT OF MULTI SELECT PORTION */,
        child: Column(
          children: <Widget>[
            Container(
              width: displayWidth(context) / 1.1,
              height: displayHeight(context) / 20,
//              color: Color(0xffffffff),
              color: Colors.blueGrey,
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
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),

                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForPaymentUnSelected(
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

//            GYG
            // 2ND CONTAINER HOLDS THE total price BEGINS HERE..
            Container(

              padding: EdgeInsets
                  .fromLTRB(
                  300, 0, 10, 0),
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
                      '${
                          (unObsecuredInputandPayment.totalPrice
                              /* * unObsecuredInputandPayment.totalPrice */).toStringAsFixed(2)} '
                          '\u20AC',
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

            Container(
              padding: EdgeInsets.fromLTRB(displayWidth(context)/6, 20, 0, 5),
//              alignment:Alignment.center,
//
//                                                      padding::::
              color: Colors.blueGrey,
//              color:Colors.white,
//                                            height: 200,
              height: displayHeight(context) /10,
              width: displayWidth(context)
                  - displayWidth(context) /
                      5,
//                                            width: displayWidth(context) * 0.57,
              child:  _buildPaymentTypeSingleSelectOption(),

            ),
          ],
        ),
      );
  }
  Widget _buildShoppingCartPaymentMethodsUNObscuredUnSelected(Order unObsecuredInputandPayment)
  {
//    XYZ
    return
      Container(
        color: Colors.blueGrey,
        height: displayHeight(context) / 20 /* HEIGHT OF CHOOSE ORDER TYPE TEXT PORTION */ +  displayHeight(context) /7 /* HEIGHT OF MULTI SELECT PORTION */,
        child: Column(
          children: <Widget>[
            Container(
              width: displayWidth(context) / 1.1,
              height: displayHeight(context) / 20,
//              color: Color(0xffffffff),
              color: Colors.blueGrey,
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
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),

                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForPaymentUnSelected(
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

//            GYG
            // 2ND CONTAINER HOLDS THE total price BEGINS HERE..
            Container(

              padding: EdgeInsets
                  .fromLTRB(
                  300, 0, 10, 0),
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
                      '${
                          (unObsecuredInputandPayment.totalPrice
                              /* * unObsecuredInputandPayment.totalPrice */).toStringAsFixed(2)} '
                          '\u20AC',
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

            Container(
              padding: EdgeInsets.fromLTRB(displayWidth(context)/6, 20, 0, 5),
//              alignment:Alignment.center,
//
//                                                      padding::::
              color: Colors.blueGrey,
//              color:Colors.white,
//                                            height: 200,
              height: displayHeight(context) /10,
              width: displayWidth(context)
                  - displayWidth(context) /
                      5,
//                                            width: displayWidth(context) * 0.57,
              child:  _buildPaymentTypeSingleSelectOption(),

            ),
          ],
        ),
      );
  }


  int getNumberOfInputsFilledUpDinningRoom (CustomerInformation customerInfoFieldsCheck){

    print(' U   U    U  ?   U   ? getNumberOfInputsFilledUp');
    int total=0;
    switch (customerInfoFieldsCheck.address.trim().length) {

      case 0:
        total =total + 0;
        break;
      default:
        total = total +1;


    }
    switch (customerInfoFieldsCheck.flatOrHouseNumber.trim().length) {

      case 0:
        total = total + 0;
        break;
      default:
        total = total +1;


    }
    switch (customerInfoFieldsCheck.phoneNumber.trim().length) {

      case 0:
        total =total + 0;
        break;
      default:
        total = total +1;


    }
    switch (customerInfoFieldsCheck.etaTimeInMinutes) {

      case -1:
        total = total + 0;
        break;
      default:
        total = total +1;


    }


    print('-----  ||  ** **  **TOTAL : $total');
    return total;


//    else{
//      return false;
//      // empty; 3 inputs are not filled.
//    }

  }


  int  getNumberOfInputsFilledUpTakeAway(CustomerInformation customerInfoFieldsCheck){

    print(' U   U    U  ?   U   ? getNumberOfInputsFilledUp');
    int total=0;
    switch (customerInfoFieldsCheck.address.trim().length) {

      case 0:
        total =total + 0;
        break;
      default:
        total = total +1;


    }
    switch (customerInfoFieldsCheck.flatOrHouseNumber.trim().length) {

      case 0:
        total = total + 0;
        break;
      default:
        total = total +1;


    }
    switch (customerInfoFieldsCheck.phoneNumber.trim().length) {

      case 0:
        total =total + 0;
        break;
      default:
        total = total +1;


    }
    switch (customerInfoFieldsCheck.etaTimeInMinutes) {

      case -1:
        total = total + 0;
        break;
      default:
        total = total +1;


    }


    print('-----  ||  ** **  **TOTAL : $total');
    return total;


//    else{
//      return false;
//      // empty; 3 inputs are not filled.
//    }

  }
  int  getNumberOfInputsFilledUp(CustomerInformation customerInfoFieldsCheck){

    print(' U   U    U  ?   U   ? getNumberOfInputsFilledUp');
    int total=0;
    switch (customerInfoFieldsCheck.address.trim().length) {

      case 0:
        total =total + 0;
        break;
      default:
        total = total +1;


    }
    switch (customerInfoFieldsCheck.flatOrHouseNumber.trim().length) {

      case 0:
        total = total + 0;
        break;
      default:
        total = total +1;


    }
    switch (customerInfoFieldsCheck.phoneNumber.trim().length) {

      case 0:
        total =total + 0;
        break;
      default:
        total = total +1;


    }
    switch (customerInfoFieldsCheck.etaTimeInMinutes) {

      case -1:
        total = total + 0;
        break;
      default:
        total = total +1;


    }


    print('-----  ||  ** **  **TOTAL : $total');
    return total;


//    else{
//      return false;
//      // empty; 3 inputs are not filled.
//    }

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

      case 'Card': {
        return FontAwesomeIcons.solidCreditCard;

      }
      break;
      case 'Cash': {
        return FontAwesomeIcons.moneyBill;
      }
      break;
      case 'Later': {
        return FontAwesomeIcons.bookmark;
      }
      break;





      default: {
        return FontAwesomeIcons.home;
      }
    }
  }

//  oneSingleDeliveryType to be replaced with oneSinglePaymentType
  Widget oneSingleDeliveryType (OrderTypeSingleSelect x,int index){


//    String color1 = x.itemTextColor.replaceAll('#', '0xff');

//    Color c1 = Color(int.parse(color1));
//    print('x: ',x.i)

//    IconData x = IconData(int.parse(x.iconDataString),fontFamily: 'MaterialIcons');

//    print('x.icondataString: ${x.iconDataString}');
//    print('x.orderType: ${x.orderType}');
//    print('isSelected check at Shopping Cart Page: ${x.isSelected}');
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
        height: displayHeight(context) /8,
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
                  width:  displayWidth(context)/7.5,
                  height: displayWidth(context)/7.5,
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
                    size: displayWidth(context)/11,

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
              // setState(()=>) NEEDED IN THE UNSELECTED PART,
            // WE NEED TO RENDER THEM AS THEY ARE IN THE FIRST
            // TIME.
//            setState(() {
//              _currentOrderTypeIndex=index;
//            });


          },
        ),
        // : Container for 2nd argument of ternary condition ends here.

      ):

      Container(
        width: 150,
        height: displayHeight(context) /8,
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
                  width:  displayWidth(context)/7.5,
                  height: displayWidth(context)/7.5,
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
                    size: displayWidth(context)/11,
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
              // WORK -1




            setState(() {

            //   _currentOrderTypeIndex=index;

            showCustomerInformationHeader = true;
            showUserInputOptionsLikeFirstTime =true;
            // WE ARE oneSingleDeliveryType;
//            showFullPaymentType = false;  = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
            }
            );


          },
        ),




      ),
    );
  }

  // PAYMENT RELATED WIDGETS ARE HERE  --- below:


  Widget animatedObscuredPaymentSelectContainerTakeAway(Order priceandselectedCardFunctionality){
//  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Card Select Container()');
    return
      Container(
        height: displayWidth(context)/2.1,
        child: AbsorbPointer(
          child: Opacity(
            opacity:0.2,
            child: Container(
                color: Colors.yellowAccent,
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
                child: _buildShoppingCartPaymentMethodsUNObscuredUnSelected(priceandselectedCardFunctionality)
//                _buildShoppingCartPaymentMethodsUNObscuredUnSelected(unObsecuredInputandPayment)
//                _buildShoppingCartPaymentMethodsUNObscuredUnSelected

              //RRRRRR


            ),
          ),
        ),
      );
  }
  Widget animatedObscuredPaymentSelectContainer(Order priceandselectedCardFunctionality){
//  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Card Select Container()');
    return
      Container(
        height: displayWidth(context)/2.1,
        child: AbsorbPointer(
          child: Opacity(
            opacity:0.2,
            child: Container(
                color: Colors.yellowAccent,
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
                child: _buildShoppingCartPaymentMethodsUNObscuredUnSelected(priceandselectedCardFunctionality)
//                _buildShoppingCartPaymentMethodsUNObscuredUnSelected(unObsecuredInputandPayment)
//                _buildShoppingCartPaymentMethodsUNObscuredUnSelected

              //RRRRRR


            ),
          ),
        ),
      );
  }


  bool zeroORMoreInputsEmptyDinningRoom(CustomerInformation customerInfoFieldsCheck){



    print( ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber}'
        ' A :${customerInfoFieldsCheck.address} '
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}');

//    assert(customerInfoFieldsCheck.address.trim().length >0);
//    assert(customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.phoneNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.etaTimeInMinutes != -1);
    if
//    (customerInfoFieldsCheck.address.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.phoneNumber.trim().length >0)
//        &&
    (customerInfoFieldsCheck.etaTimeInMinutes != -1)


    {
      print('WILL RETURN FALSE');
      return false;
    }

    else{
      print('WILL RETURN TRUE');
      return true; // empty; one or more of the user inputs are.
    }

  }


  bool zeroORMoreInputsEmptyTakeAway(CustomerInformation customerInfoFieldsCheck){



    print( ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber}'
        ' A :${customerInfoFieldsCheck.address} '
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}');

//    assert(customerInfoFieldsCheck.address.trim().length >0);
//    assert(customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.phoneNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.etaTimeInMinutes != -1);
    if
//    (customerInfoFieldsCheck.address.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.phoneNumber.trim().length >0)
//        &&
    (customerInfoFieldsCheck.etaTimeInMinutes != -1)


    {
      print('WILL RETURN FALSE');
      return false;
    }

    else{
      print('WILL RETURN TRUE');
      return true; // empty; one or more of the user inputs are.
    }

  }

  bool zeroORMoreInputsEmpty(CustomerInformation customerInfoFieldsCheck){



    print( ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber}'
        ' A :${customerInfoFieldsCheck.address} '
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}');

//    assert(customerInfoFieldsCheck.address.trim().length >0);
//    assert(customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.phoneNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.etaTimeInMinutes != -1);
    if(
    (customerInfoFieldsCheck.address.trim().length >0)
        &&
        (customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0)
        &&
        (customerInfoFieldsCheck.phoneNumber.trim().length >0)
        &&
        (customerInfoFieldsCheck.etaTimeInMinutes != -1)
    )

    {
      print('WILL RETURN FALSE');
      return false;
    }

    else{
      print('WILL RETURN TRUE');
      return true; // empty; one or more of the user inputs are.
    }

  }


  // 3926 IS FOR THE UNOBSCURE PART.
  // 4511 is for the OBSCURED PART.
  Widget _buildPaymentTypeSingleSelectOption(){

    logger.i('at here: _buildPaymentTypeSingleSelectOption');
//   height: 40,
//   width: displayWidth(context) * 0.57,


    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return StreamBuilder(
        stream: shoppingCartbloc.getCurrentPaymentTypeSingleSelectStream,
        initialData: shoppingCartbloc.getCurrentPaymentType,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Container(child: Text('Null'));
          }
          else {
            List<PaymentTypeSingleSelect> allPaymentTypesSingleSelect = snapshot.data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

            print('paymentTypes: $allPaymentTypesSingleSelect');

            /*
            PaymentTypeSingleSelect selectedOne = allPaymentTypesSingleSelect.firstWhere(
                    (onePaymentType) =>
                    onePaymentType.isSelected==true);
            _currentPaymentTypeIndex = selectedOne.index;

            print('_currentPaymentTypeIndex: at 4237 000  0000 $_currentPaymentTypeIndex');


             */


            return ListView.builder(
              scrollDirection: Axis.horizontal,

//              reverse: true,

              shrinkWrap: false,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
              itemCount: allPaymentTypesSingleSelect.length,

              itemBuilder: (_, int index) {
                return oneSinglePaymentType(
                    allPaymentTypesSingleSelect[index],
                    index);
              },
            );
          }
        }

      // M VSM ORG VS TODO. ENDS HERE.
    );

  }



//  oneSingleDeliveryType to be replaced with oneSinglePaymentType
  Widget oneSinglePaymentType (PaymentTypeSingleSelect onePaymentType,int index){


//    String color1 = x.itemTextColor.replaceAll('#', '0xff');

//    Color c1 = Color(int.parse(color1));
//    print('x: ',x.i)

//    IconData x = IconData(int.parse(x.iconDataString),fontFamily: 'MaterialIcons');

//    print('x.icondataString: ${x.iconDataString}');
//    print('x.orderType: ${x.orderType}');
//    print('isSelected check at Shopping Cart Page: ${x.isSelected}');
//    logger.i('isSelected check at Shopping Cart Page: ',x.isSelected);




    logger.i('_currentPaymentTypeIndex: at line # 4287 $_currentPaymentTypeIndex');
    String paymentTypeName = onePaymentType.paymentTypeName;
    String paymentIconName = onePaymentType.paymentTypeName;
    String borderColor = onePaymentType.borderColor;
    const Color OrderTypeIconColor=Color(0xff070707);
    return Container(

//      height:displayHeight(context)/30,
//      width:displayWidth(context)/10,

      child:  index == _currentPaymentTypeIndex  ?

      Container(

        width: 110,
        height: displayHeight(context) /11,
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
                  width:  displayWidth(context)/11.5,
                  height: displayWidth(context)/11.5,
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
                    getIconForName(paymentTypeName),
                    color: Colors.red,
                    size: displayWidth(context)/20,

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
                    paymentTypeName, style:
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
//    void setPaymentTypeSingleSelectOptionForOrder(PaymentTypeSingleSelect x, int newPaymentIndex,int oldPaymentIndex){
            shoppingCartBloc.setPaymentTypeSingleSelectOptionForOrder(onePaymentType,index,_currentPaymentTypeIndex);

            // oneSinglePaymentType
            setState(() {
              showFullPaymentType= false;
            });


          },
        ),
        // : Container for 2nd argument of ternary condition ends here.

      ):

      Container(
        width: 110,
        height: displayHeight(context) /10,
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
                  width:  displayWidth(context)/11.5,
                  height: displayWidth(context)/11.5,
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
                    getIconForName(paymentTypeName),
                    color: Colors.grey,
                    size: displayWidth(context)/20,
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
                    paymentTypeName, style:
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
            shoppingCartBloc.setPaymentTypeSingleSelectOptionForOrder(onePaymentType,index,_currentPaymentTypeIndex);


            // oneSinglePaymentType
            setState(() {
              showFullPaymentType = false;
            });


          },
        ),




      ),
    );
  }






}





//  FoodDetailImage








