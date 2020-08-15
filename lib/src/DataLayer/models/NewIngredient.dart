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

class NewIngredient {

  String ingredientName;
  String imageURL;
  double price;
  String documentId;
  int    ingredientAmountByUser;
  bool isDefault;
  List<dynamic> extraIngredientOf;
  int sequenceNo;
  String subgroup;

//  String ingredients;

  NewIngredient(
      {
        this.ingredientName,
        this.imageURL,
        this.price,
        this.documentId,
        this.ingredientAmountByUser,
        this.isDefault,
        this.extraIngredientOf,
        this.sequenceNo,
        this.subgroup,
      }
      );

//  WHAT ABOUT:

//  NewIngredient.fromMap(Map<String, dynamic> data)
//  NewIngredient.fromMap(Map<dynamic, dynamic> data)

  /*
  // INVOCATION CODE FOODDETAILBLOC LINE # 324.
  ingItems = snapshot.documents.map((documentSnapshot) =>
  NewIngredient.fromMap
  */

  NewIngredient.ingredientConvert(Map<String, dynamic> data,String docID)
      :imageURL= data['image'],
        ingredientName= data['name'],
        price = data['price'].toDouble(),
        documentId = docID,
        isDefault= false,
        ingredientAmountByUser = 1;
//        extraIngredientOf= data['extraIngredientOf'],
//        sequenceNo = data['sequenceNo'] ,
//        subgroup= data['subgroup'];


  NewIngredient.ingredientConvertExtra(Map<String, dynamic> data,String docID)
      :imageURL= data['image'],
        ingredientName= data['name'],
        price = data['price'].toDouble(),
        documentId = docID,
        isDefault= false,
        ingredientAmountByUser = 1,
        extraIngredientOf= data['extraIngredientOf'],
        sequenceNo = data['sequenceNo'] ,
        subgroup= data['subgroup'];


  NewIngredient.updateUnselectedIngredient(NewIngredient oneIngredient)
       :imageURL= oneIngredient.imageURL,
        ingredientName= oneIngredient.ingredientName,
        price = oneIngredient.price,
        documentId = oneIngredient.documentId,
        ingredientAmountByUser = 0,
        extraIngredientOf= oneIngredient.extraIngredientOf,
        sequenceNo = oneIngredient.sequenceNo,
        subgroup= oneIngredient.subgroup,
        isDefault= false;

  // PURPOSE SETTING ISDEFAULT TRUE INORDER TO CALCULATE PRICE UPON NEW INGREDIENT ADD
  /*
  NewIngredient.updateSelectedIngredient(NewIngredient oneIngredient)
      :imageURL= oneIngredient.imageURL,
        ingredientName= oneIngredient.ingredientName,
        price = oneIngredient.price,
        documentId = oneIngredient.documentId,
        ingredientAmountByUser = 0,
        isDefault= true;

  */






//        ingredientAmountByUser = 1;

//  final DocumentSnapshot document = snapshot.data.documents[index];
//
//  document.documentID
}
