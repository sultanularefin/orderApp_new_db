
// package/ external dependency files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/BLoC/HistoryDetailsBloc.dart';
import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
//import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';
import 'package:foodgallery/src/BLoC/history_bloc.dart';
import 'package:foodgallery/src/BLoC/shoppingCart_bloc.dart';

// BLOC'S IMPORT BEGIN HERE:
//import 'package:foodgallery/src/BLoC/shoppingCart_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
//import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';


// MODEL'S IMPORT BEGINS HERE.
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/Order.dart';



import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodgallery/src/screens/history/HistoryDetailsPage.dart';
import 'package:foodgallery/src/screens/shoppingCart/ShoppingCart.dart';

import 'package:logger/logger.dart';

import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

// Screen files.


// models, dummy data file:

import 'package:foodgallery/src/DataLayer/models/NewCategoryItem.dart';

// Blocks

import 'package:foodgallery/src/BLoC/bloc_provider.dart';
//import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';


class HistoryPage extends StatefulWidget {

  final Widget child;


  HistoryPage({Key key, this.child}) : super(key: key);
  _FoodGalleryState createState() => _FoodGalleryState();

}


class _FoodGalleryState extends State<HistoryPage> {

  final GlobalKey<ScaffoldState> _scaffoldKeyFoodGallery = new GlobalKey<ScaffoldState>();
  final SnackBar snackBar = const SnackBar(content: Text('Menu button pressed'));

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  _FoodGalleryState(/*{firestore} */);


  String _currentPageHeader = 'HISTORY';

  double tryCast<num>(dynamic x, {num fallback }) {
    bool status = x is num;

    if(status) {
      return x.toDouble() ;
    }
    if(x is int) {return x.toDouble();}
    else if(x is double) {return x.toDouble();}

    else return 0.0;
  }

  var logger = Logger(
    printer: PrettyPrinter(),
  );


