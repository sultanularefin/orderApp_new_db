//food_gallery.dart



// dependency files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:foodgallery/src/screens/drawerScreen/drawerScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


// local packages

import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import 'package:foodgallery/src/screens/foodItemDetailsPage/foodItemDetails.dart';
//import 'package:shared_preferences/shared_preferences.dart';

// Screen files.


// model, dummy data file:

import './../../models/itemData.dart';
import './../../models/FoodItem.dart';
import './../../models/FoodItemWithDocID.dart';
import './../../models/CategoryItemsLIst.dart';
//import './../../models/dummy.dart';


//import './../../shared/category_Constants.dart' as Constants;


//import CategoryItems from 'package:foodgallery/src/shared/category_Constants.dart';


final Firestore firestore = Firestore();



class FoodGallery extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;

  final Firestore firestore = Firestore.instance;


  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FoodGallery({Key key, this.child}) : super(key: key);



  _FoodGalleryState createState() => _FoodGalleryState();

}


class _FoodGalleryState extends State<FoodGallery> {


  _FoodGalleryState({firestore});

  File _image;

  final _allFoodsList = [];


  @override
  void initState() {
//    getDataFromFirestore();
//  _animationController = AnimationController(...);
//  _colorTween = _animationController.drive(
//    ColorTween(
//      begin:Colors.yellow,
//      end:Colors.blue));
//  _animationController.repeat();
    //getDataFromFirestore();
    super.initState();

  }

//  restaurants
  // USWc8IgrHKdjeDe9Ft4j
  getDataFromFirestore() async {
//    firestore
//        .collection("restaurants/USWc8IgrHKdjeDe9Ft4j/foodItems").where('category', isEqualTo: 'pizza')
//
//        .snapshots()
    Firestore.instance
        .collection('restaurants/USWc8IgrHKdjeDe9Ft4j/foodItems').where('category', isEqualTo: 'pizza')
        .snapshots()
        .listen((data) =>
        data.documents.forEach((doc) {
//      document['itemName'];

//          print('doc: ***************************** ${doc['uploadDate']
//              .toDate()}');
//      doc: ***************************** Instance of 'DocumentSnapshot'

//      final DocumentSnapshot document = snapshot.data.documents[index];


//      final DocumentSnapshot document = snapshot.data.documents[index];


          final dynamic foodItemName = doc['itemName'];
          final dynamic foodImageURL = doc['imageURL'];
//          final String euroPrice = double.parse(doc['priceinEuro'])
//              .toStringAsFixed(2);
//          final String foodItemIngredients = doc['ingredients'];
          final String foodItemId = doc['itemId'];
          final bool foodIsHot = doc['isHot'];
          final bool foodIsAvailable = doc['isAvailable'];
          final String foodCategoryName = doc['categoryName'];
          final String foodItemDocumentID = doc.documentID;


          FoodItemWithDocID oneFoodItemWithDocID = new FoodItemWithDocID(


            itemName: foodItemName,
            categoryName: foodCategoryName,
            imageURL: foodImageURL,

//            priceinEuro: euroPrice,
//            ingredients: foodItemIngredients,

            itemId: foodItemId,
            isHot: foodIsHot,
            isAvailable: foodIsAvailable,
            documentId: foodItemDocumentID,


          );

          _allFoodsList.add(oneFoodItemWithDocID);
        }
        ), onDone: () {
      print("Task Done zzzzz zzzzzz zzzzzzz zzzzzzz zzzzzz zzzzzzzz zzzzzzzzz zzzzzzz zzzzzzz");
    }, onError: (error, StackTrace stackTrace) {
      print("Some Error $stackTrace");
    });
  }


  //  final _formKey = GlobalKey();

  final _formKey = GlobalKey<FormState>();



  String _searchString = '';
  String _currentCategory = "PIZZA";
  String _firstTimeCategoryString = "";
  double _total_cart_price = 1.00;
  // empty MEANS PIZZA


