
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';


//MODELS
//import 'package:foodgallery/src/DataLayer/itemData.dart';
//    import 'package:foodgallery/src/DataLayer/FoodItem.dart';
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';
//import 'package:foodgallery/src/DataLayer/CategoryItemsLIst.dart';
import 'package:foodgallery/src/DataLayer/models/NewCategoryItem.dart';
//import 'package:zomatoblock/DataLayer/location.dart';

import 'package:logger/logger.dart';


import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';


import 'dart:async';


//Firestore should be in FirebaseClient file but for testing putted here:

// import 'package:cloud_firestore/cloud_firestore.dart';
//class LocationBloc implements Bloc {
class AdminFirebaseBloc implements Bloc {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  // id ,type ,title <= Location.

//  bool _isDisposed = false;

  bool  _isDisposedIngredients = false;

  bool    _isDisposedFoodItems = false;

  bool _isDisposedCategories = false;

  bool _isDisposedExtraIngredients = false;


  List<FoodItemWithDocID> _allFoodsList=[];

  List<NewCategoryItem> _allCategoryList=[];



  List<NewIngredient> _allIngItemsFGBloc =[];
  List<NewIngredient> get getAllIngredientsPublicFGB2 => _allIngItemsFGBloc;
  Stream<List<NewIngredient>> get ingredientItemsStream => _allIngredientListController.stream;
  final _allIngredientListController = StreamController <List<NewIngredient>> /*.broadcast*/();




  List<NewIngredient> _allExtraIngredients =[];

  List<NewIngredient> get getAllExtraIngredients => _allExtraIngredients;
  Stream<List<NewIngredient>> get getExtraIngredientItemsStream => _allExtraIngredientItemsController.stream;
  final _allExtraIngredientItemsController = StreamController <List<NewIngredient>> /*.broadcast*/();






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







//    List<NewCategoryItem>_allCategoryList=[];
  final _client = FirebaseClient();

  //  getter for the above may be


  List<FoodItemWithDocID> get allFoodItems => _allFoodsList;
  List<NewCategoryItem> get allCategories => _allCategoryList;



  //  The => expr syntax is a shorthand for { return expr; }.
  //  The => notation is sometimes referred to as arrow syntax.

//    BLoC/restaurant_bloc.dart:12:  final _controller = StreamController<List<Restaurant>>();
  // 1
  final _foodItemController = StreamController <List<FoodItemWithDocID>>();
  final _categoriesController = StreamController <List<NewCategoryItem>>();



//  final _controller = StreamController<List<Restaurant>>.broadcast();

  // 2




  Stream<List<FoodItemWithDocID>> get foodItemsStream => _foodItemController.stream;

  Stream<List<NewCategoryItem>> get categoryItemsStream => _categoriesController.stream;






// this code bloc cut paste from foodGallery Bloc:

  /*
  Future<void> getAllIngredientsConstructor() async {
    print('at getAllIngredientsConstructor()');

    if (_isDisposedIngredients == false) {
      var snapshot = await _client.fetchAllIngredients();
      List docList = snapshot.documents;


      List <NewIngredient> ingItems = new List<NewIngredient>();
      ingItems = snapshot.documents.map((documentSnapshot) =>
          NewIngredient.ingredientConvert
            (documentSnapshot.data, documentSnapshot.documentID)

      ).toList();


      List<String> documents = snapshot.documents.map((documentSnapshot) =>
      documentSnapshot.documentID
      ).toList();

      // print('documents are [Ingredient Documents] at food Gallery Block : ${documents.length}');


      _allIngItemsFGBloc = ingItems;

      _allIngredientListController.sink.add(_allIngItemsFGBloc);


//    return ingItems;

      _isDisposedIngredients=true;

    }
    else {
      return;
    }
  }


  */


