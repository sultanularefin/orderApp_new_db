/*
 * Copyright (c) 2019 Razeware LLC
 *
 */

import 'dart:async';
//import 'dart:convert' show json;

import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
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
///C:/Users/Taxi/Programs/foodgallery/lib/src/DataLayer/models/newCategory.dart'tegory.dart';




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


  Future<QuerySnapshot> fetchFoodItems() async {

   // print ('at here fetchFoodItems ==================================== *************** ');

    /*
    var snapshot= Firestore.instance
        .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j').collection('foodItems').limit(65)
        .getDocuments();
    */


    var snapshot= Firestore.instance
        .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j').collection('foodItems').orderBy('sl',descending: false)
        .getDocuments();

//    orderBy('_timeStampUTC', descending: true)
    return snapshot;

  }

  Future<QuerySnapshot> fetchAllSauces()async{

    // print ('at here fetchAllIngredients ==================================== *************** ');

    var snapshot = await Firestore.instance.collection("restaurants")
        .document('USWc8IgrHKdjeDe9Ft4j')
        .collection('sauces').orderBy("sl", descending: false)
        .getDocuments();

//    var snapshot= Firestore.instance
//        .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j').collection('foodItems')
//        .getDocuments();

    return snapshot;
  }

  Future<QuerySnapshot> fetchAllCheesesORjuusto()async{

    // print ('at here fetchAllIngredients ==================================== *************** ');

    var snapshot = await Firestore.instance.collection("restaurants")
        .document('USWc8IgrHKdjeDe9Ft4j')
        .collection('juusto').orderBy("sl", descending: false)
        .getDocuments();

//    var snapshot= Firestore.instance
//        .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j').collection('foodItems')
//        .getDocuments();

    return snapshot;
  }

  Future<QuerySnapshot> fetchAllIngredients()async{

   // print ('at here fetchAllIngredients ==================================== *************** ');

    var snapshot = await Firestore.instance.collection("restaurants")
        .document('USWc8IgrHKdjeDe9Ft4j')
        .collection('ingredients')
        .getDocuments();

//    var snapshot= Firestore.instance
//        .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j').collection('foodItems')
//        .getDocuments();

    return snapshot;
  }



  Future<DocumentSnapshot> fetchRestaurantDataClient() async{

    var snapshot = Firestore.instance
        .collection('restaurants')
        .document('USWc8IgrHKdjeDe9Ft4j')
        .get();
    /*
        .then((DocumentSnapshot ds) {
      // use ds as a snapshot
    });*/
    /*
    var snapshot = await Firestore.instance.collection("restaurants")
        .document('USWc8IgrHKdjeDe9Ft4j');

//    var snapshot= Firestore.instance
//        .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j').collection('foodItems')
//        .getDocuments();

    return snapshot;

     */
    return snapshot;
  }

  Future<DocumentSnapshot> invokeClientForOneOrder(String orderDocumentId) async{


    print('at firebase_client.dart file inside this method: \"invokeClientForOneOrder\"');

    var snapshot = Firestore.instance
        .collection('restaurants')
        .document('USWc8IgrHKdjeDe9Ft4j').collection('orderList').document(orderDocumentId)
        .get();

    print('and the snapshot is: $snapshot');

//
    return snapshot;
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

    //  print('si[counter].imageURL}: ${si[counter].imageURL}');
      var identifier = {

        'type': 0,
        'name': si[counter].ingredientName,
        'image': Uri.decodeComponent(si[counter].imageURL.replaceAll(
            'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/',
            '').replaceAll('?alt=media', '')),
//        ROzgCEcTA7J9FpIIQJra
        'ingredientAmountByUser': si[counter].ingredientAmountByUser,

      };
      testIngredients.add(identifier);
      counter ++;


    });
    return testIngredients;
