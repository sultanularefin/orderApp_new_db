/*
 * Copyright (c) 2019 Razeware LLC
 *
 */

import 'dart:async';
//import 'dart:convert' show json;

import 'package:flutter/foundation.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/FoodPropertyMultiSelect.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/Order.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';
//import 'package:http/http.dart' as http;
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
//import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:zomatoblock/UI/restaurant_tile.dart';
//import './../Config/Secret.dart';


//import 'location.dart';
//import 'restaurant.dart';

//import 'package:foodgallery/src/DataLayer/itemData.dart';
//    import 'package:foodgallery/src/DataLayer/FoodItem.dart';
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
//import 'package:foodgallery/src/DataLayer/CategoryItemsLIst.dart';
//    ''file:
///C:/Users/Taxi/Programs/foodgallery/lib/src/DataLayer/models/NewCategoryItem.dart'tegory.dart';




final String storageBucketURLPredicate =
    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/';

class OrderedFood{
  final String category;      // one of foodItems> collection.
//  final String foodItemImageURL;
  final double discount;
  final String image;
//  int          quantity;
//  final String foodItemSize;
// final String foodItemOrderID;     // random might not be needed.
//  List<NewIngredient> selectedIngredients;
//
//  category
//  default_sauces
//  discount
//  image

  OrderedFood(
      {
        this.category,
        this.discount,
        this.image,
//        this.foodDocumentId,
//        this.quantity,
//        this.foodItemSize,
//        this.selectedIngredients,

        // this.foodItemOrderID,
      }
      );

}

class FirebaseClient {
//  final _apiKey = zomatoKey;
//  final _host = 'developers.zomato.com';
//  final _contextRoot = 'api/v2.1';

  List<FoodItemWithDocID> _allFoodsList = [];


//  var snapshot = await _client.fetchOrderListItems();


  Future<QuerySnapshot> fetchUnPaidOrderListItems() async {

    var snapshot= Firestore.instance
        .collection("restaurants").document('kebab_bank').collection('orderList')
        .orderBy('end',descending: true).where('paidStatus', isEqualTo: 'Unpaid')
        .getDocuments();

//    orderBy('_timeStampUTC', descending: true)
    return snapshot;



  }


  Future<QuerySnapshot> fetchOrderListItemsForHistoryPaidOnly() async {

    var snapshot= Firestore.instance
        .collection("restaurants").document('kebab_bank').
    collection('orderList').orderBy('end',descending: true).where('paidStatus', isEqualTo: 'Paid')
        .getDocuments();

//    orderBy('_timeStampUTC', descending: true)
    return snapshot;

    /*

    var snapshot= Firestore.instance
        .collection("restaurants").document('kebab_bank').collection('orderList')
        .orderBy('end',descending: true).where('paidStatus', isEqualTo: 'Unpaid')
        .getDocuments();

//    orderBy('_timeStampUTC', descending: true)
    return snapshot;
    */


  }


  Future<QuerySnapshot> fetchFoodItems() async {

    // print ('at here fetchFoodItems ==================================== *************** ');

    /*
    var snapshot= Firestore.instance
        .collection("restaurants").document('kebab_bank').collection('foodItems').limit(65)
        .getDocuments();
    */


    var snapshot= Firestore.instance
        .collection("restaurants").document('kebab_bank').collection('fooditems').orderBy('sequence_no',/*descending: false*/)
        .getDocuments();

//    orderBy('_timeStampUTC', descending: true)
    return snapshot;

  }

  Future<QuerySnapshot> fetchAllKastikeORSauces()async{

    // print ('at here fetchAllIngredients ==================================== *************** ');

    var snapshot = await Firestore.instance.collection("restaurants")
        .document('kebab_bank')
        .collection('kastike')/*.orderBy("sl", descending: false) */
        .getDocuments();

//    var snapshot= Firestore.instance
//        .collection("restaurants").document('kebab_bank').collection('foodItems')
//        .getDocuments();

    return snapshot;
  }

