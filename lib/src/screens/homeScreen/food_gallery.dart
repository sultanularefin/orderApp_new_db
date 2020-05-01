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
    getDataFromFirestore();
    super.initState();

  }

  getDataFromFirestore() async {
    Firestore.instance
        .collection('foodItems').orderBy("uploadDate", descending: true)
        .snapshots()
        .listen((data) =>
        data.documents.forEach((doc) {
//      document['itemName'];

          print('doc: ***************************** ${doc['uploadDate']
              .toDate()}');
//      doc: ***************************** Instance of 'DocumentSnapshot'

//      final DocumentSnapshot document = snapshot.data.documents[index];


//      final DocumentSnapshot document = snapshot.data.documents[index];
          final dynamic foodItemName = doc['itemName'];
          final dynamic foodImageURL = doc['imageURL'];
          final String euroPrice = double.parse(doc['priceinEuro'])
              .toStringAsFixed(2);
          final String foodItemIngredients = doc['ingredients'];
          final String foodItemId = doc['itemId'];
          final bool foodIsHot = doc['isHot'];
          final bool foodIsAvailable = doc['isAvailable'];
          final String foodCategoryName = doc['categoryName'];
          final String foodItemDocumentID = doc.documentID;


          FoodItemWithDocID oneFoodItemWithDocID = new FoodItemWithDocID(


            itemName: foodItemName,
            categoryName: foodCategoryName,
            imageURL: foodImageURL,

            priceinEuro: euroPrice,
            ingredients: foodItemIngredients,

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


  Widget _buildRow(String categoryName, int index) {

    if (_currentCategory==categoryName){
      return ListTile(
//        trailing: CustomPaint(size: Size(0,19),
//          painter: MyPainter(),
//        ),

//        contentPadding: EdgeInsets.symmetric(
//            horizontal: 4.0, vertical: 6.0),

        contentPadding: EdgeInsets.fromLTRB(20, 6, 10, 6),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(categoryName
                ,
//    Text(categoryName.substring(0, 2),
                style: TextStyle(
                  color:Color.fromRGBO(255,255,255,1),
//                  color:Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
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
        contentPadding: EdgeInsets.fromLTRB(20, 6, 10, 6),

        title: Text(categoryName,
//    Text(categoryName.substring(0, 2),
          style: TextStyle(
//            color:Color.fromRGBO(84,70,62,1),
            color:Color.fromRGBO(255,255,255,1),
            fontWeight: FontWeight.normal,
            fontSize: 18,
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
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                left: 20, top: 3, bottom: 3, right: 4.5),
                            child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(

                                  height: 25,
                                  width: 25,
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
                            return _buildRow(categoryItems[index], index);
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
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                  left: 20, top: 3, bottom: 3, right: 4.5),
                              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(

                                    height: 25,
                                    width: 25,
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
                              return _buildRow(categoryItems[index], index);
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
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                  left: 20, top: 3, bottom: 3, right: 4.5),
                              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(

                                    height: 25,
                                    width: 25,
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
                              return _buildRow(categoryItems[index], index);
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[

                            // CONTAINER FOR TOTAL PRICE CART BELOW.
                            Container(
                              margin:EdgeInsets.symmetric(
                                  horizontal: displayWidth(context)
                                      /20,
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
                              width: displayWidth(context)/5,
                              height: displayHeight(context)/40,
                              padding: EdgeInsets.only(
                                  left: 20, top: 3, bottom: 3, right: 4.5),
                              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(

                                    height: 25,
                                    width: 25,
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

                            // CONTAINER FOR TOTAL PRICE CART ABOVE.


                            // PROBLEM CODES BELOW.....
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
                              return _buildRow(categoryItems[index], index);
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
            final String euroPrice = double.parse(filteredItems[index].priceinEuro).toStringAsFixed(2);
            final String foodItemIngredients =    filteredItems[index].ingredients;
            final String foodItemId =             filteredItems[index].itemId;
            final bool foodIsHot =                filteredItems[index].isHot;
            final bool foodIsAvailable =          filteredItems[index].isAvailable;
            final String foodCategoryName =       filteredItems[index].categoryName;


            FoodItemWithDocID oneFoodItem =new FoodItemWithDocID(


              itemName: foodItemName,
              categoryName: foodCategoryName,
              imageURL: foodImageURL,

              priceinEuro: euroPrice,
              ingredients: foodItemIngredients,

              itemId:foodItemId,
              isHot: foodIsHot,
              isAvailable: foodIsAvailable,

            );


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

                                foodItemIngredients.substring(0,10)+'..',
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
            final String euroPrice = double.parse(filteredItems[index].priceinEuro).toStringAsFixed(2);
            final String foodItemIngredients =    filteredItems[index].ingredients;
            final String foodItemId =             filteredItems[index].itemId;
            final bool foodIsHot =                filteredItems[index].isHot;
            final bool foodIsAvailable =          filteredItems[index].isAvailable;
            final String foodCategoryName =       filteredItems[index].categoryName;


            FoodItemWithDocID oneFoodItem =new FoodItemWithDocID(


              itemName: foodItemName,
              categoryName: foodCategoryName,
              imageURL: foodImageURL,

              priceinEuro: euroPrice,
              ingredients: foodItemIngredients,

              itemId:foodItemId,
              isHot: foodIsHot,
              isAvailable: foodIsAvailable,

            );


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

                                foodItemIngredients.substring(0,10)+'..',
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
  final FoodItem foodItemTest = new FoodItem();

// THERE WILL BE 4 CLASSES.
//
//1. FOR INITIAL LOADING OF ONLY PIZZA ITEMS.   ----------------THIS ONE IS 1.
//    2. INITIAL LOADING AND SEARCH FUNCTIONALITY.
//    3. CATEGOY FILTERING
//4. CATEGORY FILTERING AND SEARCH FILTERING.

//  List serverDataStateTemp=[];
//  int i =33;

  @override
  Widget build(BuildContext context) {
    double textWidth = MediaQuery.of(context).size.width * 0.4;
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("foodItems").where('categoryName', isEqualTo: 'PIZZA')
          .orderBy("uploadDate", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: new LinearProgressIndicator());

//          const Text('Loading...');


//        final List filteredItems = allFoods.where((oneItem ) => oneItem.categoryName.toLowerCase() ==
//            categoryString.toLowerCase()).toList();

//        int messageCount = filteredItems.length;

        final int messageCount = snapshot.data.documents.length;
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
                final dynamic foodItemName = document['itemName'];
                final dynamic foodImageURL = document['imageURL'];
                final String euroPrice = double.parse(document['priceinEuro']).toStringAsFixed(2);
                final String foodItemIngredients =  document['ingredients'];
                final String foodItemId =  document['itemId'];
                final bool foodIsHot =  document['isHot'];
                final bool foodIsAvailable =  document['isAvailable'];
                final String foodCategoryName = document['categoryName'];


                FoodItemWithDocID oneFoodItem = new FoodItemWithDocID(

                  itemName: foodItemName,
                  categoryName: foodCategoryName,
                  imageURL: foodImageURL,

                  priceinEuro: euroPrice,
                  ingredients: foodItemIngredients,

                  itemId:foodItemId,
                  isHot: foodIsHot,
                  isAvailable: foodIsAvailable,
                  documentId: document.documentID,

                );

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

                                    foodItemIngredients.substring(0,10)+'..',
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