  Widget _buildCategoryRow(String categoryName, int index) {

    if (_currentCategory==categoryName){
      return ListTile(
//        trailing: CustomPaint(size: Size(0,19),
//          painter: MyPainter(),
//        ),

//        contentPadding: EdgeInsets.symmetric(
//            horizontal: 4.0, vertical: 6.0),

        contentPadding: EdgeInsets.fromLTRB(10, 6, 10, 6),
//    FittedBox(fit:BoxFit.fitWidth,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(categoryName
                ,
//    Text(categoryName.substring(0, 2),
                style: TextStyle(
                  color:Color.fromRGBO(255,255,255,1),
//                  color:Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),

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
      );
    }
    else {
      return ListTile(
        contentPadding: EdgeInsets.fromLTRB(10, 6, 10, 6),

        title:  Text(categoryName,
//    Text(categoryName.substring(0, 2),
          style: TextStyle(
//            color:Color.fromRGBO(84,70,62,1),
            color:Color.fromRGBO(255,255,255,1),
            fontWeight: FontWeight.normal,
            fontSize: 17,
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


  @override
  Widget build(BuildContext context) {
//    String a = Constants.SUCCESS_MESSAGE;


//    _searchString


    if ((_firstTimeCategoryString !="") && (_searchString=='')){
      //    if(_currentCategory!=""){

      print('CONDITOIN 01');
//      CONDITION 01.

      return Scaffold(
        //      resizeToAvoidBottomPadding: false ,
        //          appBar: AppBar(
        //              title: Text('Food Gallery')


        //         ),
        body:
        SafeArea(
          child:SingleChildScrollView(child:
          Column(
            //    mainAxisAlignment: MainAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[




              //    #### 1ST CONTAINER SEARCH STRING AND TOTAL ADD TO CART PRICE.



              Container(

                //      color: Colors.yellowAccent,
                height:100,
                width: displayWidth(context),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    Container(

                      //     color: Color.fromARGB(255, 255,255,255),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[


                          Container(
                            margin:EdgeInsets.symmetric(horizontal: displayWidth(context)
                                /20,vertical: 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(250, 200, 200, 1.0),
                                      blurRadius: 10.0,
                                      offset: Offset(0.0, 2.0))
                                ],
                                color: Colors.black54),
                            width: displayWidth(context)/5,
                            height: displayHeight(context)/40,

                            padding: EdgeInsets.only(
                                left: 4, top: 3, bottom: 3, right: 3),
                            child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                    Icons.add_shopping_cart,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                                Text(_total_cart_price.toStringAsFixed(2) +' kpl',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                Spacer(),

                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 0,  horizontal: displayWidth(context) /50,
                            ),
                            child:Icon(
                              Icons.search,
                              size: 24,
                              color: Colors.red,
                            ),
                          ),



                          Container(
                            margin:  EdgeInsets.only(
                              right:displayWidth(context) /32 ,
                            ),
                            width:displayWidth(context)/4,
                            child: TextField(
                              onChanged: (text) {
                                setState(() => _searchString = text);
                                print("First text field conditon 01 might not be needed also onTap().: $text");
                              },
                              onTap:(){
                                setState(() {
                                  _firstTimeCategoryString ='PIZZA';
                                });

                              },
                              onEditingComplete: (){
                                print('called onEditing complete');
                                setState(() => _searchString = "");
                              },

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter a meal term',
                                labelText: 'Search for your meal.',

                              ),
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
//                          TextField(
//                            decoration: InputDecoration(
//                                border: InputBorder.none,
//                                hintText: 'Enter a meal term',
//                                labelText: 'Search for your meal.'
//                            ),
//                          )

//                  PROBLEM CODES ABOVE..


                        ],

                      ),
                    ),



                    // BLACK CONTAINER.
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 3.8,

                      color: Color.fromARGB(255, 84, 70, 62),

                    ),

                  ],
                ),
              ),



//                #### 2ND CONTAINER SIDE MENUS AND GRIDLIST.
              Container(
                height: displayHeight(context) -
                    MediaQuery.of(context).padding.top -100,
//where 100 IS THE HEIGHT OF 1ST CONTAINER HOLDING SEARCH INPUT AND TOTAL CART PRICE.

                child:
                Row(
                  children: <Widget>[

                    Expanded(
                      child: FoodListWithCategoryString(
                          allFoods: _allFoodsList, categoryString: _currentCategory
                      ),
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 3.8,
//                      there is ---- line when selected
                      //ARGB (alpha= (0=transparent,255 = opaque);
                      color: Color.fromARGB(255, 84, 70, 62),
//239 239 239
//              child:Text('ss'),
                      child: new ListView.builder
                        (
                          itemCount: categoryItems.length,
                          //    itemBuilder: (BuildContext ctxt, int index) {
                          itemBuilder: (_, int index) {
                            return _buildCategoryRow(categoryItems[index], index);
                          }
                      ),
                    ),


                  ],
                ),
              )


            ],
          ),
          )
          ,),
      );
    }


    else if
    ((_searchString !='') &&(_firstTimeCategoryString!=''))


