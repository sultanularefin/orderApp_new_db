//food_gallery.dart



// dependency files
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  //  final _formKey = GlobalKey();

  final _formKey = GlobalKey<FormState>();

  double totalCartPrice = 0;

  String _currentSize = "normal";

  double initialPriceByQuantityANDSize = 0.0;
  double priceByQuantityANDSize = 0.0;

//  priceByQuantityANDSize = euroPrice1;
//  initialPriceByQuantityANDSize = euroPrice1;
  int _itemCount= 1;


//  oneFoodItemData


//  FoodItemWithDocID oneFoodItemandId;
//
//  _FoodItemDetailsState(this.oneFoodItemandId)
//
//

  _FoodItemDetailsState();
  List<NewIngredient> defaultIngredientListForFood;

  var logger = Logger(
    printer: PrettyPrinter(),
  );


  Order oneOrder = new Order();


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

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<FoodItemDetailsBloc>(context);

    print('totalCartPrice -----------> : $totalCartPrice');
    print('initialPriceByQuantityANDSize ----------> $initialPriceByQuantityANDSize');


    return StreamBuilder<FoodItemWithDocID>(


        stream: bloc.currentFoodItemsStream,
        initialData: bloc.currentFoodItem,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: new LinearProgressIndicator());
          }
          else {
            print('snapshot.hasData : ${snapshot.hasData}');

            final FoodItemWithDocID oneFood = snapshot.data;

            final Map<String,dynamic> foodSizePrice =  oneFood.sizedFoodPrices;


            logger.i('foodSizePrice: ',foodSizePrice);
            dynamic normalPrice = foodSizePrice['normal'];


            num normalPrice3 = foodSizePrice['normal'];




            print('normalPrice1: $normalPrice ');
            print('normalPrice2: ${foodSizePrice['normal']} ');
            print('normalPrice3: $normalPrice3');

            print('euroPrice1: $normalPrice ');
            double euroPrice1 = tryCast<double>(normalPrice, fallback: 0.00);

          initialPriceByQuantityANDSize = normalPrice;
          priceByQuantityANDSize = normalPrice;



            logger.i('initialPriceByQuantityANDSize',initialPriceByQuantityANDSize);

//        return(Container(
//            color: Color(0xffFFFFFF),
//            child:
//            GridView.builder(


//            final Map<String, dynamic> foodSizePrice = oneFood.sizedFoodPrices;

            return Scaffold(
              backgroundColor: Colors.white.withOpacity(0.05),
              // this is the main reason of transparency at next screen.
              // I am ignoring rest implementation but what i have achieved is you can see.

              body: SafeArea(



                child:Container(

                  alignment: Alignment.bottomCenter,
                  height: displayHeight(context)/3,
                  //width:displayWidth(context) / 1.5, /* 3.8*/
                  width:displayWidth(context)
                      - displayWidth(context)/3.8  /* this is about the width of yellow side menu */
                      -displayWidth(context)/20,/* 10% of widht of the device for padding margin.*/
//                  color:Colors.lightGreenAccent,
                  margin:EdgeInsets.fromLTRB(18,20,20,18),

                  decoration:
                  new BoxDecoration(
                    borderRadius: new BorderRadius.circular(10.0),
                    color:Colors.purple,
                  ),


                  child:Neumorphic(
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

                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // THIS ROW HAVE 2 PARTS -> 1ST PART HANDLES THE IMAGES, SOME HEADING TEXT(PRICE AND NAME)
                        // , 2ND PART(ROW) HANDLES THE
                        // DIFFERENT SIZES OF PRODUCTS. BEGINS HERE.


                        Container(
                            height: displayHeight(context)/3,

                            color: Colors.red,
                            width: displayWidth(context) /5,
// INCREASE THE DIVIDER TO MAKE IT MORE SAMLLER. I.E. WIDTH
//                      height: displayHeight(context)*0.50,
                            alignment: Alignment.centerLeft,


                            //ZZZ
                            // Other arguments such as margin, padding etc. (Like `Container`)
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

//        mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                //pppp
                                Container(
                                  padding:EdgeInsets.fromLTRB(10,15,0,15),
                                  child:

                                  Text(
                                      '${oneFood.itemName}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight
                                            .bold,
//                                                      color: Colors.white
                                        color: Colors.black,

                                      )
                                  ),
                                ),

                                Container(
                                  padding:EdgeInsets.fromLTRB(10,5,0,15),
                                  child:

                                  Text(
                                      '$initialPriceByQuantityANDSize '+ '\u20AC' ,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight
                                            .normal,
//                                                      color: Colors.white
                                        color: Colors.black,

                                      )
                                  ),
                                ),

                                Container(
                                  /*
                              color:Colors.blue,
                            width:displayWidth(context)/4.6,
                            */

                                  child: FoodDetailImage(oneFood.imageURL,
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
                          width:displayWidth(context) -displayWidth(context) /3.7 /* about the width of left most
                          container holding the food Item Image, image name and food item price */
                              - displayWidth(context)/3.8 /* this is about the width of yellow side menu */,
                          child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,


//        mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                //pppp
                                Container(
                                    child:_buildOverlayContent(context,oneFood.sizedFoodPrices)
                                ),
                              ]
                          ),
                        )
                        // 2ND ROW, FOR FOR OTHER ITEMS, WILL BE A COLUMN ARRAY, ENDS HERE:

                      ],
                    ),
                  ),
                ),

              ),
            );
          }
        }
    );
  }


  Widget _buildOverlayContent(BuildContext context, Map<String,dynamic> allPrices) {

    final Map<String,dynamic> foodSizePrice =allPrices;
    return Container(
      alignment: Alignment.topCenter,
//      width: 200,

      height: displayHeight(context)/3,
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
                        margin: EdgeInsets.fromLTRB(5, 0,0,0),
                        child:OutlineButton(
//                        color: Color(0xffFEE295),
                          clipBehavior:Clip.hardEdge,
                          splashColor: Color(0xffB47C00),
                          highlightElevation:12,
                          shape:RoundedRectangleBorder(
                            side: BorderSide(
                              color:Color(0xffB47C00),
                              style: BorderStyle.solid,
                              width:1.6,
                            ),
                            borderRadius: BorderRadius.circular(35.0),
                          ),

                          child:Container(
                            alignment: Alignment.center,
                            child: Text(
                              'M'.toUpperCase(), style:
                            TextStyle(
                                color:Color(0xffB47C00),

                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            ),
                          ),
                          onPressed: () {

                            print('M pressed');
                          },
                          padding: EdgeInsets.fromLTRB(5, 0,0,0),
                        ),),

                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0,0,0),
                        child:OutlineButton(
//                        color: Color(0xffFEE295),
                          splashColor: Color(0xff34720D),
                          highlightElevation:12,
                          clipBehavior:Clip.hardEdge,
                          shape:RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color(0xff34720D),
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          child:Container(

                            alignment: Alignment.center,
                            child: Text(
                              'VSM'.toUpperCase(), style:
                            TextStyle(
                                color:Color(0xff34720D),

                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            ),
                          ),
                          onPressed: () {

                            print('VSM pressed');
                          },
                          padding: EdgeInsets.fromLTRB(5, 0,0,0),
                        ),)
                      ,
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0,0,0),
                        child:OutlineButton(
//                        color: Color(0xffFEE295),
                          splashColor: Color(0xff95CB04),
                          highlightElevation:12,
                          clipBehavior:Clip.hardEdge,
                          shape:RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color(0xff95CB04),
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          child:Container(

                            alignment: Alignment.center,
                            child: Text(
                              'VS'.toUpperCase(), style:
                            TextStyle(
                                color:Color(0xff95CB04),

                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            ),
                          ),
                          onPressed: () {

                            print('VS pressed');
                          },
                          padding: EdgeInsets.fromLTRB(5, 0,0,0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0,0,0),
                        child:
                        OutlineButton(
//                        color: Color(0xffFEE295),
                          splashColor: Color(0xff739DFA),
                          highlightElevation:12,
                          clipBehavior:Clip.hardEdge,
                          shape:RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color(0xff739DFA),
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          child:Container(

                            alignment: Alignment.center,
                            child: Text(
                              'ORG'.toUpperCase(), style:
                            TextStyle(
                                color:Color(0xff739DFA),

                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            ),
                          ),
                          onPressed: () {

                            print('ORG pressed');
                          },

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
                        print('valuePrice at line # 583: $valuePrice and key is $key');
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

          RaisedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Dismiss'),
          )
        ],
      ),

    );
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

              logger.i('onePriceForSize: ',onePriceForSize);
              setState(() {
                initialPriceByQuantityANDSize = onePriceForSize;
                priceByQuantityANDSize = onePriceForSize;
                _currentSize= oneSize;
              });
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
              logger.i('onePriceForSize: ',onePriceForSize);
              setState(() {
                initialPriceByQuantityANDSize = onePriceForSize;
                priceByQuantityANDSize = onePriceForSize;
                _currentSize= oneSize;
              });
            },
          ),
        )
    );
  }
