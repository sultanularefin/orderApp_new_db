//import 'package:cloud_firestore/cloud_firestore.dart';
//

//import 'package:foodgallery/src/models/IngredientItem.dart';

//CODE FORMAT ANDROID STUDIO CTRL +
//ALT + I
//IN WINDOWS


//import 'package:flutter/material.dart';

import 'dart:core';

//final String storageBucketURLPredicate_Same =
//    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/';

class SauceItem {

  final String sauceItemName;
  final String imageURL;
  final double price;
  final String documentId;
  final int    sauceItemAmountByUser;

//  String ingredients;

  SauceItem(
      {
        this.sauceItemName,
        this.imageURL,
        this.price,
        this.documentId,
        this.sauceItemAmountByUser,
      }
      );



//  WHAT ABOUT:

//  NewIngredient.fromMap(Map<String, dynamic> data)
//  NewIngredient.fromMap(Map<dynamic, dynamic> data)
//  NewIngredient.fromMap(Map<String, dynamic> data,String docID)
//      :imageURL= data['image'],
//        ingredientName= data['name'],
//        price = data['price'].toDouble(),
//        documentId = docID,
//        ingredientAmountByUser = 1;
//

  SauceItem.fromMap(Map<String, dynamic> data,String docID)
      :imageURL= data['image'],
        sauceItemName = data['name'],
        price = data['price'].toDouble(),
        documentId = docID,
        sauceItemAmountByUser = 0;

//  NewIngredient.updateIngredient(NewIngredient oneIngredient)
//       :imageURL= oneIngredient.imageURL,
//        ingredientName= oneIngredient.ingredientName,
//        price = oneIngredient.price,
//        documentId = oneIngredient.documentId,
//        ingredientAmountByUser = 0;






//        ingredientAmountByUser = 1;

//  final DocumentSnapshot document = snapshot.data.documents[index];
//
//  document.documentID
}
