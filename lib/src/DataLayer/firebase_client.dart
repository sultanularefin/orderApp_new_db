/*
 * Copyright (c) 2019 Razeware LLC
 *
 */

import 'dart:async';
import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:zomatoblock/UI/restaurant_tile.dart';
//import './../Config/Secret.dart';


//import 'location.dart';
//import 'restaurant.dart';

import 'package:foodgallery/src/DataLayer/itemData.dart';
//    import 'package:foodgallery/src/DataLayer/FoodItem.dart';
import 'package:foodgallery/src/DataLayer/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/CategoryItemsLIst.dart';
import 'package:foodgallery/src/DataLayer/newCategory.dart';




final String storageBucketURLPredicate =
    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/';



class FirebaseClient {
//  final _apiKey = zomatoKey;
//  final _host = 'developers.zomato.com';
//  final _contextRoot = 'api/v2.1';

  List<FoodItemWithDocID> _allFoodsList = [];

  Future<List<FoodItemWithDocID>> fetchFoodItems(String query) async {

    Firestore.instance
        .collection("restaurants").document('USWc8IgrHKdjeDe9Ft4j').collection('foodItems')
        .snapshots()
        .listen((data) =>
        data.documents.forEach((doc) {
//      document['itemName'];

//          print('doc: ***************************** ${doc['uploadDate']
//              .toDate()}');
//      doc: ***************************** Instance of 'DocumentSnapshot'

//      final DocumentSnapshot document = snapshot.data.documents[index];


//      final DocumentSnapshot document = snapshot.data.documents[index];


          final String foodItemName = doc['name'];

//          final String foodImageURL  =document['image']==''?'':
//          storageBucketURLPredicate + Uri.encodeComponent(document['image'])


//          final String foodImageURL  = doc['image']==''?'':storageBucketURLPredicate +
//              Uri.encodeComponent(doc['image'])
//              +'?alt=media';


          final String foodImageURL  = doc['image']==''?
          'https://thumbs.dreamstime.com/z/smiling-orange-fruit-cartoon-mascot-character-holding-blank-sign-smiling-orange-fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
              :
          storageBucketURLPredicate + Uri.encodeComponent(doc['image'])
              +'?alt=media';


//          final String foodImageURL = doc['imageURL'];
//          final String euroPrice = double.parse(doc['priceinEuro'])
//              .toStringAsFixed(2);
//          final String foodItemIngredients = doc['ingredients'];


//          final String foodItemId = doc['itemId'];
//          final bool foodIsHot = doc['isHot'];

          final bool foodIsAvailable =  doc['available'];


//                final String foodCategoryName = document['categoryName'];

          final Map<String,dynamic> oneFoodSizePriceMap = doc['size'];

          final List<dynamic> foodItemIngredientsList =  doc['ingredient'];
//          logger.i('foodItemIngredientsList at getAllFoodDataFromFireStore: $foodItemIngredientsList');


          print('foodSizePrice __________________________${oneFoodSizePriceMap['normal']}');

          final String foodCategoryName = doc['category'];
          final String foodItemDocumentID = doc.documentID;


          FoodItemWithDocID oneFoodItemWithDocID = new FoodItemWithDocID(


            itemName: foodItemName,
            categoryName: foodCategoryName,
            imageURL: foodImageURL,
            sizedFoodPrices: oneFoodSizePriceMap,


//            priceinEuro: euroPrice,
            ingredients: foodItemIngredientsList,

//            itemId: foodItemId,
//            isHot: foodIsHot,
            isAvailable: foodIsAvailable,
            documentId: foodItemDocumentID,

          );

          _allFoodsList.add(oneFoodItemWithDocID);
        }
        ), onDone: () {
      print("Task Done zzzzz zzzzzz zzzzzzz zzzzzzz zzzzzz zzzzzzzz zzzzzzzzz zzzzzzz zzzzzzz");
    }, onError: (error, StackTrace stackTrace) {
      print("Some Error $stackTrace");
    });
    /*
    final results = await request(
        path: 'locations', parameters: {'query': query, 'count': '10'});

    final suggestions = results['location_suggestions'];
    return suggestions
        .map<FoodItemWithDocID>((json) => FoodItemWithDocID.fromJson(json))
        .toList(growable: false);

    */
    return _allFoodsList;
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
