/*
 * Copyright (c) 2019 Razeware LLC
 *
 */

import 'dart:async';
import 'dart:convert' show json;

import 'package:foodgallery/src/DataLayer/models/Order.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:zomatoblock/UI/restaurant_tile.dart';
//import './../Config/Secret.dart';


//import 'location.dart';
//import 'restaurant.dart';

import 'package:foodgallery/src/DataLayer/itemData.dart';
//    import 'package:foodgallery/src/DataLayer/FoodItem.dart';
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
//import 'package:foodgallery/src/DataLayer/CategoryItemsLIst.dart';
//    ''file:
///C:/Users/Taxi/Programs/foodgallery/lib/src/DataLayer/models/newCategory.dart'tegory.dart';




final String storageBucketURLPredicate =
    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/';



class FirebaseClient {
//  final _apiKey = zomatoKey;
//  final _host = 'developers.zomato.com';
//  final _contextRoot = 'api/v2.1';

  List<FoodItemWithDocID> _allFoodsList = [];


  Future<QuerySnapshot> fetchFoodItems() async {

    print ('at here fetchFoodItems ==================================== *************** ');

    var snapshot= Firestore.instance
        .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j').collection('foodItems')
        .getDocuments();

    return snapshot;

  }

  Future<QuerySnapshot> fetchAllIngredients()async{

    print ('at here fetchAllIngredients ==================================== *************** ');

    var snapshot = await Firestore.instance.collection("restaurants")
        .document('USWc8IgrHKdjeDe9Ft4j')
        .collection('ingredients')
        .getDocuments();

//    var snapshot= Firestore.instance
//        .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j').collection('foodItems')
//        .getDocuments();

    return snapshot;
  }

  Future<String> insertOrder(Order currentOrderToFirebase,
      String orderBy, String paidType)async {
    print('currentOrderToFirebaseL: $currentOrderToFirebase');


    String orderDocId='';
    print('saving order data using a web service');

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
      'items': currentOrderToFirebase.selectedFoodInOrder,
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
      print('Added document with ID: ${document.documentID}');
      orderDocId= document.documentID;
//      return document;
//                            _handleSignIn();
    }).catchError((onError) {
      print('K   K    K   at onError for Order data push');
      orderDocId= '';
//      return '';
    });

    return orderDocId;


  }

  Future<QuerySnapshot> fetchCategoryItems() async {



    print ('at here fetchCategories ==================================== *************** ');

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