  // HELPER METHOD FOR TEST TO BE MODIFIED....  AUGUST 14 2020.....
  bool checkThisExtraIngredientForSomeCategory(NewIngredient x) {

    List<String> categories =
    [
//      'jauheliha_kebab_vartaat' => done
//          'salaatti_kasvis',=> done
//      'pizza', => done
      'lasten_menu',
//      'kebab',=> done
      'juomat'
    ];

    logger.e('for lasten_menu');



    List<String> stringList = List<String>.from(x.extraIngredientOf);



    print('x.ingredientName ${x.ingredientName}  x.subgroup.: ${x.subgroup}');
//    print('---------------');
//    stringList.forEach((oneGroup) {
//      print('oneGroup: $oneGroup');
//    });
//
//
//    print('---------------');

    if(stringList.contains('kastike'.toLowerCase().trim())){

      print('contains /???');
      print('x.ingredientName: ${x.ingredientName}');
    };

//    print('ingredientsString: $ingredientsString');
//    print('.ingredientName.toLowerCase().trim(): ${x.ingredientName.toLowerCase().trim()}');

//    List<String> foodIngredients =ingredientsString;

//    logger.w('onlyIngredientsNames2',onlyIngredientsNames2);

    /*

    String elementExists = allIngredients.firstWhere(
            (oneItem) => oneItem.toLowerCase() == inputString.toLowerCase(),
        orElse: () => '');

    print('elementExists: $elementExists');

    return elementExists;

    */


//    categories[3]= 'lasten_menu';


    String elementExists = stringList.firstWhere(
            (oneItem) => oneItem.toLowerCase().trim() == 'lasten_menu'.toLowerCase().trim(),
        orElse: () => '');

    if(elementExists!=''){

      print('elementExists: $elementExists');

      return true;

    }

//    print('elementExists: Line # 612:  $elementExists');

    return false;
  }

  // this code bloc cut paste from foodGallery Bloc:
  Future<void> getAllExtraIngredientsConstructor() async {

    print('at getAllExtraIngredientsConstructor()');



    if (_isDisposedExtraIngredients == false) {

      var snapshot = await _client.fetchAllExtraIngredients();
      List docList = snapshot.documents;

      List <NewIngredient> ingItems = new List<NewIngredient>();
      ingItems = snapshot.documents.map((documentSnapshot) =>
          NewIngredient.ingredientConvertExtra
            (documentSnapshot.data, documentSnapshot.documentID)
      ).toList();


      List<String> documents = snapshot.documents.map((documentSnapshot) =>
      documentSnapshot.documentID).toList();

      print('documents are [Ingredient Documents] at food Gallery Block : ${documents.length}');



      ingItems.forEach((doc) {
        print('one Extra . . . . . . . name: ${doc.ingredientName} documentID: ${doc.documentId}');
//        String imageURL;
//        double price;
//        String documentId;
//        doc['name'],
//        price = data['price'].toDouble(),
//        documentId = docID,

      }
      );



      _allExtraIngredients = ingItems;
//      _allIngItemsFGBloc = ingItems;

      _allExtraIngredientItemsController.sink.add(_allExtraIngredients);

//      _allIngredientListController.sink.add(_allIngItemsFGBloc);


//    return ingItems;







      _isDisposedExtraIngredients=true;




    }
    else {
//      _isDisposedExtraIngredients == Element.true
      return;
    }
  }




//  Future<List<FoodItemWithDocID>> getAllFoodItems() async {
  void getAllFoodItemsConstructor() async {

    print('at getAllFoodItemsConstructor()');

//    _isDisposedFoodItems = true;
    if(_isDisposedFoodItems==true) {
      return;
    }
    else {

      var snapshot = await _client.fetchFoodItems();
      List docList = snapshot.documents;

      List<FoodItemWithDocID> tempAllFoodsList= new List<FoodItemWithDocID>();
      docList.forEach((doc) {

        final String foodItemName = doc['name'];



//      print('foodItemName $foodItemName');

        final String foodItemDocumentID = doc.documentID;
//      print('foodItemDocumentID $foodItemDocumentID');


        final String foodImageURL  = doc['image']==''?
        'https://thumbs.dreamstime.com/z/smiling-orange-fruit-cartoon-mascot-character-holding-blank-sign-smiling-orange-fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
            :
        storageBucketURLPredicate + Uri.encodeComponent(doc['image'])
            +'?alt=media';
//      print('doc[\'image\'] ${doc['image']}');



        final bool foodIsAvailable =  doc['available'];
        final int sequenceNo =  doc['sequence_no'];

//        print('foodIsAvailable: $foodIsAvailable');

        final Map<String,dynamic> oneFoodSizePriceMap = doc['size'];
        final List<dynamic> foodItemIngredientsList =  doc['ingredients'];
//          logger.i('foodItemIngredientsList at getAllFoodDataFromFireStore: $foodItemIngredientsList');

//          print('foodSizePrice __________________________${oneFoodSizePriceMap['normal']}');

        final String foodCategoryName = doc['category'];

        final String shorCategoryName2 = doc['categoryShort'];

        print('shorCategoryName2: ZZZZ ZZZZZZ ZZZZZ   $shorCategoryName2');




//      print('category: $foodCategoryName');

        String defaultJuusto = doc['default_juusto'];

        String defaultKastike = doc['default_kastike'];

        print('___/////// defaultKastike of $foodItemName :  $defaultKastike ______');


        List<String> defaultJuusto2 = new List<String>() ;
        defaultJuusto2.add(defaultJuusto);

        List<String> defaultKastike2 = new List<String>();
        defaultKastike2.add(defaultKastike);


//        logger.e('defaultKastike2.length: ${defaultKastike2.length}');
//        logger.w('defaultJuusto2.length: ${defaultJuusto2.length}');


        /*
        print('foodItemName: $foodItemName  and docID: $foodItemDocumentID and '
            'defaultJuusto $defaultJuusto and defaultKastike: $defaultKastike');

        */
        if(foodItemName.toLowerCase()=='pita'){
          print('--------------------------pita found-==================');
        }

//        final double foodItemDiscount = doc['discount'];

//      print('foodItemDiscount: for $foodItemDocumentID is: $foodItemDiscount');


        FoodItemWithDocID oneFoodItemWithDocID = new FoodItemWithDocID(
          itemName: foodItemName,
          categoryName: foodCategoryName,
          shorCategoryName:shorCategoryName2,
          imageURL: foodImageURL,
          sizedFoodPrices: oneFoodSizePriceMap,
          ingredients: foodItemIngredientsList,
          isAvailable: foodIsAvailable,
          documentId: foodItemDocumentID,
//          discount: foodItemDiscount,
          defaultJuusto:defaultJuusto2,
          defaultKastike:defaultKastike2,
          sequenceNo: sequenceNo,
        );

        tempAllFoodsList.add(oneFoodItemWithDocID);
      }
      );


      _allFoodsList= tempAllFoodsList;

      _foodItemController.sink.add(_allFoodsList);
      _isDisposedFoodItems = true;

    }
  }



