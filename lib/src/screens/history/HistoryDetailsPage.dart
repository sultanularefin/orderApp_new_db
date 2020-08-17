//food_gallery.dart



// dependency files
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/BLoC/HistoryDetailsBloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:qr_flutter/qr_flutter.dart';


//import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocIDViewModel.dart';

import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
import 'package:foodgallery/src/DataLayer/models/OrderedItem.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';
import 'package:foodgallery/src/screens/history/HistoryDetailImage.dart';


//sizeConstantsList


// SCREEN FILES AND MODLE FILES AND UTILITY FILES.

import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
//import 'package:foodgallery/src/screens/foodItemDetailsPage/Widgets/FoodDetailImage.dart';
import 'package:foodgallery/src/DataLayer/models/FoodPropertyMultiSelect.dart';
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';

import 'package:logger/logger.dart';

// Blocks

import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';

class HistoryDetailsPage extends StatefulWidget {

  final Widget child;
  HistoryDetailsPage({Key key, this.child}) : super(key: key);
  @override
  _FoodItemDetailsState createState() => new _FoodItemDetailsState();

}


class _FoodItemDetailsState extends State<HistoryDetailsPage> {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  String _currentSize;
//  int _itemCount= 0;
//  double priceBySize = 0.0;
//  double priceBasedOnCheeseSauceIngredientsSizeState = 0.0;
//
//  List<String> allSubGroups1 = new List<String>();

/*

  @override
  void initState() {

//    setallSubgroups();

    super.initState();
  }


   */







  double tryCast<num>(dynamic x, {num fallback }) {


    bool status = x is num;

    if(status) {
      return x.toDouble() ;
    }

    if(x is int) {return x.toDouble();}
    else if(x is double) {return x.toDouble();}


    else return 0.0;
  }

  bool showUnSelectedIngredients = false;
  bool showPressWhenFinishButton = false;



  @override
  Widget build(BuildContext context) {


    final blocHD = BlocProvider.of<HistoryDetailsBloc>(context);


    return Container(

        child: StreamBuilder<OneOrderFirebase>(


            stream:       blocHD.getCurrentOrderStream,
            initialData:  blocHD.getCurrentFireBaseOrder,

            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: new LinearProgressIndicator());
              }
              else {

                final OneOrderFirebase oneFireBaseOrderDetail = snapshot.data;



//                priceBasedOnCheeseSauceIngredientsSizeState =  oneFireBaseOrderDetail.priceBasedOnCheeseSauceIngredientsSize;
//
//                priceBySize = oneFireBaseOrderDetail.itemPriceBasedOnSize;
//
//                _currentSize = oneFireBaseOrderDetail.itemSize;


                return GestureDetector(
                  onTap: () {
                    print('s');
                    print('navigating to FoodGallery 2 again with block');

                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }

// WE DON'T NEED TO CREATE THE ORDER OBJECT AND STORE SELECTED ITEMS, RATHER,
// WE JUST NEED TO SENT THE SELECTED ITEM IN FOOD GALLERY PAGE.
// FROM FOOD ITEM PAGE.


                    print('CLEAR SUBSCRIPTION ... before going to food gallery page..');


                    return Navigator.pop(context);


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
                              MediaQuery.of(context).padding.bottom,
//                            kToolbarHeight

                          child: GestureDetector(
                            onTap: () {
                              print('GestureDetector for Stack working');
                              print('no navigation now');


                            },
                            child:

                            Container(

// FROM 2.3 ON JULY 3 AFTER CHANGE INTRODUCTION OF CHEESE AND SAUCES.
                                width: displayWidth(context)/1.03,

                                child:
                                initialView(oneFireBaseOrderDetail)
                            ),



                          )


                      ),
                    ),
                  ),
                );
              }
            }
        )
    );
