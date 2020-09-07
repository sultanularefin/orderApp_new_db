
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/IngredientSubgroup.dart';
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

import 'package:foodgallery/src/DataLayer/models/NewCategoryItem.dart';





import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';




class AdminFirebaseIngredientBloc implements Bloc{

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  bool  _isDisposedIngredients = false;

  bool    _isDisposedFoodItems = false;

  bool _isDisposedCategories = false;

  bool _isDisposed_known_last_sequenceNumber = false;


  List<NewCategoryItem>   _foodCategoryTypesForMultiSelect;
  List<NewCategoryItem> get getCategoryTypesForDropDown => _foodCategoryTypesForMultiSelect;
  final _categoryMultiSelectController = StreamController <List<NewCategoryItem>>.broadcast();
  Stream  <List<NewCategoryItem>> get getCategoryMultiSelectControllerStream =>
      _categoryMultiSelectController.stream;


  List<IngredientSubgroup>_ingredientGroupes;
  List<IngredientSubgroup> get getIngredientTypes => _ingredientGroupes;
  final _ingredientsGroupsController = StreamController <List<IngredientSubgroup>>.broadcast();
  Stream  <List<IngredientSubgroup>> get getIngredientGroupsControllerStream =>
      _ingredientsGroupsController.stream;




  File _image2;
  String _firebaseUserEmail ;

  String categoryName = 'PIZZA'.toLowerCase();
  String shortCategoryName;

  bool isHot=true;
  String priceInEuro = '';

  String imageURL = '';
  bool isAvailable = true;

  int sequenceNo= 0;

  NewIngredient _thisIngredientItem;
  NewIngredient get getCurrentIngredientItem => _thisIngredientItem;
  final _ingredientItemController = StreamController <NewIngredient>();
  Stream<NewIngredient> get thisIngredientItemStream => _ingredientItemController.stream;



  final FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://kebabbank-37224.appspot.com');



  String itemId;


  String  uploadedBy = '';

  bool newsletter = false;


  void setImage(File localURL){
    print('localURL : $localURL');

    _image2=localURL;

  }






  void setUser(var param){
    _firebaseUserEmail = param;

  }

  void setPrice(String priceText){

//    double minutes2 = double.parse(minutes);
    double price = double.parse(priceText);
    NewIngredient temp = new NewIngredient();
    temp= _thisIngredientItem;
    temp.price= price;

    _thisIngredientItem= temp;

    _ingredientItemController.sink.add(_thisIngredientItem);

  }


  void setItemName(var param){

    NewIngredient temp = new NewIngredient();
    temp= _thisIngredientItem;
    temp.ingredientName = param;

    _thisIngredientItem= temp;

    _ingredientItemController.sink.add(_thisIngredientItem);

  }



