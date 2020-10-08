


import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';

import 'package:foodgallery/src/DataLayer/models/NewCategoryItem.dart';


import 'package:logger/logger.dart';


import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';


import 'dart:async';


class FoodGalleryBloc implements Bloc {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final FirebaseStorage storage =
  FirebaseStorage(storageBucket: 'gs://kebabbank-37224.appspot.com');



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


  final _client = FirebaseClient();

  //  getter for the above may be


  List<FoodItemWithDocID> get allFoodItems => _allFoodsList;
  List<NewCategoryItem> get allCategories => _allCategoryList;


  final _foodItemController = StreamController <List<FoodItemWithDocID>>();
  final _categoriesController = StreamController <List<NewCategoryItem>>();

  Stream<List<FoodItemWithDocID>> get foodItemsStream => _foodItemController.stream;

  Stream<List<NewCategoryItem>> get categoryItemsStream => _categoriesController.stream;







  // HELPER METHOD FOR TEST TO BE MODIFIED....  AUGUST 14 2020.....
  bool checkThisExtraIngredientForSomeCategory(NewIngredient x) {

    List<String> categories =
    [

      'lasten_menu',
//      'kebab',=> done
      'juomat'
    ];

    logger.e('for lasten_menu');



    List<String> stringList = List<String>.from(x.extraIngredientOf);



    print('x.ingredientName ${x.ingredientName}  x.subgroup.: ${x.subgroup}');


    if(stringList.contains('kastike'.toLowerCase().trim())){

      print('contains /???');
      print('x.ingredientName: ${x.ingredientName}');
    };



    String elementExists = stringList.firstWhere(
            (oneItem) => oneItem.toLowerCase().trim() == 'lasten_menu'.toLowerCase().trim(),
        orElse: () => '');

    if(elementExists!=''){

      print('elementExists: $elementExists');

      return true;

    }

    return false;
  }

  Future<void> getAllExtraIngredientsConstructor() async {

    print('at getAllExtraIngredientsConstructor()');



    if (_isDisposedExtraIngredients == false) {

      var snapshot = await _client.fetchAllExtraIngredients();
      List docList = snapshot.docs;

      List <NewIngredient> ingItems = new List<NewIngredient>();
      ingItems = snapshot.docs.map((documentSnapshot) =>
          NewIngredient.ingredientConvertExtra
            (documentSnapshot.data(), documentSnapshot.id)
      ).toList();


      List<String> documents = snapshot.docs.map((documentSnapshot) =>
      documentSnapshot.id).toList();

      print('documents are [Ingredient Documents] at food Gallery Block : ${documents.length}');



      for (int i = 0; i< ingItems.length ; i++){

        String fileName2  = ingItems[i].imageURL;
        print('fileName2 =============> : $fileName2');

        StorageReference storageReferenceForIngredientItemImage = storage
            .ref()
            .child(fileName2);

        String newimageURLIngredient = await storageReferenceForIngredientItemImage.getDownloadURL();

        ingItems[i].imageURL= newimageURLIngredient;

        print('newimageURL ingredient Item : $newimageURLIngredient');
      }

      ingItems.forEach((doc) {
        print('one Extra . . . . . . . name: ${doc.ingredientName} documentID: ${doc.documentId}');
      }
      );



      _allExtraIngredients = ingItems;

      _allExtraIngredientItemsController.sink.add(_allExtraIngredients);
      _isDisposedExtraIngredients=true;




    }
    else {

      return;
    }
  }



  List<String> dynamicListFilteredToStringList(List<dynamic> dlist) {

    List<String> stringList = List<String>.from(dlist);

    return stringList;


  }



  Future<String> getDownloadURL2(String imageURL) async{

    StorageReference storageReference_2 = storage
        .ref()
        .child('foodItems2')
        .child(imageURL);

    String x;
    try {
      x = await storageReference_2.getDownloadURL();
    } catch (e) {

      print('e         _____ -----: $e');

    }


    print('x         _____ -----: $x');

    return x;
  }


