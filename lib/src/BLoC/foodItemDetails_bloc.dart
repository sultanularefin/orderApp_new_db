
//import 'package:flutter/material.dart';
//import 'package:zomatoblock/BLoC/bloc_provider.dart';
//import 'package:zomatoblock/BLoC/location_bloc.dart';
//import 'package:zomatoblock/BLoC/location_query_bloc.dart';
//
import 'package:foodgallery/src/BLoC/bloc.dart';


//MODELS
import 'package:foodgallery/src/DataLayer/itemData.dart';
//    import 'package:foodgallery/src/DataLayer/FoodItem.dart';
import 'package:foodgallery/src/DataLayer/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/CategoryItemsLIst.dart';
import 'package:foodgallery/src/DataLayer/newCategory.dart';
//import 'package:zomatoblock/DataLayer/location.dart';


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


class FoodItemDetailsBloc implements Bloc {

  var _oneFoodItem ;


  FoodItemWithDocID get currentFoodItem => _oneFoodItem;


  // FOR location_bloc => final _locationController = StreamController<Location>();
  // [NORMAL STREAM, BELOW IS THE BROADCAST STREAM].

  // FOR location_bloc => Stream<Location> get locationStream => _locationController.stream;

  // getter that get's the stream with _locationController.stream;
  //  Stream<Location> get locationStream => _locationController.stream;

  // declartion and access.


  //  How it know's from the Restaurant array that this are favorite;

  // 1
  final _controller = StreamController <FoodItemWithDocID>();

  // INVOKER -> stream: bloc.favoritesStream,
  Stream<FoodItemWithDocID> get currentFoodItemsStream => _controller.stream;

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

  FoodItemDetailsBloc(FoodItemWithDocID oneFoodItem) {

    _oneFoodItem = oneFoodItem;
//    _allFoodsList.add(oneFoodItemWithDocID);

    _controller.sink.add(oneFoodItem);

//    getAllFoodItems();
//    getAllCategories();

//    this.getAllFoodItems();
//    this.getAllCategories();

  }

  @override
  void dispose() {
    _controller.close();
  }
}
