//food_gallery.dart



// dependency files
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/DataLayer/NewIngredient.dart';
import 'package:logger/logger.dart';
import 'package:neumorphic/neumorphic.dart';


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

  double initialPriceByQuantityANDSize;
  double priceByQuantityANDSize = 12.0;


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


  num tryCast<num>(dynamic x, {num fallback }) => x is num ? x : 0.0;

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<FoodItemDetailsBloc>(context);
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


//        return(Container(
//            color: Color(0xffFFFFFF),
//            child:
//            GridView.builder(


            final Map<String, dynamic> foodSizePrice = oneFood.sizedFoodPrices;

            return Scaffold(
              backgroundColor: Colors.white.withOpacity(0.05),
              // this is the main reason of transparency at next screen.
              // I am ignoring rest implementation but what i have achieved is you can see.

              body: SafeArea(
                child:Container(
                  alignment: Alignment.centerLeft,
                  height: displayHeight(context)/3,
                  width:displayWidth(context) / 1.5, /* 3.8*/
                  color:Colors.lightGreenAccent,
                  margin:EdgeInsets.fromLTRB(30,20,20,20),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // 1ST CONTAINER OF THIS ROW HANDLES THE BIG DETAIL PAGE IMAGE.

                      Container(
                        height: displayHeight(context)/3,

                        color: Colors.red,
                        width: displayWidth(context) /3.7,
//                      height: displayHeight(context)*0.50,
                        alignment: Alignment.centerLeft,
                        child:NeuCard(
                          // State of Neumorphic (may be convex, flat & emboss)
                            curveType: CurveType.concave,
//            padding: EdgeInsets.symmetric(horizontal: 3,vertical:0),
//                            margin: EdgeInsets.fromLTRB(12, 0, 5, 0),

                            // Elevation relative to parent. Main constituent of Neumorphism
//            bevel: 12,

                            // Specified decorations, like `BoxDecoration` but only limited
                            decoration: NeumorphicDecoration(
                              borderRadius: BorderRadius.circular(8),
                              shape: BoxShape.rectangle,
                              clipBehavior: Clip.antiAlias,
                              color: Color(0xffabcdef),
                            ),

                            //ZZZ
                            // Other arguments such as margin, padding etc. (Like `Container`)
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,

//        mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                //pppp
                                Container(
                                  padding:EdgeInsets.fromLTRB(0,0,0,12),
                                  child:

                                  Text(
                                      '${oneFood.itemName}',
                                      style: TextStyle(
                                        fontSize: 24,
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
                      ),

                      Container(
                          child:_buildOverlayContent(context)
                      ),

                    ],
                  ),
                ),

              ),
            );
          }
        }

    );
  }


  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
//      width: 200,
      width:displayWidth(context)/3,
      height: displayHeight(context)/3,
//      height: 400,
      color: Colors.white,
      child: Column(
//        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              'This is a nice overlay',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,


              ),
              textAlign: TextAlign.center,
            ),

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
//    logger.i('onePriceForSize: $onePriceForSize');

    return InkWell(
      onTap: () {

        setState(() {
          initialPriceByQuantityANDSize = onePriceForSize;
          priceByQuantityANDSize = onePriceForSize;
          _currentSize= oneSize;
        });
//        print('_handleRadioValueChange called from Widget categoryItem ');

//        _handleRadioValueChange(index);
      },
      child:Container(

        height:displayHeight(context)/30,
        width:displayWidth(context)/10,

        child:  oneSize.toLowerCase() == _currentSize  ?
        (
            Card(

              color: Colors.lightGreenAccent,
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
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
                ),
              ),
            )
        ):
        (
            Card(

              color: Color(0xffFEE295),
              borderOnForeground: true,

              elevation: 2.5,
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
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
                ),
              ),
            )
        ),



      ),
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
              height:displayWidth(context)/3.9,
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
                    width: displayWidth(context)/3.8,
                    height:displayWidth(context)/3.8,
                    imageUrl: imageURLBig,
                    fit: BoxFit.cover,
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