  Future<QuerySnapshot> fetchAllCheesesORjuusto()async{

    // print ('at here fetchAllIngredients ==================================== *************** ');

    var snapshot = await Firestore.instance.collection("restaurants")
        .document('kebab_bank')
        .collection('juusto')/*.orderBy("sl", descending: false)*/
        .getDocuments();

//    var snapshot= Firestore.instance
//        .collection("restaurants").document('kebab_bank').collection('foodItems')
//        .getDocuments();

    return snapshot;
  }

  /*
  Future<QuerySnapshot> fetchAllIngredients()async{

    // print ('at here fetchAllIngredients ==================================== *************** ');

    var snapshot = await Firestore.instance.collection("restaurants")
        .document('kebab_bank')
        .collection('inagedients')
        .getDocuments();

//    var snapshot= Firestore.instance
//        .collection("restaurants").document('kebab_bank').collection('foodItems')
//        .getDocuments();

    return snapshot;
  }

  */

//  Future<QuerySnapshot /*DocumentSnapshot */> getLastSequenceNumberFromFireBaseFoodItems() async{
  Future<int> getLastSequenceNumberFromFireBaseFoodItems() async{


    var snapshot = await Firestore.instance.collection("restaurants")
        .document('kebab_bank')
        .collection('foodItems').orderBy('sequenceNo',descending: true).limit(1).getDocuments();


    print('snapshot: $snapshot');
    if (snapshot==null)

      {
        print('..at snapshot==null of getLastSequenceNumberFromFireBaseFoodItems()> > ${snapshot==null}');
        return 0;
      }
    else{

      print('at else..... of getLastSequenceNumberFromFireBaseFoodItems()');
//      var snapshot = await _client.getLastSequenceNumberFromFireBaseFoodItems();
      List docList = snapshot.documents;

      FoodItemWithDocID lastOne = new FoodItemWithDocID();

      int lastIndex = docList[0]['sequenceNo'];

      return lastIndex;
    }
//    where('sequenceNo', isEqualTo: 'Unpaid')


    /*
    var snapshot= Firestore.instance
        .collection("restaurants").document('kebab_bank').collection('orderList')
        .orderBy('end',descending: true).where('paidStatus', isEqualTo: 'Unpaid')
        .getDocuments();
    */

//    orderBy('_timeStampUTC', descending: true)
    ;

//    orderBy('sequenceNo', descending: true).limit(1);
//
//    return snapshot;
  }

  Future<QuerySnapshot> fetchAllExtraIngredients()async{

    // print ('at here fetchAllIngredients ==================================== *************** ');

    var snapshot = await Firestore.instance.collection("restaurants")
        .document('kebab_bank')
        .collection('extraIngredients2')
        .getDocuments();

//    var snapshot= Firestore.instance
//        .collection("restaurants").document('kebab_bank').collection('foodItems')
//        .getDocuments();

    return snapshot;
  }



  Future<DocumentSnapshot> fetchRestaurantDataClient() async{

    var snapshot = Firestore.instance
        .collection('restaurants')
        .document('kebab_bank')
        .get();
    /*
        .then((DocumentSnapshot ds) {
      // use ds as a snapshot
    });*/
    /*
    var snapshot = await Firestore.instance.collection("restaurants")
        .document('kebab_bank');

//    var snapshot= Firestore.instance
//        .collection("restaurants").document('kebab_bank').collection('foodItems')
//        .getDocuments();

    return snapshot;

     */
    return snapshot;
  }

