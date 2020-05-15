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



final Firestore firestore = Firestore();





class FoodItemDetails extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;
//  final FoodItem oneFoodItemData;
  final FoodItemWithDocID oneFoodItemData;
  final Firestore firestore = Firestore.instance;

//  FoodItemWithDocID oneFoodItem =new FoodItemWithDocID(


  FoodItemDetails({Key key, this.child,this.oneFoodItemData}) : super(key: key);

  @override
  _FoodItemDetailsState createState() => new _FoodItemDetailsState(oneFoodItemData);



//  _FoodItemDetailsState createState() => _FoodItemDetailsState();



}


class _FoodItemDetailsState extends State<FoodItemDetails> {

  //  final _formKey = GlobalKey();

  final _formKey = GlobalKey<FormState>();





  double totalCartPrice = 0;
  String _currentSize = "normal";

  double initialPriceByQuantityANDSize;
  double priceByQuantityANDSize;


  int _itemCount= 1;


//  oneFoodItemData

  FoodItemWithDocID oneFoodItemandId;

  _FoodItemDetailsState(this.oneFoodItemandId);
  List<NewIngredient> defaultIngredientListForFood;

  var logger = Logger(
    printer: PrettyPrinter(),
  );


  Order oneOrder = new Order();


  @override
  void initState() {


    setDetailForFood();
    retrieveIngredientsDefault();
    super.initState();

  }

  Future<void> retrieveIngredientsDefault() async {
    debugPrint("Entering in retrieveIngredients1");


    await retrieveIngredients2().then((onValue){

//      print('onValue: |||||||||||||||||||||||||||||||||||||||||||||||||||||||$onValue');
      setState(() {
        defaultIngredientListForFood = onValue;
//        ingredientlistUnSelected = onValue.sublist(4);
      }
      );

    }

    );


  }







  Future <List> retrieveIngredients2() async {
    var logger = Logger(
      printer: PrettyPrinter(),
    );

//    final List<dynamic> foodItemIngredientsList =

    List <NewIngredient> ingItems = new List<NewIngredient>();


    final List<dynamic> foodItemIngredientsList2 =  oneFoodItemandId.ingredients;
    List<String> test2 = dListFilteredToSList(foodItemIngredientsList2);

    if(test2.length!=0) {
      logger.i('test in retrieveIngredients2() : $test2');

//    firestore
//        .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j')
//        .collection('ingredients').where(
//        'name', whereIn: test
//
//    ).snapshots(),


      var snapshot = await Firestore.instance.collection("restaurants")
          .document('USWc8IgrHKdjeDe9Ft4j')
          .collection('ingredients').where(
          'name', whereIn: test2)
          .getDocuments();

      //    firestore
      //        .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j')
      //        .collection('ingredients').

      //    List docList = snapshot.documents;
      //    print('doc List at FoodDetails page (init State) :  ******************* <================ : $docList');

      // ingItems = snapshot.documents.map((documentSnapshot) => IngredientItem.fromMap
      //(documentSnapshot.data)).toList();

      ingItems = snapshot.documents.map((documentSnapshot) =>
          NewIngredient.fromMap
            (documentSnapshot.data, documentSnapshot.documentID)

      ).toList();


      List<String> documents = snapshot.documents.map((documentSnapshot) =>
      documentSnapshot.documentID
      ).toList();

      print('documents are: $documents');


      return ingItems;
    }
    else{
      NewIngredient c1 = new NewIngredient(
          ingredientName : 'None',
          imageURL: 'None',

          price: 0.01,
          documentId: 'None',
          ingredientAmountByUser :1000

      );

      ingItems.add(c1);

      return ingItems;

    }
  }



  // !(NOT) NECESSARY NOW.
  Future<void> setDetailForFood() async {
    debugPrint("Entering in retrieveIngredients1");
//    logger.i('ss',oneFoodItemandId);
//
//
//    logger.i('ss','sss');

//    final Map<String,dynamic> foodSizePrice = oneFoodItemandId.sizedFoodPrices;


    dynamic normalPrice = oneFoodItemandId.sizedFoodPrices['normal'];
    double euroPrice1 = tryCast<double>(normalPrice, fallback: 0.00);



//    logger.i('euroPrice1 :',euroPrice1);
//    tryCast(normalPrice);


//      print('onValue: |||||||||||||||||||||||||||||||||||||||||||||||||||||||$onValue');
    setState(()
    {

      priceByQuantityANDSize = euroPrice1;
      initialPriceByQuantityANDSize = euroPrice1;
    }
    );



  }



//    final FoodItemWithDocID oneFoodItemandId;
//  _FoodItemDetailsState({this.oneFoodItemandId});



//  final Map<String,dynamic> foodSizePrice = oneFoodItemandId.sizedFoodPrices;



