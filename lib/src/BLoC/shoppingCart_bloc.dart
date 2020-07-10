

//### EXTERNAL PACKAGES
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart'; // to be removed later.


import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
import 'package:logger/logger.dart';
//import 'package:wifi/wifi.dart';
//import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';


//printing blue tooth or wifi in same local area network.

//import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';


//### LOCAL DATA RELATED RESOURCES
import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/Order.dart';
import 'package:foodgallery/src/DataLayer/models/OrderTypeSingleSelect.dart';
import 'package:foodgallery/src/DataLayer/models/PaymentTypeSingleSelect.dart';




//MODELS


class ShoppingCartBloc implements Bloc {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final _client = FirebaseClient();



//  PRINTING RELATED objects put here Beginning {.


  final FirebaseAuth _auth = FirebaseAuth.instance; // TO BE REMOVE LATER.

//  PRINTING RELATED objects put here } ends .
//  List<Order> _curretnOrder = [];

  Order _curretnOrder ;
  List<OrderTypeSingleSelect>   _orderType;
  List<PaymentTypeSingleSelect> _paymentType;
  List<SelectedFood> _expandedSelectedFood =[];
  List<SelectedFood> _savedSelectedFood    =[];


//  CustomerInformation _oneCustomerInfo;


//  List<Order> get getCurrentOrder => _curretnOrder;
  Order get getCurrentOrder => _curretnOrder;
  List<OrderTypeSingleSelect> get getCurrentOrderType => _orderType;
  List<PaymentTypeSingleSelect> get getCurrentPaymentType => _paymentType;
  List<SelectedFood> get getExpandedSelectedFood => _expandedSelectedFood;
  List<SelectedFood> get getSavedSelectedFood => _savedSelectedFood;
//  CustomerInformation get getCurrentCustomerInfo => _oneCustomerInfo;



  final _orderController = StreamController <Order>();
  final _expandedSelectedFoodController =  StreamController<List<SelectedFood>>();
  final _savedSelectedFoodController =  StreamController<List<SelectedFood>>();
  final _orderTypeController = StreamController <List<OrderTypeSingleSelect>>.broadcast();
  final _paymentTypeController = StreamController <List<PaymentTypeSingleSelect>>.broadcast();

//  final _orderTypeController = StreamController <List<OrderTypeSingleSelect>>.broadcast();
//  final _customerInformationController = StreamController <CustomerInformation>();
//  final _customerInformationController = StreamController <CustomerInformation>.broadcast();


  Stream<Order> get getCurrentOrderStream => _orderController.stream;

  Stream  <List<SelectedFood>> get getExpandedFoodsStream => _expandedSelectedFoodController.stream;

  Stream  <List<OrderTypeSingleSelect>> get getCurrentOrderTypeSingleSelectStream =>
      _orderTypeController.stream;

  Stream  <List<PaymentTypeSingleSelect>> get getCurrentPaymentTypeSingleSelectStream =>
      _paymentTypeController.stream;

  Stream  <List<SelectedFood>> get getSavedFoodsStream => _savedSelectedFoodController.stream;


  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devicesBlueTooth = [];

//  List<String> _devices =[];
  List<PrinterBluetooth> get getDevices => _devicesBlueTooth;
  final _devicesController = StreamController<List<PrinterBluetooth>>();
  Stream <List<PrinterBluetooth>> get getDevicesStream => _devicesController.stream;


//  List<String> _devices =[];
//  List<String> get getDevices => _devices;
//  final _devicesController = StreamController<List<String>>();
//  Stream <List<String>> get getDevicesStream => _devicesController.stream;

  /*
  Stream<CustomerInformation> get getCurrentCustomerInformationStream =>
      _customerInformationController.stream;
  */



  // CONSTRUCTOR BEGINS HERE.