  Future<DocumentSnapshot> invokeClientForOneOrder(String orderDocumentId) async{


    print('at firebase_client.dart file inside this method: \"invokeClientForOneOrder\"');

    var snapshot = Firestore.instance
        .collection('restaurants')
        .document('kebab_bank').collection('orderList').document(orderDocumentId)
        .get();

    print('and the snapshot is: $snapshot');

//
    return snapshot;
  }

//  List <String> /*<OrderedFood>*/ convertedMultiSelect(List<FoodPropertyMultiSelect> multiSelects) {
    List <String> /*<OrderedFood>*/ foodItemIngredientsInsertDummy( List<FoodPropertyMultiSelect> multiSelects ) {

    print('at here... convertedMultiSelect(List<FoodPropertyMultiSelect> multiSelects) ... .... .... %%%%% ECHO');
//    print('multiSelects: $multiSelects');

    List<String> multiSelectStrings = new List<String>();

    if (multiSelects == null) {
      multiSelectStrings.add("");
      return multiSelectStrings;
    }

    int counter = 0;

    List<FoodPropertyMultiSelect> selectedMultiSelects = new List<
        FoodPropertyMultiSelect>(4);

    selectedMultiSelects =
        multiSelects.where((element) => element.isSelected == true).toList();

    if (selectedMultiSelects.length != 0){
      selectedMultiSelects.forEach((oneFoodPropertyMultiSelect) {
        print('--------------------------------------');
        print(
            'oneFoodPropertyMultiSelect.itemFullName}: ${oneFoodPropertyMultiSelect
                .itemFullName}');

        print('--------------------------------------');

        // FOR MAP
        /*
      var identifier = {
        'multiSelectName': oneFoodPropertyMultiSelect.itemFullName,
      };
      */

        // FOR ARRAY..
        multiSelectStrings.add(oneFoodPropertyMultiSelect.itemFullName);
        counter ++;
      });


      print('counter: $counter');
      return multiSelectStrings;
    }

    else{
      multiSelectStrings.add("");
      return multiSelectStrings;
    }

  }

//  List <Map<String, dynamic>> /*<OrderedFood>*/ convertedMultiSelect(List<FoodPropertyMultiSelect> multiSelects){
  List <String> /*<OrderedFood>*/ convertedMultiSelect(List<FoodPropertyMultiSelect> multiSelects) {

    print('at here... convertedMultiSelect(List<FoodPropertyMultiSelect> multiSelects) ... .... .... %%%%% ECHO');
    print('multiSelects: $multiSelects');

    List<String> multiSelectStrings = new List<String>();

    if (multiSelects == null) {
      multiSelectStrings.add("");
      return multiSelectStrings;
    }

    int counter = 0;

    List<FoodPropertyMultiSelect> selectedMultiSelects = new List<
        FoodPropertyMultiSelect>(4);

    selectedMultiSelects =
        multiSelects.where((element) => element.isSelected == true).toList();

    if (selectedMultiSelects.length != 0){
      selectedMultiSelects.forEach((oneFoodPropertyMultiSelect) {
        print('--------------------------------------');
        print(
            'oneFoodPropertyMultiSelect.itemFullName}: ${oneFoodPropertyMultiSelect
                .itemFullName}');

        print('--------------------------------------');

        // FOR MAP
        /*
      var identifier = {
        'multiSelectName': oneFoodPropertyMultiSelect.itemFullName,
      };
      */

        // FOR ARRAY..
        multiSelectStrings.add(oneFoodPropertyMultiSelect.itemFullName);
        counter ++;
      });


    print('counter: $counter');
    return multiSelectStrings;
  }

    else{
      multiSelectStrings.add("");
      return multiSelectStrings;
    }

  }


  List <Map<String, dynamic>> /*<OrderedFood>*/ convertedIngredients(List<NewIngredient> si){

//    ingredientName;
//    imageURL;
//    price;
//    documentId;
//    ingredientAmountByUser


    List<Map<String, dynamic>> testIngredients = new List<Map<String, dynamic>>();
    int counter=0;
    si.forEach((oneIngredient) {

      print('--------------------------------------');
      print('si[counter].ingredientName}: ${si[counter].ingredientName}');
      print('si[counter].imageURL}: ${si[counter].imageURL}');


      print('si[counter].price}: ${si[counter].price}');
//      print('si[counter].ingredientAmountByUser}: ${si[counter].ingredientAmountByUse}');



      print('si[counter].isDefault}: ${si[counter].isDefault}');



      print('--------------------------------------');


//      print('si[counter].imageURL}: ${si[counter].imageURL}');
//      print('si[counter].imageURL}: ${si[counter].imageURL}');

      //  print('si[counter].imageURL}: ${si[counter].imageURL}');
      var identifier = {

        'type': 0,
        'name': si[counter].ingredientName,
        'image':si[counter].imageURL,
        /*
        'image': Uri.decodeComponent(si[counter].imageURL.replaceAll(
            'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/',
            '').replaceAll('?alt=media', '')),

        */
//        ROzgCEcTA7J9FpIIQJra
//        'ingredientAmountByUser': si[counter].ingredientAmountByUser,
        'ingredientPrice':si[counter].price,
        'isDefault':si[counter].isDefault,
        'isDeleted':si[counter].isDeleted,

      };
      testIngredients.add(identifier);
      counter ++;


    });
    return testIngredients;
//    return sf.length

  }

