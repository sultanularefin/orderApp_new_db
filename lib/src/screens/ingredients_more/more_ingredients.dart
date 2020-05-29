
//food_gallery.dart


// DEPENDENCY FILES BEGINS HERE.
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:logger/logger.dart';

// DEPENDENCY FILES ENDS HERE.
//sizeConstantsList


//import './../../shared/category_Constants.dart' as Constants;
//SCREEN FILES


// SCREEN FILES ENDS HERE.

import 'package:foodgallery/src/DataLayer/IngredientItem.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

// MODEL FILES BEGINS HERE.

import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/itemData.dart';

import 'package:foodgallery/src/DataLayer/models/Order.dart';

import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
// BOTH ARE CORRECT.
//import './../../models/NewIngredient.dart';

// MODEL FILES ENDS HERE.

final Firestore firestore = Firestore();

class MoreIngredients extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;
//  final FoodItem oneFoodItemData;

  final Firestore firestore = Firestore.instance;
  final FoodItemWithDocID oneFoodItemData1;
  final List<String> onlyIngredientsNames1;


  MoreIngredients({Key key, this.child,this.oneFoodItemData1,this.onlyIngredientsNames1}) : super(key: key);

  @override
  _MoreIngredientsPageState createState() => new _MoreIngredientsPageState(oneFoodItemData1,onlyIngredientsNames1);

}


class _MoreIngredientsPageState extends State<MoreIngredients> {

  //  final _formKey = GlobalKey();

  FoodItemWithDocID oneFoodItemandId2;

  final List<String> onlyIngredientsNames2;
  _MoreIngredientsPageState(this.oneFoodItemandId2,this.onlyIngredientsNames2);

  final _formKey = GlobalKey<FormState>();

  int _radioValue = 0;
  int _sizeValue = 0;

  double totalCartPrice = 0;
//  double totalCartPrice = 1.00;
  int _itemCount=1;
  final _itemData = ItemData();
  String _searchString = '';
  String _currentCategory = "PIZZA".toLowerCase();
  String _firstTimeCategoryString = "";
  List<NewIngredient> ingredients;

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  int selectedIngredientCount = 4; // DEFAULT INGREDIENTS.

//  List<UserIngredientAmountData> defaultIngredientListForFood = new List<UserIngredientAmountData>();

//  List<IngredientItem> defaultIngredientListForFood = new List<IngredientItem>();
//  List<IngredientItem> defaultIngredientListForFood;

  List<NewIngredient> defaultIngredientListForFood;


  List<NewIngredient> _ingredientlistUnSelected;


  List<NewIngredient> _allIngredientsList;

//  final _allIngredientsList = [];






  @override
  void initState() {
//    getIngredientDataFromFirestore();
    retrieveIngredients1();
    super.initState();

  }


  static Future <List> retrieveIngredients2() async {
    List<NewIngredient> ingItems = new List<NewIngredient>();
    var snapshot = await Firestore.instance.collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j')
        .collection('ingredients')
        .getDocuments();

//    firestore
//        .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j')
//        .collection('ingredients').

    List docList = snapshot.documents;
//    print('doc List at more Ingredient page (init State) :  ******************* <================ : $docList');

    // ingItems = snapshot.documents.map((documentSnapshot) => IngredientItem.fromMap
    //(documentSnapshot.data)).toList();

    ingItems = snapshot.documents.map((documentSnapshot) => NewIngredient.fromMap
      (documentSnapshot.data,documentSnapshot.documentID)

    ).toList();


    List<String> documents = snapshot.documents.map((documentSnapshot) =>
    documentSnapshot.documentID
    ).toList();

    print('documents are [More_ingredients page] : ${documents.length}');
//    print('documents are: $documents');


    return ingItems;
  }



