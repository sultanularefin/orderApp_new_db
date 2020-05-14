

// BLOC
import 'package:foodgallery/src/BLoC/bloc.dart';

//  import 'package:flutter/material.dart';
//  import 'package:foodgallery/src/BLoC/bloc.dart';

// MODEL.

import 'package:foodgallery/src/DataLayer/FoodItemWithDocID.dart';

// DATA ACCESS CLASS.
import 'package:foodgallery/src/DataLayer/firebase_client.dart';


// DART PACKAGE.

import 'dart:async';



class FoodItemsQueryBloc implements Bloc {

  final _controller = StreamController<List<FoodItemWithDocID>>();
  final _client = FirebaseClient();

  // CALLED LIKE THIS: stream: bloc.locationStream,


//  Stream<List<FoodItemWithDocID>> get locationStream => _controller.stream;


  Stream<List<FoodItemWithDocID>> get foodItemsStream => _controller.stream;


  /*
  void fetchFoodItems0() async {


    print('at here 2 ***********   ||||||||||||||||||' );
    // 1
    final results = await _client.fetchFoodItems();


    // this method is called then Streams becomes populated with data.
    _controller.sink.add(results);


  }
  */

  /*

  void submitQuery(String query) async {


    // 1
    final results = await _client.fetchFoodItems(query);


    // this method is called then Streams becomes populated with data.
    _controller.sink.add(results);


  }
   */

  @override
  void dispose() {
    _controller.close();
  }


}