  List <Map<String, dynamic>> /*<OrderedFood>*/ convertedCheeseItems(List<CheeseItem> cheeseItems){

  print('cheeseItems.length: ${cheeseItems.length}');

    List<Map<String, dynamic>> testCheeseItems = new List<Map<String, dynamic>>();
    int counter=0;
  cheeseItems.forEach((oneCheeseItem) {

      print('selected check: ${cheeseItems[counter].cheeseItemName} === ${cheeseItems[counter].isDefaultSelected}');

      //  print('si[counter].imageURL}: ${si[counter].imageURL}');
      var identifier = {

        'type': 0,
        'name': cheeseItems[counter].cheeseItemName,
        'image':cheeseItems[counter].imageURL,
//        'image': Uri.decodeComponent(cheeseItems[counter].imageURL.replaceAll(
//            'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/',
//            '').replaceAll('?alt=media', '')),
//        ROzgCEcTA7J9FpIIQJra
        'cheeseItemAmountByUser': cheeseItems[counter].cheeseItemAmountByUser,
        'cheeseItemPrice':cheeseItems[counter].price,
        'isDefaultSelected':cheeseItems[counter].isDefaultSelected,
        'isDeleted':cheeseItems[counter].isDeleted,

      };
      testCheeseItems.add(identifier);
      counter ++;


    });
    return testCheeseItems;
//    return sf.length

  }

  List <Map<String, dynamic>> /*<OrderedFood>*/ convertedSauceItems(List<SauceItem> sauceItems){

//    ingredientName;
//    imageURL;
//    price;
//    documentId;
//    ingredientAmountByUser

    print('sauceItems.length: ${sauceItems.length}');


    List<Map<String, dynamic>> testIngredients = new List<Map<String, dynamic>>();
    int counter=0;
    sauceItems.forEach((oneIngredient) {

      print('selected check: ${sauceItems[counter].sauceItemName} === ${sauceItems[counter].isDefaultSelected}');

      //  print('si[counter].imageURL}: ${si[counter].imageURL}');
      var identifier = {

        'type': 0,
        'name': sauceItems[counter].sauceItemName,
        'image': Uri.decodeComponent(sauceItems[counter].imageURL.replaceAll(
            'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/',
            '').replaceAll('?alt=media', '')),
//        ROzgCEcTA7J9FpIIQJra
        'sauceItemAmountByUser': sauceItems[counter].sauceItemAmountByUser,// +1, // 1 is added since by default it is zero
        'sauceItemPrice':sauceItems[counter].price,
        'isDefaultSelected':sauceItems[counter].isDefaultSelected,
        'isDeleted':sauceItems[counter].isDeleted,

      };
      testIngredients.add(identifier);
      counter ++;


    });
    return testIngredients;
//    return sf.length

  }