//    }
  }


  Widget initialView(OneOrderFirebase oneFireBaseOrder){

    List<OrderedItem> orderedItems = oneFireBaseOrder.orderedItems;



    return Container(

      height: displayHeight(context) -
          MediaQuery.of(context).padding.top -
          MediaQuery.of(context).padding.bottom,


// FROM 2.3 ON JULY 3 AFTER CHANGE INTRODUCTION OF CHEESE AND SAUCES.
      width: displayWidth(context)/1.03,
//                  color:Colors.lightGreen,
      margin: EdgeInsets.fromLTRB(
          0, displayHeight(context)/16, 0, 5),

      decoration:
      new BoxDecoration(
        borderRadius: new BorderRadius
            .circular(
            10.0),
//                                    color: Colors.purple,
        color: Colors.white,
      ),


      child:
      Neumorphic(
        curve: Neumorphic.DEFAULT_CURVE,
        style: NeumorphicStyle(
          shape: NeumorphicShape
              .concave,
          depth: 8,
          lightSource: LightSource
              .topLeft,
          color: Colors.white,
          boxShape:NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(5)),
          ),
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

            Container(
//              color: Colors.blue,
              height:displayHeight(context)/11,
              width: displayWidth(context)/1.07,

              child:
// YELLOW NAME AND PRICE BEGINS HERE.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: displayWidth(context)/2.8 /*+  displayWidth(context)/8 */, /*3.9 */


                    decoration: BoxDecoration(
                      color:Color(0xffFFE18E),
                      borderRadius: BorderRadius.only(bottomRight:  Radius.circular(60)),
//
                    ),


                    height:displayHeight(context)/18,
//                                          height: displayHeight(context)/40,

                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: <Widget>[
                        Container(
                          width: displayWidth(context)/3.9,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child:

                          Text(
                              '${oneFireBaseOrder.orderBy.toLowerCase()}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
//                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                              )
                          ),
                        ),



                      ],
                    ),



                  ),




                  Container(

//                    color:Colors.green,
                    width: displayWidth(context) /2.5,
                    height:displayHeight(context)/11,
                    child:displayCustomerInformationWidget(oneFireBaseOrder.oneCustomer),
//                    height: displayHeight(context)/20,

                  )

                ],
              ),

            ),

            Divider(
              height:10,
              thickness:1,
              color:Colors.grey,
            ),



            SizedBox(height:10),

            Container(

                width: displayWidth(context) /2.49 + displayWidth(context) /1.91,

                height: displayHeight(context) / 1.6,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
//                                                    width: displayWidth(context)/4,
                      width: displayWidth(context)/3,
//                                                    width: displayWidth(context)/3.29,
//                      color:Colors.blue,
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,


                        children: [
                          Container(
                            height:displayHeight(context)/6.5,
                            width: displayWidth(context)/3.59,
//                        color: Colors.red,
//                            color:Colors.blue,


                            padding: EdgeInsets
                                .fromLTRB(
                                0, 0, 0,
                                0),

//                          child: Text('FoodImageURL')

                            child:
                            HistoryDetailImage(
                              oneFireBaseOrder.formattedOrderPlacementDatesTimeOnly,
                              oneFireBaseOrder.orderBy,
                              oneFireBaseOrder.startDate,
                              oneFireBaseOrder.totalPrice,

//
                            ),
//                          formattedOrderPlacementDatesTimeOnly2
//),

                          ),


                          Container(
                            height:displayHeight(context)/4,
                            width: displayWidth(context)/2.99,
//                        color: Colors.red,


                            padding: EdgeInsets
                                .fromLTRB(
                                20, 0, 20,
                                0),

//                          child: Text('FoodImageURL')

                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [

                                Text(
                                    '${oneFireBaseOrder.formattedOrderPlacementDatesTimeOnly}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                      color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                    )
                                ),

                                Text(
                                    '${oneFireBaseOrder.orderProductionTime}:00 min',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                      color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                    )
                                ),

                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Text(
                                          'SUBTOTAL',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color:Colors.grey,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),


                                      Text(
                                          '${oneFireBaseOrder.totalPrice.toStringAsFixed(2)}'+'\u20AC',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color:Colors.grey,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ],
                                  ),
                                ),



                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Text(
                                          'DELIVERY',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color:Colors.grey,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),


                                      Text(
                                          '${oneFireBaseOrder.deliveryCost.toStringAsFixed(2)}'+'\u20AC',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color:Colors.grey,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ],
                                  ),
                                ),




                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Text(
                                          'ALV',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
//                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),


                                      Text(
                                          '14%',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
//                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ],
                                  ),
                                ),

                                Divider(
                                  height:5,
                                  thickness:1,
                                  color:Colors.grey,
                                ),




                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Text(
                                          'TOTAL',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),


                                      Text(
                                          '${oneFireBaseOrder.priceWithDelivery.toStringAsFixed(2)}'+'\u20AC',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  child: Row(

                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Text(
                                          '${oneFireBaseOrder.paidStatus}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),


                                      Text(
                                          '${oneFireBaseOrder.paidType}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ],
                                  ),
                                ),














                              ],
                            ),
//                          formattedOrderPlacementDatesTimeOnly2
//),

                          ),



                        ],
                      ),
                    ),

                    VerticalDivider(
//                      height:10,
                      width:10,
                      thickness:1,
                      color:Colors.grey,
                    ),



                    Container(
//                      color:Colors.purpleAccent,
                      height:displayHeight(context)/1.7,



                      width:displayWidth(context) /1.91,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .start,
                        crossAxisAlignment: CrossAxisAlignment
                            .end,
                        children: <Widget>[



                          Container(
                              width: 550,
                              height:displayHeight(context)/1.7,
                              child: processFoodForHistoryDetailsPage(orderedItems)
                          ),

//                          FFFFF




                        ],
                      ),
                    ),




                  ],
                )

            ),



            Center(
              child: OutlineButton(
                padding: EdgeInsets.all(0),
                splashColor: Colors.lightBlueAccent,
                highlightElevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                borderSide: BorderSide(
                  color:Color(0xff707070),
                  style: BorderStyle.solid,
                  width: 1.6,
                ),

                child: Container(

                  child:
                  Column(
                    children: [
                      Container(
                        width: 150,
                        height:150,
                        child: QrImage(
                          data: "1234567890",
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),

                      Text(
                        'check order',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 23,
//                          fontFamily: 'Itim-Regular',
                        ),
                      ),

                    ],
                  ),
                ),
                onPressed: () {

                  print('-------------- ---------- pressed');

                },


              ),
            ),