  ShoppingCartBloc(
      /*FoodItemWithDocID oneFoodItem, List<NewIngredient> allIngsScoped */
      Order x
      ) {

    /*
    if(x.page==1){
      cancelButtonPressed();

    }
    else {
  */
//      logger.e('enterred into ShoppingCartBloc ');

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

//    print('food Item name in Shopping Cart BlocK ${x.foodItemName}');

    print('x.paymentTypeIndex: ${x.paymentTypeIndex}');
    int paymentTypeIndex = x.paymentTypeIndex;
    initiateOrderTypeSingleSelectOptions();

    initiatePaymentTypeSingleSelectOptions(paymentTypeIndex);


    List<SelectedFood> allOrderedFoods = x.selectedFoodInOrder;


    _savedSelectedFood = allOrderedFoods;
    _savedSelectedFoodController.sink.add(_savedSelectedFood);


    List<SelectedFood> selectedFoodforDisplay = new List<SelectedFood>();

//      List<SelectedFood> test = makeMoreFoodByQuantity(allOrderedFoods.first);


    allOrderedFoods.forEach((oneFood) {
      print('oneFood details: ===> ===> ');
      print('oneFood: ${oneFood.foodItemName}');
      logger.e('oneFood.quantity: ${oneFood.quantity}');
//         print('oneFood: ${oneFood.foodItemName}');
      List<SelectedFood> test = makeMoreFoodByQuantity(oneFood);

      print('MOMENT OF TRUTH: ');
      print(':::: ::: :: $test');
      selectedFoodforDisplay.addAll(test);
    });


//      selectedFoodforDisplay.addAll(test);

//      logger.i('|| || || || forDisplay: $selectedFoodforDisplay');
    print('item count : ${selectedFoodforDisplay.length}');

    print('\n\n AM I EXECUTED TWICE  ;;; \n\n ');

    _expandedSelectedFood = selectedFoodforDisplay;
    _expandedSelectedFoodController.sink.add(_expandedSelectedFood);


    discoverDevicesConstructor('9100');
    //    initiateCustomerInformation();

    _curretnOrder = x;
    _orderController.sink.add(x);
//    }

  }
// CONSTRUCTOR ENDS HERE.



  List<SelectedFood> makeMoreFoodByQuantity(SelectedFood X){

    int fillingLength = X.quantity;
    print('X X is $X');
    print('X.quantity is: ${X.quantity}');

    SelectedFood oneSelectedFood = X;
    oneSelectedFood.quantity = 1;
    print('oneSelectedFood.quantity is: ${oneSelectedFood.quantity}');
    print('oneSelectedFood.foodItemName is: ${oneSelectedFood.foodItemName}');

    List<SelectedFood> multiplied = List.filled(fillingLength, oneSelectedFood);

    print('\n \n AFTER ... FILLING');
    print('X.quantity is: $fillingLength');
    print('oneSelectedFood.quantity is: ${oneSelectedFood.quantity}');

    print('multiplied: $multiplied');

//    List<SelectedFood> multiplied2 = new List<SelectedFood>(X.quantity);
//    List.filled(int length, E fill, {bool growable = false});

    return multiplied;
  }
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

  void initiatePaymentTypeSingleSelectOptions(int selectedPayment){
    PaymentTypeSingleSelect Later = new PaymentTypeSingleSelect(
      borderColor: '0xff739DFA',
      index: 0,
      isSelected: false,
      paymentTypeName: 'Later',
      iconDataString: 'FontAwesomeIcons.facebook',

      paymentIconName: 'Later',
    );

    PaymentTypeSingleSelect Cash = new PaymentTypeSingleSelect(
      borderColor: '0xff95CB04',
      index: 1,
      isSelected: false,
      paymentTypeName: 'Cash',
      iconDataString: 'FontAwesomeIcons.twitter',

      paymentIconName: 'Cash',
    );


//     0xffFEE295 false
    PaymentTypeSingleSelect Card = new PaymentTypeSingleSelect(
      borderColor: '0xffFEE295',
      index: 2,
      isSelected: false,
      paymentTypeName: 'Card',
      iconDataString: 'FontAwesomeIcons.home',

      paymentIconName: 'Card',
    );

//
//    OrderTypeSingleSelect _dinningRoom = new OrderTypeSingleSelect(
//      borderColor: '0xffB47C00',
//      index: 3,
//      isSelected: false,
//      orderType: 'DinningRoom',
//      iconDataString: 'Icons.audiotrack',
//      orderIconName: 'fastfood',
//    );



    List <PaymentTypeSingleSelect> paymentTypeSingleSelectArray = new List<PaymentTypeSingleSelect>();


    paymentTypeSingleSelectArray.addAll([Later, Cash, Card  ]);

    paymentTypeSingleSelectArray[selectedPayment].isSelected =true;

    _paymentType = paymentTypeSingleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.


//    initiateAllMultiSelectOptions();

    _paymentTypeController.sink.add(_paymentType);
  }

