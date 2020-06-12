// bloc 's
import 'package:flutter/cupertino.dart';
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';
import 'package:foodgallery/src/BLoC/identity_bloc.dart';

// models
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';



// external pkg's
import 'package:logger/logger.dart';

//abstract class Bloc {
//  void dispose();
//}

class AppBloc implements Bloc {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  FoodGalleryBloc foodGalleryBlockObject;
  FoodItemDetailsBloc foodItemDetailsBlockObject;
//  IdentityBloc identityBlocObject;

//  FoodItemWithDocID emptyFoodItemWithDocID =new FoodItemWithDocID();
  List<NewIngredient> emptyIngs = [];



  /*
  Future<void> getAllIngredients(/*int pageFrom */) async {
//        final bloc = BlocProvider.of<FoodGalleryBloc>(context);
//    final bloc = BlocProvider2.of(context).getFoodGalleryBlockObject;
//    await foodGalleryBlockObject.getAllIngredients(
    await foodGalleryBlockObject.getAllIngredients();
    List<NewIngredient> emptyIngs = foodGalleryBlockObject.allIngredients;
  }
  */

//  FoodItemDetailsBloc(emptyFoodItemWithDocID,emptyIngs ,fromWhichPage:0),

  AppBloc(FoodItemWithDocID oneFoodItemWithDocID,
      /*final*/ List<NewIngredient> allIngredients  /*{int fromWhichPage =1}*/) {

//    logger.e('fromWhichPage: $fromWhichPage');


    foodGalleryBlockObject = FoodGalleryBloc();
//    identityBlocObject = IdentityBloc();
    foodItemDetailsBlockObject =

    FoodItemDetailsBloc(oneFoodItemWithDocID,allIngredients);

//    fromWhichPage:0


//    foodGalleryBlockObject.counter$.listen(foodItemDetailsBlockObject.increment.add);
  }

//  final bloc = BlocProvider.of<FoodGalleryBloc>(context);
//  final bloc = BlocProvider.of(context).getFoodGalleryBlockObject;


  FoodGalleryBloc get getFoodGalleryBlockObject => foodGalleryBlockObject;
  FoodItemDetailsBloc get getFoodItemDetailsBlockObject => foodItemDetailsBlockObject;
//  IdentityBloc get getIdentityBlocsObject => identityBlocObject;


  @override
  void dispose() {
//    _controller.close();
//    _orderControllerFoodDetails.close();
//    _itemSizeController.close();
//    _allIngredientListController.close();
//    _defaultIngredientListController.close();
//    _unSelectedIngredientListController.close();
//    _multiSelectForFoodController.close();


    foodGalleryBlockObject.dispose();
    foodItemDetailsBlockObject.dispose();

  }
}