  Future<void> retrieveIngredients1() async {
    debugPrint("Entering in retrieveIngredients1");

    await retrieveIngredients2().then((onValue){

      List<NewIngredient> filteredIngredients = filterSelectedIngredients(onValue);

//      logger.i('filteredIngredients: ',filteredIngredients);
//
//      logger.i('important default list (test): ',filteredIngredients);

//      print('onValue: |||||||||||||||||||||||||||||||||||||||||||||||||||||||$onValue');


      List<NewIngredient> defaultMinus =
      onValue.toSet().difference(filteredIngredients.toSet()).toList();

//      ingItems = snapshot.documents.map((documentSnapshot) => NewIngredient.fromMap
//        (documentSnapshot.data,documentSnapshot.documentID)
//
//      ).toList();


      List<NewIngredient> unSelectedDecremented =  defaultMinus.map((oneIngredient)=>NewIngredient.updateIngredient(
          oneIngredient
      )).toList();


//      return dlist.where((oneItem) =>oneItem.ingredientName.trim().toLowerCase()
//          ==
//          searchForThisIngredient(oneItem.ingredientName.trim().toLowerCase())
//      ).toList();

//      List<NewIngredient> unSelectedDecremented = <NewIngredient>[defaultMinus.length];
//      final List<Widget> children = <Widget>[];
//      _tasks.forEach((StorageUploadTask task) {
//        final Widget tile = UploadTaskListTile(
//          task: task,
//          onDismissed: () => setState(() => _tasks.remove(task)),
//          onDownload: () => _downloadFile(task.lastSnapshot.ref),
//        );
//        children.add(tile);
//      });

      setState(() {

        defaultIngredientListForFood = filteredIngredients;

//        defaultIngredientListForFood = onValue.sublist(0,4);
//        _ingredientlistUnSelected = onValue.sublist(4);

        _ingredientlistUnSelected = unSelectedDecremented;
        _allIngredientsList = onValue;
      }
      );

    }
    );
  }




//  NewIngredient updateIngredient(NewIngredient oneNewIngredient) {
//
//    // List<String> stringList = List<String>.from(dlist);
//
//    logger.i('oneNewIngredient ====================================> ',oneNewIngredient);
//
//    return oneNewIngredient.addAll({
//      "lastName": "Smith",
//      "age": 26,
//    });
//
//  }



  List<NewIngredient> filterSelectedIngredients(List<NewIngredient> dlist) {

    // List<String> stringList = List<String>.from(dlist);

//    logger.i('dlist ====================================> ',dlist);

    return dlist.where((oneItem) =>oneItem.ingredientName.trim().toLowerCase()
        ==
        searchForThisIngredient(oneItem.ingredientName.trim().toLowerCase())
    ).toList();

  }

  String searchForThisIngredient(String inputString) {


    List<String> foodIngredients = onlyIngredientsNames2;

//    logger.w('onlyIngredientsNames2',onlyIngredientsNames2);


    String elementExists = foodIngredients.firstWhere(
            (oneItem) => oneItem.toLowerCase() == inputString,
        orElse: () => '');

    print('elementExists: $elementExists');

    return elementExists.toLowerCase();

  }


  /*
  // MODIFICATION OF THIS CODE TO BE USED WHEN USED WITH BLOCK PATTERN.
  FILTER selected from the unselected since set operation is deep, but we need to compare only one field.

  ingrendient name to ingredient name of unselected INGREDIENT ITEM, e.g.
  String searchForThisIngredientInIngredientList(String inputString) {


    List<String> foodIngredients = onlyIngredientsNames2;

//    logger.w('onlyIngredientsNames2',onlyIngredientsNames2);


    String elementExists = foodIngredients.firstWhere(
            (oneItem) => oneItem.toLowerCase() == inputString,
        orElse: () => '');

    print('elementExists: $elementExists');

    return elementExists.toLowerCase();

  }

  */