  List <Map<String, dynamic>> /*<OrderedFood>*/ convertedFoods (List<SelectedFood> sf){

    List<Map<String, dynamic>> testFoodItems = new List<Map<String, dynamic>>();
    int counter=0;
    sf.forEach((oneFood) {

      // print('sf[counter].foodItemImageURL: ${sf[counter].foodItemImageURL}');
      var identifier = {

        'category': sf[counter].categoryName,
        'discount': sf[counter].discount,
        'foodImage': Uri.decodeComponent(sf[counter].foodItemImageURL.replaceAll(
            'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/',
            '').replaceAll('?alt=media', '')),
//        ROzgCEcTA7J9FpIIQJra
        'quantity': sf[counter].quantity,
        'selectedSauces':convertedSauceItems(sf[counter].selectedSauceItems),
        'selectedCheeses':convertedCheeseItems(sf[counter].selectedCheeseItems),
        'ingredients':convertedIngredients(sf[counter].selectedIngredients),
        'multiSelect':convertedMultiSelect(sf[counter].multiSelct),
//        _multiSelectForFood
        'name':sf[counter].foodItemName,
        'oneFoodTypeTotalPrice': sf[counter].quantity * sf[counter].unitPrice,
        'unitPrice':sf[counter].unitPrice,
        'unitPriceWithoutCheeseIngredientSauces': sf[counter].unitPriceWithoutCheeseIngredientSauces, // for recite
        'foodItemSize':sf[counter].foodItemSize,
      };
      testFoodItems.add(identifier);
      counter ++;

    });
    return testFoodItems;
//    return sf.length

  }


  Future<DocumentSnapshot> updateOneUnPaidOrderLater
//  Future<bool> updateOrderCollectionDocumentWithRecitePrintedInformation
      (String orderDocumentId, String status) async {
    print('orderDocumentId in updateOrderCollectionDocumentWithRecitePrintedInformation: $orderDocumentId');

    final DocumentReference postRef = Firestore.instance.collection(
        "restaurants").
    document('kebab_bank').
    collection('orderList').document(orderDocumentId);


    Future<Map<String, dynamic>> test=    Firestore.instance.runTransaction((Transaction tx) async {

      DocumentSnapshot postSnapshot = await tx.get(postRef);

      if (postSnapshot.exists) {
        print('postSnapshot.exists.... in updateOneUnPaidOrderLater');
        await tx.update(postRef, <String, String>{'recitePrinted': status});


//        return true;
      }else{

        return null;
        throw ('postSnapshot don\'t exists....');

      }

    });


    return test.whenComplete(() => print("update complete let\'s download the data")
    ).then((document) {


      var snapshot = Firestore.instance.collection(
          "restaurants").
      document('kebab_bank').
      collection('orderList').document(orderDocumentId)
          .get();
//     print('async result [document] for runTransaction in order : $document');
//     return true;
      print('snapshot: $snapshot');

      return snapshot;

//                            _handleSignIn();
    }).catchError((onError) {
      print('..... transaction not successfull.... : $onError');

      return null;
      throw ('postSnapshot don\'t exists....');
//     return false;
//     orderDocId= '';
//      return '';
    });

//    print('will this method return null');
//    return null;
//    return null;
  }


  Future<DocumentSnapshot> updateOrderCollectionDocumentWithRecitePrintedInformation
//  Future<bool> updateOrderCollectionDocumentWithRecitePrintedInformation
      (String orderDocumentId, String paidType) async {
    print('orderDocumentId in updateOrderCollectionDocumentWithRecitePrintedInformation: $orderDocumentId');

    final DocumentReference postRef = Firestore.instance.collection(
        "restaurants").
    document('kebab_bank').
    collection('orderList').document(orderDocumentId);


    Future<Map<String, dynamic>> test=    Firestore.instance.runTransaction((Transaction tx) async {

      DocumentSnapshot postSnapshot = await tx.get(postRef);

      if (postSnapshot.exists) {
        print('postSnapshot.exists....');
        await tx.update(postRef, <String, String>{'paidType': paidType,
          'paidStatus': paidType != 'Later' ? 'Paid' : 'Unpaid',});


//        return true;
      }else{

        return null;
        throw ('postSnapshot don\'t exists....');

      }

    });


   return test.whenComplete(() => print("update complete let\'s download the data")
   ).then((document) {


     var snapshot = Firestore.instance.collection(
         "restaurants").
     document('kebab_bank').
     collection('orderList').document(orderDocumentId)
         .get();
//     print('async result [document] for runTransaction in order : $document');
//     return true;
     print('snapshot: $snapshot');

     return snapshot;

//                            _handleSignIn();
   }).catchError((onError) {
     print('..... transaction not successfull.... : $onError');

     return null;
     throw ('postSnapshot don\'t exists....');
//     return false;
//     orderDocId= '';
//      return '';
   });

//    print('will this method return null');
//    return null;
//    return null;
  }