      // CONDITION 02.
        {
      print('CONDITON 02 || ');


      return Scaffold(
        //      resizeToAvoidBottomPadding: false ,
        //          appBar: AppBar(
        //              title: Text('Food Gallery')


        //         ),
        body:
        SafeArea(
          child:SingleChildScrollView(
            child:
            Column(
              //    mainAxisAlignment: MainAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[




                //    #### 1ST CONTAINER SEARCH STRING AND TOTAL ADD TO CART PRICE.



                Container(

                  //      color: Colors.yellowAccent,
                  height:100,
                  width: displayWidth(context),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      Container(

                        //     color: Color.fromARGB(255, 255,255,255),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[


                            Container(
                              margin:EdgeInsets.symmetric(horizontal: displayWidth(context)
                                  /20,vertical: 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(250, 200, 200, 1.0),
                                        blurRadius: 10.0,
                                        offset: Offset(0.0, 2.0))
                                  ],
                                  color: Colors.black54),
                              width: displayWidth(context)/5,
                              height: displayHeight(context)/40,

                              padding: EdgeInsets.only(
                                  left: 4, top: 3, bottom: 3, right: 3),
                              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      Icons.add_shopping_cart,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(_total_cart_price.toStringAsFixed(2) +' kpl',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                  Spacer(),

                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 0,  horizontal: displayWidth(context) /50,
                              ),
                              child:Icon(
                                Icons.search,
                                size: 24,
                                color: Colors.red,
                              ),
                            ),



                            Container(
                              margin:  EdgeInsets.only(
                                right:displayWidth(context) /32 ,
                              ),
                              width:displayWidth(context)/4,
                              child: TextField(
                                onChanged: (text) {
                                  setState(() => _searchString = text);
                                  print("First text field: $text");
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter a meal term',
                                  labelText: 'Search for your meal.',

                                ),
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
//                          TextField(
//                            decoration: InputDecoration(
//                                border: InputBorder.none,
//                                hintText: 'Enter a meal term',
//                                labelText: 'Search for your meal.'
//                            ),
//                          )

//                  PROBLEM CODES ABOVE..


                          ],

                        ),
                      ),



                      // BLACK CONTAINER.
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 3.8,

                        color: Color.fromARGB(255, 84, 70, 62),

                      ),

                    ],
                  ),
                ),



//                #### 2ND CONTAINER SIDE MENUS AND GRIDLIST.
                Container(
                  height: displayHeight(context) -
                      MediaQuery.of(context).padding.top -100,
//where 100 IS THE HEIGHT OF 1ST CONTAINER HOLDING SEARCH INPUT AND TOTAL CART PRICE.

                  child:
                  Row(
                    children: <Widget>[


//              Text('Craft beautiful UIs'),  TODO ANOTHER WIDGET.
//              Expanded(
//                child: FittedBox(
//                  fit: BoxFit.contain, // otherwise the logo will be tiny
//                  child: const FlutterLogo(),
//                ),
//              ),
                      Expanded(
                        child: FoodListWithCategoryStringAndSearchString(
                            allFoods: _allFoodsList, categoryString: _currentCategory,searchString2:_searchString),

                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 3.8,
//                      there is ---- line when selected
                        //ARGB (alpha= (0=transparent,255 = opaque);
                        color: Color.fromARGB(255, 84, 70, 62),
//239 239 239
//              child:Text('ss'),
                        child: new ListView.builder
                          (
                            itemCount: categoryItems.length,
                            //    itemBuilder: (BuildContext ctxt, int index) {
                            itemBuilder: (_, int index) {
                              return _buildCategoryRow(categoryItems[index], index);
                            }
                        ),
                      ),


                    ],
                  ),
                )


              ],
            ),
          ),
        ),
      );

    }

    else if((_searchString!="") &&(_firstTimeCategoryString==""))
    {

      //CONDITION 03
      print('x CONDITON 03');
      {


        return Scaffold(
          //      resizeToAvoidBottomPadding: false ,
          //          appBar: AppBar(
          //              title: Text('Food Gallery')


          //         ),
          body:
          SafeArea(
            child:SingleChildScrollView(child:

            Column(
              //    mainAxisAlignment: MainAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[




                //    #### 1ST CONTAINER SEARCH STRING AND TOTAL ADD TO CART PRICE.



                Container(

                  //      color: Colors.yellowAccent,
                  height:100,
                  width: displayWidth(context),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      Container(

                        //     color: Color.fromARGB(255, 255,255,255),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[


                            Container(
                              margin:EdgeInsets.symmetric(horizontal: displayWidth(context)
                                  /20,vertical: 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(250, 200, 200, 1.0),
                                        blurRadius: 10.0,
                                        offset: Offset(0.0, 2.0))
                                  ],
                                  color: Colors.black54),
                              width: displayWidth(context)/5,
                              height: displayHeight(context)/40,

                              padding: EdgeInsets.only(
                                  left: 4, top: 3, bottom: 3, right: 3),
                              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      Icons.add_shopping_cart,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(_total_cart_price.toStringAsFixed(2) +' kpl',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                  Spacer(),

                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 0,  horizontal: displayWidth(context) /50,
                              ),
                              child:Icon(
                                Icons.search,
                                size: 24,
                                color: Colors.red,
                              ),
                            ),



                            Container(
                              margin:  EdgeInsets.only(
                                right:displayWidth(context) /32 ,
                              ),
                              width:displayWidth(context)/4,
                              child: TextField(
                                onChanged: (text) {
                                  setState(() => _searchString = text);
                                  print("First text field: $text");
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter a meal term',
                                  labelText: 'Search for your meal.',

                                ),
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
//                          TextField(
//                            decoration: InputDecoration(
//                                border: InputBorder.none,
//                                hintText: 'Enter a meal term',
//                                labelText: 'Search for your meal.'
//                            ),
//                          )

//                  PROBLEM CODES ABOVE..


                          ],

                        ),
                      ),



                      // BLACK CONTAINER.
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 3.8,

                        color: Color.fromARGB(255, 84, 70, 62),

                      ),

                    ],
                  ),
                ),



//                #### 2ND CONTAINER SIDE MENUS AND GRIDLIST.
                Container(
                  height: displayHeight(context) -
                      MediaQuery.of(context).padding.top -100,
//where 100 IS THE HEIGHT OF 1ST CONTAINER HOLDING SEARCH INPUT AND TOTAL CART PRICE.

                  child:
                  Row(
                    children: <Widget>[


//              Text('Craft beautiful UIs'),  TODO ANOTHER WIDGET.
//              Expanded(
//                child: FittedBox(
//                  fit: BoxFit.contain, // otherwise the logo will be tiny
//                  child: const FlutterLogo(),
//                ),
//              ),
                      Expanded(
                        child: FoodListWithCategoryStringAndSearchString(
                            allFoods: _allFoodsList,categoryString: _currentCategory, searchString2:_searchString),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 3.8,
//                      there is ---- line when selected
                        //ARGB (alpha= (0=transparent,255 = opaque);
                        color: Color.fromARGB(255, 84, 70, 62),
//239 239 239
//              child:Text('ss'),
                        child: new ListView.builder
                          (
                            itemCount: categoryItems.length,
                            //    itemBuilder: (BuildContext ctxt, int index) {
                            itemBuilder: (_, int index) {
                              return _buildCategoryRow(categoryItems[index], index);
                            }
                        ),
                      ),


                    ],
                  ),
                )


              ],
            ),
            ),
          ),
        );

      }
    }
