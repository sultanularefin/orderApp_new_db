//food_gallery.dart



// dependency files
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/DataLayer/FoodItemWithDocIDViewModel.dart';
import 'package:foodgallery/src/DataLayer/NewIngredient.dart';
import 'package:logger/logger.dart';
//import 'package:neumorphic/neumorphic.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

//sizeConstantsList


// SCREEN FILES AND MODLE FILES AND UTILITY FILES.
import 'package:foodgallery/src/screens/ingredients_more/more_ingredients.dart';
import 'package:foodgallery/src/DataLayer/IngredientItem.dart';
import 'package:foodgallery/src/DataLayer/SizeConstants.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import 'package:foodgallery/src/screens/foodItemDetailsPage/Widgets/FoodDetailImage.dart';
import './../../DataLayer/FoodItemWithDocID.dart';
import './../../DataLayer/Order.dart';
//import './../../DataLayer/itemData.dart';


//import './../../shared/category_Constants.dart' as Constants;


// Blocks

import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';

final Firestore firestore = Firestore();



class FoodItemDetails2 extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;
//  final FoodItem oneFoodItemData;


//  FoodItemWithDocID oneFoodItem =new FoodItemWithDocID(


  FoodItemDetails2({Key key, this.child}) : super(key: key);

  @override
  _FoodItemDetailsState createState() => new _FoodItemDetailsState();


//  _FoodItemDetailsState createState() => _FoodItemDetailsState();



}


class _FoodItemDetailsState extends State<FoodItemDetails2> {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  String _currentSize;

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
    if(status) {
      return x.toDouble() ;
    }

    if(x is int) {return x.toDouble();}
    else if(x is double) {return x.toDouble();}


    else return 0.0;
  }
  bool showUnSelectedIngredients = false;
  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<FoodItemDetailsBloc>(context);

//    print('totalCartPrice -----------> : $totalCartPrice');
//    print('initialPriceByQuantityANDSize ----------> $initialPriceByQuantityANDSize');