  Future<String> insertOrder(Order currentOrderToFirebase, String orderBy, String paidType, String restaurantName)async {

    List<SelectedFood> tempSelectedFood = currentOrderToFirebase.selectedFoodInOrder;

    var map1 = Map.fromIterable(tempSelectedFood, key: (e)
    => e.foodItemName, value: (e)=>e.foodItemName,

//    key:'category', value:'t',
    ); /*{

      e.foodItemImageURL;
      e.unitPrice;
      e.foodDocumentId;
      e.quantity;
      e.foodItemSize;

    }*/
//    );
    // print('map1 $map1');

    String orderDocId='';
    // print('saving order data using a web service');

    DocumentReference document = await Firestore.instance.collection(
        "restaurants").
    document('kebab_bank').
//    collection('orderList').add(switch (<String, dynamic>{
    collection('orderList').add(<String, dynamic>{

      'address': {
        'apartNo': currentOrderToFirebase.orderingCustomer.flatOrHouseNumber,
        'geo': [0, 0],
        'state': currentOrderToFirebase.orderingCustomer.address,
        'phone': currentOrderToFirebase.orderingCustomer.phoneNumber,

      },
      'restaurantName':restaurantName,
      'contact': currentOrderToFirebase.orderingCustomer.phoneNumber,
      'driver': 'mhmd',
      'end': FieldValue.serverTimestamp(),
//      'items': [],


      'items': convertedFoods(tempSelectedFood),
      'orderby': orderBy,
      'paidStatus': paidType != 'Later' ? 'Paid' : 'Unpaid',
      'paidType': paidType,
      'price': currentOrderToFirebase.totalPrice,
      'tax': (14/100)*(currentOrderToFirebase.totalPrice),
      'priceWithDelivery?':orderBy == 'Phone' ? (currentOrderToFirebase.totalPrice) : orderBy == 'Delivery'
          ? (currentOrderToFirebase.totalPrice + 2.50)
          : orderBy == 'TakeAway' ? (currentOrderToFirebase.totalPrice )
        : (currentOrderToFirebase.totalPrice) ,

      'start': FieldValue.serverTimestamp(),
      // time when order is placed in firestore by clicking the pay button
      'status': "ready",
      'tableNo': '33',
      'orderType': orderBy == 'Phone' ? 'Phone' : orderBy == 'Delivery'
          ? 'Delivery'
          : orderBy == 'TakeAway' ? 'TakeAway' : 'DinningRoom',
      'orderProductionTimeFromNow': currentOrderToFirebase.orderingCustomer.etaTimeInMinutes,
      'orderProductionTimeOfDay':  currentOrderToFirebase.orderingCustomer.etaTimeOfDay.toString(),


      // currentOrderToFirebase.orderingCustomer.etaTimeOfDay.hour +
      //     currentOrderToFirebase.orderingCustomer.etaTimeOfDay.minute,

      'orderProduction'
      'recitePrinted':'false',
      'deliveryCost?':orderBy == 'Phone' ? 0.00 : orderBy == 'Delivery'
          ? 2.50
          : orderBy == 'TakeAway' ? 0.00 : 0.00,

    }).whenComplete(() => print("called when future completes"))
        .then((document) {
      //  print('Added document with ID: ${document.documentID}');
      orderDocId= document.documentID;
//      return document;
//                            _handleSignIn();
    }).catchError((onError) {
      //   print('K   K    K   at onError for Order data push : $onError');
      orderDocId= '';
//      return '';
    });

    return orderDocId;


  }


