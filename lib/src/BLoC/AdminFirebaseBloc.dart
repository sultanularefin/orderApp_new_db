
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:logger/logger.dart';
import 'dart:ui';
// import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_storage/firebase_storage.dart';


//MODELS

import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';
import 'package:foodgallery/src/DataLayer/models/NewCategoryItem.dart';





import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';

class AdminFirebaseBloc implements Bloc{

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  // id ,type ,title <= Location.

//  bool _isDisposed = false;

  bool  _isDisposedIngredients = false;

  bool    _isDisposedFoodItems = false;

  bool _isDisposedCategories = false;

  bool _isDisposed_known_last_sequenceNumber = false;





  File _image2;
  String _firebaseUser ;
  //    final uid = user.uid



  String itemName = '';
  String categoryName = 'PIZZA'.toLowerCase();
  String shortCategoryName;


  String ingredients = '';
  bool isHot=true;
  String priceInEuro = '';

  String imageURL = '';
  bool isAvailable = true;
//  String StoragePNGURL ='';
  int sequenceNo= 0;

  FoodItemWithDocID _thisFoodItem;
  FoodItemWithDocID get getCurrentFoodItem => _thisFoodItem;
  final _foodItemController = StreamController <FoodItemWithDocID>();
  Stream<FoodItemWithDocID> get thisFoodItemStream => _foodItemController.stream;



  // CollectionReference get firestoreFoodItems => firestore.collection('foodItems');


  final FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://fluttercrudarefin.appspot.com');


  // unseen fields:
  String itemId;
  //  itemId

  String  uploadedBy = '';


  //  String lastName = '';

  //  Map<String, bool> passions = {
  //    PassionCooking: false,
  //    PassionHiking: false,
  //    PassionTraveling: false
  //  };


  bool newsletter = false;

  set setImage(var param){
    _image2=param;

  }





  void setCategoryValue (String name,String shortName){

    print('setting category name to: $name');
    String categoryName = name.toLowerCase();

    String shortCategoryName = shortName.toLowerCase();

    _thisFoodItem.categoryName=name;
    _thisFoodItem.shorCategoryName= shortCategoryName;

    _foodItemController.sink.add(_thisFoodItem);




//    String shortCategoryName =
  }

  set setUser(var param){
    _firebaseUser = param;

  }



  Future<String> generateItemId(int length)  async {
    String _result = "";
    int i = 0;
    String _allowedChars ='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789}';
    while (i < length.round()) {
      //Get random int
      int randomInt = Random.secure().nextInt(_allowedChars.length);
      //      print('randomInt: $randomInt');
      //Get random char and append it to the password

      //      print('_allowedChars[randomInt]: ${_allowedChars[randomInt]}');


      _result += _allowedChars[randomInt];

      //      print('_result: $_result');

      i++;
    }

    return _result;
  }



  String titleCase(var text) {
    // print("text: $text");
    if (text is num) {
      return text.toString();
    } else if (text == null) {
      return '';
    } else if (text.length <= 1) {
      return text.toUpperCase();
    } else {
      return text
          .split(' ')
          .map((word) => word[0].toUpperCase() + word.substring(1))
          .join(' ');


    }
  }




  Future<String> _uploadFile() async {

    print('at _uploadFile: ');

//    print('foodItemsStorageReference: $foodItemsStorageReference');


//    print('categoryName: $categoryName); //to upper case



    print('itemId: $itemId');
    StorageReference storageReference_1 = storage.ref().child('foodItems').
    child(categoryName).child(
        'itemName'+itemId+'.png');



//    print('storageReference: $storageReference');
//    final StorageReference storageReference_1 = storageReference.child('ss.png');


    print('_image2: $_image2');

    StorageUploadTask uploadTask = storageReference_1.putFile(_image2,
      StorageMetadata(

          contentType: 'image/jpg',
          cacheControl: 'no-store', // disable caching
          customMetadata: {
            'itemName': itemName,
          }

      ),);

    if(uploadTask.isCanceled == true){
      return "error";
    }

    await uploadTask.onComplete;


    String urlString = await storageReference_1.getDownloadURL().then((onValue){
      print('onValue: $onValue');
//      print('t: $t');
      print('File Uploaded');
      return onValue;
    });

    print('am i printed :   ????????????????????');

    return urlString;


  }

  Future<int> getLastSequenceNumberFromFireBaseFoodItems() async {



      print('at get Last SequenceNumberFromFireBaseFoodItems()');



      if (_isDisposed_known_last_sequenceNumber == false) {

        var snapshot = await _client.getLastSequenceNumberFromFireBaseFoodItems();
        List docList = snapshot.documents;

        FoodItemWithDocID lastOne = new FoodItemWithDocID();
//        ingItems = snapshot.documents.map((documentSnapshot) =>
//            NewIngredient.ingredientConvertExtra
//              (documentSnapshot.data, documentSnapshot.documentID)
//        ).toList();

        lastOne.reverseCustomCast(docList[0])


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


  }


  Future<int> save() async {
    //  save() {

    itemId = await generateItemId(6);
    imageURL =  await _uploadFile();

    var uri = Uri.parse(imageURL);
    // print(uri.isScheme("HTTP"));  // Prints true.

    if(uri.isScheme("HTTP")||(uri.isScheme("HTTPS"))){
      print('on of them is true');

    }
    else{
      print ('storage server error: ');
      print("try VPN ___________________________________________");

      logger.v("Verbose log");

      logger.d("Debug log");

      logger.i("Info log");

      logger.w("Warning log");

      logger.e("Error log");
      return 0;
    }

//    bool _validURL = Uri.parse(_adVertData.webLink).isAbsolute;

//    if(imageURL == null){
//      print ('storage server error: ');
//      return 0;
//    }

    print('imageURL: $imageURL');


    print('itemId: $itemId');
    print('itemName: $itemName');

    print('ingredients: $ingredients');
    print('Euro Price: $priceInEuro');


    print('isHot: $isHot');
    print('isAvailable: $isAvailable');

    print('_image2: $_image2');
    print('_categoryName: $categoryName');

    //    print('itemCategory: $itemCategory');
    //    _addMessage()
    print('saving user using a web service');

    itemName = titleCase(itemName);
    ingredients = titleCase(ingredients);


    //    Image Storage code TODO


    //    await firestoreFoodItems.add(<String, dynamic>{


    String documentID = await _client.insertFoodItems(_thisFoodItem,sequenceNo);

    DocumentReference document = await firestoreFoodItems.add(<String, dynamic>{
      'priceinEuro': priceInEuro,
      'isHot':isHot,
      'itemName':itemName,
      'categoryName': categoryName,
      'ingredients':ingredients,
      'imageURL':imageURL,


    });
    print('added document: ${document.documentID}');
    //    }

    return(1);

  }




  List<FoodItemWithDocID> _allFoodsList=[];

  List<NewCategoryItem> _allCategoryList=[];



//    List<NewCategoryItem>_allCategoryList=[];
  final _client = FirebaseClient();



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
  // AdminFirebaseBloc
  //   AdminFirebaseBloc
    AdminFirebaseBloc() {

    print('at AdminFirebaseBloc  ......()');



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
    _isDisposed_known_last_sequenceNumber = true;



//    _isDisposed = true;

//    _allIngredientListController.close();
  }
}