/*  TOP CONTAINER IN THE STACK WHICH IS VISIBLE ENDS HERE. */

          ],
        ),

      ),
    );
  }


  Widget displayOneFoodInformation(OrderedItem oneFood, int index){
    print('index: : : : $index');

    List<NewIngredient> extraIngredient   = oneFood.selectedIngredients;
    List<SauceItem>     extraSauces       = oneFood.selectedSauces;
    List<CheeseItem>    extraCheeseItems  = oneFood.selectedCheeses;


    print('extraIngredient: $extraIngredient');

    print('extraSauces: $extraSauces');

    print('extraCheeseItems: $extraCheeseItems');

    List<NewIngredient> onlyExtraIngredient   = extraIngredient.where((e) => e.isDefault != true).toList();
    List<SauceItem> onlyExtraSauces       = extraSauces.where((e) => e.isDefaultSelected != true).toList();
    List<CheeseItem>    onlyExtraCheeseItems  = extraCheeseItems.where((e) => e.isDefaultSelected != true).toList();


    print('onlyExtraIngredient: $onlyExtraIngredient');

    print('onlyExtraSauces: $onlyExtraSauces');

    print('onlyExtraCheeseItems: $onlyExtraCheeseItems');


    return Container(

      height:145,
      width: 550,
      padding:EdgeInsets.symmetric(vertical:8,horizontal: 6),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
            color:Colors.amber,
            height: 30,
            width: 550,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text(
                  '${oneFood.name.toString()}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20,
//                    fontFamily: 'Itim-Regular',
                  ),
                ),
                Text(
                  'X${oneFood.quantity}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',),
                ),
                /*
        Text(
                  '${oneFood.foodItemSize}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',),
                ),

                */
                Text(
                  '${(oneFood.oneFoodTypeTotalPrice * oneFood.quantity).toStringAsFixed(2)}',
                  // '${oneFood.unitPriceWithoutCheeseIngredientSauces.toStringAsFixed(2)}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',),
                ),

              ],
            ),
          ),

          Container(
              height: 30,
              width: 550,
              child: showExtraIngredients(onlyExtraIngredient,oneFood.quantity)
          ),

//                Text('||'),
          Container(
              height: 30,
              width: 550,
              child: showExtraCheeseItems(onlyExtraCheeseItems,oneFood.quantity)
          ),

//                Text('||'),
          Container(
              height: 30,
              width: 550,
              child: showExtraSauces(onlyExtraSauces,oneFood.quantity)
          ),

          Divider(
            height:5,
            thickness:1,
            color:Colors.grey,
          ),

        ],
      ),
    );
  }



  Widget processFoodForHistoryDetailsPage(List<OrderedItem> orderedItems){

    return ListView.builder(

      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: orderedItems.length,

      itemBuilder: (_,int index) {
        return displayOneFoodInformation(orderedItems[index], index);
      },
    );
  }



  Widget displayOneExtraIngredientInRecite(NewIngredient oneIngredientForHistoryDetailsPage, int index,int quantity){

    print('oneIngredientForRecite.ingredientName: ${oneIngredientForHistoryDetailsPage.ingredientName}');

    if(oneIngredientForHistoryDetailsPage.isDefault==false) {

      print(' oneIngredientForHistoryDetailsPage.isDefault==false  : ${oneIngredientForHistoryDetailsPage.isDefault==false} ==> '
          'oneIngredientForHistoryDetailsPage.ingredientName => ${oneIngredientForHistoryDetailsPage.ingredientName}');
      return

        Container(
          padding:EdgeInsets.symmetric(vertical:0,horizontal: 6),
          child: Text('${((oneIngredientForHistoryDetailsPage.ingredientName == null) ||
              (oneIngredientForHistoryDetailsPage.ingredientName.length == 0)) ?
          '----' : oneIngredientForHistoryDetailsPage.ingredientName.length > 18 ?
          oneIngredientForHistoryDetailsPage.ingredientName.substring(0, 15) + '...' :
          oneIngredientForHistoryDetailsPage.ingredientName}, ',
            /*
              Text(
                '${oneIngredientForRecite.ingredientName}', */

            textAlign: TextAlign.left,
            style: TextStyle(
//                fontWeight: FontWeight.bold,
              color: Colors.black,
//                        color: Color(0xffF50303),
              fontSize: 17,
//                fontFamily: 'Itim-Regular',
            ),



          ),
        );
    }
    else return Text('Null');
  }

  Widget displayOneExtraSauceItemInRecite(SauceItem oneSauceItemForHistoryDetailsPage, int index,int quantity){

    print('oneSauceItemForRecite.ingredientName: ${oneSauceItemForHistoryDetailsPage.sauceItemName}');

    if(oneSauceItemForHistoryDetailsPage.isDefaultSelected !=true) {
      return

        Container(
          padding:EdgeInsets.symmetric(vertical:0,horizontal: 6),
          child: Text('${((oneSauceItemForHistoryDetailsPage.sauceItemName == null) ||
              (oneSauceItemForHistoryDetailsPage.sauceItemName.length == 0)) ?
          '---' : oneSauceItemForHistoryDetailsPage.sauceItemName.length > 18 ?
          oneSauceItemForHistoryDetailsPage.sauceItemName.substring(0, 15) + '...' :
          oneSauceItemForHistoryDetailsPage.sauceItemName}, ',
            /*
            Text(
                '${oneSauceItemForRecite.sauceItemName} ',
                */

            textAlign: TextAlign.left,
            style: TextStyle(
//              fontWeight: FontWeight.bold,
              color: Colors.black,
//                        color: Color(0xffF50303),
              fontSize: 20,
//              fontFamily: 'Itim-Regular',
            ),

          ),
        );
    }
    else return Text('Null');
  }


  Widget displayOneExtraCheeseItemInRecite(CheeseItem oneCheeseItemForHistoryDetailsPage, int index,int quantity){

    print('oneCheeseItemForRecite.ingredientName: ${oneCheeseItemForHistoryDetailsPage.cheeseItemName}');
    if(oneCheeseItemForHistoryDetailsPage.isDefaultSelected !=true) {
      return
        Container(

          padding:EdgeInsets.symmetric(vertical:0,horizontal: 6),
          child: Text('${((oneCheeseItemForHistoryDetailsPage.cheeseItemName == null) ||
              (oneCheeseItemForHistoryDetailsPage.cheeseItemName.length == 0)) ?
          '---' : oneCheeseItemForHistoryDetailsPage.cheeseItemName.length > 18 ?
          oneCheeseItemForHistoryDetailsPage.cheeseItemName.substring(0, 15) + '...' :
          oneCheeseItemForHistoryDetailsPage.cheeseItemName}, ',
            textAlign: TextAlign.left,
            style: TextStyle(
//              fontWeight: FontWeight.bold,
              color: Colors.black,
//                        color: Color(0xffF50303),
              fontSize: 20,
//              fontFamily: 'Itim-Regular',
            ),

          ),
        );
    }
    else return Text('Null');
  }