  @override
  Widget build(BuildContext context) {

//    final _allIngredientsList = [];
//    List<IngredientItem> ingredientlistFinal;

//    print('ingredientlistFinal ====================================: $defaultIngredientListForFood');
//
//    print('__ingredientlistUnSelected ||||||||||||||||||||||||||||||||||: $_ingredientlistUnSelected');
//
    print('at build _____________________________________________________________________');
//
//    print('widget.oneFoodItemData.itemName:__________________________________________ ${widget.oneFoodItemData.imageURL}');
    print('oneFoodItemandId.imageURL:_________________________________________ ${oneFoodItemandId2.imageURL}');

    logger.i('oneFoodItemandId',oneFoodItemandId2);

//    String a = Constants.SUCCESS_MESSAGE;
    if(_ingredientlistUnSelected==null){
      return Container
        (
          alignment: Alignment.center,
          child:LinearProgressIndicator()
      );
    }

    else {

//      logger.i('defaultIngredientListForFood[0]: ',defaultIngredientListForFood[0].ingredientName);
//      logger.i('defaultIngredientListForFood[1]: ',defaultIngredientListForFood[1].imageURL);
//
//      logger.i('defaultIngredientListForFood[0]: ',defaultIngredientListForFood[0].imageURL);
//
//      logger.i('defaultIngredientListForFood[2]: ',defaultIngredientListForFood[2].imageURL);

//    logger.i('docID: ',defaultIngredientListForFood[0].documentId);
//
//    logger.i('docID: ',defaultIngredientListForFood[2].documentId);
//    logger.i('docID: ',defaultIngredientListForFood[3].documentId);
//    logger.i('docID: ',defaultIngredientListForFood[4].documentId);

      return Scaffold(
          body:
          SafeArea(
            child:
            // MAIN COLUMN FOR THIS PAGE.
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

//      1ST CONTAINER STARTS HERE || BELOW ||
//                #### 1ST CONTAINER SEARCH STRING AND TOTAL ADD TO CART PRICE.
                // EVERYTHING IS FINE HERE.
                //


                Container(

//                color: Color.fromRGBO(239, 239, 239, 1.0),
//                  color: Color.fromRGBO(239, 239, 239, 1.0),
                  color: Color(0xffF7F0EC),

                  height: 100,

                  width: displayWidth(context),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      // GO BACK TO MENU STARTS HERE.
                      Container(
                        height: displayHeight(context) / 30,
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.chevron_left, size: 32.0),
                              color: Colors.grey,

                              tooltip: MaterialLocalizations
                                  .of(context)
                                  .openAppDrawerTooltip,
                            ),
                            FlatButton(
//                color: Colors.blue,
                              textColor: Colors.white,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              padding: EdgeInsets.all(8.0),
//                splashColor: Colors.blueAccent,

                              onPressed: () => Navigator.pop(context),

                              child: Text('Go back to menu', style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 22),
                              ),
                            )

                          ],
                        ),
                      ),

                      // GO BACK TO MENU ENDS HERE.


                      // PRICE CART AT THE TOP STARTS HERE.

                      Container(


//                      color: Color.fromARGB(255, 255,255,255),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[

                            // CONTAINER FOR TOTAL PRICE CART BELOW.
                            Container(
                              alignment: Alignment.center,
                              height: 100,
                              child:
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: displayWidth(context)
                                        / 20,
                                    vertical: 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(
                                              250, 200, 200, 1.0),
                                          blurRadius: 10.0,
                                          offset: Offset(0.0, 2.0))
                                    ],
//                                color: Colors.black54),
                                    color: Color.fromRGBO(112, 112, 112, 1)),
                                width: displayWidth(context) / 5,

                                height: displayHeight(context) / 30,
                                // BOX DECORATION HEIGHT WHICH HOLDS OTHER ICONS IN TOTAL PRICE CART AT THE TOP.

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
                                    Text(totalCartPrice.toStringAsFixed(2) +
                                        ' kpl',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),

                                    CustomPaint(size: Size(0, 19),
                                      painter: LongHeaderPainter(),
                                    )


                                  ],
                                ),
                              ),
                            ),

                            // CONTAINER FOR TOTAL PRICE CART ABOVE.


                          ],

                        ),
                      ),


                    ],
                  ),
                ),

                //      1ST CONTAINER ENDS HERE || ABOVE ||
