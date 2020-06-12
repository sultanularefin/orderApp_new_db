// package/ external dependency files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/BLoC/app_bloc.dart';
import 'package:foodgallery/src/BLoC/bloc_provider2.dart';
import 'package:foodgallery/src/BLoC/identity_bloc.dart';

import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/Order.dart';
import 'package:foodgallery/src/screens/foodItemDetailsPage/foodItemDetails2.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:foodgallery/src/screens/drawerScreen/drawerScreen.dart';

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodgallery/src/welcomePage.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
//import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphic/neumorphic.dart';

//C:/src/flutter/.pub-cache/hosted/pub.dartlang.org/neumorphic-0.3.0/lib/src/components/neu_card.dart
// local packages

import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:foodgallery/src/screens/foodItemDetailsPage/foodItemDetails.dart';
//import 'package:shared_preferences/shared_preferences.dart';

// Screen files.


// models, dummy data file:

import '../../DataLayer/itemData.dart';
import '../../DataLayer/FoodItem.dart';
import '../../DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/newCategory.dart';

// Blocks

import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
//import 'package:foodgallery/src/BLoC/foodItems_query_bloc.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';

//import './../../shared/category_Constants.dart' as Constants;


//import CategoryItems from 'package:foodgallery/src/shared/category_Constants.dart';


final Firestore firestore = Firestore();



class FoodGallery2 extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;

  final Firestore firestore = Firestore.instance;

  FoodGallery2({Key key, this.child}) : super(key: key);

  _FoodGalleryState createState() => _FoodGalleryState();

}


class _FoodGalleryState extends State<FoodGallery2> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  _FoodGalleryState({firestore});

//  File _image;

//  List<NewCategoryItem>_allCategoryList=[];


  // List<NewIngredient> _allIngredientState=[];

  /*
  @override
  void initState() {
//    setAllIngredients();
    super.initState();

  }



  // !(NOT) NECESSARY NOW.
  Future<void> setAllIngredients() async {

    debugPrint("Entering in retrieveIngredients1");

//    final bloc = BlocProvider.of<FoodGalleryBloc>(context);

//    final identityBlocInvokerAppBlockWelcomPageInitState = BlocProvider2.of(context).getIdentityBlocsObject;
    final bloc = BlocProvider2.of(context).getIdentityBlocsObject;

    await bloc.getAllIngredients();
    List<NewIngredient> test = bloc.allIngredients;

//    print(' ^^^ ^^^ ^^^ ^^^ ### test: $test');

    print('done: ');

//    dynamic normalPrice = oneFoodItemandId.sizedFoodPrices['normal'];
//    double euroPrice1 = tryCast<double>(normalPrice, fallback: 0.00);

    setState(()
    {
      print('_allIngredientState: $test');
      _allIngredientState = test;
//      priceByQuantityANDSize = euroPrice1;
//      initialPriceByQuantityANDSize = euroPrice1;
    }
    );



  }

  */




  //  final _formKey = GlobalKey();

  final _formKey = GlobalKey<FormState>();



  String _searchString = '';
  String _currentCategory = "pizza";
  String _firstTimeCategoryString = "";