  void getAllCategoriesConstructor() async {

    print('at getAllCategoriesConstructor()');

    if(_isDisposedCategories == true) {
      return;
    }

    else {


      var snapshot = await _client.fetchCategoryItems();
      List docList = snapshot.documents;


      List<NewCategoryItem> tempAllCategories = new List<NewCategoryItem>();

      docList.forEach((doc) {

//

        final String categoryItemName = doc['name'];

        print('categoryItemName : $categoryItemName');

        final String documentID = doc.documentID;


        /*
        final String categoryImageURL  = doc['image']==''?
        'https://thumbs.dreamstime.com/z/smiling-orange-fruit-cartoon-mascot-character-holding-blank-sign-smiling-orange-fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
            :
        storageBucketURLPredicate + Uri.encodeComponent(doc['image'])
            +'?alt=media';

        */



//      print('categoryImageURL in food Gallery Bloc: $categoryImageURL');

        final num sequenceNo0 = doc['sequence_no'];
//        final num totalCategoryRating = doc['total_rating'];


        final String fireStoreFieldName2= doc['fireStoreFieldName'];


        /*

        print('categoryItemName : $categoryItemName,categoryRating :'
            ' $categoryRating, totalCategoryRating , $totalCategoryRating, categoryImageURL: $categoryImageURL');


        */

        NewCategoryItem oneCategoryItem = new NewCategoryItem(

          categoryName: categoryItemName,
          squenceNo: sequenceNo0.toInt(),
          documentID:documentID,
          fireStoreFieldName:fireStoreFieldName2,

//          imageURL: categoryImageURL,
//          rating: categoryRating.toDouble(),
//          totalRating: totalCategoryRating.toDouble(),

        );

        tempAllCategories.add(oneCategoryItem);
      }
      );

//    NewCategoryItem all = new NewCategoryItem(
//      categoryName: 'All',
//      imageURL: 'None',
//      rating: 0,
//      totalRating: 5,
//
//    );

      _allCategoryList= tempAllCategories;

      _categoriesController.sink.add(_allCategoryList);
      //    _foodItemController.sink.add(_allCategoryList);
      //    return _allFoodsList;

      _isDisposedCategories = true;

    }
  }