  Future<String> _downloadFile(StorageReference ref) async {
    final String url = await ref.getDownloadURL();

    return url;
  }


  void getAllFoodItemsConstructor() async {

    print('at getAllFoodItemsConstructor()');

    if(_isDisposedFoodItems==true) {
      return;
    }
    else {

      var snapshot = await _client.fetchFoodItems();


      List<FoodItemWithDocID> tempAllFoodsList= new List<FoodItemWithDocID>();

      snapshot.docs.forEach((doc) async {

        Map getDocs = doc.data();

        final String foodItemName = getDocs ['name'];

        final String foodItemDocumentID = doc.id;


        final String foodImageURL  = getDocs ['image'];
        final bool foodIsAvailable =  getDocs ['available'];
        final int sequenceNo =  getDocs ['sequenceNo'];



        final Map<String,dynamic> oneFoodSizePriceMap = getDocs ['size'];
        final List<dynamic> foodItemIngredientsList =   getDocs ['ingredients'];

        final String foodCategoryName =  getDocs ['category'];

        final String shorCategoryName2 = getDocs ['categoryShort'];

        print('shorCategoryName2: ZZZZ ZZZZZZ ZZZZZ   $shorCategoryName2');


        List<dynamic> defaultJuusto2 = new List<dynamic>() ;
        defaultJuusto2 = getDocs ['default_juusto'];

        List<dynamic> defaultKastike2 = new List<dynamic>();

        defaultKastike2= getDocs ['default_kastike'];

        print('\n\n\n');

        print('foodItemName => => $foodItemName');


        List<String> defaultJuusto3 = new List<String>() ;
        if(defaultJuusto2 != null) {
          defaultJuusto3 = dynamicListFilteredToStringList(defaultJuusto2);
        }

        List<String> defaultKastike3 = new List<String>();

        if(defaultKastike2 != null) {
          defaultKastike3 = dynamicListFilteredToStringList(defaultKastike2);
        }

        if(foodItemName.toLowerCase()=='pita'){
          print('--------------------------pita found-==================');
        }

        FoodItemWithDocID oneFoodItemWithDocID = new FoodItemWithDocID(
          itemName: foodItemName,
          categoryName: foodCategoryName,
          shorCategoryName:shorCategoryName2,
          imageURL: foodImageURL,
          sizedFoodPrices: oneFoodSizePriceMap,
          ingredients: foodItemIngredientsList,
          isAvailable: foodIsAvailable,
          documentId: foodItemDocumentID,

          defaultJuusto:defaultJuusto3,
          defaultKastike:defaultKastike3,
          sequenceNo: sequenceNo,
        );

        tempAllFoodsList.add(oneFoodItemWithDocID);
      }
      );


      for (int i =0; i< tempAllFoodsList.length ; i++){


        String fileName2  = tempAllFoodsList[i].imageURL;


        print('fileName2 =============> : $fileName2');

        StorageReference storageReferenceForFoodItemImage = storage
            .ref()
            .child(fileName2);

        String newimageURLFood = await storageReferenceForFoodItemImage.getDownloadURL();

        tempAllFoodsList[i].imageURL= newimageURLFood;

        print('newimageURL food Item : $newimageURLFood');
      }


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



      List docList = snapshot.docs;

      print('docList.length: ${docList.length}');





      List<NewCategoryItem> tempAllCategories = new List<NewCategoryItem>();

      docList.forEach((doc) {

        final String categoryItemName = doc.get('name');//['name'];

        print('categoryItemName : $categoryItemName');

        final String documentID = doc.documentID;


        final num sequenceNo0 =doc.get('sequence_no');

        final String fireStoreFieldName2= doc.get('fireStoreFieldName');


        NewCategoryItem oneCategoryItem = new NewCategoryItem(

          categoryName: categoryItemName,
          sequenceNo: sequenceNo0.toInt(),
          documentID:documentID,
          fireStoreFieldName:fireStoreFieldName2,

        );

        tempAllCategories.add(oneCategoryItem);
      }
      );


      _allCategoryList= tempAllCategories;

      _categoriesController.sink.add(_allCategoryList);

      _isDisposedCategories = true;

    }
  }