// DUMMY RECITE RELATED PRINT CODES ARE HERE ==> LINE # 11264 ==>

//  showExtraIngredients(oneFood.selectedIngredients)
//  showExtraCheeseItems(oneFood.selectedCheeses)
//  showExtraSauces(oneFood.defaultSauces)

  Widget showExtraIngredients(List <NewIngredient> historyDetailPageIngrdients,int quantity){

    print('reciteIngrdients.length: ${historyDetailPageIngrdients.length}');
    return ListView.builder(

      scrollDirection: Axis.horizontal,
//      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: historyDetailPageIngrdients.length,


      itemBuilder: (_,int index) {
        return displayOneExtraIngredientInRecite(historyDetailPageIngrdients[index], index,quantity);
      },

    );

  }


  Widget showExtraCheeseItems(List<CheeseItem> historyDetailPageCheeseItems,int quantity){
    print('reciteCheeseItems.length: ${historyDetailPageCheeseItems.length}');
    return ListView.builder(

      scrollDirection: Axis.horizontal,
      reverse: false,
      shrinkWrap: false,
      itemCount: historyDetailPageCheeseItems.length,

      itemBuilder: (_,int index) {
        return displayOneExtraCheeseItemInRecite(historyDetailPageCheeseItems[index], index,quantity);
      },
    );
  }

  Widget showExtraSauces(List<SauceItem> historyDetailPageSauceItems,int quantity){
    print('reciteSauceItems.length: ${historyDetailPageSauceItems.length}');
    return ListView.builder(

      scrollDirection: Axis.horizontal,
      reverse: false,
      shrinkWrap: false,
      itemCount: historyDetailPageSauceItems.length,

      itemBuilder: (_,int index) {
        return displayOneExtraSauceItemInRecite(historyDetailPageSauceItems[index], index,quantity);
      },
    );
  }





  Widget displayCustomerInformationWidget(CustomerInformation customerForHistoryDetailsPage){



    print('customerForHistoryDetailsPage.address:  ===  ===>  ${customerForHistoryDetailsPage.address} |  |  |  |  |  |  |  |');

    return



// ADDRESS: BEGINS HERE.

      Column(
        children: [

          ((customerForHistoryDetailsPage.address!='')) ?

          Container(
            margin:EdgeInsets.fromLTRB(15,15,5,10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                Row(
                  children: [
                    Text('address: ',

                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 22,
//                        fontFamily: 'Itim-Regular',
                      ),
                    ),

                    Text(
                      '${((customerForHistoryDetailsPage.address == null) ||
                          (customerForHistoryDetailsPage.address.length == 0)) ?
                      '----' : customerForHistoryDetailsPage.address.length > 21 ?
                      customerForHistoryDetailsPage.address.substring(0, 18) + '_ _' :
                      customerForHistoryDetailsPage.address}',

                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 22,
//                        fontFamily: 'Itim-Regular',
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text('Flat: ',

                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 22,
//      fontFamily: 'Itim-Regular',
                      ),
                    ),

// 2 ends here.
                    Text('${customerForHistoryDetailsPage.flatOrHouseNumber}',

                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 22,
//                    fontFamily: 'Itim-Regular',
                      ),
                    ),
                  ],
                ),


                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'phone: ',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 22,
//                          fontFamily: 'Itim-Regular',
                        ),
                      ),
                      Text(
                        '${customerForHistoryDetailsPage.phoneNumber}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 22,
//                          fontFamily: 'Itim-Regular',
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),

          ):
          Container(
//            alignment: Alignment.center,

            margin:EdgeInsets.fromLTRB(15,15,5,10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text(
                  'phone: ',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 22,
//                    fontFamily: 'Itim-Regular',
                  ),
                ),
                Text(
                  '${customerForHistoryDetailsPage.phoneNumber}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 22,
//                    fontFamily: 'Itim-Regular',
                  ),
                ),

              ],
            ),
          ),