//  double _total_cart_price = 1.00;
  // empty MEANS PIZZA



  Widget _buildCategoryRow(/*DocumentSnapshot document*/
      NewCategoryItem oneCategory, int index) {

//    final DocumentSnapshot document = snapshot.data.documents[index];
    final String categoryName = oneCategory.categoryName;
//    final String categoryName = document['name'];

//    final DocumentSnapshot document = snapshot.data.documents[index];
//    final String categoryName = document['name'];
    if (_currentCategory.toLowerCase()==categoryName.toLowerCase()){
      return

        ListTile(

          contentPadding: EdgeInsets.fromLTRB(10, 6, 10, 6),
//    FittedBox(fit:BoxFit.fitWidth, stringifiedFoodItemIngredients
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(categoryName.toLowerCase(), style:
                TextStyle(

                  fontFamily: 'Itim-Regular',
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
//                    fontStyle: FontStyle.italic,
                  color: Color(0xff000000),
                ),


//                    'Reross Quadratic',


                ),CustomPaint(size: Size(0,19),
                  painter: MyPainter(),
                )
              ]
          ),
          onTap: () { // Add 9 lines from here...
            print('onTap pressed');
            print('index: $index');
            setState(() {
              _currentCategory = categoryName;
              _firstTimeCategoryString =categoryName;
            });
          }, // ... to here.
        )
      ;
    }
    else {
      return ListTile(
        contentPadding: EdgeInsets.fromLTRB(10, 6, 10, 6),

        title:  Text(categoryName.toLowerCase(),
//    Text(categoryName.substring(0, 2),
          style: TextStyle(

            fontFamily: 'Itim-Regular',

            fontSize: 24,
            fontWeight: FontWeight.normal,
//                    fontStyle: FontStyle.italic,
            color: Color(0xff000000),
          ),

        ),
        onTap: () { // Add 9 lines from here...
          print('onTap pressed');
          print('index: $index');
          setState(() {
            _currentCategory = categoryName;
            _firstTimeCategoryString =categoryName;
          });
        }, // ... to here.
      );
    }

  }


  num tryCast<num>(dynamic x, {num fallback }) => x is num ? x : 0.0;


  var logger = Logger(
    printer: PrettyPrinter(),
  );




  Future<void> logout(BuildContext context2) async {
    print('what i do is : ||Logout||');



//    _scaffoldKey.currentState.showSnackBar(
//    ABOVE ONE ALSO WORKS



    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
//    THIS ALSO WORKS
    /*
    Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => WelcomePage()),
    );
    */


//    return Navigator.push(context,
//
//        MaterialPageRoute(builder: (context)
//        => FoodItemDetails(oneFoodItemData:oneFoodItem))
//    );


    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) {

          return BlocProvider<IdentityBloc>(
              bloc: IdentityBloc(),
              //AppBloc(emptyFoodItemWithDocID,loginPageIngredients,fromWhichPage:0),
              child: WelcomePage(fromWhicPage:'foodGallery2')
          );
          /*
                                  return BlocProvider<FoodGalleryBloc>(
                                      bloc: FoodGalleryBloc(),
                                      child: FoodGallery2()

                                  );
                                  */

        }),(Route<dynamic> route) => false);


  }


  @override
  Widget build(BuildContext context) {
//    String a = Constants.SUCCESS_MESSAGE;

//    final bloc = BlocProvider.of<FoodGalleryBloc>(context);


//    final bloc = BlocProvider.of<FoodGalleryBloc>(context);
    final bloc = BlocProvider2.of(context).getFoodGalleryBlockObject;

//    final foodItemDetailsBlocForOrderProcessing = BlocProvider.of<FoodItemDetailsBloc>(context);



//    List<NewIngredient> testIngs =  bloc.allIngredients;

//    print('testIngs: $testIngs');

    /*
    List<NewIngredient> favorites =((testIngs==null) ||(testIngs.length==0))
//    (snapshot.connectionState == ConnectionState.waiting)
        ? bloc.favorites
        : testIngs;


    */

// FOODLIST LOADED FROM FIRESTORE NOT FROM STATE HERE
    return  GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child:
      Scaffold(
        key: _scaffoldKey,
//          backgroundColor: Colors.purpleAccent,

//      resizeToAvoidBottomPadding: false ,
        // appBar: AppBar(title: Text('Food Gallery')),
        body:
        SafeArea(
          child:SingleChildScrollView(
              child:

              Row(

                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[


//                #### 1ST CONTAINER SEARCH STRING AND TOTAL ADD TO CART PRICE.

                  Expanded(
                      child: Column(

                          mainAxisAlignment: MainAxisAlignment.start,

                          children: <Widget>[

                            Container(
                              height:displayHeight(context)/14,
                              color: Color(0xffFFFFFF),
//                      color: Color.fromARGB(255, 255,255,255),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  Container(
                                    margin:EdgeInsets.symmetric(
                                        horizontal: 9,
                                        vertical: 0),

                                    width: displayWidth(context)/5,
                                    height: displayHeight(context)/21,
                                    child: Image.asset('assets/Group520.png'),

                                  ),
                                  // CONTAINER FOR TOTAL PRICE CART BELOW.


                                  Container(
                                    margin:EdgeInsets.symmetric(
                                        horizontal: 0,
                                        vertical: 0),
                                    decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(

                                        color: Color(0xffBCBCBD),
                                        style: BorderStyle.solid,
                                        width: 1.0,


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
                                    width: displayWidth(context)/3,
                                    height: displayHeight(context)/27,
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
                                            Icons.search,
                                            size: 28,
                                            color: Color(0xffBCBCBD),
                                          ),


                                        ),

                                        Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                          alignment: Alignment.center,
                                          width:displayWidth(context)/4,
//                                        color:Colors.purpleAccent,
                                          // do it in both Container
                                          child: TextField(
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Search about meal',

//                                        labelText: 'Search about meal.'
                                            ),
                                            onChanged: (text) {
//                                              logger.i('on onChanged of condition 4');

                                              setState(() => _searchString = text);
                                              print("First text field from Condition 04: $text");
                                            },
                                            onTap:(){
                                              print('condition 4');
//                                              logger.i('on Tap of condition 4');
                                              setState(() {
                                                _firstTimeCategoryString ='PIZZA';
                                              });

                                            },

                                            onEditingComplete: (){
//                                              logger.i('onEditingComplete  of condition 4');
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
                                          ),

                                        )

//                                  Spacer(),

//                                  Spacer(),

                                      ],
                                    ),
                                  ),

                                  /*
                                  Container(
                                    margin:EdgeInsets.symmetric(
                                        horizontal: 0,
                                        vertical: 0),
                                    width: displayWidth(context)/9,
                                    height: displayHeight(context)/27,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 3, bottom: 3, right: 3),
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      size: 28,
                                      color: Color(0xff54463E),
                                    ),
                                  ),

                                  */


                                  /*
                                     StreamBuilder<Order>(
                  stream: foodItemDetailsbloc.getCurrentOrderStream,
                  initialData: foodItemDetailsbloc.getCurrentOrderFoodDetails,
                builder: (context, snapshot) {
                  if ((snapshot.hasError) || (!snapshot.hasData)) {
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('WRNG'),
                      ),
                    );
                  }
                  else {
                                   */


                                  Container(
                                    /*
                                      height:displayHeight(context) -
                                        MediaQuery.of(context).padding.top  - displayHeight(context)/13,
                                    padding: EdgeInsets.fromLTRB(
                                        20, 0, 10, 0),
                                    */
                                    // FOR CATEGORY SERARCH.

                                    child: ShoppingCartClass(

                                      /*
                                        categoryString: _currentCategory,
                                        searchString2:_searchString,
                                        allIngredients:_allIngredientState
                                        */
                                    ),

                                    // FOR SEARCHING AMONG ALL THE CATEGORIES.
//                              child: FoodList(searchString2:_searchString),


                                  ),
//                                  ShoppingCartClass(),





                                ],
                              ),
                            ),

                            Container(
                              height:displayHeight(context)/20,
                              color: Color(0xffffffff),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[

                                    Spacer(),
                                    CustomPaint(size: Size(0, 19),
                                      painter: LongHeaderPainterBefore(context),
                                    ),
                                    Text('$_currentCategory'.toLowerCase(),
                                      style:
                                      TextStyle(

                                        fontFamily: 'Itim-Regular',
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
                              /*
                              child:Text('$_currentCategory'.toLowerCase(),
                                style: GoogleFonts.itim(
                                  textStyle: Theme.of(context).textTheme.display1,
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
//                    fontStyle: FontStyle.italic,
                                  color: Color(0xff000000),
                                ),

                              ),
                              */

                            ),

                            // CONTAINER FOR TOTAL PRICE CART ABOVE.
                            Container(
                              height:displayHeight(context) -
                                  MediaQuery.of(context).padding.top  - displayHeight(context)/13,
                              padding: EdgeInsets.fromLTRB(
                                  20, 0, 10, 0),
                              // FOR CATEGORY SERARCH.

                              child: FoodList(
                                  categoryString: _currentCategory,
                                  searchString2:_searchString,/*allIngredients:_allIngredientState */),

                              // FOR SEARCHING AMONG ALL THE CATEGORIES.
//                              child: FoodList(searchString2:_searchString),


                            ),

                          ]
                      )
                  ),

                  Container(
                    height: displayHeight(context) -
                        MediaQuery.of(context).padding.top + displayHeight(context)/20 ,

//                          color: Color.fromARGB(255, 84, 70, 62),
//              child:Text('ss'),

                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding:EdgeInsets.only(top:20,right: 20,bottom: 0,left:0 ),
//                        height:100,
                          height:displayHeight(context)/13,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 3.8,
//              color: Colors.yellowAccent,
//                    color: Color(0xff54463E),
                          color: Color(0xffFFE18E),

                          alignment: Alignment.topRight,
                          child:IconButton(
                            onPressed: () async  {
                              print(
                                  'Menu button pressed');

//                              Scaffold.of(context).showSnackBar(
                                  _scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(
                                    action: SnackBarAction(
                                      label: ' Signed out Undo',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),

                                    duration: new Duration(seconds: 5),

                                    content:
                                  new Row(
                                    children: <Widget>[
                                      new CircularProgressIndicator(),
                                      new Text("Signed out...",style:TextStyle(
                                        color: Colors.white38,
                                      ))
                                    ],
                                  ),
                                  )
                              );



                              await logout(context);

//                              work 0


                            },
                            icon: const Icon(Icons.menu, size: 32.0),
//                            color: Colors.grey,
                            color: Color(0xff54463E),

                            tooltip: MaterialLocalizations
                                .of(context)
                                .openAppDrawerTooltip,
                          ),

                        ),


                        Container(
                          height:displayHeight(context) -
                              MediaQuery.of(context).padding.top  - displayHeight(context)/13,
//                          height:800,
//                          padding:EdgeInsets.symmetric(horizontal: 0,vertical: displayHeight(context)/13),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 3.8,
//              color: Colors.yellowAccent,
//                    color: Color(0xff54463E),
                          color: Color(0xffFFE18E),

                          child:StreamBuilder<List<NewCategoryItem>>(

                              stream:bloc.categoryItemsStream,
                              initialData: bloc.allCategories,
//        initialData: bloc.getAllFoodItems(),
                              builder: (context, snapshot){

                                if (!snapshot.hasData) {
                                  return Center(child: new LinearProgressIndicator());
                                }
                                else{
                                  final List allCategories =snapshot.data;
//                                  logger.i('allCategories.length:', allCategories.length);


//                                  _allCategoryList.add(All);



//                                  allCategories.add(all);
//                                  logger.i('allCategories.length after :', allCategories.length);

                                  final int categoryCount = allCategories.length;


//                              print('categoryCount in condition 04: ');


//                                logger.i("categoryCount in condition 04: $categoryCount");

                                  return(
                                      new ListView.builder
                                        (
                                          itemCount: categoryCount,



                                          //    itemBuilder: (BuildContext ctxt, int index) {
                                          itemBuilder: (_, int index) {


//                                            return (Text('ss'));


                                            return _buildCategoryRow(allCategories[index]
                                                /*categoryItems[index]*/, index);

                                          }
                                      )
                                  )
                                  ;
                                }
                              }
                          ),
                        ),

                      ],
                    ),
                  ),
                ]
                ,)

          ),
        ),
      ),
    );


  }


}