  Future<String> insertIngredientItems(NewIngredient x, String email
      )async {

    Timestamp date ;
    String orderDocId='';

    DocumentReference document = await Firestore.instance.collection("restaurants").
    document('kebab_bank').

    collection('foodItems').add(<String, dynamic>{
//      'category':'someC',
//      'categoryShort':'someC',

    'extraIngredientOf':'pizza',

      'ingredients': foodItemIngredientsInsertDummy(null),
      'name':x.ingredientName,
      'uploadedBy':email,
      'uploadDate':FieldValue.serverTimestamp(),
//      'priceinEuro': priceInEuro,
//      'isHot':isHot,
//      'itemName':itemName,
//      'categoryName': categoryName,
//      'ingredients':ingredients,
      'imageURL':x.imageURL,
      'itemID':x.itemId,



    }).whenComplete(() => print("called when future completes for food Item insert...."))
        .then((document) {
      //  print('Added document with ID: ${document.documentID}');
      orderDocId= document.documentID;
//      return document;
//                            _handleSignIn();
    }).catchError((onError) {
      //   print('K   K    K   at onError for Order data push : $onError');
      orderDocId= '';
//      return '';
    });

    return orderDocId;

  }

  Future<String> insertFoodItems(/*Order currentOrderToFirebase, String orderBy, String paidType, String restaurantName */
//      String name,int sequenceNo,

  FoodItemWithDocID x, int sequenceNo, String email
      )async {

    Timestamp date ;
    String orderDocId='';

    DocumentReference document = await Firestore.instance.collection("restaurants").
    document('kebab_bank').

    collection('foodItems').add(<String, dynamic>{
      'category':'someC',
      'categoryShort':'someC',
      'default_juust':'dj',
      'default_kastike': 'dk',
      'ingredients': foodItemIngredientsInsertDummy(null),
      'name':x.itemName+sequenceNo.toString(),
      'sequence_no':sequenceNo,

      'size': {
        'normal': 1.5,
         'gluteeniton':1.5,
         'lasten':1,
         'medium':2.5,
         'pannu':8,
         'perhe':5,
      },

      'isAvailable':x.isAvailable,
      'isHot':x.isHot,
      'uploadedBy':email,
      'uploadDate':FieldValue.serverTimestamp(),


      'imageURL': Uri.decodeComponent(x.imageURL.replaceAll(
//          'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/',
      'https://firebasestorage.googleapis.com/v0/b/linkupfoodgallery.appspot.com/o/',
          '').replaceAll('?alt=media', '')),
      'itemID':x.itemId,



    }).whenComplete(() => print("called when future completes for food Item insert...."))
        .then((document) {
      //  print('Added document with ID: ${document.documentID}');
      orderDocId= document.documentID;
//      return document;
//                            _handleSignIn();
    }).catchError((onError) {
      //   print('K   K    K   at onError for Order data push : $onError');
      orderDocId= '';
//      return '';
    });

    return orderDocId;


  }

  Future<QuerySnapshot> fetchCategoryItems() async {



    //print ('at here fetchCategories ==================================== *************** ');

    var snapshot= Firestore.instance
        .collection("restaurants").document('kebab_bank').
    collection('categories').orderBy("sequence_no", /*descending: false*/)
        .getDocuments();

    return snapshot;

  }



/*
  Future<List<Restaurant>> fetchRestaurants(
      Location location, String query) async {
    final results = await request(path: 'search', parameters: {
      'entity_id': location.id.toString(),
      'entity_type': location.type,
      'q': query,
      'count': '10'
    });

    final restaurants = results['restaurants']
        .map<Restaurant>((json) => Restaurant.fromJson(json['restaurant']))
        .toList(growable: false);

    return restaurants;
  }

  Future<Map> request(
      {@required String path, Map<String, String> parameters}) async {
    final uri = Uri.https(_host, '$_contextRoot/$path', parameters);
    final results = await http.get(uri, headers: _headers);
    final jsonObject = json.decode(results.body);
    return jsonObject;
  }

  Map<String, String> get _headers =>
      {
        'Accept': 'application/json', 'user-key': _apiKey};

  */
}
