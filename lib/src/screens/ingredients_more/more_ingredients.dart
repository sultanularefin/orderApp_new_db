


//food_gallery.dart



// dependency files
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/models/IngredientItem.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

import './../../models/FoodItemWithDocID.dart';
import './../../models/itemData.dart';
//sizeConstantsList


//import './../../shared/category_Constants.dart' as Constants;



final Firestore firestore = Firestore();



class MoreIngredients extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;
//  final FoodItem oneFoodItemData;
  final FoodItemWithDocID oneFoodItemData;
  final Firestore firestore = Firestore.instance;


  MoreIngredients({Key key, this.child,this.oneFoodItemData}) : super(key: key);

  @override
  _FoodItemDetailsState createState() => new _FoodItemDetailsState(oneFoodItemData);

}


class _FoodItemDetailsState extends State<MoreIngredients> {

  //  final _formKey = GlobalKey();

  final _formKey = GlobalKey<FormState>();

  int _radioValue = 0;
  int _sizeValue = 0;

  double _total_cart_price = 1.00;
  int _itemCount=1;
  final _itemData = ItemData();
  String _searchString = '';
  String _currentCategory = "PIZZA";
  String _firstTimeCategoryString = "";

  int selectedIngredientCount = 4; // DEFAULT INGREDIENTS.

//  List<UserIngredientAmountData> defaultIngredientListForFood = new List<UserIngredientAmountData>();

//  List<IngredientItem> defaultIngredientListForFood = new List<IngredientItem>();
  List<IngredientItem> defaultIngredientListForFood;
  List<IngredientItem> ingredientlistUnSelected;

  FoodItemWithDocID oneFoodItemandId;
  _FoodItemDetailsState(this.oneFoodItemandId);


  final _allIngredientsList = [];






  @override
  void initState() {
//    getIngredientDataFromFirestore();
    retrieveIngredients1();
    super.initState();

  }

  Future<void> retrieveIngredients1() async {
    debugPrint("Entering in retrieveIngredients1");

    await retrieveIngredients2().then((onValue){

//      print('onValue: |||||||||||||||||||||||||||||||||||||||||||||||||||||||$onValue');
      setState(() {
        defaultIngredientListForFood = onValue.sublist(0,4);
        ingredientlistUnSelected = onValue.sublist(4);
      }
      );

    }
    );
  }

  static Future <List> retrieveIngredients2() async {
    List<IngredientItem> ingItems = new List<IngredientItem>();
    var snapshot = await Firestore.instance.collection("ingredientitems").
    orderBy("uploadDate", descending: true)
        .getDocuments();

    List docList = snapshot.documents;
//    print('doc List :  ******************* <================ : $docList');

    ingItems = snapshot.documents.map((documentSnapshot) => IngredientItem.fromMap(documentSnapshot.data)).toList();

    return ingItems;
  }

  /*
  getIngredientDataFromFirestore() async {
    Firestore.instance
        .collection('ingredientitems').orderBy("uploadDate", descending: true)
        .snapshots()
        .listen((data) =>
        data.documents.forEach((doc) {
//      document['itemName'];

          print('doc: ***************************** ${doc['uploadDate']
              .toDate()}');
//          print('doc.toObject: ',doc.)

          final dynamic ingredientName = doc['ingredientName'];
          final dynamic ingredientImageURL = doc['imageURL'];


          final String ingredientItemId = doc['ingredientId'];

          final bool IsAvailableIngredient = doc['isAvailable'];
          final String ingredientDocumentID = doc.documentID;


          IngredientItem oneIngredientItemWithDocID = new IngredientItem(
            ingredientName: ingredientName,
            imageURL: ingredientImageURL,
            ingredientId: ingredientItemId,
            isAvailable: IsAvailableIngredient,
            documentId: ingredientDocumentID,


          );

          _allIngredientsList.add(oneIngredientItemWithDocID);
        }
        ), onDone: () {
      print("Task Done zzzzz zzzzzz zzzzzzz zzzzzzz zzzzzz zzzzzzzz zzzzzzzzz zzzzzzz zzzzzzz");
    }, onError: (error, StackTrace stackTrace) {
      print("Some Error $stackTrace");
    });
  }

   */


