
// BLOC
//    import 'package:foodgallery/src/Bloc/
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/NewIngredient.dart';


//MODELS
import 'package:foodgallery/src/DataLayer/itemData.dart';
//    import 'package:foodgallery/src/DataLayer/FoodItem.dart';
import 'package:foodgallery/src/DataLayer/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/CategoryItemsLIst.dart';
import 'package:foodgallery/src/DataLayer/newCategory.dart';
//import 'package:zomatoblock/DataLayer/location.dart';




import 'package:foodgallery/src/DataLayer/firebase_client.dart';


import 'dart:async';


//Firestore should be in FirebaseClient file but for testing putted here:

import 'package:cloud_firestore/cloud_firestore.dart';
//class LocationBloc implements Bloc {
class FoodGalleryBloc implements Bloc {
  // id ,type ,title <= Location.

  List<FoodItemWithDocID> _allFoodsList=[];

  List<NewCategoryItem> _allCategoryList=[];

  List<NewIngredient> _allIngItems =[];




//    List<NewCategoryItem>_allCategoryList=[];
  final _client = FirebaseClient();

  //  getter for the above may be


  List<FoodItemWithDocID> get allFoodItems => _allFoodsList;
  List<NewCategoryItem> get allCategories => _allCategoryList;
  List<NewIngredient> get allIngredients => _allIngItems;


  //  The => expr syntax is a shorthand for { return expr; }.
  //  The => notation is sometimes referred to as arrow syntax.

//    BLoC/restaurant_bloc.dart:12:  final _controller = StreamController<List<Restaurant>>();
  // 1
  final _foodItemController = StreamController <List<FoodItemWithDocID>>();
  final _categoriesController = StreamController <List<NewCategoryItem>>();

  final _allIngredientListController = StreamController <List<NewIngredient>>();

//  final _controller = StreamController<List<Restaurant>>.broadcast();

  // 2

  // getter that get's the stream with _locationController.stream;

  // CALLED LIKE THIS: stream: BlocProvider.of<LocationBloc>(context).locationStream,

//    Stream<List<Restaurant>> get stream => _controller.stream;


  Stream<List<FoodItemWithDocID>> get foodItemsStream => _foodItemController.stream;

  Stream<List<NewCategoryItem>> get categoryItemsStream => _categoriesController.stream;

  Stream<List<NewIngredient>> get ingredientItemsStream => _allIngredientListController.stream;
  // 3
  // CALLED LIKE THIS:

  //  lib/UI/location_screen.dart:119:            locationBloc.selectLocation(location);
  //  lib/UI/location_screen.dart:131:            locationBloc.selectLocation(location);

  /*
  void selectLocation(Location location) {
    _location = location;
    _locationController.sink.add(location);
  }
  */


//  Future<List<FoodItemWithDocID>> getAllFoodItems() async {
  void getAllFoodItems() async {

    var snapshot = await _client.fetchFoodItems();
    List docList = snapshot.documents;

    docList.forEach((doc) {

      final String foodItemName = doc['name'];
//      print('foodItemName $foodItemName');


      final String foodImageURL  = doc['image']==''?
      'https://thumbs.dreamstime.com/z/smiling-orange-fruit-cartoon-mascot-character-holding-blank-sign-smiling-orange-fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
          :
      storageBucketURLPredicate + Uri.encodeComponent(doc['image'])
          +'?alt=media';


      final bool foodIsAvailable =  doc['available'];


      final Map<String,dynamic> oneFoodSizePriceMap = doc['size'];

      final List<dynamic> foodItemIngredientsList =  doc['ingredient'];
//          logger.i('foodItemIngredientsList at getAllFoodDataFromFireStore: $foodItemIngredientsList');


//          print('foodSizePrice __________________________${oneFoodSizePriceMap['normal']}');

      final String foodCategoryName = doc['category'];
      final String foodItemDocumentID = doc.documentID;


      FoodItemWithDocID oneFoodItemWithDocID = new FoodItemWithDocID(


        itemName: foodItemName,
        categoryName: foodCategoryName,
        imageURL: foodImageURL,
        sizedFoodPrices: oneFoodSizePriceMap,


        ingredients: foodItemIngredientsList,

        isAvailable: foodIsAvailable,
        documentId: foodItemDocumentID,

      );

      _allFoodsList.add(oneFoodItemWithDocID);
    }
    );

    _foodItemController.sink.add(_allFoodsList);


  }

  //  Future<List<NewCategoryItem>> getAllCategories() async {



  void getAllIngredients() async {


    var snapshot = await _client.fetchAllIngredients();
    List docList = snapshot.documents;



    List <NewIngredient> ingItems = new List<NewIngredient>();
    ingItems = snapshot.documents.map((documentSnapshot) =>
        NewIngredient.fromMap
          (documentSnapshot.data, documentSnapshot.documentID)

    ).toList();


    List<String> documents = snapshot.documents.map((documentSnapshot) =>
    documentSnapshot.documentID
    ).toList();

    print('Ingredient documents are at Line# 175 in FoodGalleryBlock: $documents');


    _allIngItems = ingItems;

    _allIngredientListController.sink.add(ingItems);


//    return ingItems;

  }


  void getAllCategories() async {


    var snapshot = await _client.fetchCategoryItems();
    List docList = snapshot.documents;


    docList.forEach((doc) {

      final String categoryItemName = doc['name'];

      final String categoryImageURL  = doc['image']==''?
      'https://thumbs.dreamstime.com/z/smiling-orange-fruit-cartoon-mascot-character-holding-blank-sign-smiling-orange-fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
          :
      storageBucketURLPredicate + Uri.encodeComponent(doc['image'])
          +'?alt=media';

      print('categoryImageURL: $categoryImageURL');

      final num categoryRating = doc['rating'];
      final num totalCategoryRating = doc['total_rating'];


      NewCategoryItem oneCategoryItem = new NewCategoryItem(


        categoryName: categoryItemName,
        imageURL: categoryImageURL,
        rating: categoryRating.toDouble(),
        totalRating: totalCategoryRating.toDouble(),

      );

      _allCategoryList.add(oneCategoryItem);
    }
    );

    NewCategoryItem all = new NewCategoryItem(
      categoryName: 'All',
      imageURL: 'None',
      rating: 0,
      totalRating: 5,

    );

    _allCategoryList.add(all);

    _categoriesController.sink.add(_allCategoryList);
    //    _foodItemController.sink.add(_allCategoryList);
    //    return _allFoodsList;

  }





    // CONSTRUCTOR BIGINS HERE..
    FoodGalleryBloc() {

    getAllFoodItems();
    getAllCategories();

    getAllIngredients();
    // invoking this here to make the transition in details page faster.

//    this.getAllFoodItems();
//    this.getAllCategories();

    }

  // CONSTRUCTOR ENDS HERE..




  // 4
  @override
  void dispose() {
    _foodItemController.close();
    _categoriesController.close();
    _allIngredientListController.close();
  }
}