// PHONE: ENDS HERE.
        ],
      );

  }





  Widget continueShoppingButton(){

    ///sdfsdfsdf
    return
      RaisedButton(

          color:Color(0xff5D9EFF),
          highlightColor: Color(0xff525FFF),
          splashColor: Color(0xffB47C00),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          highlightElevation: 12,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(0xff707070),
              style: BorderStyle.solid,
//            width: 1,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),



//        clipBehavior: Clip.hardEdge,
//          splashColor: Color(0xffFEE295),
//          splashColor: Color(0xff739DFA),
//          highlightElevation: 12,

//          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//          clipBehavior: Clip.hardEdge,
//          highlightElevation: 12,
/*
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(5.0),
          ),
 */
//          disabledBorderColor: false,
/*
          borderSide: BorderSide(
            color: Color(0xffF83535),
            style: BorderStyle.solid,
            width: 3.6,
          ),

          */

          child:Container(

            width:displayWidth(context)/3,

            height: displayHeight(context)/24,
            padding: EdgeInsets.fromLTRB(0,0,0,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment
                  .center,
              children: <
                  Widget>[
//  SizedBox(width: 5,),



                Text(
                  'continue shopping'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight
                        .bold,
//                    color: Color(0xffF50303),
                    color: Colors.white,
                    fontSize: 22, fontFamily: 'Itim-Regular',),
                ),
              ],
            ),
          ),
          onPressed: () {

            FocusScopeNode currentFocus = FocusScope.of(
                context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
//                  Navigator.pop(context);

            }



            final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//                      final blocD =
//                          BlocProvider2.of(context).getFoodItemDetailsBlockObject;



            SelectedFood temp = blocD.getCurrentSelectedFoodDetails;

            print('temp is $temp');

            print('temp.selectedIngredients: ${temp.selectedIngredients}');
            print('temp.selectedCheeseItems: ${temp.selectedCheeseItems}');
            print('temp.selectedSauceItems:  ${temp.selectedSauceItems}');


            print('temp.unitPrice:  ${temp.unitPrice}');
            print('temp.unitPriceWithoutCheeseIngredientSauces: '
                ' ${temp.unitPriceWithoutCheeseIngredientSauces}');
            print('temp.quantity:  ${temp.quantity}');

            print('temp.foodItemSize:  ${temp.foodItemSize}');
            print('temp.subTotalPrice:  ${temp.subTotalPrice}');





            SelectedFood tempSelectedFood = (temp == null)? new SelectedFood():
            temp /*.selectedFoodInOrder.first*/;



// WE DON'T NEED TO CREATE THE ORDER OBJECT AND STORE SELECTED ITEMS, RATHER,
// WE JUST NEED TO SENT THE SELECTED ITEM IN FOOD GALLERY PAGE.
// FROM FOOD ITEM PAGE.


            print('CLEAR SUBSCRIPTION ... before going to food gallery page..');
            blocD.clearSubscription();

            return Navigator.pop(context,tempSelectedFood);

          }

      );
  }

  Widget moreIngredientsButton(){


    ///sdfsdfsdf
    return
      RaisedButton(

          color:Color(0xffFCF5E4),
          highlightColor: Color(0xff525FFF),
          splashColor: Color(0xffB47C00),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          highlightElevation: 12,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(0xff707070),
              style: BorderStyle.solid,
//            width: 1,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),



//        clipBehavior: Clip.hardEdge,
//          splashColor: Color(0xffFEE295),
//          splashColor: Color(0xff739DFA),
//          highlightElevation: 12,

//          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//          clipBehavior: Clip.hardEdge,
//          highlightElevation: 12,
/*
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(5.0),
          ),
 */
//          disabledBorderColor: false,
/*
          borderSide: BorderSide(
            color: Color(0xffF83535),
            style: BorderStyle.solid,
            width: 3.6,
          ),

          */



          child:Container(

            width:displayWidth(context)/3,

            height: displayHeight(context)/24,
            padding: EdgeInsets.fromLTRB(0,0,0,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment
                  .center,
              children: <
                  Widget>[
//  SizedBox(width: 5,),

                Container(
                  padding: EdgeInsets.fromLTRB(0,3,0,0),
                  child: Icon(
                    Icons.add,
                    size: 25.0,
//                    color: Color(0xffF50303),
                    color: Colors.black,
//        color: Color(0xffFFFFFF),
                  ),
                ),

                Text(
                  'more Ingredients'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight
                        .bold,
//                    color: Color(0xffF50303),
                    color: Colors.black,
                    fontSize: 22, fontFamily: 'Itim-Regular',),
                ),
              ],
            ),
          ),
          onPressed: () {
//                                                                        logger.i('s  =>   =>   => ','ss');


            setState(() {

// toggle..
              showUnSelectedIngredients = !showUnSelectedIngredients;
              showPressWhenFinishButton = !showPressWhenFinishButton;
//                        myAnimatedWidget2 = myAnimatedWidget1();
            });
            print(
                'xyz');
          }






      );
  }

  Widget pressToContinueInitialDetailPage(){

    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//    final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//    final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);
    return    Container(
      width:displayWidth(
          context) /
          3,

//        color:Colors.black54,
//      color:Colors.white,
//      color:Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <
            Widget>[

// MORE INGREDIENTS row BEGINS HERE.
          Container(


//            child: moreIngredientsButton(),

            child: continueShoppingButton(),




          ),




        ],
      ),
    );
  }

  Widget animatedWidgetMoreIngredientsButton(){

    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//    final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//    final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);
    return    Container(
      width:displayWidth(
          context) /
          3,

//        color:Colors.black54,
//      color:Colors.white,
      color:Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <
            Widget>[

// MORE INGREDIENTS row BEGINS HERE.
          Container(


            child: moreIngredientsButton(),




          ),




        ],
      ),
    );
  }



  Widget _buildOneUNSelected(NewIngredient unSelectedOneIngredient, int index
/*,
      List<NewIngredient> allUnSelected */
      ) {

//    print('index : $index');

//    print('unSelectedOneIngredient: ${unSelectedOneIngredient.ingredientName}');
//
//    logger.i("unSelectedOneIngredient: ",unSelectedOneIngredient.ingredientAmountByUser);


    int currentAmount = unSelectedOneIngredient.ingredientAmountByUser;

    String imageURLFinalNotSelected = (unSelectedOneIngredient.imageURL == '') ?
    'https://thumbs.dreamstime.com/z/smiling-orange-fruit-'
        'cartoon-mascot-character-holding-blank-sign-smiling-orange-'
        'fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
        : storageBucketURLPredicate + Uri.encodeComponent(unSelectedOneIngredient.imageURL) + '?alt=media';

//    logger.i("imageURLFinalNotSelected: ",imageURLFinalNotSelected);


    return Container(
        color: Color.fromRGBO(239, 239, 239, 0),
        padding: EdgeInsets.symmetric(
//                          horizontal: 10.0, vertical: 22.0),
            horizontal: 2.0, vertical: 2.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//                              SizedBox(height: 10),

            Container(

              width: displayWidth(context) /9,
              height: displayWidth(context) /8.8,
              padding:EdgeInsets.symmetric(vertical: 2,horizontal: 0),
//                                    height: displayWidth(context) * 0.19,

              child: ClipOval(

                child: CachedNetworkImage(
                  imageUrl: imageURLFinalNotSelected,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => new LinearProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Image.network(
                          'https://img.freepik.com/free-vector/404-error-design-with-donut_76243-30.jpg?size=338&ext=jpg'),
//                    https://img.freepik.com/free-vector/404-error-design-with-donut_76243-30.jpg?size=338&ext=jpg
//                    https://img.freepik.com/free-vector/404-error-page-found-with-donut_114341-54.jpg?size=626&ext=jpg

//                    errorWidget:(context,imageURLFinalNotSelected,'Error'),
                ),
              ),
            ),

            Container(
// TO Be
//          height:45, // same as the heidth of increment decrement button.
              width: displayWidth(context) /6.5,
              height: displayHeight(context) /36,

//              height:45,
//              alignment: Alignment.center,
// pp ToDOPPP

              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child:


//              stringifiedFoodItemIngredients.length==0?
//              'EMPTY':  stringifiedFoodItemIngredients.length>12?
//              stringifiedFoodItemIngredients.substring(0,12)+'...':
//              stringifiedFoodItemIngredients,
//

/*
              Text(
//                unSelectedOneIngredient.ingredientName,
                unSelectedOneIngredient.ingredientName.length==0?
                'EMPTY':  unSelectedOneIngredient.ingredientName.length>10?
                unSelectedOneIngredient.ingredientName.substring(0,10)+'...':
                unSelectedOneIngredient.ingredientName,
                style: TextStyle(
                  color:Color(0xff707070),
//                                    color: Colors.blueGrey[800],

                  fontWeight: FontWeight.normal,
                  fontSize: 17,
                ),

              ),
              */
              Text(unSelectedOneIngredient.ingredientName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:Color(0xff707070),
//                                    color: Colors.blueGrey[800],

                  fontWeight: FontWeight.normal,

                  fontSize: 14,
                ),

              ),
            ),


// PROBLEM CONTAINER WITH ROW. INCREMENT DECREMENT FUNCTIONALITY. -- BELOW.
            Container(
              margin:EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0
              ),


//                                              height: displayHeight(context) *0.11,
              height:displayHeight(context) /35,
              width: displayWidth(context) /6.9,
// same as the heidth of increment decrement button. // 45
// later changed height to 40.
              decoration: BoxDecoration(
//                                              color: Colors.black54,
                color:Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(25),

              ),


//                                            color:Color(0xffC27FFF),

              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  IconButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                    icon: Icon(Icons.add),
                    iconSize: 30,

//                      tooltip: 'Increase Ingredient count by 1',
                    onPressed: () {


                      print('Add button pressed in unselected Ing');


                      final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//                      final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//                      final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                      blocD.incrementThisIngredientItem(unSelectedOneIngredient);


//                      setState(() {
//                        _ingredientlistUnSelected= allUnSelected;
//                      });
                    },
                    color: Color(0xff707070),
                  ),



//      double.parse(doc['priceinEuro'])
//          .toStringAsFixed(2);
                  Text(
                    currentAmount.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),




                  IconButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                    icon: Icon(Icons.remove),
                    iconSize: 30,

//                      tooltip: 'Increase Ingredient count by 1',
                    onPressed: () {
                      print('Minus button pressed in unselected ing');
                      print('Decrease button pressed InkResponse');

                      if (currentAmount >=1) {
//                      if(currentAmount>=2)
//                      City c1 = new City()..name = 'Blum'..state = 'SC';

/*
                          NewIngredient c1 = new NewIngredient(
                              ingredientName: unSelectedOneIngredient
                                  .ingredientName,
                              imageURL: unSelectedOneIngredient.imageURL,

                              price: unSelectedOneIngredient.price,
                              documentId: unSelectedOneIngredient.documentId,
                              ingredientAmountByUser: unSelectedOneIngredient
                                  .ingredientAmountByUser - 1
                          );


                          allUnSelected[index] = c1;

                          */

                        final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//                        final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//                        final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                        blocD.decrementThisIngredientItem(unSelectedOneIngredient,index);

/*
                          setState(() {
                            // _ingredientlistUnSelected = allUnSelected;
                          });
                          */


//                      setState(() {
//                        _ingredientlistUnSelected= allUnSelected;
//                      });
                      }
                      else{
                        print('decrease button pressed '
                            'but nothing will happen since it is less than 1');
                      }
                    },
                    color: Color(0xff707070),
                  ),
                ],

              ),
            ),
