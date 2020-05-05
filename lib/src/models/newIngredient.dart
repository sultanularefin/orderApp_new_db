//import 'package:cloud_firestore/cloud_firestore.dart';
//

//import 'package:foodgallery/src/models/IngredientItem.dart';

//CODE FORMAT ANDROID STUDIO CTRL +
//ALT + I
//IN WINDOWS


class NewIngredient {

  String ingredientName;
  String imageURL;
  double price;
  String documentId;

//  String ingredients;

  NewIngredient(
      {
        this.ingredientName,
        this.imageURL,
        this.price,
        this.documentId,
      }
     );
}
