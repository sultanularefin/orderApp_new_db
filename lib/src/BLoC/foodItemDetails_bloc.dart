
//import 'package:flutter/material.dart';
//import 'package:zomatoblock/BLoC/bloc_provider.dart';
//import 'package:zomatoblock/BLoC/location_bloc.dart';
//import 'package:zomatoblock/BLoC/location_query_bloc.dart';
//
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:logger/logger.dart';

//MODELS
import 'package:foodgallery/src/DataLayer/itemData.dart';
//    import 'package:foodgallery/src/DataLayer/FoodItem.dart';

import 'package:foodgallery/src/DataLayer/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/CategoryItemsLIst.dart';
import 'package:foodgallery/src/DataLayer/newCategory.dart';
//import 'package:zomatoblock/DataLayer/location.dart';
import 'package:foodgallery/src/DataLayer/FoodItemWithDocIDViewModel.dart';

import 'package:foodgallery/src/DataLayer/firebase_client.dart';


import 'dart:async';


/*
#### keep track of their favorite restaurants
and show those in a separate list
*/

/*
```json
Favoriting Restaurants
So far, the BLoC pattern has been used to manage user input, but it can be used
 for so much more. Let’s say the user want to keep track of their favorite restaurants
and show those in a separate list. That too can be solved with the BLoC pattern.
```
*/


//Map<String, int> mapOneSize = new Map();

class FoodItemDetailsBloc implements Bloc {



  var logger = Logger(
    printer: PrettyPrinter(),
  );
  // can also use var _oneFoodItem = new FoodItemWithDocID() ;
//  FoodItemWithDocID _oneFoodItem = new FoodItemWithDocID() ;
  FoodItemWithDocIDViewModel _thisFoodItem ;
//  String _currentSize = 'normal';

  var _currentSize = new Map<String ,double>();

//  Map<String,Dynamic>

  FoodItemWithDocIDViewModel get currentFoodItem => _thisFoodItem;



  // FOR location_bloc => final _locationController = StreamController<Location>();
  // [NORMAL STREAM, BELOW IS THE BROADCAST STREAM].

  // FOR location_bloc => Stream<Location> get locationStream => _locationController.stream;

  // getter that get's the stream with _locationController.stream;
  //  Stream<Location> get locationStream => _locationController.stream;

  // declartion and access.


  //  How it know's from the Restaurant array that this are favorite;

  // 1
  final _controller = StreamController <FoodItemWithDocIDViewModel>();


  final _itemSizeController = StreamController<Map<String, double>>();

  // INVOKER -> stream: bloc.favoritesStream,

  Stream<FoodItemWithDocIDViewModel> get currentFoodItemsStream => _controller.stream;


  Stream<Map<String,double>> get CurrentItemSizePlusPrice => _itemSizeController.stream;


  /*
  void toggleRestaurant(Restaurant restaurant) {
    if (_restaurants.contains(restaurant)) {
      _restaurants.remove(restaurant);
    } else {
      _restaurants.add(restaurant);
    }

    _controller.sink.add(_restaurants);
  }

  */

  // constructor

  FoodItemDetailsBloc(FoodItemWithDocID oneFoodItem) {

//    _oneFoodItem = oneFoodItem;


    final Map<String,dynamic> foodSizePrice = oneFoodItem.sizedFoodPrices;


    dynamic normalPrice = foodSizePrice['normal'];

    if(normalPrice is double){print('price double at foodItemDetails bloc');}


    else if(normalPrice is num){print('price num at foodItemDetails bloc');}


    else if(normalPrice is int){print('price int at foodItemDetails bloc');}

    else
    {
      print('normalPrice is dynamic: ${normalPrice is dynamic}');
      print('price dynamic at foodItemDetails bloc');
    }


    double normalPriceCasted = tryCast<double>(normalPrice, fallback: 0.00);

    FoodItemWithDocIDViewModel thisFood =
    FoodItemWithDocIDViewModel.customCastFrom(oneFoodItem,'normal',normalPriceCasted);

//    FoodItemWithDocIDViewModel thisFood = new FoodItemWithDocIDViewModel(
//      itemName: oneFoodItem.itemName,
//      categoryName: oneFoodItem.categoryName,
//      sizedFoodPrices: oneFoodItem.sizedFoodPrices,
//      uploadDate: oneFoodItem.uploadDate,
//      imageURL: oneFoodItem.imageURL,
//      content: oneFoodItem.content,
//      ingredients: oneFoodItem.ingredients,
//      itemId: oneFoodItem.itemId,
//      indicatorValue: oneFoodItem.indicatorValue,
//      isAvailable: oneFoodItem.isAvailable,
//      isHot: oneFoodItem.isHot,
//      uploadedBy: oneFoodItem.uploadedBy,
//      documentId: oneFoodItem.documentId,
//      itemSize: 'normal',
//      itemPrice: normalPriceCasted,
//    );

    _thisFoodItem = thisFood; // important otherwise => The getter 'sizedFoodPrices' was called on null.

    _controller.sink.add(thisFood);
  }

