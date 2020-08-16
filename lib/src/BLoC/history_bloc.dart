

import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';


import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';

import 'package:foodgallery/src/DataLayer/models/NewCategoryItem.dart';


import 'package:logger/logger.dart';


import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';


import 'dart:async';



class HistoryBloc implements Bloc {

  var logger = Logger(
    printer: PrettyPrinter(),
  );



  bool  _isDisposedIngredients = false;
  bool    _isDisposedFoodItems = false;
  bool _isDisposedCategories = false;
  bool _isDisposedExtraIngredients = false;


  List<FoodItemWithDocID> _allFoodsList=[];

  List<NewCategoryItem> _allCategoryList=[];


  // cheese items
  List<CheeseItem> _allCheeseItemsFoodGalleryBloc =[];
  List<CheeseItem> get getAllCheeseItemsFoodGallery => _allCheeseItemsFoodGalleryBloc;
  final _cheeseItemsControllerFoodGallery      =  StreamController <List<CheeseItem>>();
  Stream<List<CheeseItem>> get getCheeseItemsStream => _cheeseItemsControllerFoodGallery.stream;

  // sauce items
  List<SauceItem> _allSauceItemsFoodGalleryBloc =[];
  List<SauceItem> get getAllSauceItemsFoodGallery => _allSauceItemsFoodGalleryBloc;
  final _sauceItemsControllerFoodGallery      =  StreamController <List<SauceItem>>();
  Stream<List<SauceItem>> get getSauceItemsStream => _sauceItemsControllerFoodGallery.stream;

  final _client = FirebaseClient();




  // CONSTRUCTOR BIGINS HERE..
  HistoryBloc() {

    print('at FoodGalleryBloc()');



//    getAllIngredientsConstructor();
//
//    getAllExtraIngredientsConstructor();
//
//    getAllFoodItemsConstructor();


    print('at FoodGalleryBloc()');


  }


  // 4
  @override
  void dispose() {
//    _foodItemController.close();
//    _categoriesController.close();
//    _allIngredientListController.close();
//
//    _cheeseItemsControllerFoodGallery.close();
//    _sauceItemsControllerFoodGallery.close();
//    _allExtraIngredientItemsController.close();


//    _isDisposedIngredients=
//    _isDisposedIngredients = true;
//    _isDisposedFoodItems = true;
//    _isDisposedCategories = true;
//    _isDisposedExtraIngredients = true;



//    _isDisposed = true;

//    _allIngredientListController.close();
  }
}