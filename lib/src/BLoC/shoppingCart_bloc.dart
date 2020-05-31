

//### EXTERNAL PACKAGES
import 'dart:async';
import 'package:logger/logger.dart';


//### LOCAL DATA RELATED RESOURCES
import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/Order.dart';
import 'package:foodgallery/src/DataLayer/models/OrderTypeSingleSelect.dart';



//MODELS


class ShoppingCartBloc implements Bloc {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final _client = FirebaseClient();


//  List<Order> _curretnOrder = [];

  Order _curretnOrder ;
  List<OrderTypeSingleSelect> _orderType;
//  CustomerInformation _oneCustomerInfo;


//  List<Order> get getCurrentOrder => _curretnOrder;
  Order get getCurrentOrder => _curretnOrder;
  List<OrderTypeSingleSelect> get getCurrentOrderType => _orderType;
//  CustomerInformation get getCurrentCustomerInfo => _oneCustomerInfo;



  final _orderController = StreamController <Order>();
  final _orderTypeController = StreamController <List<OrderTypeSingleSelect>>.broadcast();
//  final _orderTypeController = StreamController <List<OrderTypeSingleSelect>>.broadcast();
//  final _customerInformationController = StreamController <CustomerInformation>();
//  final _customerInformationController = StreamController <CustomerInformation>.broadcast();


  Stream<Order> get getCurrentOrderStream => _orderController.stream;

  Stream  <List<OrderTypeSingleSelect>> get getCurrentOrderTypeSingleSelectStream =>
      _orderTypeController.stream;

  /*
  Stream<CustomerInformation> get getCurrentCustomerInformationStream =>
      _customerInformationController.stream;
  */



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

    initiateOrderTypeSingleSelectOptions();

    //    initiateCustomerInformation();

    _curretnOrder=x;
    _orderController.sink.add(x);



  }
// CONSTRUCTOR ENDS HERE.


  /*

  void initiateCustomerInformation(){
    CustomerInformation customerInfoAtConstructor = new CustomerInformation(
      address:'',
      flatOrHouseNumber:'',
      phoneNumber:'',
      etaTimeInMinutes:-1,
//        CustomerInformation currentUser = _oneCustomerInfo;
//    currentUser.address = address;
//

    );
    _oneCustomerInfo = customerInfoAtConstructor;
    _customerInformationController.sink.add(_oneCustomerInfo);
  }
  */
  void initiateOrderTypeSingleSelectOptions()
  {

    OrderTypeSingleSelect _takeAway = new OrderTypeSingleSelect(
      borderColor: '0xff739DFA',
      index: 0,
      isSelected: true,
      orderType: 'TakeAway',
      iconDataString: 'FontAwesomeIcons.facebook',

      orderIconName: 'flight_takeoff',
    );

    OrderTypeSingleSelect _delivery = new OrderTypeSingleSelect(
      borderColor: '0xff95CB04',
      index: 1,
      isSelected: false,
      orderType: 'Delivery',
      iconDataString: 'FontAwesomeIcons.twitter',

      orderIconName: 'local_shipping',
    );


//     0xffFEE295 false
    OrderTypeSingleSelect _phone = new OrderTypeSingleSelect(
      borderColor: '0xffFEE295',
      index: 2,
      isSelected: false,
      orderType: 'Phone',
      iconDataString: 'FontAwesomeIcons.home',

      orderIconName: 'phone_in_talk',
    );


    OrderTypeSingleSelect _dinningRoom = new OrderTypeSingleSelect(
      borderColor: '0xffB47C00',
      index: 3,
      isSelected: false,
      orderType: 'DinningRoom',
      iconDataString: 'Icons.audiotrack',
      orderIconName: 'fastfood',
    );



    List <OrderTypeSingleSelect> orderTypeSingleSelectArray = new List<OrderTypeSingleSelect>();


    orderTypeSingleSelectArray.addAll([_takeAway,_delivery, _phone, _dinningRoom]);

    _orderType = orderTypeSingleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.


//    initiateAllMultiSelectOptions();

    _orderTypeController.sink.add(_orderType);

  }

  void setOrderTypeSingleSelectOptionForOrder(OrderTypeSingleSelect x, int newIndex,int oldIndex){

    print('newIndex is $newIndex');
    print('oldIndex is $oldIndex');


    List <OrderTypeSingleSelect> singleSelectArray = _orderType;
//    _currentOrderTypeIndex


    singleSelectArray[oldIndex].isSelected =
    !singleSelectArray[oldIndex].isSelected;

    singleSelectArray[newIndex].isSelected =
    !singleSelectArray[newIndex].isSelected;

//    singleSelectArray[index].isSelected = true;

//    x.isSelected= !x.isSelected;


    Order currentOrderTemp = _curretnOrder;

    currentOrderTemp.deliveryTypeIndex=newIndex;


    _orderType = singleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.

    _curretnOrder = currentOrderTemp;

//    initiateAllMultiSelectOptions();

    _orderTypeController.sink.add(_orderType);
    _orderController.sink.add(_curretnOrder);
  }

  setAddressForOrder(String address){

    Order tempOrderModifyCustomerInfo = _curretnOrder;

    tempOrderModifyCustomerInfo.ordersCustomer.address= address;

    _curretnOrder = tempOrderModifyCustomerInfo;

    _orderController.sink.add(_curretnOrder);

  }

  setHouseorFlatNumberForOrder(String houseOrFlatNumber){

    Order tempOrderModifyCustomerInfo = _curretnOrder;

    tempOrderModifyCustomerInfo.ordersCustomer.flatOrHouseNumber= houseOrFlatNumber;

    _curretnOrder = tempOrderModifyCustomerInfo;

    _orderController.sink.add(_curretnOrder);



//    CustomerInformation currentUser = _oneCustomerInfo;
//
//    currentUser.flatOrHouseNumber = houseOrFlatNumber;
//
//    _oneCustomerInfo = currentUser;
//    _customerInformationController.sink.add(_oneCustomerInfo);

  }

  setPhoneNumberForOrder(String phoneNumber){

    Order tempOrderModifyCustomerInfo = _curretnOrder;

    tempOrderModifyCustomerInfo.ordersCustomer.phoneNumber = phoneNumber;

    _curretnOrder = tempOrderModifyCustomerInfo;

    _orderController.sink.add(_curretnOrder);
//
//    CustomerInformation currentUser = _oneCustomerInfo;
//
//    currentUser.phoneNumber=phoneNumber;
//
//    _oneCustomerInfo = currentUser;
//    _customerInformationController.sink.add(_oneCustomerInfo);
  }

  // ETA = estimated time of arrival.
  setETAForOrder(String minutes){



    double minutes2 = double.parse(minutes);
    int minutes3 =minutes2.ceil();

    Order tempOrderModifyCustomerInfo = _curretnOrder;

    tempOrderModifyCustomerInfo.ordersCustomer.etaTimeInMinutes = minutes3;

    _curretnOrder = tempOrderModifyCustomerInfo;

    _orderController.sink.add(_curretnOrder);



//    CustomerInformation currentUser = _oneCustomerInfo;
//
//    currentUser.etaTimeInMinutes=minutes3;
//
//    _oneCustomerInfo = currentUser;
//    _customerInformationController.sink.add(_oneCustomerInfo);


  }

  @override
  void dispose() {
    _orderController.close();
    _orderTypeController.close();
//    _customerInformationController.close();
//    _multiSelectForFoodController.close();

  }
}