//    THIS IS ELSE.
//    if(_firstTimeCategoryString == null){
    else{
      print('CONDIONT 04 || ELSE');
//      CONDITION 4

// FOODLIST LOADED FROM FIRESTORE NOT FROM STATE HERE
      return Scaffold(

//      resizeToAvoidBottomPadding: false ,
        // appBar: AppBar(title: Text('Food Gallery')),
          body:
          SafeArea(
            child:SingleChildScrollView(child:

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[


//                #### 1ST CONTAINER SEARCH STRING AND TOTAL ADD TO CART PRICE.



                Container(

//                  color: Colors.yellowAccent,
                  height:100,
                  width: displayWidth(context),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      Container(

//                      color: Color.fromARGB(255, 255,255,255),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            // CONTAINER FOR TOTAL PRICE CART BELOW.
                            Container(
                              margin:EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(250, 200, 200, 1.0),
                                        blurRadius: 10.0,
                                        offset: Offset(0.0, 2.0))
                                  ],
                                  color: Colors.black54),
                              width: displayWidth(context)/3,
                              height: displayHeight(context)/27,
                              padding: EdgeInsets.only(
                                  left: 4, top: 3, bottom: 3, right: 3),
                              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      Icons.add_shopping_cart,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
//                                  Spacer(),
                                  Text(_total_cart_price.toStringAsFixed(2) +' kpl',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
//                                  Spacer(),

                                ],
                              ),
                            ),

                            // CONTAINER FOR TOTAL PRICE CART ABOVE.


                            // PROBLEM CODES BELOW.....

                            // SEARCH CODES ARE BELOW:
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 0,  horizontal: displayWidth(context) /50,
                              ),
                              child:Icon(
                                Icons.search,
                                size: 24,
                                color: Colors.red,
                              ),
                            ),
                            Container(
                              margin:  EdgeInsets.only(
                                right:displayWidth(context) /32 ,
                              ),
                              width:displayWidth(context)/4,
                              // do it in both Container
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter a meal term',
                                    labelText: 'Search for your meal.'
                                ),
                                onChanged: (text) {
                                  setState(() => _searchString = text);
                                  print("First text field from Condition 04: $text");
                                },
                                onTap:(){
                                  print('condition 4');
                                  setState(() {
                                    _firstTimeCategoryString ='PIZZA';
                                  });

                                },

                                onEditingComplete: (){
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
//                          TextField(
//                            decoration: InputDecoration(
//                                border: InputBorder.none,
//                                hintText: 'Enter a meal term',
//                                labelText: 'Search for your meal.'
//                            ),
//                          )

//                  PROBLEM CODES ABOVE..


                          ],

                        ),
                      ),



                      // BLACK CONTAINER.
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 3.8,

                        color: Color.fromARGB(255, 84, 70, 62),

                      ),

                    ],
                  ),
                ),



//                #### 2ND CONTAINER SIDE MENUS AND GRIDLIST.
                Container(
                  height: displayHeight(context) -
                      MediaQuery.of(context).padding.top -100,
//where 100 IS THE HEIGHT OF 1ST CONTAINER HOLDING SEARCH INPUT AND TOTAL CART PRICE.


//                  height: displayHeight(context) -
//                      MediaQuery.of(context).padding.top -
//                      kToolbarHeight,

                  child:

                  Row(
                    children: <Widget>[

                      Expanded(
                        child: FoodList(firestore: firestore),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 3.8,
//              color: Colors.yellowAccent,
                        color: Color.fromARGB(255, 84, 70, 62),
//              child:Text('ss'),
                        child: new ListView.builder
                          (
                            itemCount: categoryItems.length,
                            //    itemBuilder: (BuildContext ctxt, int index) {
                            itemBuilder: (_, int index) {
                              return _buildCategoryRow(categoryItems[index], index);
                            }
                        ),
                      ),


                    ],
                  ),
                ),



              ],
            ),
            )
            ,)

      );

    }

  }
}

//
//class FoodList extends StatelessWidget {
//  FoodList({this.firestore});


class FoodListWithCategoryStringAndSearchString extends StatelessWidget{

// THERE WILL BE 4 CLASSES.
//
//1. FOR INITIAL LOADING OF ONLY PIZZA ITEMS.
//    2. INITIAL LOADING AND SEARCH FUNCTIONALITY.  ----------THIS ONE IS FOR 2 ALSO.
//    3. CATEGOY FILTERING
//4. CATEGORY FILTERING AND SEARCH FILTERING. -----------THIS ONE IS 4.


  final List allFoods;


  final String categoryString;
  final String searchString2;
  FoodListWithCategoryStringAndSearchString({this.allFoods,this.categoryString,this.searchString2});



//  const ChildScreen({Key key, this.func}) : super(key: key);

  // @override
//  bool updateShouldNotify(InheritedDataProvider oldWidget) => data != oldWidget.data;


  String listTitleCase(List<String> text) {
    // print("text: $text");
    if (text.length==0) {
      return " ";
    } else if (text == null) {
      return ' ';
    }
//    else if (text.length <= 1) {
//      return text.toUpperCase();
//    }
    else {
      return text
          .map((word) => word.split(' ')
          .map((word2) => word2[0].toUpperCase() + word2.substring(1)).join(' '))
          .join(', ');

    }
  }