  void setPaymentTypeSingleSelectOptionForOrder(PaymentTypeSingleSelect x, int newPaymentIndex,int oldPaymentIndex){

    print('new Payment Index is $newPaymentIndex');
    print('old Payment Index is $oldPaymentIndex');


    List <PaymentTypeSingleSelect> singleSelectArray = _paymentType;
//    _currentOrderTypeIndex

    /*
    logger.w('singleSelectArray[oldPaymentIndex].isSelected:'
        ' ${singleSelectArray[oldPaymentIndex].isSelected}');


    */

    singleSelectArray[oldPaymentIndex].isSelected =
    !singleSelectArray[oldPaymentIndex].isSelected;

    /*
    logger.w('singleSelectArray[oldPaymentIndex].isSelected:'

        ' ${singleSelectArray[oldPaymentIndex].isSelected}');

     */

    singleSelectArray [newPaymentIndex].isSelected =
    !singleSelectArray[newPaymentIndex].isSelected;

//    singleSelectArray[index].isSelected = true;

//    x.isSelected= !x.isSelected;


    Order currentOrderTemp = _curretnOrder;

    currentOrderTemp.paymentTypeIndex = newPaymentIndex;


    _paymentType = singleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.

    _curretnOrder = currentOrderTemp;

//    initiateAllMultiSelectOptions();

    _paymentTypeController.sink.add(_paymentType);
    _orderController.sink.add(_curretnOrder);
  }


  //PAYMENT FIRESTORE =>

  Future<Order> paymentButtonPressed(Order payMentProcessing) async{


    String orderBy =    _orderType[payMentProcessing.orderTypeIndex].orderType;
//    logger.i('payment Button Pressed is payMentProcessing.orderTypeIndex ${payMentProcessing.orderTypeIndex} ::'
//        ' orderBy: $orderBy    ${_curretnOrder.paymentTypeIndex}');




    String paidType0 =  _paymentType[payMentProcessing.paymentTypeIndex].paymentTypeName;

    // where should i put cancelButtonPressed();
//
    // payMentProcessing
    Order tempOrder= payMentProcessing;

    tempOrder.paymentButtonPressed=true;
//    List<SelectedFood> selectedFoodCheckForList = tempOrder.selectedFoodInOrder;

    List<SelectedFood> selectedFoodCheckForList = _expandedSelectedFood;
    int length =tempOrder.selectedFoodListLength;


//    logger.e('tempOrder.selectedFoodListLength ${tempOrder.selectedFoodListLength}');
//
//    logger.e('selectedFoodCheckForList: $selectedFoodCheckForList');

//    print('selectedFoodCheckForList[3].quantity => ${selectedFoodCheckForList[3].quantity}');

    Set<SelectedFood> selectedFoodCheckForListToSet= selectedFoodCheckForList.toSet();

    int lengthOfNotDuplicateFoods= selectedFoodCheckForListToSet.length;

//    unDuplicatedSelectedFoods
//

    selectedFoodCheckForListToSet.forEach((oneFood) {


      for(int i=0;i<selectedFoodCheckForList.length;i++){
        if(oneFood==selectedFoodCheckForList[i]){
          oneFood.quantity= oneFood.quantity +1;
        }
      }

//      print('oneFood details: ===> ===> ');
//      print('oneFood: ${oneFood.foodItemName}');
//      logger.i('oneFood.quantity: ${oneFood.quantity}');
//         print('oneFood: ${oneFood.foodItemName}');



    });

    selectedFoodCheckForListToSet.forEach((oneFood) {

      oneFood.quantity= oneFood.quantity-1; //initially 1 that was incremented in the previous forEach loop.
      print('oneFood.quantity SS: ${oneFood.quantity}');





    });



//    print('${selectedFoodCheckForListToSet.}')


    tempOrder.selectedFoodInOrder = selectedFoodCheckForListToSet.toList();





    String documentID = await _client.insertOrder(tempOrder,orderBy,paidType0);


    print('documentID: $documentID');

    if(documentID!=null){
      tempOrder.orderdocId= documentID;
      _curretnOrder=null;
      _expandedSelectedFood =[];
      _orderType =[];
      _paymentType =[];

      return tempOrder;

    }
    else{
      return tempOrder;
    }




//    _orderController;

//    this.paymentButtonPressed:false,
//    this.orderdocId:'',

    /*
    logger.e('Order received, Firestore id: $documentID');
    */

//    cancelButtonPressed();

//    _curretnOrder=null;
//    _expandedSelectedFood =[];
//    _orderType =[];
//    _paymentType =[];
//
//
//    _orderController.sink.add(_curretnOrder);
//    _expandedSelectedFoodController.sink.add(_expandedSelectedFood);
//    _orderTypeController.sink.add(_orderType);
//    _paymentTypeController.sink.add(_paymentType);

//    return documentID;

  }