  num tryCast<num>(dynamic x, {num fallback }) => x is num ? x : 0.0;



  String convertDList(List<dynamic> dlist) {

    return dlist.map((name) =>

    "\'"+name.trim().toString()+"\'"
    ).join(', ');

  }



  String isIngredientExist(String inputString) {
    List<String> allIngredients = [
      'ananas',
      'aurajuusto',
      'aurinklkuivattu_tomaatti',
      'cheddar',
      'emmental_laktoositon',
      'fetajuusto',
      'herkkusieni',
      'jalapeno',
      'jauheliha',
      'juusto',
      'kana',
      'kanakebab',
      'kananmuna',
      'kapris',
      'katkarapu',
      'kebab',
      'kinkku',
      'mieto_jalapeno',
      'mozzarella',
      'oliivi',
      'paprika',
      'pekoni',
      'pepperoni',
      'persikka',
      'punasipuli',
      'rucola',
      'salaatti',
      'salami',
      'savujuusto_hyla',
      'simpukka',
      'sipuli',
      'suolakurkku',
      'taco_jauheliha',
      'tomaatti',
      'tonnikala',
      'tuore_chili',
      'tuplajuusto',
      'vuohejuusto'
    ];

// String s= allIngredients.where((oneItem) =>oneItem.toLowerCase().contains(inputString.toLowerCase())).toString();
//
// print('s , $s');

//firstWhere(bool test(E element), {E orElse()}) {
    String elementExists = allIngredients.firstWhere(
            (oneItem) => oneItem.toLowerCase() == inputString.toLowerCase(),
        orElse: () => '');

    print('elementExists: $elementExists');

    return elementExists;

//allIngredients.every(test(t)) {
//contains(
//    searchString2.toLowerCase())).toList();
  }

  List<String> dListFilteredToSList(List<dynamic> dlist) {

    List<String> stringList = List<String>.from(dlist);
    return stringList.where((oneItem) =>oneItem.toString().toLowerCase()
        ==
        isIngredientExist(oneItem.toString().trim().toLowerCase())).toList();

  }

  List<String> convertDList3(List<dynamic> dlist) {

    return dlist.map((name) =>

    "\'"+name.trim().toString()+"\'"
    ).toList();

  }

  @override
  Widget build(BuildContext context) {



    // TEST CODE.

    return (
        Container(
          height: displayHeight(context) -
            MediaQuery.of(context).padding.top  - 700,
          color:Colors.lightGreenAccent,
          child:
          Hero(
            tag: 'GalleryToDetails',
            child: Icon(
            Icons.home,
              color: Color(0xffFFFFFF),
              size: displayWidth(context),
          ),
          ),
        )
    );
  }




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
  FoodDetailImage(this.imageURLBig);

  @override
  Widget build(BuildContext context) {


    return Transform.translate(
      offset:Offset(-displayWidth(context)/22,0),

//      INCREAS THE DIVIDER TO MOVE THE IMAGE TO THE RIGHT
      // -displayWidth(context)/9

      child:NeuCard(
        // State of Neumorphic (may be convex, flat & emboss)
        curveType: CurveType.concave,
//            padding: EdgeInsets.symmetric(horizontal: 3,vertical:0),
//        margin: EdgeInsets.fromLTRB(12, 0, 5, 0),

        // Elevation relative to parent. Main constituent of Neumorphism
//            bevel: 12,

        // Specified decorations, like `BoxDecoration` but only limited
        decoration: NeumorphicDecoration(
//          borderRadius: BorderRadius.circular(8),
          shape: BoxShape.circle,
          clipBehavior: Clip.antiAlias,
          color: Color(0xffFFFFFF),
        ),child:
      ClipOval(child:
      Container(
        color:Color(0xffFFFFFF),
        alignment:Alignment.centerLeft,
//        width: 600,
        height:650,
        child:
        ClipOval(
          child: CachedNetworkImage(
            height:630,
            imageUrl: imageURLBig,
//            fit: BoxFit.fitHeight,
            fit: BoxFit.cover,

            placeholder: (context, url) => new CircularProgressIndicator(),

          ),
        ),
      ),
      ),
      ),

//                Image.network(imageURLBig)

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