//  child:MessageList(firestore: firestore),

}


//  FoodDetailImage




class FoodDetailImage extends StatelessWidget {


  final String imageURLBig;
  final String foodItemName;
  FoodDetailImage(this.imageURLBig,this.foodItemName);

  @override
  Widget build(BuildContext context) {

    return Container(

      color:Colors.white,
//      height: displayHeight(context)/4,
      height:displayWidth(context)/3.8,
      width:displayWidth(context)/4.6,
      child:Transform.translate(
        offset:Offset(-displayWidth(context)/18,0),

//      INCREAS THE DIVIDER TO MOVE THE IMAGE TO THE RIGHT
        // -displayWidth(context)/9
        child:
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: displayWidth(context)/3.9,
              height:displayWidth(context)/4.4,

              // INCREASE THE HEIGHT TO MAKE THE IMAGE CONTAINER MORE SMALLER.

              decoration: new BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Hero(
                tag: foodItemName,
                child:
                ClipOval(
                  child:CachedNetworkImage(
                    width: displayWidth(context)/3.9,
                    height:displayWidth(context)/4.4,
                    imageUrl: imageURLBig,
//                    fit: BoxFit.scaleDown,cover,scaleDown,fill
                    fit: BoxFit.fill,
//
                    placeholder: (context, url) => new CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomRect extends CustomClipper<Rect>{
  @override
  Rect getClip(Size size) {
    print('at get Clip');
//    Rect rect = Rect.fromLTRB(100, 0.0, size.width, size.height);
    Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    return rect;
    // TODO: implement getClip
  }
  @override
  bool shouldReclip(CustomRect oldClipper) {
    // TODO: implement shouldReclip
    //    return true;
    return false;
  }
}


class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0); // (x,h) =(width,0)
    path.lineTo(size.width - 1, size.height- 1);
    path.lineTo(size.width - 2, size.height- 2);
    path.lineTo(size.width - 3, size.height- 3);
    path.lineTo(size.width - 4, size.height- 4);
    path.lineTo(size.width - 5, size.height- 5);
    path.lineTo(size.width - 6, size.height- 6);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}