//                #### 1ST CONTAINER SEARCH STRING AND TOTAL ADD TO CART PRICE.
                // EVERYTHING IS FINE HERE.
                //


                //                #### 2ND CONTAINER SIDE MENUS AND GRIDLIST.
                Container(
                  color: Color.fromRGBO(239, 239, 239, 1.0),
                  height: displayHeight(context) -
                      MediaQuery
                          .of(context)
                          .padding
                          .top - 100,
                  //where 100 IS THE HEIGHT OF 1ST CONTAINER HOLDING SEARCH INPUT AND TOTAL CART PRICE.


                  //                  height: displayHeight(context) -
                  //                      MediaQuery.of(context).padding.top -
                  //                      kToolbarHeight,

                  child:

                  Row(
                    children: <Widget>[

                      // 1ST CONTAINER OF THIS ROW HANDLES THE BIG DETAIL PAGE IMAGE.
                      Container(
//                      height: 900,
//                        color: Color(0xffCCCCCC),
                        color: Color(0xffF7F0EC),
                        width: displayWidth(context) * 0.28,
//                      height: displayHeight(context)*0.50,

                        alignment: Alignment.centerLeft,
                        child: FoodDetailImageInMoreIngredients(
                            oneFoodItemandId2.imageURL),

                      ),
                      Container(
                          color: Color(0xffF7F0EC),
                          width: displayWidth(context) * 0.72,
                          child: Column(
                            children:
                            <Widget>[


                              SizedBox(height: 40),
                              // ITEM NAME ENDS HERE.

                              // SIZE CARD STARTS HERE.
                              Card(

                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                              borderOnForeground: true,

                                child:
                                Container(
//                                    color: Color(0xffDAD7C3),
                                    color: Color(0xffF7F0EC),
                                    width: displayWidth(context) * 0.72,
                                    child: Column(children: <Widget>[
// 1st container outsource below:

                                      Container(

                                        //      color: Colors.yellowAccent,
                                        height: 40,
                                        width: displayWidth(context) * 0.72,

                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: <Widget>[

                                            // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.

                                            Container(child:

                                            Container(

                                              alignment: Alignment.topLeft,


                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    112, 112, 112, 1),
//                                              color: Colors.black54,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight: Radius
                                                        .circular(60)),
//                                              border: Border.all(
//                                                  width: 3
//                                                  ,color: Colors.green,
//                                                  style: BorderStyle.solid
//                                              )
                                              ),


                                              width: displayWidth(context) /
                                                  4.2,
                                              // 4.2 make divider smaller to make decoration bigger.
//                                          height: displayHeight(context)/40,
                                              child: Container(
                                                alignment: Alignment.center,
                                                child:

                                                Text('INGREDIENTS',
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        color: Colors.white
                                                    )
                                                ),
                                              ),

                                            ),

                                            ),

                                            // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.
                                            // ENDED HERE.

                                            // BLACK CONTAINER WILL BE DELETED LATER.
                                            // BLACK CONTAINER.


                                          ],
                                        ),
                                      ),


//1st container.


                                      // GRID VIEW FROM INGREDIENT IMAGES. STARTS FROM BELOW.

                                      Container(

                                          height:260,
                                          child: GridView.builder(

                                            itemCount: defaultIngredientListForFood
                                                .length,

                                            itemBuilder: (_, int index) {
                                              return _buildOneSizeSelected(
                                                  defaultIngredientListForFood[index],
                                                  index);
                                            },
                                            gridDelegate:
                                            new SliverGridDelegateWithMaxCrossAxisExtent(
                                              /// FOR EXAMPLE, IF THE GRID IS VERTICAL,
                                              /// THE GRID IS 500.0 PIXELS WIDE, AND
                                              /// [MAXCROSSAXISEXTENT] IS 150.0, THIS
                                              /// DELEGATE WILL CREATE A GRID WITH 4
                                              /// COLUMNS THAT ARE 125.0 PIXELS WIDE.
                                              ///
                                              maxCrossAxisExtent: 180,
                                              mainAxisSpacing: 6, // Vertical  direction
                                              crossAxisSpacing: 5,
                                              childAspectRatio: 200/247,
                                              ///childAspectRatio:
                                              /// The ratio of the cross-axis to the main-axis extent of each child.
                                              /// H/Verti



                                              /*
                                              maxCrossAxisExtent: 260,
                                              mainAxisSpacing: 8,
                                              crossAxisSpacing: 0,
                                              childAspectRatio: 380 / 400,
                                              */

                                            ),

                                            /*
                                            new SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 5,
                                                // H  direction
//
                                                crossAxisSpacing: 10,
//                                  ///childAspectRatio:
//                                  /// The ratio of the cross-axis to the main-axis extent of each child.
//                                  /// H/V
                                                // horizontal / vertical
                                                childAspectRatio: 220 / 300,
                                                crossAxisCount: 4
                                            ),

*/
//                                new SliverGridDelegateWithMaxCrossAxisExtent(
//
//                                  maxCrossAxisExtent: 270,
//                                  mainAxisSpacing: 10, // H  direction
//                                  crossAxisSpacing: 0,
//
//                                  ///childAspectRatio:
//                                  /// The ratio of the cross-axis to the main-axis extent of each child.
//                                  /// H/V
//                                  childAspectRatio: 220/200,
//
//
//                                ),

                                            controller: new ScrollController(
                                                keepScrollOffset: false),
//                                            shrinkWrap: true,

//                          childAspectRatio: 2.5, --bigger than 2.9


                                          )
                                      ),

                                      // GRID VIEW FROM INGREDIENT IMAGES. STARTS FROM BELOW.


                                      //ex


                                    ],)

                                ),
                              ),




                              // INGREDIENT CARD STARTS HERE.
                              Card(

                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                              borderOnForeground: true,

                                child:
                                Container(
//                                    color: Color(0xffDAD7C3),
                                    color: Color(0xffF7F0EC),
//                                    F7F0EC
                                    width: displayWidth(context) * 0.72,
                                    child: Column(children: <Widget>[
// 1st container outsource below:

                                      Container(

                                        //      color: Colors.yellowAccent,
                                        height: 40,
                                        width: displayWidth(context) * 0.72,
                                        child: Stack(
                                            children: [

                                              CustomPaint(size: Size(0, 19),
                                                painter: WhiteRulePainter(),
                                              ),
//                                            Container(),

                                              Container(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceAround,
//                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[

                                                    Container(),

                                                    Container(
                                                      child:
                                                      Container(
                                                        alignment: Alignment
                                                            .topLeft,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white
//                                                color:Color.fromRGBO(112,112,112,1),
//                                              borderRadius: BorderRadius.only(bottomRight:  Radius.circular(60)),
////                                              )
                                                        ),

                                                        width: displayWidth(
                                                            context) / 3,
//                                          height: displayHeight(context)/40,
                                                        //DIVIDER BIGGER MEANS WIDTH SMALLER. 4 from 4.8

                                                        child: Container(
                                                          alignment: Alignment
                                                              .center,
                                                          child: Text(
                                                              'EXTRA INGREDIENTS',
                                                              style: TextStyle(
                                                                fontSize: 24,
                                                                fontWeight: FontWeight
                                                                    .normal,
//                                                      color: Colors.white
                                                                color: Color
                                                                    .fromRGBO(
                                                                    112, 112,
                                                                    112, 1),
                                                              )
                                                          ),
                                                        ),

                                                      ),
                                                    ),

                                                    // 2ND CONTAINER VIOLET IN THE ROW. STARTS HERE.

                                                    Container(
                                                        child: GestureDetector(
//                                                          onLongPress: () {
//                                                            print(
//                                                                'at on Loong Press: ');
//                                                          },
//                                                          onLongPressUp: () {
//                                                            print(
//                                                                'on Long Press Up:');
//                                                          },
                                                          onTap: () {
                                                            print('on Tap');


                                                            List<NewIngredient> unSelectedToSelected =
                                                            _ingredientlistUnSelected.where((oneItem) =>
                                                            oneItem.ingredientAmountByUser>=1

                                                            ).toList();

//                                                            logger.i('unSelectedToSelected.ingredientName: ',unSelectedToSelected[0]
//                                                                .ingredientName);
//                                                            logger.i('unSelectedToSelected.ingredientName: ',unSelectedToSelected[1]
//                                                                .ingredientName);

                                                            List<NewIngredient> combinedSelectedIngredientList =
//                                                            defaultIngredientListForFood.expand((i) =>
//                                                            [i, unSelectedToSelected]).toList();

                                                            [...defaultIngredientListForFood, ...unSelectedToSelected];

                                                            List<NewIngredient> newUnselected =
                                                            _allIngredientsList.toSet().
                                                            difference(combinedSelectedIngredientList.toSet()).toList();

                                                            List<NewIngredient> unSelectedDecremented =  newUnselected.map
                                                              ((oneIngredient)=>NewIngredient.updateIngredient(
                                                                oneIngredient
                                                            )).toList();

                                                            logger.i('unSelectedDecremented.length',unSelectedDecremented.length);

                                                            logger.i('NEW SELECTED ||combinedSelectedIngredientList.length',
                                                                combinedSelectedIngredientList.length);
                                                            logger.i('_allIngredientsList.length',_allIngredientsList.length);


                                                            setState(() {
                                                              defaultIngredientListForFood = combinedSelectedIngredientList;
                                                              _ingredientlistUnSelected = unSelectedDecremented;
                                                            });


                                                          },

                                                          child: Container(

                                                            decoration: BoxDecoration(
//                                              color: Colors.black54,
//                                                              color: Colors.red,
                                                              color:Color(0xffFA0026),
                                                              borderRadius: BorderRadius
                                                                  .circular(15),
                                                              border: Border
                                                                  .all(
                                                                  width: 2
                                                                  ,
                                                                  color: Colors
                                                                      .black,
                                                                  style: BorderStyle
                                                                      .solid
                                                              ),

                                                            ),
                                                            height: 40,
                                                            width: displayWidth(
                                                                context) * 0.25,


//                                            color:Color(0xffC27FFF),
                                                            child:


                                                            Align(
                                                              alignment: Alignment
                                                                  .center,
                                                              child: Text(
                                                                'Press when finish',
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .bold,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: 20),
                                                              ),

                                                            ),


                                                          ),
                                                        )
                                                    )

                                                  ],
                                                ),)
                                            ]
                                        ),
                                      ),


//1st container.

                                      // NOT DEFAULT INGREDIENTS ARE BELOW:
                                      // NOT YET SELECTED BUT CAN BE SELECTED BY USER. --BELOW.


                                      Container(
                                          height: displayHeight(context) -
                                              MediaQuery
                                                  .of(context)
                                                  .padding
                                                  .top - 600,
                                          child: GridView.builder(
                                            itemCount: _ingredientlistUnSelected
                                                .length,

                                            itemBuilder: (_, int index) {
                                              return _buildOneSizeUNSelected
                                                (
                                                  _ingredientlistUnSelected[index],
                                                  index,_ingredientlistUnSelected
                                              );
                                            },
                                            gridDelegate:
//                                            new SliverGridDelegateWithFixedCrossAxisCount(
//                                              crossAxisCount: 3,
                                            new SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 260,

                                              mainAxisSpacing: 8,
                                              // H  direction
                                              crossAxisSpacing: 0,

                                              ///childAspectRatio:
                                              /// The ratio of the cross-axis to the main-axis extent of each child.
                                              /// H/V
                                              childAspectRatio: 380 / 400,
//                                  ///childAspectRatio:
//                                  /// The ratio of the cross-axis to the main-axis extent of each child.
//                                  /// H/V
                                              // horizontal / vertical
//                                              childAspectRatio: 280/360,

                                            ),


//                                            new SliverGridDelegateWithMaxCrossAxisExtent(
//                                              /// FOR EXAMPLE, IF THE GRID IS VERTICAL,
//                                              /// THE GRID IS 500.0 PIXELS WIDE, AND
//                                              /// [MAXCROSSAXISEXTENT] IS 150.0, THIS
//                                              /// DELEGATE WILL CREATE A GRID WITH 4
//                                              /// COLUMNS THAT ARE 125.0 PIXELS WIDE.
//                                              ///
//                                              maxCrossAxisExtent: 200,
//                                              mainAxisSpacing: 0, // H  direction
//                                              crossAxisSpacing: 0,
//
//                                              ///childAspectRatio:
//                                              /// The ratio of the cross-axis to the main-axis extent of each child.
//                                              /// H/V
//                                              childAspectRatio: 380/330,
//
//                                            ),
                                            controller: new ScrollController(
                                                keepScrollOffset: false),

                                            shrinkWrap: false,


                                          )
                                      ),

                                      /*
                                    Container(
                                        height: displayHeight(context) -
                                            MediaQuery.of(context).padding.top -400,

                                        child:
                                        LoadUncommonIngredients(allIngredientItems:_ingredientlistUnSelected)
                                    ),

                                    */


                                    ],)

                                ),
                              ),


