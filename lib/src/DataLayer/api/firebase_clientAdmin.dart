
import 'dart:async';
//import 'dart:convert' show json;

//import 'package:flutter/foundation.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';

import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';

import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';
//import 'package:http/http.dart' as http;

//import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';



//final String storageBucketURLPredicate =
//    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/';



class FirebaseClientAdmin {


// _thisFoodItem, sequenceNo, _firebaseUserEmail, imageURL
  Future<String> insertSauceItem(SauceItem x, int sequenceNo, String email,
      String imageURL) async {
    print('at insertIngredientItems....');


    Timestamp date;
    String orderDocId = '';

    String imageURLFinal1 = '';
    var uri = Uri.parse(imageURL);

    print('imageURL at insertIngredientItems ...: $imageURL');
    // print(uri.isScheme("HTTP"));  // Prints true.

    if (uri.isScheme("HTTP") || (uri.isScheme("HTTPS"))) {
      print('on of them is true');


      String imageURLFinal2 = imageURL;
      String iteration2 = Uri.decodeComponent(imageURLFinal2).replaceAll(
          'https://firebasestorage.googleapis.com/v0/b/kebabbank-37224.appspot.com/o/',
          '');

      // https://firebasestorage.googleapis.com/v0/b/kebabbank-37224.appspot.com/o/404%2Fingredient404.jpg?alt=media&token=0bea2b84-04ca-4ec8-8ed9-b355b8fb0bb7


      String stringTokenizing2 = iteration2.substring(
          0, iteration2.indexOf('?'));

      imageURLFinal1 = stringTokenizing2;
    }
    else {
      imageURLFinal1 = imageURL;
    }

    DocumentReference document = await FirebaseFirestore.instance.collection(
        "restaurants").
    doc('kebab_bank').
    collection('sauces2').add(<String, dynamic>{

      // 'ingredients': foodItemIngredientsInsertDummy1(null),
      'name': x.sauceItemName,
      'uploadedBy': email,
      'uploadDate': FieldValue.serverTimestamp(),
      'image': imageURLFinal1,
      'itemID': x.itemId,
      'price': x.price,
      'sequenceNo': sequenceNo,
    }).whenComplete(() =>
        print("called when future completes for food Item insert...."))
        .then((document) {
      //  print('Added document with ID: ${document.documentID}');
      orderDocId = document.documentID;
//      return document;
//                            _handleSignIn();
    }).catchError((onError) {
      //   print('K   K    K   at onError for Order data push : $onError');
      orderDocId = '';
//      return '';
    });

    return orderDocId;
  }


  Future<QuerySnapshot> fetchAllCheesesORjuustoAdmin()async{

    print ('at here fetchAllCheesesORjuustoAdmin() ======================= *************** ');

    var snapshot = await FirebaseFirestore.instance.collection("restaurants")
        .doc('kebab_bank')
        .collection('cheeses2')/*.orderBy("sl", descending: false)*/
        .get();


    return snapshot;
  }


  Future<QuerySnapshot> fetchAllKastikeORSaucesAdmin()async{

    // print ('at here fetchAllIngredients ==================================== *************** ');

    var snapshot = await FirebaseFirestore.instance.collection("restaurants")
        .doc('kebab_bank')
        .collection('sauces2')/*.orderBy("sl", descending: false) */
        .get();



    return snapshot;
  }


  Future<QuerySnapshot> fetchAllExtraIngredientsAdmin()async{

    // print ('at here fetchAllIngredients ==================================== *************** ');

    var snapshot = await FirebaseFirestore.instance.collection("restaurants")
        .doc('kebab_bank')
        .collection('extraIngredients')
        .get();

    return snapshot;
  }



//  Future<QuerySnapshot /*DocumentSnapshot */> getLastSequenceNumberFromFireBaseFoodItems() async{
  Future<int> getLastSequenceNumberFromFireBaseFoodItems() async{



    var snapshot = await FirebaseFirestore.instance.collection("restaurants")
        .doc('kebab_bank')
        .collection('foodItems2').orderBy('sequenceNo',descending: true).limit(1).get();
    print('snapshot 000 ========================>> : $snapshot');



    print('at else..... of getLastSequenceNumberFromFireBaseFoodItems()');


//    List docList = snapshot.docs;
    int lastIndexCheese;



    try {
      var oneCheese =snapshot.docs.first.data();
    } catch (e) {

      print('e         _____ -----: $e');
      return lastIndexCheese=-1;

    }


    var oneCheese =snapshot.docs.first.data();
    try {
      lastIndexCheese = oneCheese['sequenceNo'];
    } catch (e) {

      print('e         _____ -----: $e');
      lastIndexCheese=-1;
      return lastIndexCheese;

    }


    print('lastIndexCheese: $lastIndexCheese');


    return lastIndexCheese;


  }

