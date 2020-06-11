// bloc 's
import 'package:flutter/cupertino.dart';
import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';
import 'package:foodgallery/src/BLoC/identity_bloc.dart';

// models
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';



// external pkg's
import 'package:logger/logger.dart';



class AppBloc {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  FoodGalleryBloc foodGalleryBlockObject;
  FoodItemDetailsBloc foodItemDetailsBlockObject;
  IdentityBloc identityBlocObject;

  FoodItemWithDocID emptyFoodItemWithDocID =new FoodItemWithDocID();
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
      /*final List<NewIngredient> allIngredients,*/{int fromWhichPage =1}) {

    logger.e('fromWhichPage: $fromWhichPage');


    foodGalleryBlockObject = FoodGalleryBloc();
    identityBlocObject = IdentityBloc();
    foodItemDetailsBlockObject = (fromWhichPage==0)?

    FoodItemDetailsBloc(emptyFoodItemWithDocID,[] ,fromWhichPage:0):(fromWhichPage==-1)?
    FoodItemDetailsBloc(emptyFoodItemWithDocID,[] ,fromWhichPage:0):
    FoodItemDetailsBloc(oneFoodItemWithDocID,/*allIngredients , TO DO -->INTENTION IS CHANGE THIS VALUE BY
    MAKING A SETTER CALL TO FoodItemDetailsBloc FROM OTHER PAGE.
     like from FoodGallery page set the foodItemd details List<NewIngredients> object=set value*/[],
        fromWhichPage:1);


//    foodGalleryBlockObject.counter$.listen(foodItemDetailsBlockObject.increment.add);
  }

//  final bloc = BlocProvider.of<FoodGalleryBloc>(context);
//  final bloc = BlocProvider.of(context).getFoodGalleryBlockObject;


  FoodGalleryBloc get getFoodGalleryBlockObject => foodGalleryBlockObject;
  FoodItemDetailsBloc get getFoodItemDetailsBlockObject => foodItemDetailsBlockObject;
  IdentityBloc get getIdentityBlocsObject => identityBlocObject;
}