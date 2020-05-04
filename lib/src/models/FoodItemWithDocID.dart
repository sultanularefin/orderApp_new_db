//import 'package:cloud_firestore/cloud_firestore.dart';
//
class FoodItemWithDocID {

  String itemName;
  String categoryName;

  Map<String,dynamic> sizedFoodPrices;
  List<dynamic> ingredients;
//  String priceinEuro;

//  Timestamp uploadDate;
  DateTime uploadDate;
  String imageURL;

  String content;
  String itemId;
  double indicatorValue;
  bool isAvailable;
  bool isHot;
  String uploadedBy;
  String documentId;

  FoodItemWithDocID(
      {

        this.itemName,
        this.categoryName,
        this.sizedFoodPrices,
        this.uploadDate,
        this.imageURL,
        this.content,
        this.ingredients,
        this.itemId,
        this.indicatorValue,
        this.isAvailable,
        this.isHot,
        this.uploadedBy,
        this.documentId,
      }
      );
}




//class Dummy {
//  int id;
//  String title;
//  int price;
//  int counter;
//  String url;
//  String amountPerUnit;
//  String content;
//  String level;
//  double indicatorValue;
//
//  Dummy(
//      {this.id, this.title, this.price, this.counter, this.url, this.content, this.amountPerUnit, this.level, this.indicatorValue, });
//}