//

                            ],
                          )
                      )

                    ],
                  ),
                ),


              ],
            )
            ,)

      );
    }



  }







//  Widget _buildOneSizeUNSelected(IngredientItem unSelectedOneIngredient, int index) {

//  itemSelectedCallback,buttonTypeCallkack
//  onPressed: () =>
//
//  _handlePressForProfile('profile',context)



  Widget _buildOneSizeUNSelected(NewIngredient unSelectedOneIngredient, int index, List<NewIngredient> allUnSelected
      ) {

    print('unSelectedOneIngredient: ${unSelectedOneIngredient.ingredientName}');

    logger.i("unSelectedOneIngredient: ",unSelectedOneIngredient.ingredientAmountByUser);


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
            horizontal: 4.0, vertical: 15.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

//                              SizedBox(height: 10),

            Container(
// TO Be
//          height:45, // same as the heidth of increment decrement button.
              width: displayWidth(context)/7,
              height:45,
              alignment: Alignment.center,

              child:

              Text(

                unSelectedOneIngredient.ingredientName,

                style: TextStyle(
                  color:Color.fromRGBO(112,112,112,1),
//                                    color: Colors.blueGrey[800],

                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),

              ),
            ),

            Container(

              width: displayWidth(context) * 0.09,
              height: displayWidth(context) * 0.11,
              padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),
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


            // PROBLEM CONTAINER WITH ROW. INCREMENT DECREMENT FUNCTIONALITY. -- BELOW.
            Container(
              margin:EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0
              ),


//                                              height: displayHeight(context) *0.11,
              height:35,
              width: 150,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[



                  IconButton(
                    icon: Icon(Icons.add),
                    iconSize: 30,

//                      tooltip: 'Increase Ingredient count by 1',
                    onPressed: () {
                      print('Add button pressed');
                      NewIngredient c1 = new NewIngredient(
                          ingredientName : unSelectedOneIngredient.ingredientName,
                          imageURL: unSelectedOneIngredient.imageURL,

                          price: unSelectedOneIngredient.price,
                          documentId: unSelectedOneIngredient.documentId,
                          ingredientAmountByUser :unSelectedOneIngredient.ingredientAmountByUser+1

                      );

                      allUnSelected[index] = c1;

                      setState(() {
                        _ingredientlistUnSelected= allUnSelected;
                      });
                    },
                    color: Colors.grey,
                  ),


//      double.parse(doc['priceinEuro'])
//          .toStringAsFixed(2);
                  Text(
                    currentAmount.toString(),
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontWeight: FontWeight.normal,
                      fontSize: 22,
                    ),
                  ),


                  InkResponse(
                    onTap: (){
                      print('Decrease button pressed InkResponse');
                      if (currentAmount > 1) {
//                      if(currentAmount>=2)
//                      City c1 = new City()..name = 'Blum'..state = 'SC';

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
                        setState(() {
                          _ingredientlistUnSelected = allUnSelected;
                        });
                      }
                    },
                    splashColor:Colors.deepOrangeAccent,
                    focusColor:Colors.blue,
                    hoverColor:Colors.lightGreen,
                    highlightColor:Colors.indigo,
                    child:

                    IconButton(
                      icon: Icon(Icons.remove),
                      iconSize: 30,
//                      tooltip: 'Decrease Ingredient count by 1',
                      onPressed: () {
                        print('Decrease button pressed IconButton');
                        if (currentAmount >= 1) {
//                      if(currentAmount>=2)
//                      City c1 = new City()..name = 'Blum'..state = 'SC';

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
                          setState(() {
                            _ingredientlistUnSelected = allUnSelected;
                          });
                        }
                      },
                      splashColor:Colors.deepOrangeAccent,
                      focusColor:Colors.blue,
                      hoverColor:Colors.lightGreen,
                      highlightColor:Colors.indigo,
//                              size: 24,
                      color: Colors.grey,
                    ),),


                ],

              ),
            ),

            // PROBLEM CONTAINER WITH ROW. INCREMENT DECREMENT FUNCTIONALITY. -- ABOVE.




          ],
        )

    );
  }