  void getAllKastikeSaucesConstructor() async {


    var snapshot = await _client.fetchAllKastikeORSauces();
    List docList = snapshot.docs;



    List <SauceItem> sauceItems = new List<SauceItem>();
    sauceItems = snapshot.docs.map((documentSnapshot) =>
        SauceItem.convertFireStoreSauceItemData
          (documentSnapshot.data(), documentSnapshot.id)

    ).toList();


    List<String> documents = snapshot.docs.map((documentSnapshot) =>
    documentSnapshot.id
    ).toList();

    print('Sauces documents are: $documents');



    sauceItems.forEach((oneSauceItem) {
      print('oneSauceItem.sauceItemName: ${oneSauceItem.sauceItemName}');
    }

    );




    for (int i = 0; i< sauceItems.length ; i++){

      String fileName2  = sauceItems[i].imageURL;

      print('fileName2 =============> : $fileName2');

      StorageReference storageReferenceForSauceItemImage = storage
          .ref()
          .child(fileName2);

      String newimageURLSauce = await storageReferenceForSauceItemImage.getDownloadURL();

      sauceItems[i].imageURL= newimageURLSauce;

      print('newimageURL ingredient Item : $newimageURLSauce');
    }



    _allSauceItemsFoodGalleryBloc = sauceItems;
    _sauceItemsControllerFoodGallery.sink.add(_allSauceItemsFoodGalleryBloc);


  }


  void getAllCheeseItemsJuustoConstructor() async {


    var snapshot = await _client.fetchAllCheesesORjuusto();
    List docList = snapshot.docs;



    List <CheeseItem> cheeseItems = new List<CheeseItem>();
    cheeseItems = snapshot.docs.map((documentSnapshot) =>
        CheeseItem.convertFireStoreCheeseItemData
          (documentSnapshot.data(), documentSnapshot.id)

    ).toList();




    List<String> documents = snapshot.docs.map((documentSnapshot) =>
    documentSnapshot.id
    ).toList();



    List<CheeseItem> cheeseItemIMageUrlUpdated = new List<CheeseItem>();

    for (int i = 0; i< cheeseItems.length ; i++){

      CheeseItem tempCheeseItem =cheeseItems[i];
      String fileName2  = cheeseItems[i].imageURL;

      print('fileName2 cheese.... =============> : $fileName2');

      StorageReference storageReferenceForSauceItemImage = storage
          .ref()
          .child(fileName2);

      String newimageURLCheese = await storageReferenceForSauceItemImage.getDownloadURL();


      tempCheeseItem.imageURL = newimageURLCheese;

      print('tempCheeseItem.imageURL : ${tempCheeseItem.imageURL}');

      cheeseItemIMageUrlUpdated.add(tempCheeseItem);

    }


    _allCheeseItemsFoodGalleryBloc  = cheeseItemIMageUrlUpdated;
    _cheeseItemsControllerFoodGallery.sink.add(_allCheeseItemsFoodGalleryBloc);

  }


  // CONSTRUCTOR BIGINS HERE..
  FoodGalleryBloc() {

    print('at FoodGalleryBloc()');



    getAllExtraIngredientsConstructor();

    getAllFoodItemsConstructor();

    getAllCategoriesConstructor();

    getAllKastikeSaucesConstructor();

    getAllCheeseItemsJuustoConstructor();


    print('at FoodGalleryBloc()');


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


    _isDisposedIngredients = true;
    _isDisposedFoodItems = true;
    _isDisposedCategories = true;
    _isDisposedExtraIngredients = true;

  }
}