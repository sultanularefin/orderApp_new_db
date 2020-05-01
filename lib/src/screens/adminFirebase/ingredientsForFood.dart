
// dependency files
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:shared_preferences/shared_preferences.dart';

// Screen files.
import 'package:foodgallery/src/screens/homeScreen/food_gallery.dart';
import 'package:foodgallery/src/screens/workspace_spinkit.dart';

// model, dummy data file:

import '../../models/itemData.dart';


//import 'package:foodgallery/src/shared/category_Constants.dart' as CategoryItems;


final Firestore firestore = Firestore();


class CategoryItem {
  CategoryItem(this.index,this.name,this.icon);
  final int index;
  final String name;
  final Icon icon;

}

//class Item {
//  const Item(this.name,this.icon);
//  final String name;
//  final Icon icon;
//}


class IngredientsForFood extends StatefulWidget {
//  IngredientsForFood({this.firestore});


  final String documentId;
  final Firestore firestore = Firestore.instance;

  IngredientsForFood({Key key, this.documentId}) : super(key: key);
  _AddIngredientsState createState() => _AddIngredientsState();

}


class _AddIngredientsState extends State<IngredientsForFood> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _AddIngredientsState({firestore});

  //  final _formKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  //  final _itemData = new ItemData();
  final _itemData = ItemData();
  int _currentCategory= 0;
  bool _loadingState = false;

  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };


  String _barcodeValue;


  int _radioValue =3;
  int _itemCount ;

  final Firestore firestore = Firestore.instance;

  CollectionReference get storeIngredients => firestore.collection('ingredientitems');



//  @override
//  Widget build(BuildContext context) {
//
//    print("at IngredientsForFood");
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Admin FireBase Page',),
//
//      ),
//      body: AddData(firestore: firestore),
//
//    );
//  }

  @override
  Widget build(BuildContext context) {

    print('widget.documentId at here: ${widget.documentId}');



      return new Scaffold(
          key:_scaffoldKey,
          appBar: AppBar(title: Text('Add ingredients to foo:')),
          body: Container(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child:
              GridView.extent(

                maxCrossAxisExtent: 300,
                controller: new ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
//                          childAspectRatio: 2.5, --bigger than 2.9
                childAspectRatio: 200/400,


                children: <Widget>[

                  new Container(
                    child: Stack(
                      children: <Widget>[
                        categoryItem(Colors.green, 'Fresh',0),
                      ],
                    ),),

                  new Container(
                    child: Stack(
                      children: <Widget>[

                        categoryItem(Colors.blue, 'Refrigerator',1),
                      ],
                    ),),
                  new Container(
                    child: Stack(
                      children: <Widget>[
                        categoryItem(Colors.pink, 'Freezer',2),

                      ],
                    ),),

                  new Container(
                    child: Stack(
                      children: <Widget>[
                        categoryItem(Colors.red, 'Canned',3),

                      ],
                    ),),

                  new Container(
                    child: Stack(
                      children: <Widget>[
                        categoryItem(Color.fromRGBO(209, 191, 16, 1), 'Dry',4),

                      ],
                    ),),

                  new Container(
                    child: Stack(
                      children: <Widget>[
                        categoryItem(Colors.deepPurple, 'Cleaning',5),
                      ],
                    ),),
                ],
              ),
          )
      );

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
              child:Stack(
                  children:[
                    Align(
                        alignment: Alignment.center,
                        child: Text(name, style: TextStyle(color: Colors.white))
                    ),

                    new Positioned(left:110,
//                  top:-10,
                      top:0,
                      child:
                      IconButton(
                        icon: Icon(Icons.check_box,color: Colors.limeAccent,
                            size: 30.0),
                        tooltip: 'Decrease product count by 1',
                        onPressed: () {
                          print('check Button in the categoryItem Widget pressed.');
                          _handleRadioValueChange(index);
                        },
//                              size: 24,
                        color: Colors.grey,
                      ),
                    ),
                  ]
              ),
            )):(Card(
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


  int _submitbuttonTapped(){

    print('submit button Tapped');
    print('submit button Tapped');

    print('_barcodeValue: $_barcodeValue');

    print('_radioValue: $_radioValue');
    print('_itemCount: $_itemCount');

    return 1;

  }


}



