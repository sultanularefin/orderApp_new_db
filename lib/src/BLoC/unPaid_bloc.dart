

import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';


import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
import 'package:foodgallery/src/DataLayer/models/OrderedItem.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';

import 'package:logger/logger.dart';


import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';


import 'dart:async';
import 'package:intl/intl.dart';



class UnPaidBloc implements Bloc {

  var logger = Logger(
    printer: PrettyPrinter(),
  );



//  bool  _isDisposedIngredients = false;
  bool    _isDisposedOrderListItems = false;

//  List<FoodItemWithDocID> _allFoodsList=[];
//
//  List<NewCategoryItem> _allCategoryList=[];



//  List<OneOrderFirebase> tempAllOrderedItems= new List<OneOrderFirebase>();


  // cheese items
//  List<CheeseItem> _allCheeseItemsFoodGalleryBloc =[];
//  List<CheeseItem> get getAllCheeseItemsFoodGallery => _allCheeseItemsFoodGalleryBloc;
//  final _cheeseItemsControllerFoodGallery      =  StreamController <List<CheeseItem>>();
//  Stream<List<CheeseItem>> get getCheeseItemsStream => _cheeseItemsControllerFoodGallery.stream;


  // OneOrderFirebase items
  List<OneOrderFirebase> _allOneOrderFirebaseHistoryBloc =[];
  List<OneOrderFirebase> get getAllFirebaseUnPaidOrderList => _allOneOrderFirebaseHistoryBloc;
  final _firebaseOrderListController      =  StreamController <List<OneOrderFirebase>>();
  Stream<List<OneOrderFirebase>> get getFirebaseUnPaidOrderListStream => _firebaseOrderListController.stream;

  final _client = FirebaseClient();



  //Helper method in history page...
  CustomerInformation localCustomerInformationObject(Map<String,dynamic> customerAddress){


    CustomerInformation oneCustomer = new CustomerInformation(
      address: customerAddress['state'],
      flatOrHouseNumber: customerAddress['apartNo'],
      phoneNumber:customerAddress['phone'],
//      etaTimeInMinutes: , ETA IS orderProductionTime
    );

    return oneCustomer;

  }



  List<NewIngredient> convertFireStoreIngredientItemsToLocalNewIngredientItemsList(List<dynamic>
  fireStoreNewIngredients){

    print('at convertFireStoreIngredientItemsToLocalNewIngredientItemsList');

    // List<Map<String, dynamic>>

//    print('--   ::      :: at here: convertFireStoreSauceItemsToLocalSauceItemsList -------- : : ');

    List<NewIngredient> allIngredientItems = new List<NewIngredient>();

    int ingredientCount =0;
    fireStoreNewIngredients.forEach((oneFireStoreSauce) {

      var oneNewIngredient = oneFireStoreSauce;


      NewIngredient oneTempNewIngredient = new NewIngredient(
        ingredientName: oneFireStoreSauce['name'] ,
        imageURL: oneFireStoreSauce['image'] ,
        ingredientAmountByUser: oneFireStoreSauce['ingredientAmountByUser'] ,
        isDefault:oneFireStoreSauce['isDefault'],
        price:oneFireStoreSauce['ingredientPrice'],
//          isDefault: oneFireStoreSauce['isDefault'],

      );

      print('--   ::      :: at here: convertFireStoreIngredientItemsToLocalNewIngredientItemsList -------- : :'
          ' for ingredient: ${oneTempNewIngredient.ingredientName} ');

      print('name: ${oneTempNewIngredient.ingredientName} '
          'imageURL: ${oneTempNewIngredient.imageURL} price: ${oneTempNewIngredient.price},'
          ' ingredientAmountByUser: ${oneTempNewIngredient.ingredientAmountByUser}... isDefault: ${oneTempNewIngredient.isDefault}');


      allIngredientItems.add(oneTempNewIngredient);

      ingredientCount = ingredientCount +1;

    });

    logger.i('total Ingredient count: $ingredientCount');

    return allIngredientItems;
//    return sf.length
  }

//  convertFireStoreCheeseItemsToLocalCheeseItemsList(oneFoodItem['selectedCheeses']),