class ShoppingCartClass extends StatelessWidget {


//  final String categoryString;
//  final String searchString2;
//  final List<NewIngredient> allIngredients;

  ShoppingCartClass(
      /*{this.categoryString, this.searchString2 ,this.allIngredients } */);

  final logger = Logger(
    printer: PrettyPrinter(),
  );


  @override
  Widget build(BuildContext context) {
//    final bloc = LocationQueryBloc();

//    final blocZZ = FoodItemsQueryBloc();

    final foodItemDetailsBlocForOrderProcessing = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//    final foodItemDetailsBlocForOrderProcessing = BlocProvider.of<
//        FoodItemDetailsBloc>(context);
//    final bloc = BlocProvider.of<FoodGalleryBloc>(context);


    /*
Widget work1(BuildContext context){
  BlocProvider(
    bloc: ,
    child: ,
//
  )

  */
    return StreamBuilder<Order>(
        stream: foodItemDetailsBlocForOrderProcessing.getCurrentOrderStream,
        initialData: foodItemDetailsBlocForOrderProcessing
            .getCurrentOrderFoodDetails,

        builder: (context, snapshot) {
          if ((snapshot.hasError) || (!snapshot.hasData)) {
//            logger.e('no Order data fetched');

//                                          return Center(child: new LinearProgressIndicator());
            int selectedFoodsForOrderLength = 0;

            print('selectedFoodsForOrderLength: $selectedFoodsForOrderLength');
            return Container(
//                                                                        width:60,
              width: displayWidth(
                  context) / 13,
              height: displayHeight(context) / 25,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),

              child: OutlineButton(
                onPressed: () {
                  print(
                      ' method for old Outline button that deals with navigation to Shopping Cart Page');
                },
//                        color: Color(0xffFEE295),
                clipBehavior: Clip.hardEdge,
                splashColor: Color(0xffFEE295),
//          splashColor: Color(0xff739DFA),
                highlightElevation: 12,
//          clipBehavior: Clip.hardEdge,
//          highlightElevation: 12,
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(35.0),
                ),
//          disabledBorderColor: false,
                borderSide: BorderSide(
                  color: Color(0xffFEE295),
                  style: BorderStyle.solid,
                  width: 3.6,
                ),


                child:

                ///SSWW


                Center(
                  child: Stack(
                      children: <Widget>[ Center(
                        child: Icon(

                          Icons.add_shopping_cart,
                          size: 40,
                          color: Color(0xff707070),
                        ),
                      ),

                        Container(
//                                              color:Colors.red,
                          width: 30,


                          decoration: new BoxDecoration(
                            color: Colors.redAccent,

                            border: new Border.all(
                                color: Colors.green,
                                width: 1.0,
                                style: BorderStyle.solid
                            ),
                            shape: BoxShape.circle,

                          ),

                          alignment: Alignment.center,
                          child: Text(
                            selectedFoodsForOrderLength.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight
                                  .normal,
                              fontSize: 20,
                            ),
                          ),

                        ),

                      ]
                  ),
                ),

              ),
            );
          }
          else {
            Order sessionedOrder = snapshot.data;

//            logger.e('sessionedOrder TTTT: $sessionedOrder');

            int selectedFoodsForOrderLength = sessionedOrder.selectedFoodInOrder
                .length;

            print('selectedFoodsForOrderLength: $selectedFoodsForOrderLength');
            return Container(
//                                                                        width:60,
              width: displayWidth(
                  context) / 13,
              height: displayHeight(context) / 25,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),

              child: OutlineButton(
                onPressed: () {
                  print(
                      ' method for old Outline button that deals with navigation to Shopping Cart Page');
                },
//                        color: Color(0xffFEE295),
                clipBehavior: Clip.hardEdge,
                splashColor: Color(0xffFEE295),
//          splashColor: Color(0xff739DFA),
                highlightElevation: 12,
//          clipBehavior: Clip.hardEdge,
//          highlightElevation: 12,
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(35.0),
                ),
//          disabledBorderColor: false,
                borderSide: BorderSide(
                  color: Color(0xffFEE295),
                  style: BorderStyle.solid,
                  width: 3.6,
                ),


                child:

                ///SSWW


                Center(
                  child: Stack(
                      children: <Widget>[ Center(
                        child: Icon(

                          Icons.add_shopping_cart,
                          size: 40,
                          color: Color(0xff707070),
                        ),
                      ),

                        Container(
//                                              color:Colors.red,
                          width: 30,


                          decoration: new BoxDecoration(
                            color: Colors.redAccent,

                            border: new Border.all(
                                color: Colors.green,
                                width: 1.0,
                                style: BorderStyle.solid
                            ),
                            shape: BoxShape.circle,

                          ),

                          alignment: Alignment.center,
                          child: Text(
                            selectedFoodsForOrderLength.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight
                                  .normal,
                              fontSize: 20,
                            ),
                          ),

                        ),

                      ]
                  ),
                ),

              ),
            );
          }
        }
    );
  }
}

