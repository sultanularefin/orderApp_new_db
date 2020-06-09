import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';

class AppBloc {
  FoodGalleryBloc foodGalleryBlockObject;
  FoodItemDetailsBloc foodItemDetailsBlockObject;

  FoodItemWithDocID emptyFoodItemWithDocID =new FoodItemWithDocID();
  List<NewIngredient> emptyIngs = [];
//  FoodItemDetailsBloc(emptyFoodItemWithDocID,emptyIngs ,fromWhichPage:0),

  AppBloc() {
    foodGalleryBlockObject = FoodGalleryBloc();
    foodItemDetailsBlockObject = FoodItemDetailsBloc(emptyFoodItemWithDocID,emptyIngs ,fromWhichPage:0);
//    foodGalleryBlockObject.counter$.listen(foodItemDetailsBlockObject.increment.add);
  }

  FoodGalleryBloc get getFoodGalleryBlockObject => foodGalleryBlockObject;
  FoodItemDetailsBloc get getFoodItemDetailsBlockObject => foodItemDetailsBlockObject;
}
