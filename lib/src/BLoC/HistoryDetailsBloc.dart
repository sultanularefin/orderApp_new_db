


import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';

import 'package:foodgallery/src/DataLayer/models/FoodPropertyMultiSelect.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';


import 'package:logger/logger.dart';

//MODELS
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';

import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';


import 'dart:async';



//Map<String, int> mapOneSize = new Map();

class HistoryDetailsBloc /*with ChangeNotifier */ implements Bloc  {



  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final _client = FirebaseClient();



  // selected Sauce Items


  List<SauceItem> _allSelectedSauceItems =[];
  List<SauceItem> get getAllSelectedSauceItems => _allSelectedSauceItems;
  final _selectedSauceListController      =  StreamController <List<SauceItem>>.broadcast();
  Stream<List<SauceItem>> get getSelectedSauceItemsStream => _selectedSauceListController.stream;


  List<String> _allSubgroups =[];
  List<String> get getAllSubGroups => _allSubgroups;
  final _categoryWiseSubGroupsController      =  StreamController <List<String>>.broadcast();
  Stream <List<String>> get getCategoryWiseSubgroupsStream => _categoryWiseSubGroupsController.stream;



  void initiateSauces(List<SauceItem> sauceItems0, List<String>defaultSaucesString) async {

    print('sauceItems0: $sauceItems0 length: ${sauceItems0.length}');

//    print('defaultSauces: $defaultSaucesString length: ${defaultSaucesString.length}');




    sauceItems0.map((oneSauce) =>
    /*NewIngredient.updateSelectedIngredient */(
        oneSauce.isDefaultSelected = false
    )).toList();

    sauceItems0.map((oneSauce) =>
    /*NewIngredient.updateSelectedIngredient */(
        oneSauce.isSelected = false
    )).toList();

    List <SauceItem> sauceItems = sauceItems0;







//    return ingItems;

  }






  // CONSTRUCTOR BEGINS HERE.
  HistoryDetailsBloc(
      OneOrderFirebase oneFoodItem,
      ) {

//    oneFoodItem,
//    tempIngs,


//    FoodItemWithDocID



    logger.i('oneFoodItem.itemName: ${oneFoodItem.documentId}');








    initiateAllMultiSelectOptions();

//    _controller.sink.add(_thisFoodItem);
  }

  // CONSTRUCTOR ENDS HERE.

//  List<FoodPropertyMultiSelect> initiateAllMultiSelectOptions()
  void initiateAllMultiSelectOptions()
  {

    FoodPropertyMultiSelect _org = new FoodPropertyMultiSelect(
      borderColor: '0xff739DFA',
      index: 4,
      isSelected: false,
      itemName: 'ORG',
      itemImage:'assets/multiselectImages/multiSelectAssetORG.png',
      itemTextColor: '0xff739DFA',
    );

//    assets/multiselectImages/multiSelectAssetM.png
//    assets/multiselectImages/multiSelectAssetVSM.png
//    assets/multiselectImages/multiSelectAssetVS.png
//    assets/multiselectImages/multiSelectAssetORG.png

    FoodPropertyMultiSelect _vs = new FoodPropertyMultiSelect(
      borderColor: '0xff95CB04',
      index: 3,
      isSelected: false,
      itemName: 'VS',
      itemImage:'assets/multiselectImages/multiSelectAssetVS.png',
      itemTextColor: '0xff95CB04',
    );


//     0xffFEE295 false
    FoodPropertyMultiSelect _vsm = new FoodPropertyMultiSelect(
      borderColor: '0xff34720D',
      index: 2,
      isSelected: false,
      itemName: 'VSM',
      itemImage:'assets/multiselectImages/multiSelectAssetVSM.png',
      itemTextColor: '0xff34720D',
    );


    FoodPropertyMultiSelect _m = new FoodPropertyMultiSelect(
      borderColor: '0xffB47C00',
      index: 1,
      isSelected: false,
      itemName: 'M',
      itemImage:'assets/multiselectImages/multiSelectAssetM.png',
      itemTextColor: '0xffB47C00',
    );


    List <FoodPropertyMultiSelect> multiSelectArray = new List<FoodPropertyMultiSelect>();

    multiSelectArray.addAll([_org,_vs,_vsm,_m]);

//    _multiSelectForFood = multiSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.


//    initiateAllMultiSelectOptions();

//    _multiSelectForFoodController.sink.add(_multiSelectForFood);

  }








  // HELPER METHOD tryCast Number (1)
  double tryCast<num>(dynamic x, {num fallback }) {

    print(" at tryCast");
    print('x: $x');

    bool status = x is num;

//    print('status : x is num $status');
//    print('status : x is dynamic ${x is dynamic}');
//    print('status : x is int ${x is int}');
    if(status) {
      return x.toDouble() ;
    }

    if(x is int) {return x.toDouble();}
    else if(x is double) {return x.toDouble();}

    else return 0.0;
  }




  @override
  void dispose() {

//    _controller.close();
//    _selectedFoodControllerFoodDetails.close();
//    _allIngredientListController.close();
//    _defaultIngredientListController.close();
//    _unSelectedIngredientListController.close();
//    _multiSelectForFoodController.close();
//    _sauceItemsController.close();
//    _cheeseItemsController.close();
//
//    _selectedSauceListController.close();
//    _selectedCheeseListController.close();
//    _categoryWiseSubGroupsController.close();
  }
}


