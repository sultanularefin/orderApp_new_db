// package/ external dependency files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:foodgallery/src/screens/drawerScreen/drawerScreen.dart';

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
//import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphic/neumorphic.dart';

//C:/src/flutter/.pub-cache/hosted/pub.dartlang.org/neumorphic-0.3.0/lib/src/components/neu_card.dart
// local packages

import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import 'package:foodgallery/src/screens/foodItemDetailsPage/foodItemDetails.dart';
//import 'package:shared_preferences/shared_preferences.dart';

// Screen files.


// models, dummy data file:

import '../../DataLayer/itemData.dart';
import '../../DataLayer/FoodItem.dart';
import '../../DataLayer/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/newCategory.dart';

// Blocks

import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
import 'package:foodgallery/src/BLoC/foodItems_query_bloc.dart';


//import './../../shared/category_Constants.dart' as Constants;


//import CategoryItems from 'package:foodgallery/src/shared/category_Constants.dart';


final Firestore firestore = Firestore();



class FoodGallery2 extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;

  final Firestore firestore = Firestore.instance;


  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FoodGallery2({Key key, this.child}) : super(key: key);



  _FoodGalleryState createState() => _FoodGalleryState();

}


class _FoodGalleryState extends State<FoodGallery2> {


  _FoodGalleryState({firestore});

  File _image;



  List<NewCategoryItem>_allCategoryList=[];


  @override
  void initState() {
    super.initState();

  }




  //  final _formKey = GlobalKey();

  final _formKey = GlobalKey<FormState>();



  String _searchString = '';
  String _currentCategory = "pizza";
  String _firstTimeCategoryString = "";
  double _total_cart_price = 1.00;
  // empty MEANS PIZZA



  Widget _buildCategoryRow(/*DocumentSnapshot document*/
      String oneCategory, int index) {

//    final DocumentSnapshot document = snapshot.data.documents[index];
    final String categoryName = oneCategory;
//    final String categoryName = document['name'];
    if (_currentCategory.toLowerCase()==categoryName.toLowerCase()){


      return
/*
        Neumorphic(
          style: NeumorphicStyle(
          border: NeumorphicBorder(
          color: Color(0xff54463E),
//                  width: 0.8,
    )
    ),

 */
        NeuCard(
          // State of Neumorphic (may be convex, flat & emboss)
          curveType: CurveType.concave,
//            padding: EdgeInsets.symmetric(horizontal: 3,vertical:0),
          margin: EdgeInsets.fromLTRB(12, 0, 5, 0),

          // Elevation relative to parent. Main constituent of Neumorphism
//            bevel: 12,

          // Specified decorations, like `BoxDecoration` but only limited
          decoration: NeumorphicDecoration(
            borderRadius: BorderRadius.circular(8),
            shape: BoxShape.rectangle,
            clipBehavior: Clip.antiAlias,
            color: Color(0xff54463E),
          ),

          //ZZZ
          // Other arguments such as margin, padding etc. (Like `Container`)
          child:
          ListTile(
//        trailing: CustomPaint(size: Size(0,19),
//          painter: MyPainter(),
//        ),

//        contentPadding: EdgeInsets.symmetric(
//            horizontal: 4.0, vertical: 6.0),

            contentPadding: EdgeInsets.fromLTRB(10, 6, 10, 6),

            title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(categoryName.toUpperCase()
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
                _searchString = '';
              });
            }, // ... to here.
          ),
        );
    }
    else {
      return ListTile(
        contentPadding: EdgeInsets.fromLTRB(10, 6, 10, 6),

        title:  Text(categoryName.toUpperCase(),
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
            _searchString = '';
          });
        }, // ... to here.
      );
    }
  }


  Widget _buildCategoryRowWithSnapshot(DocumentSnapshot document, int index) {

//    final DocumentSnapshot document = snapshot.data.documents[index];
    final String categoryName = document['name'];
    if (_currentCategory.toLowerCase()==categoryName.toLowerCase()){
      return
/*
        Neumorphic(
          style: NeumorphicStyle(
          border: NeumorphicBorder(
          color: Color(0xff54463E),
//                  width: 0.8,
    )
    ),

 */
        NeuCard(
          // State of Neumorphic (may be convex, flat & emboss)
            curveType: CurveType.concave,
//            padding: EdgeInsets.symmetric(horizontal: 3,vertical:0),
            margin: EdgeInsets.fromLTRB(12, 0, 5, 0),

            // Elevation relative to parent. Main constituent of Neumorphism
//            bevel: 12,

            // Specified decorations, like `BoxDecoration` but only limited
            decoration: NeumorphicDecoration(
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
              clipBehavior: Clip.antiAlias,
              color: Color(0xff54463E),
            ),

            // Other arguments such as margin, padding etc. (Like `Container`)
            child: ListTile(

              contentPadding: EdgeInsets.fromLTRB(10, 6, 10, 6),
//    FittedBox(fit:BoxFit.fitWidth, stringifiedFoodItemIngredients
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(categoryName.toUpperCase()
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
            )
        );
    }
    else {
      return ListTile(
        contentPadding: EdgeInsets.fromLTRB(10, 6, 10, 6),

        title:  Text(categoryName.toUpperCase(),
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

  num tryCast<num>(dynamic x, {num fallback }) => x is num ? x : 0.0;


  var logger = Logger(
    printer: PrettyPrinter(),
  );


  @override
  Widget build(BuildContext context) {
//    String a = Constants.SUCCESS_MESSAGE;


//    _searchString

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

                              height:displayHeight(context)/13,
                              color: Color(0xffFFFFFF),
//                      color: Color.fromARGB(255, 255,255,255),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                              color: Color(0xff54463E),
                                              blurRadius: 10.0,
                                              offset: Offset(0.0, 2.0))
                                        ],
                                        color: Colors.black54),
                                    width: displayWidth(context)/5,
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
                                            Icons.add_shopping_cart,
                                            size: 28,
                                            color: Colors.white,
                                          ),
                                        ),
//                                  Spacer(),
                                        Text(_total_cart_price.toStringAsFixed(2) +' kpl',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,

                                            )),
