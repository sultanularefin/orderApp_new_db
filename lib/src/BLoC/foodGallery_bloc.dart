
    // BLOC
//    import 'package:foodgallery/src/Bloc/
import 'package:foodgallery/src/BLoC/bloc.dart';


    //MODELS
    import 'package:foodgallery/src/DataLayer/itemData.dart';
//    import 'package:foodgallery/src/DataLayer/FoodItem.dart';
    import 'package:foodgallery/src/DataLayer/FoodItemWithDocID.dart';
    import 'package:foodgallery/src/DataLayer/CategoryItemsLIst.dart';
    import 'package:foodgallery/src/DataLayer/newCategory.dart';
//import 'package:zomatoblock/DataLayer/location.dart';



import 'dart:async';

//class LocationBloc implements Bloc {
  class FoodGalleryBloc implements Bloc {
  // id ,type ,title <= Location.

    List<FoodItemWithDocID> _allFoodsList = [];

    List<NewCategoryItem>_allCategoryList=[];


  //  getter for the above may be

    List<FoodItemWithDocID> get allFoodItems => _allFoodsList;

  //  The => expr syntax is a shorthand for { return expr; }.
  //  The => notation is sometimes referred to as arrow syntax.

//    BLoC/restaurant_bloc.dart:12:  final _controller = StreamController<List<Restaurant>>();
  // 1
  final _foodItemController = StreamController<List<FoodItemWithDocID>>();

  // 2

  // getter that get's the stream with _locationController.stream;

  // CALLED LIKE THIS: stream: BlocProvider.of<LocationBloc>(context).locationStream,


//    Stream<List<Restaurant>> get stream => _controller.stream;


  Stream<List<FoodItemWithDocID>> get foodItemsStream => _foodItemController.stream;



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


  // 4
  @override
  void dispose() {
    _foodItemController.close();
  }
}