//
//class FoodList extends StatelessWidget {
//  FoodList({this.firestore});

class FoodList extends StatelessWidget {





  final String categoryString;
  final String searchString2;
//  final List<NewIngredient> allIngredients;

  FoodList({this.categoryString, this.searchString2 /*,this.allIngredients */});

  final logger = Logger(
    printer: PrettyPrinter(),
  );

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
//    print ('text at listTitleCase:  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE: $text');
//    print('dlist ---------------------------------------------> $dlist');

    List<String> stringList = List<String>.from(dlist);
    if (stringList.length==0) {
      return " ";
    } else if (stringList == null) {
      return ' ';
    }


//    var strings = text.OfType<String>().ToList();

//    var strings = dlist.map((item) => item.price).toList();

//    print ('stringList --> : $stringList');


    // print("text: $text");
    if (stringList.length==0) {
      return " ";
    } else if (stringList == null) {
      return ' ';
    }
//    else if (text.length <= 1) {
//      return text.toUpperCase();
//    }

//    else {
//      return stringList
//          .map((word) => word.toString().split(' ')
//          .map((word2) => word2[0].toUpperCase() + word2.substring(1)).join(' '))
//          .join(', ');
//
//    }

    else {
      return stringList
          .map((word) => word.toString().split(' ')
          .map((word2) => titleCase(word2)).join(' '))
          .join(', ');

    }
//    word2[0].toUpperCase() + word2.substring(1)

//    return "bash";
  }


  num tryCast<num>(dynamic x, {num fallback }) => x is num ? x : 0.0;




  @override
  Widget build(BuildContext context) {

//    print('_allIngredientState: in FoodLIst: $allIngredients');
//    final bloc = LocationQueryBloc();

//    final blocZZ = FoodItemsQueryBloc();

    final foodGalleryBloc = BlocProvider2.of(context).getFoodGalleryBlockObject;
//  final bloc = BlocProvider.of<FoodGalleryBloc>(context);

/*
    List<NewIngredient> testIngs = bloc.allIngredients;


    print('testIngs in foodgallery2: $testIngs');


    if ((testIngs) == null || (testIngs.length == 0)) {
      return Container
        (
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }

    else {
      */
    return StreamBuilder<List<FoodItemWithDocID>>(
//        stream:bloc.getAllFoodItems(),

      stream: foodGalleryBloc.foodItemsStream,


      initialData: foodGalleryBloc.allFoodItems,
//        initialData: bloc.getAllFoodItems(),
      builder: (context, snapshot) {

        /*
        print('snapshot.connectionState : ${snapshot.connectionState}');
        print('ConnectionState $ConnectionState');
        print('snapshot:::  ${snapshot.data}');
        print('bloc.allFoodItems : ${bloc.allFoodItems}');

        print('bloc.getAllFoodItems() : ${bloc.getAllFoodItems()}');
        print('bloc.foodItemsStream : ${bloc.foodItemsStream}');
        print('snapshot.data : ${snapshot.data}');
        print('snapshot.hasError : ${snapshot.hasError}');

        */
        print('snapshot.hasData FG2 : ${snapshot.hasData}');


        if (snapshot.hasData) {
//          return Center(child:
//          Text('${messageCount.toString()}')
//          );
          print(
              'searchString  ##################################: $searchString2');
          print(
              'categoryString  ##################################: $categoryString');
          // ..p


//          int messageCount = filteredItems.length;

          //..p
          final List allFoods = snapshot.data;

          List filteredItemsByCategory;

//          logger.i('categoryString.toLowerCase().trim(): ',categoryString.toLowerCase().trim());

          if (categoryString.toLowerCase().trim() != 'all') {
            filteredItemsByCategory = allFoods.where((oneItem) =>
            oneItem.categoryName.
            toLowerCase() ==
                categoryString.toLowerCase()).toList();


            // to do test.
            // if(searchString2!=null)
            final List filteredItems = filteredItemsByCategory.where((
                oneItem) =>
                oneItem.itemName.toLowerCase().
                contains(
                    searchString2.toLowerCase())).toList();

            final int categoryItemsCount = filteredItems.length;
            print('categoryItemsCount: $categoryItemsCount');
            return
              (
                  Container(
                    color: Color(0xffFFFFFF),
                    child:
                    GridView.builder(
                      itemCount: categoryItemsCount,
                      gridDelegate:
                      new SliverGridDelegateWithMaxCrossAxisExtent(

                        //Above to below for 3 not 2 Food Items:
                        maxCrossAxisExtent: 240,
                        mainAxisSpacing: 0, // H  direction
                        crossAxisSpacing: 5,
                        childAspectRatio: 140 / 180,


                      ),
                      shrinkWrap: false,

                      itemBuilder: (_, int index) {
//            logger.i("allFoods Category STring testing line # 1862: ${filteredItems[index]}");

//
                        final String foodItemName = filteredItems[index]
                            .itemName;
                        final String foodImageURL = filteredItems[index]
                            .imageURL;

//            logger.i("foodImageURL in CAtegory tap: $foodImageURL");


//            final String euroPrice = double.parse(filteredItems[index].priceinEuro).toStringAsFixed(2);
                        final Map<String,
                            dynamic> foodSizePrice = filteredItems[index]
                            .sizedFoodPrices;

//            final List<String> foodItemIngredientsList =  filteredItems[index].ingredient;
                        final List<
                            dynamic> foodItemIngredientsList = filteredItems[index]
                            .ingredients;

//            final String foodItemIngredients =    filteredItems[index].ingredients;
//            final String foodItemId =             filteredItems[index].itemId;
//            final bool foodIsHot =                filteredItems[index].isHot;
                        final bool foodIsAvailable = filteredItems[index]
                            .isAvailable;
                        final String foodCategoryName = filteredItems[index]
                            .categoryName;

//            final Map<String,dynamic> foodSizePrice = document['size'];

//            final List<dynamic> foodItemIngredientsList =  document['ingredient'];
//                print('foodSizePrice __________________________${foodSizePrice['normal']}');
                        final dynamic euroPrice = foodSizePrice['normal'];

//                num euroPrice2 = tryCast(euroPrice);
                        double euroPrice2 = tryCast<double>(
                            euroPrice, fallback: 0.00);
//                String euroPrice3= num.toString();
//                print('euroPrice2 :$euroPrice2');

                        String euroPrice3 = euroPrice2.toStringAsFixed(2);

                        FoodItemWithDocID oneFoodItem = new FoodItemWithDocID(


                          itemName: foodItemName,
                          categoryName: foodCategoryName,
                          imageURL: foodImageURL,
                          sizedFoodPrices: foodSizePrice,

//              priceinEuro: euroPrice,
                          ingredients: foodItemIngredientsList,

//              itemId:foodItemId,
//              isHot: foodIsHot,
                          isAvailable: foodIsAvailable,

                        );


//            logger.i('ingredients:',foodItemIngredientsList);

                        String stringifiedFoodItemIngredients = listTitleCase(
                            foodItemIngredientsList);


//            print('document__________________________: ${document.data}');
//            Map<String, dynamic> oneFoodItemData = Map<String, dynamic>.from (document.data);
//            print('FoodItem:__________________________________________ $oneFoodItemData');


                        return
                          Container(
                            // `opacity` is alpha channel of this color as a double, with 0.0 being
                            //  ///   transparent and 1.0 being fully opaque.
                              color: Color(0xffFFFFFF),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 16.0),
                              child: InkWell(
                                  child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      new Container(child:
                                      new Container(
                                        width: displayWidth(context) / 7,
                                        height: displayWidth(context) / 7,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
//                                          707070
//                                              color:Color(0xffEAB45E),
// good yellow color
//                                            color:Color(0xff000000),
                                                color: Color(0xff707070),
// adobe xd color
//                                              color: Color.fromRGBO(173, 179, 191, 1.0),
                                                blurRadius: 30.0,
                                                spreadRadius: 1.0,
                                                offset: Offset(0, 21)
                                            )
                                          ],
                                        ),
                                        child: Hero(
                                          tag: foodItemName,
                                          child:
                                          ClipOval(
                                            child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                                              imageUrl: foodImageURL,
                                              fit: BoxFit.cover,
                                              placeholder: (context,
                                                  url) => new CircularProgressIndicator(),
                                            ),
                                          ),
                                          placeholderBuilder: (context,
                                              heroSize, child) {
                                            return Opacity(
                                              opacity: 0.5, child: Container(
                                              width: displayWidth(context) /
                                                  7,
                                              height: displayWidth(context) /
                                                  7,
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
//                                          707070
//                                              color:Color(0xffEAB45E),
// good yellow color
//                                            color:Color(0xff000000),
                                                      color: Color(
                                                          0xffEAB45E),
// adobe xd color
//                                              color: Color.fromRGBO(173, 179, 191, 1.0),
                                                      blurRadius: 30.0,
                                                      spreadRadius: 1.0,
                                                      offset: Offset(0, 21)
                                                  )
                                                ],
                                              ),
                                              child:
                                              ClipOval(
                                                child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                                                  imageUrl: foodImageURL,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context,
                                                      url) => new CircularProgressIndicator(),
                                                ),
                                              ),
                                            ),
                                            );
                                          },
//                                  placeholderBuilder: (context,
//                                      Size.fromWidth(displayWidth(context) / 7),
//                          Image.network(foodImageURL)
//
//                                );
                                          //Placeholder Image.network(foodImageURL),
                                        ),

                                      ),

                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 12),
                                      ),