//                                  Spacer(),

                                      ],
                                    ),
                                  ),

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
                                              logger.i('on onChanged of condition 4');

                                              setState(() => _searchString = text);
                                              print("First text field from Condition 04: $text");
                                            },
                                            onTap:(){
                                              print('condition 4');
                                              logger.i('on Tap of condition 4');
                                              setState(() {
                                                _firstTimeCategoryString ='PIZZA';
                                              });

                                            },

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
                                          ),

                                        )

//                                  Spacer(),

//                                  Spacer(),

                                      ],
                                    ),
                                  ),



                                ],
                              ),
                            ),

                            // CONTAINER FOR TOTAL PRICE CART ABOVE.
                            Container(
                              height:displayHeight(context) -
                                  MediaQuery.of(context).padding.top  - displayHeight(context)/13,
                              child: FoodList(),
                            ),

                          ]
                      )
                  ),

                  Container(
                    height: displayHeight(context) -
                        MediaQuery.of(context).padding.top ,
                    padding:EdgeInsets.symmetric(horizontal: 0,vertical: displayHeight(context)/13),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 3.8,
//              color: Colors.yellowAccent,
                    color: Color(0xff54463E),
//                          color: Color.fromARGB(255, 84, 70, 62),
//              child:Text('ss'),
                    child:StreamBuilder<QuerySnapshot>(
                        stream: firestore
                            .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j').
                        collection('categories').orderBy("rating", descending: true)
//        .where('category', isEqualTo: 'Pizza')
                            .snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: new LinearProgressIndicator());

                          else{
                            final int categoryCount = snapshot.data.documents.length;
//                              print('categoryCount in condition 04: ');


//                                logger.i("categoryCount in condition 04: $categoryCount");

                            return(
                                new ListView.builder
                                  (
                                    itemCount: categoryCount,


                                    //    itemBuilder: (BuildContext ctxt, int index) {
                                    itemBuilder: (_, int index) {
                                      return _buildCategoryRowWithSnapshot(snapshot.data.documents[index]
                                          /*categoryItems[index]*/, index);
                                    }
                                )
                            )
                            ;
                          }
                        }
                    ),
                  )
                ],
              ),
            )
            ,)

      ),
    );


  }
}

//
//class FoodList extends StatelessWidget {
//  FoodList({this.firestore});

class FoodList extends StatelessWidget {



  FoodList();


//  final Firestore firestore;
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
  // THIS IS NOT REQUIRED below:
  Map<String, String> headersMap = {
//    'Cookie' : 'jwt-cookie=eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI0IiwiaXNzIjoiMSIsInN1YiI6InRtYSIsImlhdCI6MTU1NjExNTY2MCwiZXhwIjoxNTU2NzIwNDYwfQ.DQMV59lTlGSgVN_viwlUaJIxZNO_Sru0gQT31EnKZEdD533OR9VUCRYaj5pY8ist48zRUmn6HXs4M_oWkkzm7A'
    'token':'BaArDBcLm8OodxaIMZKpiA7Vql72'
  };