  @override
  Widget build(BuildContext context) {

//    final _allIngredientsList = [];
//    List<IngredientItem> ingredientlistFinal;

//    print('ingredientlistFinal ====================================: $defaultIngredientListForFood');
//
//    print('_ingredientlistUnSelected ||||||||||||||||||||||||||||||||||: $ingredientlistUnSelected');
//
    print('at build _____________________________________________________________________');
//
//    print('widget.oneFoodItemData.itemName:__________________________________________ ${widget.oneFoodItemData.imageURL}');
//    print('oneFoodItemandId.imageURL:_________________________________________ ${oneFoodItemandId.imageURL}');

//    String a = Constants.SUCCESS_MESSAGE;
    if(ingredientlistUnSelected==null){
      return Container
        (
          alignment: Alignment.center,
          child:LinearProgressIndicator()
      );
    }

    else {
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
                                    Text(_total_cart_price.toStringAsFixed(2) +
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
                            oneFoodItemandId.imageURL),

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
                                              maxCrossAxisExtent: 190,
                                              mainAxisSpacing: 6, // Vertical  direction
                                              crossAxisSpacing: 8,

                                              ///childAspectRatio:
                                              /// The ratio of the cross-axis to the main-axis extent of each child.
                                              /// H/Verti
                                              childAspectRatio: 370/330,

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
                                                          onLongPress: () {
                                                            print(
                                                                'at on Loong Press: ');
                                                          },
                                                          onLongPressUp: () {
                                                            print(
                                                                'on Long Press Up:');
                                                          },
                                                          onTap: () {
                                                            print('on Tap');
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
                                            itemCount: ingredientlistUnSelected
                                                .length,

                                            itemBuilder: (_, int index) {
                                              return _buildOneSizeUNSelected
                                                (
                                                  ingredientlistUnSelected[index],
                                                  index);
                                            },
                                            gridDelegate:
                                            new SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 8,
                                                // H  direction
                                                crossAxisSpacing: 0,

                                                ///childAspectRatio:
                                                /// The ratio of the cross-axis to the main-axis extent of each child.
                                                /// H/V
                                                childAspectRatio: 400 / 380,
//                                  ///childAspectRatio:
//                                  /// The ratio of the cross-axis to the main-axis extent of each child.
//                                  /// H/V
                                                // horizontal / vertical
//                                              childAspectRatio: 280/360,
                                                crossAxisCount: 3
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
                                        LoadUncommonIngredients(allIngredientItems:ingredientlistUnSelected)
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


  void _handleRadioValueChange(int value) {
    // print('at _handleRadioValueChange() method ???????????');
    print('value is: $value');
    setState(() {

      switch (_radioValue) {
        case 0:
          _radioValue = value;
          //print('case 0: $value');
          break;
        case 1:
          _radioValue = value;
          //print('case 1: $value');
          break;
        case 2:
          _radioValue = value;
          //print('case 2: $value');
          break;
        case 3:
          _radioValue = value;
          //print('case 0: $value');
          break;
        case 4:
          _radioValue = value;
          //print('case 1: $value');
          break;
        case 5:
          _radioValue = value;
          //print('case 2: $value');
          break;
      }
    });
  }



  Widget categoryItem(Color color, String name,int index) {
    return GestureDetector(

      onTap: () {
//        print('_handleRadioValueChange called from Widget categoryItem ');

        _handleRadioValueChange(index);
      },
      child:Container(
        child: _radioValue == index ?
        (
            Card(
              color: color,
              elevation: 2.5,
              shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                borderRadius: BorderRadius.circular(35.0),
              ),
              child:
              Align(
                  alignment: Alignment.center,
                  child: Text(name, style: TextStyle(color: Colors.white))
              ),



            )
        ):
        (
            Card(
              color: color,
              elevation: 2.5,
              shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                borderRadius: BorderRadius.circular(35.0),
              ),
              child:Align(
                  alignment: Alignment.center,
                  child: Text(name, style: TextStyle(color: Colors.white))
              ),
            )
        ),
      ),
    );

  }


  Widget _buildOneSizeUNSelected(IngredientItem unSelectedOneIngredient, int index) {

    print('unSelectedOneIngredient: ${unSelectedOneIngredient.ingredientName}');
    int currentAmount =unSelectedOneIngredient.ingredientAmountByUser-1;
    return Container(
        color: Color.fromRGBO(239, 239, 239, 0),
        padding: EdgeInsets.symmetric(
//                          horizontal: 10.0, vertical: 22.0),
            horizontal: 4.0, vertical: 15.0),

        child: Column(
          children: <Widget>[
//                              SizedBox(height: 10),

            Text(

              unSelectedOneIngredient.ingredientName,

              style: TextStyle(
                color:Color.fromRGBO(112,112,112,1),
//                                    color: Colors.blueGrey[800],

                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),

            Container(

              width: displayWidth(context) * 0.09,
              padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),
//                                    height: displayWidth(context) * 0.19,

              child: ClipOval(

                child: CachedNetworkImage(
                  imageUrl: unSelectedOneIngredient.imageURL,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => new LinearProgressIndicator(),
                ),
              ),
            )
            ,


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
                    icon: Icon(Icons.remove),
                    iconSize: 30,
                    tooltip: 'Decrease product count by 1',
                    onPressed: () {
                      print('Decrease button pressed');
//                                      setState(() {
//                                        _itemCount -= 1;
//                                      });
                    },
//                              size: 24,
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

                  Container(
                    alignment:Alignment.topCenter,
//                    margin: EdgeInsets.only(top:0),
////                    padding: EdgeInsets.only(top:0),
                    child:

                    IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 30,

                      tooltip: 'Increase product count by 1',
                      onPressed: () {
                        print('Add button pressed');
//                                      setState(() {
//                                        _itemCount += 1;
//                                      });
                      },
                      color: Colors.grey,
                    ),
                  ),
                ],

              ),
            ),

            // PROBLEM CONTAINER WITH ROW. INCREMENT DECREMENT FUNCTIONALITY. -- ABOVE.




          ],
        )

    );
  }

  Widget _buildOneSizeSelected(IngredientItem selectedOneIngredient, int index) {


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
//    ingredientlistUnSelected
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
//                                    height: displayWidth(context) * 0.19,

            width: displayWidth(context) * 0.11,
            padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),
            child: ClipOval(

              child: CachedNetworkImage(
                imageUrl: selectedOneIngredient.imageURL,
                fit: BoxFit.cover,
                placeholder: (context, url) => new LinearProgressIndicator(),
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
    final p1 = Offset(700, 28); //(X,Y) TO (X,Y)
    final p2 = Offset(0, 28);
    final paint = Paint()
      ..color = Color.fromRGBO(112,112,112,1)
//          Colors.white
      ..strokeWidth = 1;
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