//    logger.w('defaultIngredients: ',bloc.defaultIngredients);

    List<NewIngredient> defaultIngredients = bloc.defaultIngredients;
    List<NewIngredient> unSelectedIngredients = bloc.unSelectedIngredients;

    logger.w('unSelectedIngredients in foodItemDetails2 line #116 : ',unSelectedIngredients);



    if(unSelectedIngredients == null){
      return Container
        (
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }
    else {
      return Container(
          color: Colors.blue,
          child: Stack(
            children: <Widget>[
              Positioned(

                top: 60,
                left: 150,
//            bottom:10,
//            right:10,
                child: Container(
                    height: displayHeight(context) -
                        MediaQuery
                            .of(context)
                            .padding
                            .top - 600,
                    child: GridView.builder(
                      itemCount: unSelectedIngredients
                          .length,

                      itemBuilder: (_, int index) {
                        return _buildOneSizeUNSelected
                          (
                            unSelectedIngredients[index],
                            index, unSelectedIngredients
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


                      controller: new ScrollController(
                          keepScrollOffset: false),

                      shrinkWrap: false,


                    )
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                top: showUnSelectedIngredients ? 220 : 60,
                left: 150,

//            right:10,
                child: Container(

                  child: StreamBuilder<FoodItemWithDocIDViewModel>(


                      stream: bloc.currentFoodItemsStream,
                      initialData: bloc.currentFoodItem,

                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: new LinearProgressIndicator());
                        }
                        else {
                          print('snapshot.hasData : ${snapshot.hasData}');

                          final FoodItemWithDocIDViewModel oneFood = snapshot
                              .data;

                          final Map<String, dynamic> foodSizePrice = oneFood
                              .sizedFoodPrices;

                          double initialPriceByQuantityANDSize = 0.0;
                          double priceByQuantityANDSize = 0.0;
                          //            initialPriceByQuantityANDSize = oneFood.itemSize;

                          initialPriceByQuantityANDSize = oneFood.itemPrice;
                          priceByQuantityANDSize = oneFood.itemPrice;
                          _currentSize = oneFood.itemSize;


//        return(Container(
//            color: Color(0xffFFFFFF),
//            child:
//            GridView.builder(


//            final Map<String, dynamic> foodSizePrice = oneFood.sizedFoodPrices;
                          return GestureDetector(
                            onTap: () {
                              print('s');
                              Navigator.pop(context);
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
                                child: Container(

                                  alignment: Alignment.bottomCenter,
                                  height: displayHeight(context) / 1.5,
                                  //width:displayWidth(context) / 1.5, /* 3.8*/
                                  width: displayWidth(context)
                                      - displayWidth(context) /
                                          3.8 /* this is about the width of yellow side menu */
                                      - displayWidth(context) /
                                          20, /* 10% of widht of the device for padding margin.*/
//                  color:Colors.lightGreenAccent,
                                  margin: EdgeInsets.fromLTRB(18, 20, 20, 18),

                                  decoration:
                                  new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(
                                        10.0),
                                    color: Colors.purple,
                                  ),


                                  child: Neumorphic(
                                    // State of Neumorphic (may be convex, flat & emboss)

                                      boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.all(Radius.circular(15)),

                                      ),
                                      curve: Neumorphic.DEFAULT_CURVE,
                                      style: NeumorphicStyle(
                                          shape: NeumorphicShape.concave,
                                          depth: 8,
                                          lightSource: LightSource.topLeft,
                                          color: Colors.grey
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
                                          Container(child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              // THIS ROW HAVE 2 PARTS -> 1ST PART HANDLES THE IMAGES, SOME HEADING TEXT(PRICE AND NAME)
                                              // , 2ND PART(ROW) HANDLES THE
                                              // DIFFERENT SIZES OF PRODUCTS. BEGINS HERE.


                                              Container(
                                                  height: displayHeight(
                                                      context) / 2.6,

                                                  color: Colors.red,
                                                  width: displayWidth(context) /
                                                      5,
// INCREASE THE DIVIDER TO MAKE IT MORE SAMLLER. I.E. WIDTH
//                      height: displayHeight(context)*0.50,
//                                    alignment: Alignment.centerLeft,


                                                  //ZZZ
                                                  // Other arguments such as margin, padding etc. (Like `Container`)
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,

//        mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      //pppp
                                                      Container(
                                                        padding: EdgeInsets
                                                            .fromLTRB(
                                                            10, 0, 0, 10),
                                                        child:

                                                        Text(
                                                            '${oneFood
                                                                .itemName}',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight
                                                                  .bold,
//                                                      color: Colors.white
                                                              color: Colors
                                                                  .black,

                                                            )
                                                        ),
                                                      ),

                                                      Container(
                                                        padding: EdgeInsets
                                                            .fromLTRB(
                                                            10, 0, 0, 10),
                                                        child:

                                                        Text(
                                                            '$initialPriceByQuantityANDSize ' +
                                                                '\u20AC',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight
                                                                  .normal,
//                                                      color: Colors.white
                                                              color: Colors
                                                                  .black,

                                                            )
                                                        ),
                                                      ),

                                                      Container(
                                                        /*
                                color:Colors.blue,
                              width:displayWidth(context)/4.6,
                              */
                                                        padding: EdgeInsets
                                                            .fromLTRB(0, 0, 0,
                                                            displayHeight(
                                                                context) / 25),

                                                        child: FoodDetailImage(
                                                            oneFood.imageURL,
                                                            oneFood.itemName),
                                                      ),


                                                    ],

                                                  )
                                              ),

                                              // THIS ROW HAVE 2 PARTS -> 1ST PART (ROW) HANDLES THE IMAGES, SOME HEADING TEXT(PRICE AND NAME)
                                              // , 2ND PART(ROW) HANDLES THE
                                              // DIFFERENT SIZES OF PRODUCTS.
                                              // ENDS HERE.


                                              // 2ND ROW, FOR FOR OTHER ITEMS, WILL BE A COLUMN ARRAY, BEGINS HERE:

                                              Container(
                                                height: displayHeight(context) /
                                                    2.6,
                                                width: displayWidth(context) -
                                                    displayWidth(context) / 3.7 /* about the width of left most
                            container holding the food Item Image, image name and food item price */
                                                    - displayWidth(context) /
                                                        3.8 /* this is about the width of yellow side menu */,
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,


//        mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      //pppp
                                                      Container(
                                                          child: _buildProductSizes(
                                                              context,
                                                              foodSizePrice)
                                                      ),

//                                  Text('ss'),
                                                      Container(
                                                          child: buildDefaultIngredients(
                                                              context,
                                                              defaultIngredients)
                                                      ),

                                                      // MORE INGREDIENTS BEGINS HERE.
                                                      Container(
                                                          child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .end,
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .center,
                                                              children: <
                                                                  Widget>[
                                                                Container(

                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                      0, 0,
                                                                      displayHeight(
                                                                          context) /
                                                                          55,
                                                                      0),
                                                                  //      color: Colors.yellowAccent,
                                                                  height: displayHeight(
                                                                      context) /
                                                                      20,
                                                                  width: displayWidth(
                                                                      context) /
                                                                      3,

                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment
                                                                        .start,
                                                                    children: <
                                                                        Widget>[

                                                                      // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.

                                                                      // 2ND CONTAINER VIOLET IN THE ROW. STARTS HERE.

                                                                      Container(
                                                                          child: GestureDetector(
//                                                onLongPress: (){
//                                                  print('at on Loong Press: ');
//                                                },
//                                                onLongPressUp: (){
//
//                                                },
                                                                            onTap: () {
                                                                              print(
                                                                                  'xyz');
                                                                            },
                                                                            child: Container(
                                                                              width: displayWidth(
                                                                                  context) *
                                                                                  0.33,
                                                                              height: 45,
                                                                              decoration: BoxDecoration(
//                                              color: Colors.black54,
                                                                                color: Color(
                                                                                    0xffFFFFFF),
                                                                                borderRadius: BorderRadius
                                                                                    .circular(
                                                                                    25),
                                                                              ),


//                                            color:Color(0xffC27FFF),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment
                                                                                    .start,
                                                                                crossAxisAlignment: CrossAxisAlignment
                                                                                    .center,
                                                                                children: <
                                                                                    Widget>[
                                                                                  Icon(
                                                                                    Icons
                                                                                        .add,
                                                                                    size: 32.0,
                                                                                    color: Color
                                                                                        .fromRGBO(
                                                                                        112,
                                                                                        112,
                                                                                        112,
                                                                                        1),
                                                                                    //        color: Color(0xffFFFFFF),
                                                                                  ),
                                                                                  Text(
                                                                                    'More Ingredients',
                                                                                    style: TextStyle(
                                                                                        fontWeight: FontWeight
                                                                                            .bold,
                                                                                        color: Color
                                                                                            .fromRGBO(
                                                                                            112,
                                                                                            112,
                                                                                            112,
                                                                                            1),
                                                                                        fontSize: 22),
                                                                                  ),
                                                                                ],
                                                                              ),

                                                                            ),
                                                                          )
                                                                      )


                                                                      // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.
                                                                      // ENDED HERE.

                                                                      // BLACK CONTAINER WILL BE DELETED LATER.
                                                                      // BLACK CONTAINER.


                                                                    ],
                                                                  ),
                                                                ),
                                                              ]
                                                          )
                                                      )

                                                      // MORE INGREDIENTS ENDS HERE.


                                                    ]
                                                ),
                                              )
                                              // 2ND ROW, FOR FOR OTHER ITEMS, WILL BE A COLUMN ARRAY, ENDS HERE:

                                            ],
                                          ),
                                          ),

                                          Container(child: Text(
                                              "Unselected Ingredients are here")),


                                        ],
                                      )

                                  ),
                                ),

                              ),
                            ),

                          );
                        }
                      }
                  ),
                ),
              ),
            ],
          )
      );
    }
  }



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


