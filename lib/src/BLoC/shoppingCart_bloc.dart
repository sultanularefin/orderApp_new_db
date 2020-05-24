

//### EXTERNAL PACKAGES
import 'dart:async';
import 'package:logger/logger.dart';


//### LOCAL DATA RELATED RESOURCES
import 'package:foodgallery/src/DataLayer/firebase_client.dart';
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/Order.dart';

//MODELS


class ShoppingCartBloc implements Bloc {



  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final _client = FirebaseClient();


//  List<Order> _curretnOrder = [];
  Order _curretnOrder ;


//  List<Order> get getCurrentOrder => _curretnOrder;
  Order get getCurrentOrder => _curretnOrder;

  final _orderController = StreamController <Order>();

  Stream<Order> get getCurrentOrderStream => _orderController.stream;




  // CONSTRUCTOR BEGINS HERE.


  ShoppingCartBloc(
      /*FoodItemWithDocID oneFoodItem, List<NewIngredient> allIngsScoped */

      Order x
      ) {

//    Order x = new Order(
//      foodItemName: foodItemDetailsbloc.currentFoodItem.itemName,
//      foodItemImageURL: foodItemDetailsbloc.currentFoodItem.imageURL,
//      unitPrice:initialPriceByQuantityANDSize ,
//      foodDocumentId: foodItemDetailsbloc.currentFoodItem.documentId,
//      quantity: _itemCount,
//      foodItemSize: _currentSize,
//      ingredients: foodItemDetailsbloc.getDefaultIngredients,
//    );


//    getAllIngredients();

//    List<NewIngredient> allIngsScoped= _allIngItems;
    print("at the begin of Constructor [ShoppingCartBloc]");

    print('food Item name in Shopping Cart BlocK ${x.foodItemName}');

    _curretnOrder=x;
    _orderController.sink.add(x);

  }
// CONSTRUCTOR ENDS HERE.




    @override
  void dispose() {
    _orderController.close();

  }
}