  Future<int> getLastSequenceNumberForAdminCheese2() async{

    var snapshot = await FirebaseFirestore.instance.collection("restaurants")
        .doc('kebab_bank')
        .collection('cheeses2').orderBy('sequenceNo',descending: true).limit(1).get();
    print('snapshot: $snapshot');
    if (snapshot==null)

    {
      print('..at snapshot==null of getLastSequenceNumberFromFireBaseFoodItems()> > ${snapshot==null}');
      return 0;
    }
    else{

      print('at else..... of getLastSequenceNumberFromFireBaseFoodItems()');


      List docList = snapshot.docs;

      var oneCheese =snapshot.docs.first.data();


      print('....oneCheese[\'sequenceNo\'] => ${oneCheese['sequenceNo']}');

      int lastIndexCheese = oneCheese['sequenceNo'];

      print('lastIndexCheese: $lastIndexCheese');


      return lastIndexCheese;
    }

  }


//  Future<QuerySnapshot /*DocumentSnapshot */> getLastSequenceNumberFromFireBaseFoodItems() async{
  Future<int> getLastSequenceNumberForAdminIngredient2() async{

    var snapshot = await FirebaseFirestore.instance.collection("restaurants")
        .doc('kebab_bank')
        .collection('extraIngredients').orderBy('sequenceNo',descending: true).limit(1).get();
    print('snapshot: $snapshot');
    if (snapshot==null)

    {
      print('..at snapshot==null of getLastSequenceNumberFromFireBaseFoodItems()> > ${snapshot==null}');
      return 0;
    }
    else{

      print('at else..... of getLastSequenceNumberFromFireBaseFoodItems()');


      List docList = snapshot.docs;

      var oneIngredient =snapshot.docs.first.data();


      print('....oneIngredient[\'sequenceNo\'] => ${oneIngredient['sequenceNo']}');

      int lastIndex = oneIngredient['sequenceNo'];

      return lastIndex;
    }

  }



//  Future<QuerySnapshot /*DocumentSnapshot */> getLastSequenceNumberFromFireBaseFoodItems() async{
  Future<int> getLastSequenceNumberForAdminSacue2() async{

    var snapshot = await FirebaseFirestore.instance.collection("restaurants")
        .doc('kebab_bank')
        .collection('sauces2').orderBy('sequenceNo',descending: true).limit(1).get();
    print('snapshot: $snapshot');
    if (snapshot==null)

    {
      print('..at snapshot==null of getLastSequenceNumberFromFireBaseFoodItems()> > ${snapshot==null}');
      return 0;
    }
    else{

      print('at else..... of getLastSequenceNumberFromFireBaseFoodItems()');


      List docList = snapshot.docs;

      var oneSauce =snapshot.docs.first.data();


      print('....oneSauce[\'sequenceNo\'] => ${oneSauce['sequenceNo']}');

      int lastIndex = oneSauce['sequenceNo'];

      return lastIndex;
    }

  }


// _thisFoodItem, sequenceNo, _firebaseUserEmail, imageURL
  Future<String> insertCheeseItem(CheeseItem x, int sequenceNo, String email,
      String imageURL) async {
    print('at insertIngredientItems....');


    Timestamp date;
    String orderDocId = '';

    String imageURLFinal1 = '';
    var uri = Uri.parse(imageURL);

    print('imageURL at insertIngredientItems ...: $imageURL');
    // print(uri.isScheme("HTTP"));  // Prints true.

    if (uri.isScheme("HTTP") || (uri.isScheme("HTTPS"))) {
      print('on of them is true');


      String imageURLFinal2 = imageURL;
      String iteration2 = Uri.decodeComponent(imageURLFinal2).replaceAll(
          'https://firebasestorage.googleapis.com/v0/b/kebabbank-37224.appspot.com/o/',
          '');

      // https://firebasestorage.googleapis.com/v0/b/kebabbank-37224.appspot.com/o/404%2Fingredient404.jpg?alt=media&token=0bea2b84-04ca-4ec8-8ed9-b355b8fb0bb7


      String stringTokenizing2 = iteration2.substring(
          0, iteration2.indexOf('?'));

      imageURLFinal1 = stringTokenizing2;
    }
    else {
      imageURLFinal1 = imageURL;
    }

    DocumentReference document = await FirebaseFirestore.instance.collection(
        "restaurants").
    document('kebab_bank').
    collection('cheeses2').add(<String, dynamic>{

      // 'ingredients': foodItemIngredientsInsertDummy1(null),
      'name': x.cheeseItemName,
      'uploadedBy': email,
      'uploadDate': FieldValue.serverTimestamp(),
      'image': imageURLFinal1,
      'itemID': x.itemId,
      'price': x.price,
      'sequenceNo': sequenceNo,
    }).whenComplete(() =>
        print("called when future completes for food Item insert...."))
        .then((document) {
      //  print('Added document with ID: ${document.documentID}');
      orderDocId = document.documentID;
//      return document;
//                            _handleSignIn();
    }).catchError((onError) {
      //   print('K   K    K   at onError for Order data push : $onError');
      orderDocId = '';
//      return '';
    });

    return orderDocId;
  }


// _thisFoodItem, sequenceNo, _firebaseUserEmail, imageURL
  Future<String> insertIngredientItems(NewIngredient x, int sequenceNo,
      String email, String imageURL) async {
    print('at insertIngredientItems....');


    Timestamp date;
    String orderDocId = '';

    String imageURLFinal1 = '';
    var uri = Uri.parse(imageURL);

    print('imageURL at insertIngredientItems ...: $imageURL');
    // print(uri.isScheme("HTTP"));  // Prints true.

    if (uri.isScheme("HTTP") || (uri.isScheme("HTTPS"))) {
      print('on of them is true');


      String imageURLFinal2 = imageURL;
      String iteration2 = Uri.decodeComponent(imageURLFinal2).replaceAll(
          'https://firebasestorage.googleapis.com/v0/b/kebabbank-37224.appspot.com/o/',
          '');

      // https://firebasestorage.googleapis.com/v0/b/kebabbank-37224.appspot.com/o/404%2Fingredient404.jpg?alt=media&token=0bea2b84-04ca-4ec8-8ed9-b355b8fb0bb7


      String stringTokenizing2 = iteration2.substring(
          0, iteration2.indexOf('?'));

      imageURLFinal1 = stringTokenizing2;
    }
    else {
      imageURLFinal1 = imageURL;
    }

    DocumentReference document = await FirebaseFirestore.instance.collection(
        "restaurants").
    document('kebab_bank').
    collection('extraIngredients').add(<String, dynamic>{
//      'category':'someC',
//      'categoryShort':'someC',

      'extraIngredientOf': x.extraIngredientOf,
      // 'ingredients': foodItemIngredientsInsertDummy1(null),
      'name': x.ingredientName,
      'uploadedBy': email,
      'uploadDate': FieldValue.serverTimestamp(),
      'image': imageURLFinal1,
      'itemID': x.itemId,
      'price': x.price,
      'sequenceNo': sequenceNo,
      'subGroup': x.subgroup,

    }).whenComplete(() =>
        print("called when future completes for food Item insert...."))
        .then((document) {
      //  print('Added document with ID: ${document.documentID}');
      orderDocId = document.documentID;
//      return document;
//                            _handleSignIn();
    }).catchError((onError) {
      //   print('K   K    K   at onError for Order data push : $onError');
      orderDocId = '';
//      return '';
    });

    return orderDocId;
  }