//                              SizedBox(height: 10),


                                      Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Text(
//                                  double.parse(euroPrice).toStringAsFixed(2),
                                              euroPrice3 + '\u20AC',
                                              style: TextStyle(
                                                  fontWeight: FontWeight
                                                      .normal,
//                                          color: Colors.blue,
                                                  color: Color.fromRGBO(
                                                      112, 112, 112, 1),
                                                  fontSize: 20),
                                            ),
//                                    SizedBox(width: 10),
                                            SizedBox(
                                                width: displayWidth(context) /
                                                    100),

                                            Icon(
                                              Icons.whatshot,
                                              size: 24,
                                              color: Colors.red,
                                            ),
                                          ]),


                                      FittedBox(fit: BoxFit.fitWidth, child:
                                      Text(
//                '${dummy.counter}',
                                        foodItemName,

                                        style: TextStyle(
                                          color: Color(0xff707070),
//                                color:Color.fromRGBO(112,112,112,1),

                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),)
                                      ,
                                      Container(
                                          height: displayHeight(context) / 61,

                                          child: Text(
//                                'stringifiedFoodItemIngredients',


                                            stringifiedFoodItemIngredients
                                                .length == 0
                                                ?
                                            'EMPTY'
                                                : stringifiedFoodItemIngredients
                                                .length > 12 ?
                                            stringifiedFoodItemIngredients
                                                .substring(0, 12) + '...' :
                                            stringifiedFoodItemIngredients,

//                                    foodItemIngredients.substring(0,10)+'..',
                                            style: TextStyle(
                                              color: Color(0xff707070),
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15,
                                            ),
                                          )
                                      ),
//
//
                                    ],
                                  ),
                                  onTap: () {

                                    final blocG =
                                        BlocProvider2.of(context).getFoodGalleryBlockObject;

                                    List<NewIngredient> tempIngs = blocG.getAllIngredientsPublicFGB2;

                                    final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;

//                                    blocD.getAllIngredients();
//                                    List<NewIngredient> test = blocD.allIngredients;


                                    logger.e('tempIngs_push 1: $tempIngs');


                                    blocD.setallIngredients(tempIngs);
//                                    _allIngredientState
                                    return Navigator.of(context).push(


                                      PageRouteBuilder(
                                        opaque: false,
                                        transitionDuration: Duration(
                                            milliseconds: 900),
                                        pageBuilder: (_, __, ___) =>
                                            BlocProvider2 /*<FoodItemDetailsBloc>*/(
                                              /* thisAllIngredients2:allIngredients,*/
                                              /*bloc: FoodItemDetailsBloc(
                                                  oneFoodItem,
                                                  allIngredients), */

                                              bloc: AppBloc(
                                                  oneFoodItem, tempIngs
                                                  /*allIngredients,*/ /*fromWhichPage:1*/),


                                              child: FoodItemDetails2()

                                              ,),
                                        /*
                                            BlocProvider<FoodItemDetailsBloc>(
                                              bloc: FoodItemDetailsBloc(
                                                  oneFoodItem,
                                                  allIngredients),


                                              child: FoodItemDetails2()

                                              ,),

                                        */
                                        // fUTURE USE -- ANIMATION TRANSITION CODE.
                                        /*
                                  transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: RotationTransition(
                                        turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                                        child: child,
                                      ),
                                    );
                                  }
                                  */
                                      ),
                                    );
                                  }

                              )
                          );