  void clearSubscription(){


    _curretnOrder=null;
    _expandedSelectedFood =[];
    _orderType =[];
    _paymentType =[];

    _devicesBlueTooth = [];





    _orderController.sink.add(_curretnOrder);
    _expandedSelectedFoodController.sink.add(_expandedSelectedFood);
    _orderTypeController.sink.add(_orderType);
    _paymentTypeController.sink.add(_paymentType);

    _devicesController.sink.add(_devicesBlueTooth);


  }


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

    currentOrderTemp.orderTypeIndex=newIndex;


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


  /*
  Future<List<String>> discoverDevices2(String portNumber) async {
//    AuthResult result = await _auth.signInWithEmailAndPassword(email:
//    email, password: password);

    // print('result:  IIIII   >>>>>  $result'  );
    List<String> devices = [];

//    if (result.user.email != null) {
//      FirebaseUser fireBaseUserRemote = result.user;




    String ip;
    try {
      ip = await Wifi.ip;
      print('local ip:\t$ip');
    } catch (e) {

      print('ip error, please check internet');
      return devices;
    }

    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    int port = 9100;
    try {
      port = int.parse(portNumber);
    } catch (e) {
      print('port.toString()  please check $e');
    }
    print('subnet:\t$subnet, port:\t$port');


    final stream = NetworkAnalyzer.discover2(subnet, port);

    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');

        devices.add(addr.ip);


      }
    });

    _devices=devices;
    _devicesController.sink.add(_devices);

    return devices;

  }

  */

  void discoverDevicesConstructor(String portNumber) async {
//    AuthResult result = await _auth.signInWithEmailAndPassword(email:
//    email, password: password);

    // print('result:  IIIII   >>>>>  $result'  );
    List<String> devices = [];

//    if (result.user.email != null) {
//      FirebaseUser fireBaseUserRemote = result.user;



    printerManager.startScan(Duration(seconds: 9));
    printerManager.scanResults.listen((scannedDevices) {
//      setState(() {
//        _devices=scannedDevices;
//      });

      logger.w('scannedDevices: $scannedDevices');
      _devicesBlueTooth =scannedDevices;

//    bluetoo
    });

//    _devices=devices;
    _devicesController.sink.add(_devicesBlueTooth);

    /*
    String ip;
    try {
      ip = await Wifi.ip;
      print('local ip:\t$ip');
    } catch (e) {

      print('ip error, please check internet');
//      return devices;
    }


    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    int port = 9100;
    try {
      port = int.parse(portNumber);
    } catch (e) {
      print('port.toString()  please check $e');
    }

    print('subnet:\t$subnet, port:\t$port');


    final stream = NetworkAnalyzer.discover2(subnet, port);

    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');

        devices.add(addr.ip);


      }
    });

    */



//    return devices;

  }


  /*

  Future<List<String>> discoverDevices(String portNumber) async {

    List<String> devices = [];

    String ip;
    try {
      ip = await Wifi.ip;
      print('local ip:\t$ip');
    } catch (e) {

      print('ip error, please check internet');
      return devices;
    }

    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    int port = 9100;
    try {
      port = int.parse(portNumber);
    } catch (e) {
      print('port.toString()  please check $e');
    }
    print('subnet:\t$subnet, port:\t$port');


    final stream = NetworkAnalyzer.discover2(subnet, port);

    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');

          devices.add(addr.ip);


      }
    });

    return devices;

  }

  */



  @override
  void dispose() {
    _orderController.close();
    _expandedSelectedFoodController.close();
    _savedSelectedFoodController.close();
    _orderTypeController.close();
    _paymentTypeController.close();
    _devicesController.close();
//    _customerInformationController.close();
//    _multiSelectForFoodController.close();

  }
}