//  Widget _buildOneSizeSelected(IngredientItem selectedOneIngredient, int index) {
  Widget _buildOneSizeSelected(NewIngredient selectedOneIngredient, int index) {

    print('selectedOneIngredient: ${selectedOneIngredient.ingredientName}');

    logger.i('docID: ',selectedOneIngredient.documentId);


    String imageURLFinal = (selectedOneIngredient.imageURL == '') ?
    'https://thumbs.dreamstime.com/z/smiling-orange-fruit-'
        'cartoon-mascot-character-holding-blank-sign-smiling-orange-'
        'fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
        : storageBucketURLPredicate + Uri.encodeComponent(selectedOneIngredient.imageURL) + '?alt=media';
    // FILTER BY CATEGORY.
//    final List filteredItemsByCategory = allFoods.where((oneItem ) => oneItem.categoryName.toLowerCase() ==
//        categoryString.toLowerCase()).toList();



    // FLTER BY SEARCHSTRING;
//    final List filteredItems = filteredItemsByCategory.where((oneItem) =>oneItem.itemName.toLowerCase().
//    contains(
//        searchString2.toLowerCase())).toList();
//
//
//
//    _ingredientlistUnSelected
//
//    if(oneIngredient.ingredientName)

//    print('oneSize: $oneSize');

    return  Container(
      color: Color.fromRGBO(239, 239, 239, 0),
      padding: EdgeInsets.symmetric(
//                          horizontal: 10.0, vertical: 22.0),
          horizontal: 4.0, vertical: 15.0),
      child: Column(
        children: <Widget>[
          new Container(

//                                    width: displayWidth(context) * 0.19,
            height: displayWidth(context) * 0.13,

            width: displayWidth(context) * 0.11,
            padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),
            child: ClipOval(

              child: CachedNetworkImage(
                imageUrl: imageURLFinal,
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

//                              SizedBox(height: 10),

          Container(
            alignment: Alignment.center,
            child:
            Text(

              selectedOneIngredient.ingredientName,

              style: TextStyle(
                color:Color.fromRGBO(112,112,112,1),
//                                    color: Colors.blueGrey[800],

                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            )
            ,),


        ],
      ),
    );
  }
//  child:MessageList(firestore: firestore),

}


//  FoodDetailImage




class FoodDetailImageInMoreIngredients extends StatelessWidget {

  final String imageURLBig;
  FoodDetailImageInMoreIngredients(this.imageURLBig);

  @override
  Widget build(BuildContext context) {


    return Transform.translate(
      offset:Offset(-displayWidth(context)/27,0),
//FROM 18 TO 22
      // 22 to 27.

//      INCREAS THE DIVIDER TO MOVE THE IMAGE TO THE RIGHT
      // -displayWidth(context)/9

      child:
      ClipOval(child:
      Container(
        color:Color(0xffFFFFFF),
        alignment:Alignment.centerLeft,
//        width: 600,
//        height:800,
        height: 500,
        child:
        ClipOval(
          child: CachedNetworkImage(
//            height:770,
            height:500,
            imageUrl: imageURLBig,
//            fit: BoxFit.fitHeight,
            fit: BoxFit.cover,

            placeholder: (context, url) => new CircularProgressIndicator(),

          ),
        ),
      ),
      ),


//                Image.network(imageURLBig)

    );


  }


}




class WhiteRulePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(700, 18); //(X,Y) TO (X,Y)
    final p2 = Offset(0, 18);
    final paint = Paint()
      ..color = Colors.white
//      Color.fromRGBO(112,112,112,1)
//          Colors.white
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


class LongHeaderPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(700, 30); //(X,Y) TO (X,Y)
    final p2 = Offset(0, 30);
    final paint = Paint()
      ..color = Color.fromRGBO(112,112,112,1)
//          Colors.white
      ..strokeWidth = 2;
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