  @override
  Widget build(BuildContext context) {

    final blocG = BlocProvider.of<HistoryBloc>(context);



// FOODLIST LOADED FROM FIRESTORE NOT FROM STATE HERE
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child:
      SafeArea(
        child:
        Scaffold(
          key: _scaffoldKeyFoodGallery,

          /*
          appBar: AppBar(
//          backgroundColor: Colors.deepOrange,

            toolbarHeight: 85,
            elevation: 0,
            titleSpacing: 0,
            shadowColor: Colors.white,
            backgroundColor: Color(0xffFFE18E),



            title:
            Container(
              height: displayHeight(context) / 14,
              width: displayWidth(context) - MediaQuery
                  .of(context)
                  .size
                  .width / 3.8,

              color: Color(0xffFFFFFF),

              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceAround,
                children: <Widget>[

                  SizedBox(
                    height: kToolbarHeight + 6, // 6 for spacing padding at top for .
                    width: 200,
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Container(

                          height: displayHeight(context) / 15,
//                                            color:Colors.blue,
                          child: Image.asset('assets/Path2008.png'),

                        ),
                        Container(

                          margin: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 0),

//                                          width: displayWidth(context) / 6,
                          height: displayHeight(context) / 15,
//                                            color:Colors.red,
                          child:

//                                          Container(child: Image.asset('assets/Path2008.png')),
                          Container(
                            padding:EdgeInsets.fromLTRB(0,1,0,0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Jediline',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 30,
                                      color: Color(0xff07D607),
                                      fontFamily: 'Itim-Regular'),
                                ),
                                Text(
                                  'Online Orders',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16.42,color: Color(0xff07D607)),
                                ),
                              ],
                            ),
                          ),


                        ),

                      ],
                    ),
                  ),


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
                        width: 3,


                      ),

                      boxShadow: [
                        BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                            color: Color(0xffFFFFFF),
                            blurRadius: 25.0,
                            // USER INPUT
                            offset: Offset(0.0, 2.0))
                      ],


                      color: Color(0xffFFFFFF),
//                                      Colors.black54
                    ),
                    // USER INPUT


//                                  color: Color(0xffFFFFFF),
                    width: displayWidth(context) / 3.3,
                    height: displayHeight(context) / 27,
                    padding: EdgeInsets.only(
                        left: 4, top: 3, bottom: 3, right: 3),
                    child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisAlignment: MainAxisAlignment
                          .spaceAround,
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: <Widget>[
                        Container(

                          height:displayWidth(context)/34,
//                                          height: 25,
                          width: 5,
                          margin: EdgeInsets.only(left: 0,right:15,bottom: 5),


                          // work 1
                          child: Icon(
//                                          Icons.add_shopping_cart,
                            Icons.search,
//                                            size: 28,
                            size: displayWidth(context)/24,
                            color: Color(0xffBCBCBD),
                          ),


                        ),

                        Container(

                          alignment: Alignment.center,
                          width: displayWidth(context) / 4.7,
//                                        color:Colors.purpleAccent,
                          // do it in both Container
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
//
                            ),
                            onChanged: (text) {
//                                              logger.i('on onChanged of condition 4');

                              setState(() =>
                              _searchString = text);
                              print(
                                  "First text field from Condition 04: $text");
                            },
                            onTap: () {
                              print('condition 4');
//                                              logger.i('on Tap of condition 4');
                              setState(() {
                                _firstTimeCategoryString =
                                'PIZZA';
                              });
                            },

                            onEditingComplete: () {
//                                              logger.i('onEditingComplete  of condition 4');
                              print(
                                  'called onEditing complete');
                              setState(() =>
                              _searchString = "");
                            },

                            onSubmitted: (String value) async {
                              await showDialog<void>(
                                context: context,
                                builder: (
                                    BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Thanks!'),
                                    content: Text(
                                        'You typed "$value".'),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),

                        )

//                                  Spacer(),

//                                  Spacer(),

                      ],
                    ),
                  ),


                  Container(



                    child: shoppingCartWidget(context), // CLASS TO WIDGET SINCE I NEED TO INVOKE THE

                  ),
                ],
              ),
            ),

          ),



          */


          body:
          SingleChildScrollView(
            child: Container(
//              color:Colors.lightGreenAccent,
                child:

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

//                #### 1ST CONTAINER SEARCH STRING AND TOTAL ADD TO CART PRICE.
                    Container(
//                      color:Colors.red,
                      width: displayWidth(context)-40,
                      height: displayHeight(context) + kToolbarHeight + 10,
                      child: allHistoryList(_currentPageHeader, context),

                    ),


                  ]
                  ,)

            ),
          ),

        ),
      ),
    );
  }




  String titleCase(var text) {
    // print("text: $text");
    if (text is num) {
      return text.toString();
    } else if (text == null) {
      return '';
    } else if (text.length <= 1) {
      return text.toUpperCase();
    } else {
      return text
          .split(' ')
          .map((word) => word[0].toUpperCase() + word.substring(1))
          .join(' ');


    }
  }


  String listTitleCase(List<dynamic> dlist) {

    List<String> stringList = List<String>.from(dlist);
    if (stringList.length==0) {
      return " ";
    } else if (stringList == null) {
      return ' ';
    }


    // print("text: $text");
    if (stringList.length==0) {
      return " ";
    } else if (stringList == null) {
      return ' ';
    }


    else {
      return stringList
          .map((word) => word.toString().split(' ')
          .map((word2) => titleCase(word2)).join(' '))
          .join(', ');

    }

  }


  Widget allHistoryList(String pageHeaderString,BuildContext context)  {

    final blocH = BlocProvider.of<HistoryBloc>(context);

    return Container(

      child:
        StreamBuilder<List<OneOrderFirebase>>(
          stream: blocH.getFirebaseOrderListStream,
          initialData: blocH.getAllFirebaseOrderList,

        builder: (context, snapshot) {

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
//          print('snapshot.hasData FG2 : ${snapshot.hasData}');

            default:
              if (!snapshot.hasData) {
                return Container(
                  margin: EdgeInsets.fromLTRB(
                      0, displayHeight(context) / 2, 0, 0),
                  child: Center(
                    child: Column(
                      children: <Widget>[

                        Center(
                          child: Container(
                              alignment: Alignment.center,
                              child: Text('....')
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
              }

              else {

                print('categoryString  ##################################: $pageHeaderString');

                final List<OneOrderFirebase> allFoods = snapshot.data;




                  final int categoryItemsCount = allFoods.length;
                  print('categoryItemsCount: $categoryItemsCount');


                  return
                    Column(
                      children: <Widget>[

                        Container(


                          height: displayHeight(context) / 20,
                          color: Color(0xffffffff),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                Spacer(),
                                CustomPaint(size: Size(0, 19),
                                  painter: LongHeaderPainterBefore(context),
                                ),
                                Text('$_currentPageHeader'.toUpperCase(),
                                  style:
                                  TextStyle(

                                    // fontFamily: 'Itim-Regular',
                                    // fontFamily: 'Poppins-ExtraBold',
                                    fontSize: 30,
                                    fontWeight: FontWeight.normal,
//                    fontStyle: FontStyle.italic,
                                    color: Color(0xff000000),
                                  ),
                                ),
                                CustomPaint(size: Size(0, 19),
                                  painter: LongHeaderPainterAfter(context),
                                ),
                                Spacer(),
                              ]
                          ),


                        ),
                        Container(

                          child: fireBaseOrderListNoSearch(
                              allFoods, context),
                        ),


                      ],

                    );
                }


          }

        },
      ),
    );
  }

//  child: fireBaseOrderListNoSearch(context),
//
//  Widget fireBaseOrderListNoSearch(BuildContext context)  {


  /*
  *
  * Container(
                        color:Colors.red,
                        //sss
                        width: 70,
                        height:70,
                        child: Image.asset(
                          oneOrderForReceipt.paidType.toLowerCase() == 'card' ?
                          'assets/unpaid_cash_card/card.png'
                              :oneOrderForReceipt.paidType.toLowerCase() == 'cash'?
                          'assets/unpaid_cash_card/cash.png':'assets/unpaid_cash_card/unpaid.png',

//                color: Colors.black,
                          width: 50,
                          height:50,

                        ),
                      ),
  * */
  Widget fireBaseOrderListNoSearch(List<OneOrderFirebase> filteredItemsByCategory,BuildContext context)  {

    return Container(
      height: displayHeight(context) -
          MediaQuery
              .of(context)
              .padding
              .top -MediaQuery
          .of(context)
          .padding
          .bottom,

      child: GridView.builder(
        itemCount: filteredItemsByCategory.length,
        gridDelegate:
        new SliverGridDelegateWithMaxCrossAxisExtent(

          //Above to below for 3 not 2 Food Items:
          maxCrossAxisExtent: 240,
          mainAxisSpacing: 0, // H  direction
//          crossAxisSpacing: 5, // horizontal padding error check image snpashot for details in august 10.
          childAspectRatio: 140 / 180,


        ),
        shrinkWrap: false,

        itemBuilder: (_, int index) {

          final String orderType2 = filteredItemsByCategory[index].orderType;
          final String paidStatus2 = filteredItemsByCategory[index].paidStatus;

          final String formattedOrderPlacementDate2 = filteredItemsByCategory[index]
              .formattedOrderPlacementDate;

          final String formattedOrderPlacementDatesTimeOnly2 = filteredItemsByCategory[index].
          formattedOrderPlacementDatesTimeOnly;
          final String orderBy2 = filteredItemsByCategory[index].
          orderBy;



          String itemImage2 = (orderBy2.toLowerCase() == 'delivery') ?
          'assets/orderBYicons/delivery.png' :
            (orderBy2.toLowerCase() == 'phone') ?
                'assets/phone.png': (orderBy2.toLowerCase() == 'takeaway')
                ? 'assets/orderBYicons/takeaway.png'
              : 'assets/orderBYicons/diningroom.png';


          String documentID = filteredItemsByCategory[index].documentId;




          OneOrderFirebase oneFoodItem = new  OneOrderFirebase(

            formattedOrderPlacementDatesTimeOnly: formattedOrderPlacementDatesTimeOnly2,
            formattedOrderPlacementDate: formattedOrderPlacementDate2,
            orderType: orderType2,
            paidStatus: paidStatus2,
          );



          return
            Container(

                color: Color(0xffFFFFFF),
//            color:Colors.lightGreenAccent,
                padding: EdgeInsets.symmetric(
                    horizontal: 4.0, vertical: 16.0),
                child: InkWell(
                  child: Column(

                    children: <Widget>[
                      new Container(child:
                      new Container(
                        width: displayWidth(context) / 7,
                        height: displayWidth(context) / 7,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(

//                                color: Color(0xff707070),
                                color: Color(0xffEAB45E),
// adobe xd color
//                                              color: Color.fromRGBO(173, 179, 191, 1.0),
                                blurRadius: 25.0,
                                spreadRadius: 0.10,
                                offset: Offset(0, 10)
                            )
                          ],
                        ),
                        child: Hero(
                          tag: orderType2,
                          child:
                          ClipOval(
                            child: Image.asset(
                            itemImage2,
                            width: 43,
                            height:43,
                          ),
                          ),
                          placeholderBuilder: (context,
                              heroSize, child) {
                            return Opacity(
                              opacity: 0.5, child: Container(
                              width: displayWidth(context) / 7,
                              height: displayWidth(context) / 7,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(

                                      color: Color(0xffEAB45E),

                                      blurRadius: 25.0,
                                      spreadRadius: 0.10,
                                      offset: Offset(0, 10)
                                  )
                                ],
                              ),
                              child:
                              ClipOval(
                                child: Image.asset(
                                  itemImage2,
                                  width: 43,
                                  height:43,
                                ),
                              ),
                            ),
                            );
                          },

                          //Placeholder Image.network(foodImageURL),
                        ),

                      ),

                        padding: const EdgeInsets.fromLTRB(
                            0, 0, 0, 6),
                      ),
//                              SizedBox(height: 10),



                            Text(
//                                  double.parse(euroPrice).toStringAsFixed(2),
                              paidStatus2,
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w600,
//                                          color: Colors.blue,
                                  color: Color.fromRGBO(
                                      112, 112, 112, 1),
                                  fontSize: 15),
                            ),

                      Container(

                          child: Text(

                            formattedOrderPlacementDate2 + ' ' + formattedOrderPlacementDatesTimeOnly2,

//                                    foodItemIngredients.substring(0,10)+'..',
                            style: TextStyle(
                              color: Color(0xff707070),
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0.5,
                              fontSize: 12,
                            ),
                          )
                      ),
//
//
                    ],
                  ),
                  onTap: () {
                    _navigateAndDisplaySelection(
                        context, oneFoodItem);
                  },


                )
            );
//            return SpoiledItem(/*dummy: snapshot.data[index]*/);
        },

      ),
    );
  }



  _navigateAndDisplaySelection(BuildContext context,OneOrderFirebase oneFirebaseOrderItem) async {


    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    final blocG = BlocProvider.of<FoodGalleryBloc>(context);

    List<NewIngredient> tempIngs = blocG.getAllIngredientsPublicFGB2;

    List<CheeseItem> tempCheeseItems = blocG.getAllCheeseItemsFoodGallery;
    List<SauceItem>  tempSauceItems = blocG.getAllSauceItemsFoodGallery;
    List<NewIngredient> allExtraIngredients = blocG.getAllExtraIngredients;


    return Navigator.of(context).push(


      PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(
            milliseconds: 900),
        pageBuilder: (_, __, ___) =>
            BlocProvider<HistoryDetailsBloc>(
          bloc: HistoryDetailsBloc(
            oneFirebaseOrderItem,
          ),
          child: HistoryDetailsPage()

          ,),

      ),
    );

  }

// HELPER METHOD tryCast Number (1)
  int test1(SelectedFood x) {

    return x.quantity ;
  }

}










class MyPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(50, 20);
    final p2 = Offset(5, 20);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}


class LongHeaderPainterAfter extends CustomPainter {

  final BuildContext context;
  LongHeaderPainterAfter(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/4, 15); //(X,Y) TO (X,Y)
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