  /*
    else {
      FoodItemWithDocIDViewModel thisFood = new FoodItemWithDocIDViewModel(
        itemName: oneFoodItem.itemName,
        categoryName: oneFoodItem.categoryName,
        sizedFoodPrices: oneFoodItem.sizedFoodPrices,
        uploadDate: oneFoodItem.uploadDate,
        imageURL: oneFoodItem.imageURL,
        content: oneFoodItem.content,
        ingredients: oneFoodItem.ingredients,
        itemId: oneFoodItem.itemId,
        indicatorValue: oneFoodItem.indicatorValue,
        isAvailable: oneFoodItem.isAvailable,
        isHot: oneFoodItem.isHot,
        uploadedBy: oneFoodItem.uploadedBy,
        documentId: oneFoodItem.documentId,
        itemSize: 'normal',
        itemPrice: normalPriceCasted,
      );

      _controller.sink.add(thisFood);
    }
    */



//    _currentSize['normal']=changedPrice;

//    _itemSizeController.sink.add(_currentSize);






  //    if normal is there

  //   String key = foodSizePrice.keys.where((oneKey) =='normal').toString();


  // other wise map will return ToDo check values






  /*
    logger.i('foodSizePrice: ',foodSizePrice);
            dynamic normalPrice = foodSizePrice['normal'];


            num normalPrice3 = foodSizePrice['normal'];




            print('normalPrice1: $normalPrice ');
            print('normalPrice2: ${foodSizePrice['normal']} ');
            print('normalPrice3: $normalPrice3');

            print('euroPrice1: $normalPrice ');
            double euroPrice1 = tryCast<double>(normalPrice, fallback: 0.00);
    */
//    if(oneFoodItem.si)
//      _currentSize['normal'] =normalPrice;


//      _itemSizeController.sink.add(_currentSize);

//    _allFoodsList.add(oneFoodItemWithDocID);




//    getAllFoodItems();
//    getAllCategories();

//    this.getAllFoodItems();
//    this.getAllCategories();




  double tryCast<num>(dynamic x, {num fallback }) {

    print(" at tryCast");
    print('x: $x');

    bool status = x is num;

    print('status : x is num $status');
    print('status : x is dynamic ${x is dynamic}');
    print('status : x is int ${x is int}');
    if(status) {
      return x.toDouble() ;
    }

    if(x is int) {return x.toDouble();}
    else if(x is double) {return x.toDouble();}

    else return 0.0;
  }

  void setNewSizePlusPrice(String sizeKey) {
    final Map<String,dynamic> foodSizePrice = _thisFoodItem.sizedFoodPrices;

    print("_thisFoodItem.sizedFoodPrices: ${_thisFoodItem.sizedFoodPrices}");

    logger.i('sizeKey: ',sizeKey);

    dynamic changedPrice1 = foodSizePrice[sizeKey];

    print('changedPrice1: $changedPrice1');

    double changedPriceDouble = tryCast<double>(changedPrice1, fallback: 0.00);


    FoodItemWithDocIDViewModel thisFoodpriceModified = _thisFoodItem;
    thisFoodpriceModified.itemSize = sizeKey;
    thisFoodpriceModified.itemPrice =  changedPriceDouble;


    print('changedPriceDouble: $changedPriceDouble');

    _thisFoodItem =thisFoodpriceModified;

    _controller.sink.add(thisFoodpriceModified);

//  _thisFoodItem.itemSize =sizeKey;
//  _thisFoodItem.itemPrice= changedPriceDouble;

//  _controller.sink.add(_thisFoodItem);

//  _currentSize[SizeKey]=changedPrice;

//  _itemSizeController.sink.add(_currentSize);

  }

  @override
  void dispose() {
    _controller.close();
    _itemSizeController.close();
  }
}