  List<CheeseItem> convertFireStoreCheeseItemsToLocalCheeseItemsList(List<dynamic> fireStoreCheeseItems){


    // List<Map<String, dynamic>>

    print('--   ::      :: at here: convertFireStoreCheeseItemsToLocalCheeseItemsList -------- : : ');

    List<CheeseItem> allCheeseItems = new List<CheeseItem>();

    int cheeseItemCount= 0;
    fireStoreCheeseItems.forEach((oneFireStoreCheese) {

      var oneCheeseItem = oneFireStoreCheese;


      CheeseItem oneTempCheeseItem = new CheeseItem(
        cheeseItemName: oneCheeseItem['name'] ,
        imageURL: oneCheeseItem['image'] ,
        cheeseItemAmountByUser: oneCheeseItem['cheeseItemAmountByUser'] ,
        price: oneCheeseItem['cheeseItemPrice'] ,
        isDefaultSelected:  oneCheeseItem['isDefaultSelected'],

      );

      print('--   ::      :: at here: convertFireStoreCheeseItemsToLocalCheeseItemsList -------- : :'
          ' for cheeseItem: ${oneTempCheeseItem.cheeseItemName} ');

      print('CheeseItem_name: ${oneTempCheeseItem.cheeseItemName} '
          'imageURL: ${oneTempCheeseItem.imageURL} price: ${oneTempCheeseItem.price},'
          ' cheeseItemAmountByUser: ${oneTempCheeseItem.cheeseItemAmountByUser} isDefaultSelected: '
          '${oneTempCheeseItem.isDefaultSelected}');


      allCheeseItems.add(oneTempCheeseItem);

      cheeseItemCount = cheeseItemCount +1;

    });

    logger.i('cheeseItemCount: $cheeseItemCount');
    return allCheeseItems;
//    return sf.length
  }

  List<SauceItem> convertFireStoreSauceItemsToLocalSauceItemsList(List<dynamic> fireStoreSauces){
    // List<Map<String, dynamic>>

    print('at convertFireStoreSauceItemsToLocalSauceItemsList');

    List<SauceItem> allSauceItems = new List<SauceItem>();

    int sauceCount= 0;
    fireStoreSauces.forEach((oneFireStoreSauce) {

      var oneSauceItem = oneFireStoreSauce;


      SauceItem oneTempSauceItem = new SauceItem(
        sauceItemName: oneSauceItem['name'] ,
        imageURL: oneSauceItem['image'] ,
        sauceItemAmountByUser: oneSauceItem['sauceItemAmountByUser'] ,
        price: oneSauceItem['sauceItemPrice'],
        isDefaultSelected: oneSauceItem['isDefaultSelected'],

      );

      print('--   ::      :: at here: convertFireStoreSauceItemsToLocalSauceItemsList -------- : : for sauce: ${oneSauceItem['name']} ');

      print('sauceItemName: ${oneTempSauceItem.sauceItemName} '
          'imageURL: ${oneTempSauceItem.imageURL} price: ${oneTempSauceItem.price},'
          ' sauceItemAmountByUser: ${oneTempSauceItem.sauceItemAmountByUser} VV isDefaultSelected: '
          '${oneTempSauceItem.isDefaultSelected}');


      allSauceItems.add(oneTempSauceItem);

      sauceCount= sauceCount+ 1;
    });

    logger.i('sauceCount: $sauceCount');

    return allSauceItems;
//    return sf.length

  }



