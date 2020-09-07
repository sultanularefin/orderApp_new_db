//import 'package:cloud_firestore/cloud_firestore.dart';
//
class NewCategoryItem {

  String categoryName;
  int sequenceNo;
  String documentID;
  String fireStoreFieldName;
  bool isSelected; // for AdminIngredientUpload to firestore only....
//  String imageURL;
//  double rating;
//  double totalRating;
//  String ingredients;

  NewCategoryItem(
      {

        this.categoryName,
        this.sequenceNo,
        this.documentID,
        this.fireStoreFieldName,
        this.isSelected:false, // for AdminIngredientUpload to firestore only....
//        this.imageURL,
//        this.rating,
//        this.totalRating,
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