  var logger = Logger(
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

//    final bloc = LocationQueryBloc();

//    final blocZZ = FoodItemsQueryBloc();

    final bloc = BlocProvider.of<FoodGalleryBloc>(context);

//    bloc.getAllFoodItems();
    //*
    return FutureBuilder<List<FoodItemWithDocID>>(
//        stream:bloc.getAllFoodItems(),

      future:bloc.getAllFoodItems(),


        initialData: bloc.allFoodItems,
//        initialData: bloc.getAllFoodItems(),
      builder: (context, snapshot){

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
        print('snapshot.hasData : ${snapshot.hasData}');
        final int messageCount = snapshot.data.length;
        print('message count in condition 04: $messageCount');

        if(snapshot.hasData) {
//          return Center(child:
//          Text('${messageCount.toString()}')
//          );

//          print('categoryString  ##################################: $categoryString');
          final List allFoods =snapshot.data;

          final List filteredItems = allFoods.where((oneItem ) => oneItem.categoryName.
          toLowerCase() ==
              'PIZZA'.toLowerCase()).toList();
          return(Container(
            color: Color(0xffFFFFFF),
            child:
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



                maxCrossAxisExtent: 290,
                mainAxisSpacing: 0, // H  direction
                crossAxisSpacing: 5,
                childAspectRatio: 160/160,


              ),
              shrinkWrap:false,

              itemBuilder: (_, int index) {
//            final DocumentSnapshot document = snapshot.data.documents[index];
//            final dynamic message = document['itemName'];
//            final dynamic imageURL = document['imageURL'];
//            categoryItems
//          print(allFoods[index].itemName);
//            final document = allFoods[index];



//            logger.i("allFoods Category STring testing line # 1862: ${filteredItems[index]}");

//
                final String foodItemName =          filteredItems[index].itemName;
                final String foodImageURL =          filteredItems[index].imageURL;

//            logger.i("foodImageURL in CAtegory tap: $foodImageURL");




//            final String euroPrice = double.parse(filteredItems[index].priceinEuro).toStringAsFixed(2);
                final Map<String,dynamic> foodSizePrice = filteredItems[index].sizedFoodPrices;

//            final List<String> foodItemIngredientsList =  filteredItems[index].ingredient;
                final List<dynamic> foodItemIngredientsList =  filteredItems[index].ingredients;

//            final String foodItemIngredients =    filteredItems[index].ingredients;
//            final String foodItemId =             filteredItems[index].itemId;
//            final bool foodIsHot =                filteredItems[index].isHot;
                final bool foodIsAvailable =          filteredItems[index].isAvailable;
                final String foodCategoryName =       filteredItems[index].categoryName;

//            final Map<String,dynamic> foodSizePrice = document['size'];

//            final List<dynamic> foodItemIngredientsList =  document['ingredient'];
                print('foodSizePrice __________________________${foodSizePrice['normal']}');
                final dynamic euroPrice = foodSizePrice['normal'];

//                num euroPrice2 = tryCast(euroPrice);
                double euroPrice2 = tryCast<double>(euroPrice, fallback: 0.00);
//                String euroPrice3= num.toString();
                print('euroPrice2 :$euroPrice2');

                String euroPrice3 = euroPrice2.toStringAsFixed(2);

                FoodItemWithDocID oneFoodItem =new FoodItemWithDocID(


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

                String stringifiedFoodItemIngredients =listTitleCase(foodItemIngredientsList);



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
                                  width: displayWidth(context) *  0.23,
                                  height: displayWidth(context) *  0.23,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
//                                          707070
//                                              color:Color(0xffEAB45E),
// good yellow color
//                                            color:Color(0xff000000),
                                          color:Color(0xff707070),
// adobe xd color
//                                              color: Color.fromRGBO(173, 179, 191, 1.0),
                                          blurRadius: 40.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(0, 21)
                                      )
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
                                      euroPrice3 +'\u20AC',
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


                              FittedBox(fit:BoxFit.fitWidth,child:
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
                                  height: displayHeight(context)/61,

                                  child:Text(
//                                'stringifiedFoodItemIngredients',


                                    stringifiedFoodItemIngredients.length==0?
                                    'EMPTY':  stringifiedFoodItemIngredients.length>12?
                                    stringifiedFoodItemIngredients.substring(0,12)+'...':
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
//          Navigator.of(context)
//              .push(MaterialPageRoute(builder: (BuildContext context) {
//            return BlocProvider<InventoryBloc>(
//              bloc: InventoryBloc(),
//              child: SpoiledDetails(dummy: dummy),
//            );


//                        Type focusedType = Focus.of(context).context.widget.runtimeType;
//                        logger.i('focusedType: $focusedType');
//                        FocusScope.of(context).unfocus();


                            return Navigator.push(context,

                                MaterialPageRoute(builder: (context)
                                => FoodItemDetails(oneFoodItemData:oneFoodItem))
                            );
                          }));
//            return SpoiledItem(/*dummy: snapshot.data[index]*/);
              },

            ),
          )
          );
        }
        else{
          return Center(child:
          Text('No Data')
          );
        }
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