//            return SpoiledItem(/*dummy: snapshot.data[index]*/);
                      },

                    ),
                  )
              );
          }
          else {
//            logger.i('allFoods at all else is: ', allFoods.length);

            final List filteredItems = allFoods.where((oneItem) =>
                oneItem.itemName.toLowerCase().
                contains(
                    searchString2.toLowerCase())).toList();
            return
              (
                  Container(
                    color: Color(0xffFFFFFF),
                    child:
                    GridView.builder(
                      itemCount: filteredItems.length,
                      gridDelegate:
                      new SliverGridDelegateWithMaxCrossAxisExtent(

//          maxCrossAxisExtent: 270,
                        //          crossAxisSpacing: 0,
                        /*
          maxCrossAxisExtent: 310,
          mainAxisSpacing: 20, // H  direction
          childAspectRatio: 160/220,
          crossAxisSpacing: 10,
          */

                        ///childAspectRatio:
                        /// The ratio of the cross-axis to the main-axis extent of each child.
                        /// H/V

                        /*
                maxCrossAxisExtent: 290,
                mainAxisSpacing: 0, // H  direction
                crossAxisSpacing: 5,
                childAspectRatio: 160/160,

                 */
                        //Above to below for 3 not 2 Food Items:
                        maxCrossAxisExtent: 240,
                        mainAxisSpacing: 0, // H  direction
                        crossAxisSpacing: 5,
                        childAspectRatio: 140 / 180,


                      ),
                      shrinkWrap: false,

                      itemBuilder: (_, int index) {
//            logger.i("allFoods Category STring testing line # 1862: ${filteredItems[index]}");

//
                        final String foodItemName = filteredItems[index]
                            .itemName;
                        final String foodImageURL = filteredItems[index]
                            .imageURL;

//            logger.i("foodImageURL in CAtegory tap: $foodImageURL");


//            final String euroPrice = double.parse(filteredItems[index].priceinEuro).toStringAsFixed(2);
                        final Map<String,
                            dynamic> foodSizePrice = filteredItems[index]
                            .sizedFoodPrices;

//            final List<String> foodItemIngredientsList =  filteredItems[index].ingredient;
                        final List<
                            dynamic> foodItemIngredientsList = filteredItems[index]
                            .ingredients;

//            final String foodItemIngredients =    filteredItems[index].ingredients;
//            final String foodItemId =             filteredItems[index].itemId;
//            final bool foodIsHot =                filteredItems[index].isHot;
                        final bool foodIsAvailable = filteredItems[index]
                            .isAvailable;
                        final String foodCategoryName = filteredItems[index]
                            .categoryName;

//            final Map<String,dynamic> foodSizePrice = document['size'];

//            final List<dynamic> foodItemIngredientsList =  document['ingredient'];
//                print('foodSizePrice __________________________${foodSizePrice['normal']}');
                        final dynamic euroPrice = foodSizePrice['normal'];

//                num euroPrice2 = tryCast(euroPrice);
                        double euroPrice2 = tryCast<double>(
                            euroPrice, fallback: 0.00);
//                String euroPrice3= num.toString();
//                print('euroPrice2 :$euroPrice2');

                        String euroPrice3 = euroPrice2.toStringAsFixed(2);

                        FoodItemWithDocID oneFoodItem = new FoodItemWithDocID(


                          itemName: foodItemName,
                          categoryName: foodCategoryName,
                          imageURL: foodImageURL,
                          sizedFoodPrices: foodSizePrice,

//              priceinEuro: euroPrice,
                          ingredients: foodItemIngredientsList,

//              itemId:foodItemId,
//              isHot: foodIsHot,
                          isAvailable: foodIsAvailable,

                        );


//            logger.i('ingredients:',foodItemIngredientsList);

                        String stringifiedFoodItemIngredients = listTitleCase(
                            foodItemIngredientsList);


//            print('document__________________________: ${document.data}');
//            Map<String, dynamic> oneFoodItemData = Map<String, dynamic>.from (document.data);
//            print('FoodItem:__________________________________________ $oneFoodItemData');


                        return
                          Container(
                            // `opacity` is alpha channel of this color as a double, with 0.0 being
                            //  ///   transparent and 1.0 being fully opaque.
                              color: Color(0xffFFFFFF),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 16.0),
                              child: InkWell(
                                  child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      new Container(child:
                                      new Container(
                                        width: displayWidth(context) / 7,
                                        height: displayWidth(context) / 7,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
//                                          707070
//                                              color:Color(0xffEAB45E),
// good yellow color
//                                            color:Color(0xff000000),
                                                color: Color(0xff707070),
// adobe xd color
//                                              color: Color.fromRGBO(173, 179, 191, 1.0),
                                                blurRadius: 30.0,
                                                spreadRadius: 1.0,
                                                offset: Offset(0, 21)
                                            )
                                          ],
                                        ),
                                        child: Hero(
                                          tag: foodItemName,
                                          child:
                                          ClipOval(
                                            child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                                              imageUrl: foodImageURL,
                                              fit: BoxFit.cover,
                                              placeholder: (context,
                                                  url) => new CircularProgressIndicator(),
                                            ),
                                          ),
                                          placeholderBuilder: (context,
                                              heroSize, child) {
                                            return Opacity(
                                              opacity: 0.5, child: Container(
                                              width: displayWidth(context) /
                                                  7,
                                              height: displayWidth(context) /
                                                  7,
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
//                                          707070
//                                              color:Color(0xffEAB45E),
// good yellow color
//                                            color:Color(0xff000000),
                                                      color: Color(
                                                          0xffEAB45E),
// adobe xd color
//                                              color: Color.fromRGBO(173, 179, 191, 1.0),
                                                      blurRadius: 30.0,
                                                      spreadRadius: 1.0,
                                                      offset: Offset(0, 21)
                                                  )
                                                ],
                                              ),
                                              child:
                                              ClipOval(
                                                child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                                                  imageUrl: foodImageURL,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context,
                                                      url) => new CircularProgressIndicator(),
                                                ),
                                              ),
                                            ),
                                            );
                                          },