  Future<String> insertFoodItems(
      /*Order currentOrderToFirebase, String orderBy, String paidType, String restaurantName */
//      String name,int sequenceNo,

      FoodItemWithDocID x, int sequenceNo, String email,
      String imageURL) async {


    Timestamp date;
    String orderDocId = '';
    String imageURLFinal1 = '';

    print('sequenceNo >>>  $sequenceNo');

    print('====> ${x.shorCategoryName}');

    print('====>  ${x.categoryName}');


    var uri = Uri.parse(imageURL);
    // print(uri.isScheme("HTTP"));  // Prints true.

    if (uri.isScheme("HTTP") || (uri.isScheme("HTTPS"))) {
      print('on of them is true');


      String imageURLFinal2 = imageURL;
      String iteration2 = Uri.decodeComponent(imageURLFinal2).replaceAll(
          'https://firebasestorage.googleapis.com/v0/b/kebabbank-37224.appspot.com/o/',
          '');


      String stringTokenizing2 = iteration2.substring(
          0, iteration2.indexOf('?'));

      imageURLFinal1 = stringTokenizing2;
    }
    else {
      imageURLFinal1 = imageURL;
    }


//  List <String> /*<OrderedFood>*/ convertedMultiSelect(List<FoodPropertyMultiSelect> multiSelects) {
    List <String> /*<OrderedFood>*/ foodItemIngredientsInsertDummy(
        List<NewIngredient> ingredients) {
      print('at here... foodItemIngredientsInsertDummy %%%%% ECHO');
//    print('multiSelects: $multiSelects');

      List<String> multiSelectStrings = new List<String>();

      if (ingredients == null) {
        multiSelectStrings.add('kebab');

        multiSelectStrings.add('salaatti');

        multiSelectStrings.add('salami');

        return multiSelectStrings;
      }

      int counter = 0;

      List<NewIngredient> selectedMultiSelects = new List<NewIngredient>();

      selectedMultiSelects = ingredients;

      if (selectedMultiSelects.length != 0) {
        selectedMultiSelects.forEach((oneFoodPropertyMultiSelect) {
          print('--------------------------------------');
          // print(
          //     'oneFoodPropertyMultiSelect.itemFullName}: ${oneFoodPropertyMultiSelect
          //         .itemFullName}');

          print('--------------------------------------');

          // FOR MAP
          /*
      var identifier = {
        'multiSelectName': oneFoodPropertyMultiSelect.itemFullName,
      };
      */

          // FOR ARRAY..
          multiSelectStrings.add(oneFoodPropertyMultiSelect.ingredientName);
          counter ++;
        });


        print('counter: $counter');
        return multiSelectStrings;
      }

      else {
        multiSelectStrings.add("");
        return multiSelectStrings;
      }
    }


    DocumentReference document = await FirebaseFirestore.instance.collection(
        "restaurants").
    doc('kebab_bank').
    collection('foodItems2').add(<String, dynamic>{
      'category': x.categoryName,
      'categoryShort': x.shorCategoryName,
      'default_juusto': x.defaultJuusto,
      'default_kastike': x.defaultKastike,
      'ingredients': x.ingredients,
      //foodItemIngredientsInsertDummy(null),
      'name': x.itemName,
      'sequenceNo': sequenceNo,
      // sequenceNo

      'size': {
        'normal': 1.5,
        'gluteeniton': 1.5,
        'lasten': 1,
        'medium': 2.5,
        'pannu': 8,
        'perhe': 5,
      },

      'isAvailable': x.isAvailable,
      'isHot': x.isHot,
      'uploadedBy': email,
      'uploadDate': FieldValue.serverTimestamp(),

      'image': imageURLFinal1,
      'itemID': x.itemId,
      /*
    https://firebasestorage.googleapis.com/v0/b/kebabbank-37224.appspot.com/o/
      // foodItems/pizza/test aQQDF}I.png
      */

    }).whenComplete(() =>
        print("called when future completes for food Item insert...."))
        .then((document) {
      //  print('Added document with ID: ${document.documentID}');
      orderDocId = document.documentID;
//      return document;
//                            _handleSignIn();
    }).catchError((onError) {
      //   print('K   K    K   at onError for Order data push : $onError');
      orderDocId = '';
//      return '';
    });

    return orderDocId;
  }

}