  @override
  Widget build(BuildContext context) {

    print('searchString  ##################################: $searchString2');
    print('CATEGORY string:  ##################################: $categoryString');


//    if(categoryString!=null){

//
//    final List filteredItems = allFoods.where((oneItem ) => oneItem.categoryName.toLowerCase() ==
//        categoryString.toLowerCase()).toList();
    // FILTER BY CATEGORY.
    final List filteredItemsByCategory = allFoods.where((oneItem ) => oneItem.categoryName.toLowerCase() ==
        categoryString.toLowerCase()).toList();



    // FLTER BY SEARCHSTRING;
    final List filteredItems = filteredItemsByCategory.where((oneItem) =>oneItem.itemName.toLowerCase().
    contains(
        searchString2.toLowerCase())).toList();



    int messageCount = filteredItems.length;
//    }
//    else{
//      filteredItems = allFoods.where((oneItem ) => oneItem.categoryName.toLowerCase() ==
//          'PIZZA'.toLowerCase()).toList();
//
//      messageCount = allFoods.length;
//    }

    print('filteredItemCountWithSearchSring: $messageCount');

    return(
        GridView.builder(
          itemCount:  messageCount,

/*
          gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(
            // The number of logical pixels between each child along the main axis.
              mainAxisSpacing: 20, // H  direction
              crossAxisSpacing: 0,

              ///childAspectRatio:
              /// The ratio of the cross-axis to the main-axis extent of each child.
              /// H/V
              childAspectRatio: 160/220,
              crossAxisCount: 3),
*/


          gridDelegate:
          new SliverGridDelegateWithMaxCrossAxisExtent(

            maxCrossAxisExtent: 270,
            mainAxisSpacing: 20, // H  direction
            crossAxisSpacing: 0,

            ///childAspectRatio:
            /// The ratio of the cross-axis to the main-axis extent of each child.
            /// H/V
            childAspectRatio: 160/220,


          ),
          shrinkWrap:false,

          itemBuilder: (_, int index) {
//            final DocumentSnapshot document = snapshot.data.documents[index];
//            final dynamic message = document['itemName'];
//            final dynamic imageURL = document['imageURL'];
//            categoryItems
//          print(allFoods[index].itemName);
//            final document = allFoods[index];
            final dynamic foodItemName =          filteredItems[index].itemName;
            final dynamic foodImageURL =          filteredItems[index].imageURL;
//            final String euroPrice = double.parse(filteredItems[index].priceinEuro).toStringAsFixed(2);

            final List<String> foodItemIngredientsList =  filteredItems[index].ingredient;

//            final String foodItemIngredients =    filteredItems[index].ingredients;
            final String foodItemId =             filteredItems[index].itemId;
            final bool foodIsHot =                filteredItems[index].isHot;
            final bool foodIsAvailable =          filteredItems[index].isAvailable;
            final String foodCategoryName =       filteredItems[index].categoryName;


            FoodItemWithDocID oneFoodItem =new FoodItemWithDocID(


              itemName: foodItemName,
              categoryName: foodCategoryName,
              imageURL: foodImageURL,

//              priceinEuro: euroPrice,


//              ingredients: foodItemIngredients,
              ingredients: foodItemIngredientsList,

              itemId:foodItemId,
              isHot: foodIsHot,
              isAvailable: foodIsAvailable,

            );

            String stringifiedFoodItemIngredients =listTitleCase(foodItemIngredientsList);
//            oneFoodItem


//            print('document__________________________: ${document.data}');
//            Map<String, dynamic> oneFoodItemData = Map<String, dynamic>.from (document.data);
//            print('FoodItem:__________________________________________ $oneFoodItemData');


            return
              Container(
                // `opacity` is alpha channel of this color as a double, with 0.0 being
                //  ///   transparent and 1.0 being fully opaque.
                  color: Color.fromRGBO(239, 239, 239, 1.0),
                  padding: EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 16.0),
                  child: InkWell(
                      child: Column(
                        children: <Widget>[
//                                  Text(
//                                    'item name',
//                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
//                                        color: Colors.blueGrey[800],
//                                        fontSize: 16),
//                                  ),
//                                  SizedBox(height: 10),
                          new Container(
                            child: new Container(
                              width: displayWidth(context)*0.19,
                              height: displayWidth(context)*0.19,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(173, 179, 191, 1.0),
                                      blurRadius: 8.0,
                                      offset: Offset(0.0, 1.0))
                                ],
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                                  imageUrl: foodImageURL,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => new CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          ),
//                              SizedBox(height: 10),
/*
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
//                                  double.parse(euroPrice).toStringAsFixed(2),
//                                  euroPrice,
                                  euroPrice+'\u20AC',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
//                                      color: Colors.blue,
                                      color:Color.fromRGBO(112,112,112,1),
                                      fontSize: 20),
                                ),
                                SizedBox(width: displayWidth(context)/100),

                                Icon(
                                  Icons.whatshot,
                                  size: 24,
                                  color: Colors.red,
                                ),
                              ]),

*/

//                              SizedBox(height: 10),

                          /*
                              Container(
                                height: 20,
                                child:Text(
//                '${dummy.counter}',
                                  foodItemName,
                                  style: TextStyle(
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
//                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              )
                              */

//                              Text('s'),
//                              Text('D'),


                          Text(
//                '${dummy.counter}',
                            foodItemName,

                            style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                          ,
                          Container(
//                              height: 20,
                              height: displayHeight(context)/61,
//                              height: displayWidth(context)/50,
                              child:Text(

                                stringifiedFoodItemIngredients.substring(0,10)+'..',
                                style: TextStyle(
                                  color: Colors.blueGrey[800],
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
//          Navigator.of(context)
//              .push(MaterialPageRoute(builder: (BuildContext context) {
//            return BlocProvider<InventoryBloc>(
//              bloc: InventoryBloc(),
//              child: SpoiledDetails(dummy: dummy),
//            );

                        return Navigator.push(context,

                            MaterialPageRoute(builder: (context)
                            => FoodItemDetails(oneFoodItemData:oneFoodItem))
                        );
                      }));
//            return SpoiledItem(/*dummy: snapshot.data[index]*/);
          },

        )
    );
  }
}
class FoodListWithCategoryString extends StatelessWidget {


  // THERE WILL BE 4 CLASSES.
//
//1. FOR INITIAL LOADING OF ONLY PIZZA ITEMS.
//    2. INITIAL LOADING AND SEARCH FUNCTIONALITY.
//    3. CATEGOY FILTERING -------------------------THIS ONE IS 3.
//4. CATEGORY FILTERING AND SEARCH FILTERING.

  final List allFoods;


  final String categoryString;
  FoodListWithCategoryString({this.allFoods,this.categoryString});


  String listTitleCase(List<String> text) {
    // print("text: $text");
    if (text.length==0) {
      return " ";
    } else if (text == null) {
      return ' ';
    }
//    else if (text.length <= 1) {
//      return text.toUpperCase();
//    }
    else {
      return text
          .map((word) => word.split(' ')
          .map((word2) => word2[0].toUpperCase() + word2.substring(1)).join(' '))
          .join(', ');

    }
  }

//  const ChildScreen({Key key, this.func}) : super(key: key);

  // @override
//  bool updateShouldNotify(InheritedDataProvider oldWidget) => data != oldWidget.data;

  @override
  Widget build(BuildContext context) {

    print('categoryString  ##################################: $categoryString');


//    if(categoryString!=null){
    final List filteredItems = allFoods.where((oneItem ) => oneItem.categoryName.toLowerCase() ==
        categoryString.toLowerCase()).toList();

    int messageCount = filteredItems.length;
//    }
//    else{
//      filteredItems = allFoods.where((oneItem ) => oneItem.categoryName.toLowerCase() ==
//          'PIZZA'.toLowerCase()).toList();
//
//      messageCount = allFoods.length;
//    }

    print('messageCount: $messageCount');

    return(
        GridView.builder(
          itemCount:  messageCount,

/*
          gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(
            // The number of logical pixels between each child along the main axis.
              mainAxisSpacing: 20, // H  direction
              crossAxisSpacing: 0,

              ///childAspectRatio:
              /// The ratio of the cross-axis to the main-axis extent of each child.
              /// H/V
              childAspectRatio: 160/220,
              crossAxisCount: 3),
*/


          gridDelegate:
          new SliverGridDelegateWithMaxCrossAxisExtent(

            maxCrossAxisExtent: 270,
            mainAxisSpacing: 20, // H  direction
            crossAxisSpacing: 0,

            ///childAspectRatio:
            /// The ratio of the cross-axis to the main-axis extent of each child.
            /// H/V
            childAspectRatio: 160/220,


          ),
          shrinkWrap:false,

          itemBuilder: (_, int index) {
//            final DocumentSnapshot document = snapshot.data.documents[index];
//            final dynamic message = document['itemName'];
//            final dynamic imageURL = document['imageURL'];
//            categoryItems
//          print(allFoods[index].itemName);
//            final document = allFoods[index];
            final dynamic foodItemName =          filteredItems[index].itemName;
            final dynamic foodImageURL =          filteredItems[index].imageURL;
//            final String euroPrice = double.parse(filteredItems[index].priceinEuro).toStringAsFixed(2);
            final Map<String,String> foodSize_Value = filteredItems[index].size;

            final List<String> foodItemIngredientsList =  filteredItems[index].ingredient;

//            final String foodItemIngredients =    filteredItems[index].ingredients;
            final String foodItemId =             filteredItems[index].itemId;
            final bool foodIsHot =                filteredItems[index].isHot;
            final bool foodIsAvailable =          filteredItems[index].isAvailable;
            final String foodCategoryName =       filteredItems[index].categoryName;


            FoodItemWithDocID oneFoodItem =new FoodItemWithDocID(


              itemName: foodItemName,
              categoryName: foodCategoryName,
              imageURL: foodImageURL,

//              priceinEuro: euroPrice,
              ingredients: foodItemIngredientsList,

              itemId:foodItemId,
              isHot: foodIsHot,
              isAvailable: foodIsAvailable,

            );

            String stringifiedFoodItemIngredients =listTitleCase(foodItemIngredientsList);



//            print('document__________________________: ${document.data}');
//            Map<String, dynamic> oneFoodItemData = Map<String, dynamic>.from (document.data);
//            print('FoodItem:__________________________________________ $oneFoodItemData');


            return
              Container(
                // `opacity` is alpha channel of this color as a double, with 0.0 being
                //  ///   transparent and 1.0 being fully opaque.
                  color: Color.fromRGBO(239, 239, 239, 1.0),
                  padding: EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 16.0),
                  child: InkWell(
                      child: Column(
                        children: <Widget>[
//                                  Text(
//                                    'item name',
//                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
//                                        color: Colors.blueGrey[800],
//                                        fontSize: 16),
//                                  ),
//                                  SizedBox(height: 10),
                          new Container(
                            child: new Container(
                              width: displayWidth(context)*0.19,
                              height: displayWidth(context)*0.19,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(173, 179, 191, 1.0),
                                      blurRadius: 8.0,
                                      offset: Offset(0.0, 1.0))
                                ],
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                                  imageUrl: foodImageURL,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => new CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          ),
//                              SizedBox(height: 10),

            /*
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
//                                  double.parse(euroPrice).toStringAsFixed(2),
//                                  euroPrice,
                                  euroPrice+'\u20AC',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
//                                      color: Colors.blue,
                                      color:Color.fromRGBO(112,112,112,1),
                                      fontSize: 20),
                                ),
                                SizedBox(width: displayWidth(context)/100),

                                Icon(
                                  Icons.whatshot,
                                  size: 24,
                                  color: Colors.red,
                                ),
                              ]),

*/

//                              SizedBox(height: 10),

                          /*
                              Container(
                                height: 20,
                                child:Text(
//                '${dummy.counter}',
                                  foodItemName,
                                  style: TextStyle(
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
//                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              )
                              */

//                              Text('s'),
//                              Text('D'),


                          Text(
//                '${dummy.counter}',
                            foodItemName,

                            style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                          ,
                          Container(
//                              height: 20,
                              height: displayHeight(context)/61,
//                              height: displayWidth(context)/50,
                              child:Text(
                                stringifiedFoodItemIngredients.substring(0,10)+'..',
//                                foodItemIngredients.substring(0,10)+'..',
                                style: TextStyle(
                                  color: Colors.blueGrey[800],
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
//          Navigator.of(context)
//              .push(MaterialPageRoute(builder: (BuildContext context) {
//            return BlocProvider<InventoryBloc>(
//              bloc: InventoryBloc(),
//              child: SpoiledDetails(dummy: dummy),
//            );

                        return Navigator.push(context,

                            MaterialPageRoute(builder: (context)
                            => FoodItemDetails(oneFoodItemData:oneFoodItem))
                        );
                      }));
//            return SpoiledItem(/*dummy: snapshot.data[index]*/);
          },

        )
    );
  }
}



class FoodList extends StatelessWidget {



  FoodList({this.firestore});


  final Firestore firestore;
//  final FirebaseAuth _auth = FirebaseAuth.instance;


//  final FirebaseAuth _auth = FirebaseAuth.instance;
//  final String storageBucketURLPredicate;

  final FoodItem foodItemTest = new FoodItem();

// THERE WILL BE 4 CLASSES.
//
//1. FOR INITIAL LOADING OF ONLY PIZZA ITEMS.   ----------------THIS ONE IS 1.
//    2. INITIAL LOADING AND SEARCH FUNCTIONALITY.
//    3. CATEGOY FILTERING
//4. CATEGORY FILTERING AND SEARCH FILTERING.

//  List serverDataStateTemp=[];
//  int i =33;


  // a1.

  //  restaurants
  // USWc8IgrHKdjeDe9Ft4j

  Future<String> _getUserInfo1() async {

    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
//    Future<FirebaseUser> currentUser = await FirebaseAuth.instance.currentUser();

    return currentUser.uid;
//    return await getUserInfo2();
  }
  Map<String, String> headersMap = {
//    'Cookie' : 'jwt-cookie=eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI0IiwiaXNzIjoiMSIsInN1YiI6InRtYSIsImlhdCI6MTU1NjExNTY2MCwiZXhwIjoxNTU2NzIwNDYwfQ.DQMV59lTlGSgVN_viwlUaJIxZNO_Sru0gQT31EnKZEdD533OR9VUCRYaj5pY8ist48zRUmn6HXs4M_oWkkzm7A'
    'token':'BaArDBcLm8OodxaIMZKpiA7Vql72'
  };


  String listTitleCase(List<dynamic> text) {
    // print("text: $text");
    if (text.length==0) {
      return " ";
    } else if (text == null) {
      return ' ';
    }
//    else if (text.length <= 1) {
//      return text.toUpperCase();
//    }
    else {
      return text
          .map((word) => word.split(' ')
          .map((word2) => word2[0].toUpperCase() + word2.substring(1)).join(' '))
          .join(', ');

    }
  }

  @override
  Widget build(BuildContext context) {




    print('_getUserInfo1() ${_getUserInfo1()}');

    print('storageBucketURLPredicat: $storageBucketURLPredicate}');

    double textWidth = MediaQuery.of(context).size.width * 0.4;
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j').collection('foodItems')
          .where('category', isEqualTo: 'Pizza')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: new LinearProgressIndicator());

//          const Text('Loading...');


//        final List filteredItems = allFoods.where((oneItem ) => oneItem.categoryName.toLowerCase() ==
//            categoryString.toLowerCase()).toList();

//        int messageCount = filteredItems.length;

        final int messageCount = snapshot.data.documents.length;
        print('message count in condition 04: $messageCount');
        return(
            GridView.builder(
              itemCount:  messageCount,


              gridDelegate:
              /*
              new SliverGridDelegateWithFixedCrossAxisCount(
                // The number of logical pixels between each child along the main axis.
                  mainAxisSpacing: 20, // H  direction
                  crossAxisSpacing: 0,

                  ///childAspectRatio:
                  /// The ratio of the cross-axis to the main-axis extent of each child.
                  /// H/V
                  childAspectRatio: 160/220,
//                  childAspectRatio: 160/220,
                  crossAxisCount: 3),

               */
              new SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 270,
                mainAxisSpacing: 20, // H  direction
                crossAxisSpacing: 0,

                ///childAspectRatio:
                /// The ratio of the cross-axis to the main-axis extent of each child.
                /// H/V
                childAspectRatio: 160/220,


//                  childAspectRatio: 160/220,
              ),
              shrinkWrap:false,

              itemBuilder: (_, int index) {
//            final DocumentSnapshot document = snapshot.data.documents[index];
//            final dynamic message = document['itemName'];
//            final dynamic imageURL = document['imageURL'];
                final DocumentSnapshot document = snapshot.data.documents[index];
                final String foodItemName = document['name'];
                final String foodImageURL  = storageBucketURLPredicate + Uri.encodeComponent(document['image'])
                    +'?alt=media';

                print('foodImageURL: $foodImageURL');

//                final String euroPrice = double.parse(document['size']).toStringAsFixed(2);

//                final Map<String,String> foodSize_Value = document['size'];

                final List<dynamic> foodItemIngredientsList =  document['ingredient'];

//                final String foodItemId =  document['itemId'];

//                final bool foodIsHot =  document['isHot'];

                final bool foodIsAvailable =  document['available'];

//                final String foodCategoryName = document['categoryName'];


                FoodItemWithDocID oneFoodItem = new FoodItemWithDocID(

                  itemName: foodItemName,
//                  categoryName: foodCategoryName,
                  imageURL: foodImageURL,

//                  priceinEuro: euroPrice,
                  ingredients: foodItemIngredientsList,

//                  itemId:foodItemId,
//                  isHot: foodIsHot,
                  isAvailable: foodIsAvailable,
                  documentId: document.documentID,

                );

                String stringifiedFoodItemIngredients =listTitleCase(foodItemIngredientsList);

//                FoodItem oneFoodItem =new FoodItem(
//
//
//                  itemName: foodItemName,
//                  categoryName: foodCategoryName,
//                  imageURL: foodImageURL,
//
//                  priceinEuro: euroPrice,
//                  ingredients: foodItemIngredients,
//
//                  itemId:foodItemId,
//                  isHot: foodIsHot,
//                  isAvailable: foodIsAvailable,
//
//                );


                print('document__________________________: ${document.data}');
                Map<String, dynamic> oneFoodItemData = Map<String, dynamic>.from (document.data);
                print('FoodItem:__________________________________________ $oneFoodItemData');


                return
                  Container(
                      color: Color.fromRGBO(239, 239, 239, 0),
                      padding: EdgeInsets.symmetric(
//                          horizontal: 10.0, vertical: 22.0),
                          horizontal: 4.0, vertical: 16.0),
                      child: InkWell(
                          child: Column(
                            children: <Widget>[
//                                  Text(
//                                    'item name',
//                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
//                                        color: Colors.blueGrey[800],
//                                        fontSize: 16),
//                                  ),
//                                  SizedBox(height: 10),
                              new Container(
                                child: new Container(
                                  width: displayWidth(context) * 0.19,
                                  height: displayWidth(context) * 0.19,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(173, 179, 191, 1.0),
                                          blurRadius: 8.0,
                                          offset: Offset(0.0, 1.0))
                                    ],
                                  ),
                                  child: ClipOval(
                                    /*
                                    child:Image.network(
                                      oneFoodItem.imageURL,
                                      width: 100,
                                      headers: headersMap,
                                    ),
*/
//                                    'Cookie' : 'jwt-cookie=eyJ
                                    child: CachedNetworkImage(
//                  imageUrl: dummy.url,
//                                      httpHeaders: headersMap,

//                                      alt=media&token=3fe221b9-a340-40bb-9caa-cebc1face1fe

                                      imageUrl:
                                      oneFoodItem.imageURL,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => new CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
//                              SizedBox(height: 10),

/*
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
//                                  double.parse(euroPrice).toStringAsFixed(2),
                                      euroPrice+'\u20AC',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
//                                          color: Colors.blue,
                                          color:Color.fromRGBO(112,112,112,1),
                                          fontSize: 20),
                                    ),
//                                    SizedBox(width: 10),
                                    SizedBox(width: displayWidth(context)/100),

                                    Icon(
                                      Icons.whatshot,
                                      size: 24,
                                      color: Colors.red,
                                    ),
                                  ]),

*/

//                              SizedBox(height: 10),

                              /*
                              Container(
                                height: 20,
                                child:Text(
//                '${dummy.counter}',
                                  foodItemName,
                                  style: TextStyle(
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
//                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              )
                              */

//                              Text('s'),
//                              Text('D'),


                              Text(
//                '${dummy.counter}',
                                foodItemName,

                                style: TextStyle(
                                  color: Colors.blueGrey[800],
//                                color:Color.fromRGBO(112,112,112,1),

                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                              ,

                              Container(
                                  height: displayHeight(context)/61,
                                  child:Text(
                                    stringifiedFoodItemIngredients,
//                stringifiedFoodItemIngredients.substring(0,10)+'..',
//                                    foodItemIngredients.substring(0,10)+'..',
                                    style: TextStyle(
                                      color: Colors.blueGrey[800],
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
//          Navigator.of(context)
//              .push(MaterialPageRoute(builder: (BuildContext context) {
//            return BlocProvider<InventoryBloc>(
//              bloc: InventoryBloc(),
//              child: SpoiledDetails(dummy: dummy),
//            );

                            print('for future use');
                            return Navigator.push(context,

                                MaterialPageRoute(builder: (context)
                                => FoodItemDetails(oneFoodItemData:oneFoodItem))
                            );
                          }));
//            return SpoiledItem(/*dummy: snapshot.data[index]*/);
              },

            )
        );


      },
    );
  }

}




class MyPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(60, 10);
    final p2 = Offset(10, 10);
    final paint = Paint()
      ..color = Colors.white
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