//                                  placeholderBuilder: (context,
//                                      Size.fromWidth(displayWidth(context) / 7),
//                          Image.network(foodImageURL)
//
//                                );
                                          //Placeholder Image.network(foodImageURL),
                                        ),

                                      ),

                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 12),
                                      ),
//                              SizedBox(height: 10),


                                      Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Text(
//                                  double.parse(euroPrice).toStringAsFixed(2),
                                              euroPrice3 + '\u20AC',
                                              style: TextStyle(
                                                  fontWeight: FontWeight
                                                      .normal,
//                                          color: Colors.blue,
                                                  color: Color.fromRGBO(
                                                      112, 112, 112, 1),
                                                  fontSize: 20),
                                            ),
//                                    SizedBox(width: 10),
                                            SizedBox(
                                                width: displayWidth(context) /
                                                    100),

                                            Icon(
                                              Icons.whatshot,
                                              size: 24,
                                              color: Colors.red,
                                            ),
                                          ]),


                                      FittedBox(fit: BoxFit.fitWidth, child:
                                      Text(
//                '${dummy.counter}',
                                        foodItemName,

                                        style: TextStyle(
                                          color: Color(0xff707070),
//                                color:Color.fromRGBO(112,112,112,1),

                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),)
                                      ,
                                      Container(
                                          height: displayHeight(context) / 61,

                                          child: Text(
//                                'stringifiedFoodItemIngredients',


                                            stringifiedFoodItemIngredients
                                                .length == 0
                                                ?
                                            'EMPTY'
                                                : stringifiedFoodItemIngredients
                                                .length > 12 ?
                                            stringifiedFoodItemIngredients
                                                .substring(0, 12) + '...' :
                                            stringifiedFoodItemIngredients,

//                                    foodItemIngredients.substring(0,10)+'..',
                                            style: TextStyle(
                                              color: Color(0xff707070),
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15,
                                            ),
                                          )
                                      ),
//
//
                                    ],
                                  ),
                                  onTap: () {

                                    final blocG =
                                        BlocProvider2.of(context).getFoodGalleryBlockObject;

                                    List<NewIngredient> tempIngs = blocG.getAllIngredientsPublicFGB2;

                                    final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;

//                                    blocD.getAllIngredients();
//                                    List<NewIngredient> test = blocD.allIngredients;


                                    logger.e('tempIngs_push 2: $tempIngs');


                                    blocD.setallIngredients(tempIngs);

                                    return Navigator.of(context).push(


                                      PageRouteBuilder(
                                        opaque: false,
                                        transitionDuration: Duration(
                                            milliseconds: 900),
                                        pageBuilder: (_, __, ___) =>

                                            BlocProvider2 /*<FoodItemDetailsBloc>*/(
                                              /*thisAllIngredients2:allIngredients,*/
                                              /*bloc: FoodItemDetailsBloc(
                                                  oneFoodItem,
                                                  allIngredients), */

                                              bloc: AppBloc(
                                                  oneFoodItem, tempIngs),


                                              child: FoodItemDetails2()

                                              ,),
                                        /*
                                            BlocProvider<FoodItemDetailsBloc>(
                                              bloc: FoodItemDetailsBloc(
                                                  oneFoodItem,
                                                  allIngredients),

                                              child: FoodItemDetails2()

                                              ,),
                                        */
                                        // fUTURE USE -- ANIMATION TRANSITION CODE.
                                        /*
                                  transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: RotationTransition(
                                        turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                                        child: child,
                                      ),
                                    );
                                  }
                                  */
                                      ),
                                    );
                                  }

                              )
                          );
//            return SpoiledItem(/*dummy: snapshot.data[index]*/);
                      },

                    ),
                  )
              );
          }
        }
        else {
          return Center(child:
          Text('No Data')
          );
        }
      },
    );
  }
/*}*/
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


//    canvas.drawRect();
//    canvas.drawCircle();
//    canvas.drawArc();
//    canvas.drawPath();
//
//    canvas.draImage();
//    canvas.drawRect();
//    canvas.drawImageNine();
//    canvas.drawParagraph();
//...
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