  void getAllUnPaidOrderListItemsConstructor() async {

    print('at getAllFoodItemsConstructor()');

//    _isDisposedFoodItems = true;
    if( _isDisposedOrderListItems == true) {
      return;
    }
    else {

//      var snapshot = await _client.fetchFoodItems();

      var snapshot = await _client.fetchUnPaidOrderListItems();
      List docList = snapshot.documents;

      List<OneOrderFirebase> tempAllOrderedItems= new List<OneOrderFirebase>();
      docList.forEach((doc) {


//    List <Map<String, dynamic>>
        Map<String,dynamic>       customerAddress = doc['address'];
//    List <Map<dynamic, dynamic>> orderedItems = snapshot['items'];
        List<dynamic> orderedItems = doc['items'];
//    List<Map<String, dynamic>>
        String                    orderBy =     doc['orderby'];
        String                    paidStatus =  doc['paidStatus'];
        String                    paidType =    doc['paidType'];
        double                    totalPrice =  doc['price'];

        String                    contact =     doc['contact'];
        String                    driverName =  doc['driver'];
        DateTime                  endDate =     doc['end'].toDate();
        DateTime                  startDate =   doc['start'].toDate();

        String                    orderStatus = doc['status'];
        String                    tableNo =     doc['tableNo'];
        String                    orderType =   doc['orderType'];
        final String documentID = doc.documentID;
//        String                    documentId = orderDocumentId;
        int                    orderProductionTime =    doc['orderProductionTime'];
        double                 deliveryCost2 =          doc['deliveryCost?'];
        double                 tax =                    doc['tax'];
        double                 priceWithDelivery2 =     doc['priceWithDelivery?'];


        CustomerInformation currentCustomerFromFireStore = localCustomerInformationObject(customerAddress);
//    new CustomerInformation
        print('currentCustomerFromFireStore.address: ${currentCustomerFromFireStore.address}');
        print('currentCustomerFromFireStore.flatOrHouseNumber: ${currentCustomerFromFireStore.flatOrHouseNumber}');
        print('currentCustomerFromFireStore.phoneNumber: ${currentCustomerFromFireStore.phoneNumber}');
//    print('currentCustomerFromFireStore.etaTimeInMinutes: ${currentCustomerFromFireStore.etaTimeInMinutes}');



        print('orderedItems: $orderedItems');
        print('orderBy: $orderBy');
        print('paidStatus: $paidStatus');
        print('paidType: $paidType');
        print('totalPrice: $totalPrice');
        print('contact: $contact');
        print('driverName: $driverName');

        print('snapshot[\'end\'].toDate().toString(): ${doc['end'].toDate().toString()}');

//    DateTime d = t.toDate();
//    print(d.toString()); //2019-12-28 18:48:48.364
        print('snapshot[\'start\'].toDate().toString()${doc['start'].toDate().toString()}');


        print('snapshot[\'end\']: ${doc['end'].toDate()}');

        print('snapshot[\'start\']${doc['start'].toDate()}');


        print('endDate: $endDate');
        print('startDate: $startDate');

//    final now = DateTime.now();
        final formatter1 = /*DateFormat('MM/dd/yyyy H:m'); */ DateFormat.yMMMMd('en_US');
        final String timestamp = formatter1.format(startDate);

        final formatter2 = /*DateFormat('MM/dd/yyyy H:m'); */ DateFormat.yMMMMd('en_US').add_Hm();
        final String timestamp2 = formatter1.format(startDate);

        print('timestamp: $timestamp');
        print('timestamp2: $timestamp2');

        final formatter3 =  DateFormat.jm();
        final formatter4 =  DateFormat.Hm();

        final String formattedOrderPlacementDatesTimeOnly = formatter2.format(startDate);

        final String formattedOrderPlacementDatesTimeOnly2 = formatter4.format(startDate);

        print('formattedOrderPlacementDatesTimeOnly2: $formattedOrderPlacementDatesTimeOnly2');
        print('formattedOrderPlacementDatesTimeOnly: $formattedOrderPlacementDatesTimeOnly');

        print('orderProductionTime: $orderProductionTime');

        //    ticket.text(timestamp,
        //        styles: PosStyles(align: PosAlign.center), linesAfter: 2);

        //    new DateFormat.yMMMMd('en_US')
        //    new DateFormat.jm()
        //    new DateFormat.yMd().add_jm()

        //    -> July 10, 1996
        //    -> 5:08 PM
        //    -> 7/10/1996 5:08 PM



        print('orderStatus: $orderStatus'); // "ready"
        print('tableNo: $tableNo');
        print('orderType: $orderType');
        print('documentId: $documentID');

        List<OrderedItem> allOrderedItems= new List<OrderedItem>();
        orderedItems.forEach((oneFood) {

          var oneFoodItem = oneFood;
          print('oneFoodItem[\'quantity\'] ${oneFoodItem['quantity']}!');
          print('oneFoodItem[\'name\'] ${oneFoodItem['name']}!');
          print('oneFoodItem[\'oneFoodTypeTotalPrice\'] ${oneFoodItem['oneFoodTypeTotalPrice']}!');
//      print('oneFoodItem.category: ${oneFoodItem.category}');
          print('oneFoodItem[\'category\']: ${oneFoodItem['category']}');


          print('unitPrice: ${oneFoodItem['unitPrice']}');
          print('unitPrice: ${oneFoodItem['foodImage']}');
          print('unitPrice: ${oneFoodItem['discount']}');
          print('unitPriceWithoutCheeseIngredientSauces: ${oneFoodItem['unitPriceWithoutCheeseIngredientSauces']}');
//      print('unitPrice');
          print('foodItemSize: ${oneFoodItem['foodItemSize']}');

          List<SauceItem>     defaultSauces = convertFireStoreSauceItemsToLocalSauceItemsList(oneFoodItem['selectedSauces']);
          List<NewIngredient> selectedIngredients = convertFireStoreIngredientItemsToLocalNewIngredientItemsList(oneFoodItem['ingredients']);
          List<CheeseItem>    selectedCheeses = convertFireStoreCheeseItemsToLocalCheeseItemsList(oneFoodItem['selectedCheeses']);


          print('defaultSauces : $defaultSauces ');
          print('selectedIngredients : $selectedIngredients ');
          print('selectedCheeses : $selectedCheeses ');

          OrderedItem oneTempOrderedItem= new OrderedItem(
            category:  oneFoodItem['category'],

            selectedSauces:  defaultSauces,
            selectedIngredients: selectedIngredients,
            selectedCheeses: selectedCheeses,

            discount:  oneFoodItem['discount'],
            foodItemImage:  oneFoodItem['foodImage'],

            quantity:  oneFoodItem['quantity'],
            name:oneFoodItem['name'],
            oneFoodTypeTotalPrice:oneFoodItem['oneFoodTypeTotalPrice'],
            unitPrice:oneFoodItem['unitPrice'],
            unitPriceWithoutCheeseIngredientSauces: oneFoodItem['unitPriceWithoutCheeseIngredientSauces'],
            foodItemSize: oneFoodItem['foodItemSize'],
          );



//        print('oneFoodItem[\'quantity\'] ${oneFoodItem['quantity']}!');
//        print('oneFoodItem[\'name\'] ${oneFoodItem['name']}!');
//        print('oneFoodItem[\'oneFoodTypeTotalPrice\'] ${oneFoodItem['oneFoodTypeTotalPrice']}!');


          allOrderedItems.add(oneTempOrderedItem);


        });



        /*
    orderedItems55.forEach((oneFood) {
      /* Map<String, dynamic> */ var userX2 = oneFood;

      print('oneFood[\'category\'] ${oneFood['category']}!!');
    });
    */




        OneOrderFirebase oneOrderForReceiptProduction = new OneOrderFirebase(
          oneCustomer:currentCustomerFromFireStore,
//      orderedItems:[],
          orderedItems:allOrderedItems,
          orderBy:orderBy,
          paidStatus:paidStatus,
          paidType:paidType,
          totalPrice:totalPrice,
          contact:contact,
          driverName:driverName,
          endDate:endDate,
          startDate:startDate,
          formattedOrderPlacementDate:timestamp,
          formattedOrderPlacementDatesTimeOnly:formattedOrderPlacementDatesTimeOnly2,
          orderStatus:orderStatus,
          tableNo:tableNo,
          orderType:orderType,
          orderProductionTime:orderProductionTime,
          deliveryCost: deliveryCost2,
          tax:          tax,
          priceWithDelivery: priceWithDelivery2,
          documentId:documentID,
        );

        tempAllOrderedItems.add(oneOrderForReceiptProduction);
      }
      );

      _allOneOrderFirebaseHistoryBloc = tempAllOrderedItems;

      _firebaseOrderListController.sink.add(_allOneOrderFirebaseHistoryBloc);
      _isDisposedOrderListItems = true;

    }
  }




  // CONSTRUCTOR BIGINS HERE..
  UnPaidBloc() {

    print('at FoodGalleryBloc()');


//    getAllIngredientsConstructor();
//
//    getAllExtraIngredientsConstructor();
//
    getAllUnPaidOrderListItemsConstructor();


    print('at FoodGalleryBloc()');


  }


  // 4
  @override
  void dispose() {

    _firebaseOrderListController.close();
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