//    return sf.length

  }

  List <Map<String, dynamic>> /*<OrderedFood>*/ convertedCheeseItems(List<CheeseItem> si){

//    ingredientName;
//    imageURL;
//    price;
//    documentId;
//    ingredientAmountByUser


    List<Map<String, dynamic>> testCheeseItems = new List<Map<String, dynamic>>();
    int counter=0;
    si.forEach((oneIngredient) {

      //  print('si[counter].imageURL}: ${si[counter].imageURL}');
      var identifier = {

        'type': 0,
        'name': si[counter].cheeseItemName,
        'image': Uri.decodeComponent(si[counter].imageURL.replaceAll(
            'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/',
            '').replaceAll('?alt=media', '')),
//        ROzgCEcTA7J9FpIIQJra
        'ingredientAmountByUser': si[counter].cheeseItemAmountByUser,

      };
      testCheeseItems.add(identifier);
      counter ++;


    });
    return testCheeseItems;
//    return sf.length

  }

  List <Map<String, dynamic>> /*<OrderedFood>*/ convertedSauceItems(List<SauceItem> si){

//    ingredientName;
//    imageURL;
//    price;
//    documentId;
//    ingredientAmountByUser


    List<Map<String, dynamic>> testIngredients = new List<Map<String, dynamic>>();
    int counter=0;
    si.forEach((oneIngredient) {

      //  print('si[counter].imageURL}: ${si[counter].imageURL}');
      var identifier = {

        'type': 0,
        'name': si[counter].sauceItemName,
        'image': Uri.decodeComponent(si[counter].imageURL.replaceAll(
            'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/',
            '').replaceAll('?alt=media', '')),
//        ROzgCEcTA7J9FpIIQJra
        'ingredientAmountByUser': si[counter].sauceItemAmountByUser,

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
        'image': Uri.decodeComponent(sf[counter].foodItemImageURL.replaceAll(
            'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/',
            '').replaceAll('?alt=media', '')),
//        ROzgCEcTA7J9FpIIQJra
        'quantity': sf[counter].quantity,
        'defult_sauces':convertedSauceItems(sf[counter].selectedSauceItems),
        'selected_cheeses':convertedCheeseItems(sf[counter].selectedCheeseItems),
        'ingredient':convertedIngredients(sf[counter].selectedIngredients),
        'name':sf[counter].foodItemName,
        'subTotal': sf[counter].quantity * sf[counter].unitPrice,
      };
      testFoodItems.add(identifier);
      counter ++;


    });
    return testFoodItems;
//    return sf.length

  }


  Future<String> insertOrder(Order currentOrderToFirebase, String orderBy, String paidType)async {
   // print('currentOrderToFirebaseL: $currentOrderToFirebase');
   /*print('currentOrderToFirebase.selectedFoodInOrder: '
        '${currentOrderToFirebase.selectedFoodInOrder}'); */

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
    document('USWc8IgrHKdjeDe9Ft4j').
    collection('orderList').add(<String, dynamic>{

      'address': {
        'apartNo': currentOrderToFirebase.ordersCustomer.flatOrHouseNumber,
        'geo': [0, 0],
        'state': currentOrderToFirebase.ordersCustomer.address,

      },
      'contact': currentOrderToFirebase.ordersCustomer.phoneNumber,
      'driver': 'mhmd',
      'end': FieldValue.serverTimestamp(),
//      'items': [],


      'items': convertedFoods(tempSelectedFood),
      'orderby': orderBy,
      'p_status': paidType != 'Later' ? 'Paid' : 'Unpaid',
      'p_type': paidType,
      'price': currentOrderToFirebase.totalPrice,
      'start': FieldValue.serverTimestamp(),
      'status': "ready",
      'table_no': '33',
      'type': orderBy == 'Phone' ? 'Phone' : orderBy == 'Delivery'
          ? 'Delivery'
          : orderBy == 'TakeAway' ? 'TakeAway' : 'DinningRoom',


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

  Future<QuerySnapshot> fetchCategoryItems() async {



    //print ('at here fetchCategories ==================================== *************** ');

    var snapshot= Firestore.instance
        .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j').
    collection('categories').orderBy("rating", descending: true)
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