//                      setState(() {
//                        _ingredientlistUnSelected= allUnSelected;
//                      });
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
                      /*
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
                         // _ingredientlistUnSelected = allUnSelected;
                        });
                      */

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

                        /*
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
                        */
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


  Widget _buildProductSizes(BuildContext context, Map<String,dynamic> allPrices) {

    final Map<String,dynamic> foodSizePrice = allPrices;

    if(allPrices==null){
      return Container
        (
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }
    else {
      return Container(
//        alignment: Alignment.topCenter,
//      width: 200,
        height: displayHeight(context) / 5,
//      height: 400,
        color: Colors.white,

        child: Column(
//        mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[

            Container(
                color: Color(0xffFFFFFF),
//                                  color:Color(0xffDAD7C3),
                width: displayWidth(context) * 0.57,
                child: Column(children: <Widget>[
// 1st container outsource below:

                  // 1st CONTAINER OF THE COLUMN LAYOUT HOLDS VSM ORG VS TODO. BEGINS HERE
                  Container(


                    //      color: Colors.yellowAccent,
                    height: 40,
                    width: displayWidth(context) * 0.57,

                    // M VSM ORG VS TODO. BEGINS HERE.
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .end,
                      children: <Widget>[

                        // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.

                        Container(
                          width:60,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: OutlineButton(
//                        color: Color(0xffFEE295),
                            clipBehavior: Clip.hardEdge,
                            splashColor: Color(0xffB47C00),
                            highlightElevation: 12,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color(0xffB47C00),
                                style: BorderStyle.solid,
                                width: 1.6,
                              ),
                              borderRadius: BorderRadius.circular(35.0),
                            ),

                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'M'.toUpperCase(), style:
                              TextStyle(
                                  color: Color(0xffB47C00),

                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              ),
                            ),
                            onPressed: () {
                              print('M pressed');
                            },
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                          ),
                        ),

                        Container(
                          width:60,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: OutlineButton(
//                        color: Color(0xffFEE295),
                            splashColor: Color(0xff34720D),
                            highlightElevation: 12,
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color(0xff34720D),
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                            child: Container(

                              alignment: Alignment.center,
                              child: Text(
                                'VSM'.toUpperCase(), style:
                              TextStyle(
                                  color: Color(0xff34720D),

                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              ),
                            ),
                            onPressed: () {
                              print('VSM pressed');
                            },
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          ),)
                        ,
                        Container(
                          width:60,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: OutlineButton(
//                        color: Color(0xffFEE295),
                            splashColor: Color(0xff95CB04),
                            highlightElevation: 12,
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color(0xff95CB04),
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                            child: Container(

                              alignment: Alignment.center,
                              child: Text(
                                'VS'.toUpperCase(), style:
                              TextStyle(
                                  color: Color(0xff95CB04),

                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              ),
                            ),
                            onPressed: () {
                              print('VS pressed');
                            },
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          ),
                        ),
                        Container(
                          width:60,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child:
                          OutlineButton(
//                        color: Color(0xffFEE295),
                            splashColor: Color(0xff739DFA),
                            highlightElevation: 12,
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color(0xff739DFA),
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                            child: Container(

                              alignment: Alignment.center,
                              child: Text(
                                'ORG'.toUpperCase(), style:
                              TextStyle(
                                  color: Color(0xff739DFA),

                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              ),
                            ),
                            onPressed: () {
                              print('ORG pressed');
                            },
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                          ),
                        )


                        // CONTAINER WHERE CUSTOM CLIPPER LINE FUNCTION NEED TO BE PUTTED.
                        // ENDED HERE.

                        // BLACK CONTAINER WILL BE DELETED LATER.
                        // BLACK CONTAINER.


                      ],
                    ),
                    // M VSM ORG VS TODO. ENDS HERE.
                  ),


                  SizedBox(height: 20,),
//1st container.
                  Container(

                      child: GridView.builder(

//                                          itemCount: sizeConstantsList.length,
                        itemCount: foodSizePrice.length,

                        gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 120,
//                                            maxCrossAxisExtent: 270,
//                                          new SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 5,
                          // H  direction
//
                          crossAxisSpacing: 5,


//                                  ///childAspectRatio:
//                                  /// The ratio of the cross-axis to the main-axis extent of each child.
//                                  /// H/Vertical
                          childAspectRatio: 200 / 80,
//                                              crossAxisCount: 3
                        ),

                        itemBuilder: (_, int index) {
                          String key = foodSizePrice.keys
                              .elementAt(index);
                          dynamic value = foodSizePrice
                              .values.elementAt(index);
//
                          double valuePrice = tryCast<
                              double>(
                              value, fallback: 0.00);
                          print(
                              'valuePrice at line # 583: $valuePrice and key is $key');
                          return _buildOneSize(
                              key, valuePrice, index);
                        },


                        controller: new ScrollController(
                            keepScrollOffset: false),
                        shrinkWrap: true,
                      )
                  ),
                ],)

            ),


            // Todo DefaultItemsStreamBuilder




          ],
        ),

      );
    }
  }

  Widget buildDefaultIngredients(BuildContext context,List<NewIngredient> defaltIngs){


    logger.w("DefaultIngs",defaltIngs);
    print("DefaultIngs: $defaltIngs");

    print('defaltIngs.length LINE# 600: ${defaltIngs.length}');

    if( (defaltIngs.length==1)&& (defaltIngs[0].ingredientName.toLowerCase()=='none')){

      return Container(
          height: displayHeight(context) / 8,
//          height:190,
          width: displayWidth(context) * 0.57,
//              color: Colors.yellowAccent,
//                    color: Color(0xff54463E),
          color: Color(0xfffebaca),
          alignment: Alignment.center,

          // PPPPP

          child:(
              Text("No Ingredients, Please Select 1 or more",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blueAccent,
                ),
              )
          )
      );
    }


    else {
      return Container(
//          height: 190,
          height: displayHeight(context) / 8,
          width: displayWidth(context) * 0.57,
//              color: Colors.yellowAccent,
//                    color: Color(0xff54463E),
          color: Color(0xfffebaca),


          // PPPPP

          child: (

              GridView.builder(
                itemCount: defaltIngs.length,

                gridDelegate:
                new SliverGridDelegateWithMaxCrossAxisExtent(

                  maxCrossAxisExtent: 180,
                  mainAxisSpacing: 6, // Vertical  direction
                  crossAxisSpacing: 5,
                  childAspectRatio: 200 / 240,

                ),

                shrinkWrap: false,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
                itemBuilder: (_, int index) {
                  final String ingredientName = defaltIngs[index]
                      .ingredientName;
//                  final dynamic ingredientImageURL = document['image'];
//    final num ingredientPrice = document['price'];

                  final dynamic ingredientImageURL = defaltIngs[index]
                      .imageURL == '' ?
                  'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2FfoodItem404.jpg?alt=media'
                      :
                  storageBucketURLPredicate +
                      Uri.encodeComponent(defaltIngs[index].imageURL)

                      + '?alt=media';


                  return
                    Container(
                      color: Color.fromRGBO(239, 239, 239, 0),
                      padding: EdgeInsets.symmetric(
//                          horizontal: 10.0, vertical: 22.0),
                          horizontal: 4.0, vertical: 15.0),
                      child: GestureDetector(
                          onLongPress: () {
                            print(
                                'at Long Press: ');
                          },

                          child: Column(
                            children: <Widget>[

                              new Container(

                                width: displayWidth(context) * 0.09,
                                height: displayWidth(context) * 0.11,

                                child: ClipOval(

                                  child: CachedNetworkImage(
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
                              Text(

                                ingredientName,

                                style: TextStyle(
                                  color: Color.fromRGBO(112, 112, 112, 1),
//                                    color: Colors.blueGrey[800],

                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                ),
                              )
                              ,


                            ],
                          ),
                          onTap: () {
                            print('for future use');
//                            return Navigator.push(context,
//
//                                MaterialPageRoute(builder: (context)
//                                => FoodItemDetails())
//                            );
                          }
                      ),
                    );
                },

              ))
        // PPPPP

      );
    }
  }

  /*
  Widget build2(BuildContext context) {



    return GestureDetector(
      onTap: () {
//        FocusScopeNode currentFocus = FocusScope.of(context);
//
//        if (!currentFocus.hasPrimaryFocus) {
//          currentFocus.unfocus();
//        }

        FocusScope.of(context).unfocus();
      },
      child:
      Scaffold(
        backgroundColor: Colors.white.withOpacity(0.05),
        body:
        SafeArea(child:
        SingleChildScrollView(

          child: Center(
              child: Container(
                width: 200,
                height: 400,
                color: Colors.blueAccent,
                // MAIN COLUMN FOR THIS PAGE.
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

//      1ST CONTAINER STARTS HERE || BELOW ||
//                #### 1ST CONTAINER SEARCH STRING AND TOTAL ADD TO CART PRICE.
                    // EVERYTHING IS FINE HERE.
                    //


                    Container(

//                color:Color.fromRGBO(239, 239, 239, 1.0),
                      color: Color(0xffF7F0EC),
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
//                      color:Color(0xffCCCCCC),
                            color: Color(0xffF7F0EC),
                            width: displayWidth(context) * 0.43,
//                      height: displayHeight(context)*0.50,

                            alignment: Alignment.centerLeft,
                            child: FoodDetailImage(oneFood.imageURL,
                                oneFood.itemName),

                          ),


                        ],
                      ),
                    ),


                  ],
                )
                ,)

          ),
        ),
        ),
      ),
    );
  }
}
);
}


*/

  Widget _buildOneSize(String oneSize,double onePriceForSize, int index) {



//    logger.i('oneSize: $oneSize');
    logger.i('onePriceForSize: for oneSize: $oneSize is $onePriceForSize');

    return Container(

        height:displayHeight(context)/30,
        width:displayWidth(context)/10,

        child:  oneSize.toLowerCase() == _currentSize  ?

        Container(
          margin: EdgeInsets.fromLTRB(5, 3,5,5),
          child:
          RaisedButton(
            color: Color(0xffFFE18E),
//          color: Colors.lightGreenAccent,
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

              alignment: Alignment.center,
              child: Text(
                oneSize.toUpperCase(), style:
              TextStyle(
                  color:Color(0xff707070),

                  fontWeight: FontWeight.bold,
                  fontSize: 12),
              ),
            ),
            onPressed: () {

//              logger.i('onePriceForSize: ',onePriceForSize);

              final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
              foodItemDetailsbloc.setNewSizePlusPrice(oneSize);


//              setNewSizePlusPrice
//              setState(() {
//                initialPriceByQuantityANDSize = onePriceForSize;
//                priceByQuantityANDSize = onePriceForSize;
//                _currentSize= oneSize;
//              });
            },



          ),
        )


            :

        Container(
          margin: EdgeInsets.fromLTRB(5, 3,5,5),
          child:
          OutlineButton(
            color: Color(0xffFEE295),
            clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
            shape:RoundedRectangleBorder(

              side: BorderSide(
                color: Color(0xffF7F0EC),
                style: BorderStyle.solid,
              ),
//                BorderStyle(
//                  BorderStyle.solid,
//                )
              borderRadius: BorderRadius.circular(35.0),
            ),
            child:Container(

              alignment: Alignment.center,
              child: Text(
                oneSize.toUpperCase(), style:
              TextStyle(
                  color:Color(0xff707070),

                  fontWeight: FontWeight.bold,
                  fontSize: 12),
              ),
            ),
            onPressed: () {

//              logger.i('onePriceForSize: ',onePriceForSize);
//              setState(() {
//                initialPriceByQuantityANDSize = onePriceForSize;
//                priceByQuantityANDSize = onePriceForSize;
//                _currentSize= oneSize;
//              });

              final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
              foodItemDetailsbloc.setNewSizePlusPrice(oneSize);

            },
          ),
        )
    );
  }
//  child:MessageList(firestore: firestore),

}


//  FoodDetailImage