  Future<String> generateItemId(int length)  async {
    String _result = "";
    int i = 0;
    String _allowedChars ='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789}';
    while (i < length.round()) {
      //Get random int
      int randomInt = Random.secure().nextInt(_allowedChars.length);

      _result += _allowedChars[randomInt];


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
  void toggoleMultiSelectCategoryValue (int index){
     _foodCategoryTypesForMultiSelect[index].isSelected= !_foodCategoryTypesForMultiSelect[index].isSelected;

    _categoryMultiSelectController.sink.add(_foodCategoryTypesForMultiSelect);

  }


  void toggoleMultiSelectSubgroupValue (int index){
    _ingredientGroupes[index].isSelected= !_ingredientGroupes[index].isSelected;

    _categoryMultiSelectController.sink.add(_foodCategoryTypesForMultiSelect);

  }


  Future<String> _uploadFile(String itemId,itemName) async {

    print('at _uploadFile: ');

    print('itemId: $itemId');
    StorageReference storageReference_1 = storage.ref().child('extraIngredients').
    child(categoryName).child(
        'itemName'+itemId+'.png');

    print('_image2: $_image2');

    StorageUploadTask uploadTask = storageReference_1.putFile(_image2,
      StorageMetadata(

          contentType: 'image/jpg',
          cacheControl: 'no-store', // disable caching
          customMetadata: {
            'itemName': itemName,
//            print('itemName: ${_thisFoodItem.itemName}');
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


  Future<int> save() async {
    //  save() {


//    pizza

//    kebab
//
//    jauheliha_kebab_vartaat
//
//    salaatti_kasvis
//
//    lasten_menu
//
//    juomat



    itemId = await generateItemId(6);
    imageURL =  await _uploadFile(itemId, _thisIngredientItem.ingredientName);

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



    print('imageURL: $imageURL');


    print('itemId: $itemId');
    print('_thisIngredientItem.ingredientName: ${_thisIngredientItem.ingredientName}');

//    print('ingredients: $ingredients');
    print('Euro Price: $priceInEuro');


    print('isHot: $isHot');
    print('isAvailable: $isAvailable');

    print('_image2: $_image2');
    print('_categoryName: $categoryName');

    //    print('itemCategory: $itemCategory');
    //    _addMessage()
    print('saving user using a web service');

    _thisIngredientItem.ingredientName =  titleCase(_thisIngredientItem.ingredientName);

//    _thisFoodItem.itemName = titleCase(_thisFoodItem.itemName);
    // DON'T DELETE THIS COMMENTS.. BELOW,INGREDIENTS ARE DUMMY FOR NOW.....

    List<String> x = new List<String>();
    x=['ingredient 1', 'ingredient 2', 'ingredient 3',];
//     _thisFoodItem.ingredients = titleCase(x);

//    _thisFoodItem.ingredients=x;


    _thisIngredientItem.itemId=itemId;


    //    Image Storage code TODO


    //    await firestoreFoodItems.add(<String, dynamic>{


    String documentID = await _client.insertIngredientItems(_thisIngredientItem,_firebaseUserEmail);

    print('added document: ${documentID}');
    //    }

    return(1);

  }



//    List<NewCategoryItem>_allCategoryList=[];
  final _client = FirebaseClient();

  void initiateIngredientGroups()
  {

    List<IngredientSubgroup> ingredientSubgroups = new List<IngredientSubgroup>();

    IngredientSubgroup liha = new IngredientSubgroup(ingredientSubgroupName: 'liha',isSelected: false);

    IngredientSubgroup hedelma = new IngredientSubgroup(ingredientSubgroupName: 'hedelma',isSelected: false);


    ingredientSubgroups.addAll([


      liha ,hedelma
      ]
    );

    _ingredientGroupes =ingredientSubgroups;
    _ingredientsGroupsController.sink.add(_ingredientGroupes);

  }

  void initiateCategoryForMultiSelectFoodCategory()
  {

    NewCategoryItem pizza = new NewCategoryItem(
      categoryName:'pizza',
      sequenceNo: 0,
      documentID:'pizza',
      fireStoreFieldName:'pizza',
    );

    NewCategoryItem kebab = new NewCategoryItem(
      categoryName:'kebab',
      sequenceNo: 1,
      documentID:'kebab',
      fireStoreFieldName:'pizza',
    );

    NewCategoryItem jauheliha_kebab_vartaat = new NewCategoryItem(
      categoryName:'jauheliha kebab & vartaat',
      sequenceNo: 2,
      documentID:'jauheliha_kebab_vartaat',
      fireStoreFieldName:'jauheliha_kebab_vartaat',
    );

    NewCategoryItem salaatti_kasvis = new NewCategoryItem(
      categoryName:'salaatti & kasvis',
      sequenceNo: 3,
      documentID:'salaatti_kasvis',
      fireStoreFieldName:'salaatti_kasvis',
    );

    NewCategoryItem hampurilainen = new NewCategoryItem(
      categoryName:'hampurilainen',
      sequenceNo: 4,
      documentID:'hampurilainen',
      fireStoreFieldName:'hampurilainen',
    );

    NewCategoryItem lasten_menu = new NewCategoryItem(
      categoryName:'lasten menu',
      sequenceNo: 5,
      documentID:'lasten_menu',
      fireStoreFieldName:'lasten_menu',
    );

    NewCategoryItem juomat = new NewCategoryItem(
      categoryName:'juomat',
      sequenceNo: 6,
      documentID:'juomat',
      fireStoreFieldName:'juomat',
    );


    List<NewCategoryItem> categoryItems2 = new List<NewCategoryItem>();



    categoryItems2.addAll([
      pizza,
      kebab,
      jauheliha_kebab_vartaat,
      salaatti_kasvis,
      hampurilainen,
      lasten_menu,
      juomat]

    );

    _foodCategoryTypesForMultiSelect = categoryItems2;
    _categoryMultiSelectController.sink.add(_foodCategoryTypesForMultiSelect);

  }
  // CONSTRUCTOR BIGINS HERE..


  AdminFirebaseIngredientBloc() {

    print('at AdminFirebaseIngredientBloc  ......()');


    initiateIngredientGroups();
    initiateCategoryForMultiSelectFoodCategory();



//    initiateCategoryDropDownList();

//    getLastSequenceNumberFromFireBaseFoodItems();




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
    _ingredientItemController.close();
//    _foodItemController.close();
    _categoryMultiSelectController.close();
    _ingredientsGroupsController.close();


    _isDisposedIngredients = true;
    _isDisposedFoodItems = true;
    _isDisposedCategories = true;
    _isDisposed_known_last_sequenceNumber = true;


  }
}