  void getAllKastikeSaucesConstructor() async {


    var snapshot = await _client.fetchAllKastikeORSauces();
    List docList = snapshot.documents;



    List <SauceItem> sauceItems = new List<SauceItem>();
    sauceItems = snapshot.documents.map((documentSnapshot) =>
        SauceItem.fromMap
          (documentSnapshot.data, documentSnapshot.documentID)

    ).toList();


    List<String> documents = snapshot.documents.map((documentSnapshot) =>
    documentSnapshot.documentID
    ).toList();

    print('Ingredient documents are: $documents');



    sauceItems.forEach((oneSauceItem) {
      print('oneSauceItem.sauceItemName: ${oneSauceItem.sauceItemName}');
    }

    );




    _allSauceItemsFoodGalleryBloc = sauceItems;
    _sauceItemsControllerFoodGallery.sink.add(_allSauceItemsFoodGalleryBloc);



    /*
    _allSauceItemsDBloc = sauceItems;

    _sauceItemsController.sink.add(_allSauceItemsDBloc);


    _allSelectedSauceItems = sauceItems.where((element) => element.isSelected==true).toList();

    _selectedSauceListController.sink.add(_allSelectedSauceItems);

    */


//    return ingItems;

  }


  void getAllCheeseItemsJuustoConstructor() async {


    var snapshot = await _client.fetchAllCheesesORjuusto();
    List docList = snapshot.documents;



    List <CheeseItem> cheeseItems = new List<CheeseItem>();
    cheeseItems = snapshot.documents.map((documentSnapshot) =>
        CheeseItem.fromMap
          (documentSnapshot.data, documentSnapshot.documentID)

    ).toList();




    List<String> documents = snapshot.documents.map((documentSnapshot) =>
    documentSnapshot.documentID
    ).toList();


    cheeseItems.forEach((oneCheeseItem) {

      print('oneCheeseItem.cheeseItemName: ${oneCheeseItem.cheeseItemName}');



//      if(oneCheeseItem.sl==1){
//        oneCheeseItem.isSelected=true;
//        oneCheeseItem.isDefaultSelected=true;
//      }
    }

    );


//    print('Ingredient documents are: $documents');



    _allCheeseItemsFoodGalleryBloc  = cheeseItems;
    _cheeseItemsControllerFoodGallery.sink.add(_allCheeseItemsFoodGalleryBloc);


//    _allCheeseItemsDBloc = cheeseItems;

//    _cheeseItemsController.sink.add(_allCheeseItemsDBloc);


//    return ingItems;


    /*
    _allSelectedCheeseItems = cheeseItems.where((element) => element.isSelected==true).toList();



    logger.w('_allSelectedCheeseItems at getAllCheeseItemsConstructor():'
        ' $_allSelectedCheeseItems');

//    _selectedSauceListController.sink.add(_allSelectedSauceItems);
//    _allSelectedCheeseItems =
    _selectedCheeseListController.sink.add(_allSelectedCheeseItems);



    */
  }


  // CONSTRUCTOR BIGINS HERE..
  FoodGalleryBloc() {

    print('at FoodGalleryBloc()');



//    getAllIngredientsConstructor();

    getAllExtraIngredientsConstructor();

    getAllFoodItemsConstructor();

    getAllCategoriesConstructor();

    getAllKastikeSaucesConstructor();

    getAllCheeseItemsJuustoConstructor();

    // need to use this when moving to food Item Details page.


    print('at FoodGalleryBloc()');

//    getAllIngredients();
    // invoking this here to make the transition in details page faster.

//    this.getAllFoodItems();
//    this.getAllCategories();

  }

  // CONSTRUCTOR ENDS HERE..




  // 4
  @override
  void dispose() {
    _foodItemController.close();
    _categoriesController.close();
    _allIngredientListController.close();

    _cheeseItemsControllerFoodGallery.close();
    _sauceItemsControllerFoodGallery.close();
    _allExtraIngredientItemsController.close();


//    _isDisposedIngredients=
    _isDisposedIngredients = true;
    _isDisposedFoodItems = true;
    _isDisposedCategories = true;
    _isDisposedExtraIngredients = true;



//    _isDisposed = true;

//    _allIngredientListController.close();
  }
}