// PROBLEM CONTAINER WITH ROW. INCREMENT DECREMENT FUNCTIONALITY. -- ABOVE.

          ],
        )

    );
  }




  Widget _buildProductSizes(BuildContext context, Map<String,dynamic> allPrices) {
    final Map<String, dynamic> foodSizePrice = allPrices;

    Map<String, dynamic> listpart1 = new Map<String, dynamic>();
//    Map<String, dynamic> listpart2 = new Map<String, dynamic>();
//    Map<String, dynamic> listpart3 = new Map<String, dynamic>();
// odd

    int len = foodSizePrice.length;
    print('len: $len');





    for (int i = 0; i < len; i++) {
      print('i: $i');
      String keyTest = foodSizePrice.keys
          .elementAt(i);
      dynamic value = foodSizePrice
          .values.elementAt(i);


//
      double valuePrice = tryCast<double>(value, fallback: 0.0);


      if((valuePrice!=0.0)&&(valuePrice!=0.00)) {
        listpart1[keyTest] = valuePrice;
      }
    }




    if(allPrices==null){
      return Container(
        height: displayHeight(context) / 9.8,
//          height:190,
        width: displayWidth(context) * 0.57,

        color: Color(0xFFffffff),
        alignment: Alignment.center,

// PPPPP

        child:
        Text('No prices found.'.toLowerCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Itim-Regular',
            color: Colors.white,

          ),


        ),
      );
    }
    else {

      return
/*Directionality(
        textDirection: TextDirection.rtl,
        child:  */GridView.builder(
        itemCount: listpart1.length,
        gridDelegate:
        new SliverGridDelegateWithMaxCrossAxisExtent(

//Above to below for 3 not 2 Food Items:
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 10, // H  direction
          crossAxisSpacing: 20,
          childAspectRatio: 190 / 50, /* (h/vertical)*/


        ),
        shrinkWrap: true,

//        reverse: true,
        itemBuilder: (_, int index) {


          String key = listpart1.keys
              .elementAt(index);
          double valuePrice = listpart1
              .values.elementAt(index);
//

//                  print(
//                      'valuePrice at line # 583: $valuePrice and key is $key');
          return _buildOneSize(
              key, valuePrice, index);
        },

      );


// Todo DefaultItemsStreamBuilder


    }
  }



  Widget oneMultiSelectInDetailsPageInitialView (FoodPropertyMultiSelect x,int index){


    String color1 = x.itemTextColor.replaceAll('#', '0xff');

    Color c1 = Color(int.parse(color1));

    String itemName = x.itemName;
    String itemImage2 = x.itemImage;


    return Container(



      child:  x.isSelected == true  ?
      Container(
        width:displayWidth(context)/14,
//        height:displayHeight(context)/48,
        height:displayHeight(context)/30,

        margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child:
        RaisedButton(
          color: c1,
          padding: EdgeInsets.all(0),
          elevation: 2.5,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color:c1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),

          child:Container(
              child: Image.asset(
                itemImage2,
                width: 43,
                height:43,
              )
          ),
          onPressed: () {


            final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
            blocD.setMultiSelectOptionForFood(x,index);

          },



        ),
      )


          :

      Container(
        width:displayWidth(context)/14,
        height:displayHeight(context)/30,

        margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: OutlineButton(
          padding: EdgeInsets.all(0),
          splashColor: c1,
          highlightElevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          borderSide: BorderSide(
            color:Color(0xff707070),
            style: BorderStyle.solid,
            width: 1.6,
          ),

          child: Container(
              child: Image.asset(
                itemImage2,
                width: 43,
                height:43,
              )
          ),
          onPressed: () {

            print('$itemName pressed');
            final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

            blocD.setMultiSelectOptionForFood(x,index);
          },


        ),
      ),




    );
  }















  Widget oneDefaultIngredient(NewIngredient oneIngredient,int index){
    final String ingredientName = oneIngredient.ingredientName;


    final dynamic ingredientImageURL = oneIngredient.imageURL == '' ?
    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2FfoodItem404.jpg?alt=media'
        :
    storageBucketURLPredicate +
        Uri.encodeComponent(oneIngredient.imageURL)

        + '?alt=media';





    return
      Container(

        decoration: BoxDecoration(
          color:Color(0xffFCF5E4),
          borderRadius: BorderRadius.all(Radius.circular(5)),
//
        ),


        margin: EdgeInsets.symmetric(
            horizontal: 18, vertical: 0),
        child: GestureDetector(

            onLongPressUp: (){

              print(
                  'at Long Press UP: ');

              final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);


              blocD.removeThisDefaultIngredientItem(oneIngredient,index);

            },


            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(

                  height: displayHeight(context) / 18,
                  width: displayWidth(context) /10.5,
//                      width: displayWidth(context) /10,
//                      height: displayWidth(context) /9,
                  padding:EdgeInsets.symmetric(vertical: 0,horizontal: 0),

                  child: ClipOval(

                    child: CachedNetworkImage(
//                        color: Colors.deepOrangeAccent,
//                        colorBlendMode: BlendMode.overlay ,
                      imageUrl: ingredientImageURL,
                      fit: BoxFit.cover,
                      placeholder: (context,
                          url) => new LinearProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2Fingredient404.jpg?alt=media'),
//
                    ),
                  ),
                ),

//                              SizedBox(height: 10),
                Container(
                  width: displayWidth(context) / 9,
                  child: Text(
                    ingredientName,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      color: Colors.black,
//                                    color: Colors.blueGrey[800],

                      fontWeight: FontWeight.normal,
                      fontSize: 14,
//                    decoration: TextDecoration.underline,
//                    decorationStyle:TextDecorationStyle.double,
                    ),
                  ),
                )



              ],
            ),
            onTap: () {
              print('for future use');

            }
        ),


      );




  }



  Widget _buildOneSize(String oneSize,double onePriceForSize, int index) {

    return Container(
//        color:Colors.yellow,

//        margin: EdgeInsets.fromLTRB(0, 0,5,5),
//        height:displayHeight(context)/50,


        child:  oneSize.toLowerCase() == _currentSize  ?

        Container(
//          margin: EdgeInsets.fromLTRB(0, 0,5,5),
          margin: EdgeInsets.fromLTRB(12,2,12,5),
//          padding: EdgeInsets.fromLTRB(12,2,12,5),
          width: displayWidth(context)/3.6,
          child:
          RaisedButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xffFFE18E),
//          color: Colors.lightGreen,
            elevation: 2.5,
            shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Color(0xffF7F0EC),
                style: BorderStyle.solid,

              ),
              borderRadius: BorderRadius.circular(35.0),
            ),

            child:Container(

//              alignment: Alignment.center,
              child: Text(
                oneSize.toUpperCase(), style:
              TextStyle(
//                  color:Color(0xff54463E),
                  color:Colors.black,

                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins-ExtraBold',
                  fontSize: 13),
              ),
            ),
            onPressed: () {

//              logger.i('onePriceForSize: ',onePriceForSize);

              final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

              blocD.setNewSizePlusPrice(oneSize);



            },



          ),
        )


            :

        Container(

//          margin: EdgeInsets.fromLTRB(0, 0,5,5),
          margin: EdgeInsets.fromLTRB(12, 5,12,5),
          width: displayWidth(context)/3.6,
          child:
          OutlineButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xffFEE295),
// clipBehavior:Clip.hardEdge,

            borderSide: BorderSide(
              color: Color(0xff53453D), // 0xff54463E
              style: BorderStyle.solid,
              width: 1.6,
            ),
            shape:RoundedRectangleBorder(


              borderRadius: BorderRadius.circular(35.0),
            ),
            child:Container(

//              alignment: Alignment.center,
              child: Text(
                oneSize.toUpperCase(), style:
              TextStyle(
                  color:Color(0xff54463E),

                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins-ExtraBold',
                  fontSize: 13),
              ),
            ),
            onPressed: () {



              final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

              blocD.setNewSizePlusPrice(oneSize);

            },
          ),
        )
    );
  }


}


//  FoodDetailImage









//LongHeaderPainterAfterShoppingCartPage
class LongHeaderPainterAfterShoppingCartPage extends CustomPainter {

  final BuildContext context;
  LongHeaderPainterAfterShoppingCartPage(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/1.6, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(10, 15);
    final paint = Paint()
      ..color = Color(0xff707070)
//          Colors.white
      ..strokeWidth = 1.6;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}
