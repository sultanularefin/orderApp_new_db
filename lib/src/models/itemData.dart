import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:logger/logger.dart';
//import 'package:basic_utils/basic_utils.dart';
// import 'package:flutter/material.dart';


import 'package:firebase_core/firebase_core.dart';


import 'package:firebase_storage/firebase_storage.dart';


class ItemData {
  //  static const String PassionCooking = 'cooking';
  //  static const String PassionHiking = 'hiking';
  //  static const String PassionTraveling = 'traveling';

  var logger = Logger(
    printer: PrettyPrinter(),
  );


  final Firestore firestore = Firestore.instance;

//  final StorageReference a1 = storage.ref('ff');

//  var parentRef = storage.ref('');

  CollectionReference get firestoreFoodItems => firestore.collection('foodItems');

  // IMPORTANT CODE BELOW.

//  StorageReference storageReference = FirebaseStorage.instance
//      .ref()
//      .child('foodItems/');

  // IMPORTANT CODE BELOW.


//  gs://foodgalleryarefin.appspot.com/foodItems
  // gs://flutter-firebase-plugins.appspot.com

  final FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://foodgalleryarefin.appspot.com');

//  StorageReference foodItemsStorageReference = storage.ref()

//  final StorageReference foodItemsStorageReference = FirebaseStorage.instance
//      .ref()
//      .child('foodItems');


//  final StorageReference foodItemsStorageReference =
//  storage.ref().child('text').child('foo$uuid.txt');
//  StorageReference storageReference = FirebaseStorage.instance
//      .ref()
//      .child('foodItems/');



  //  final FirebaseStorage storage = FirebaseStorage();
  //('gs://foodgalleryarefin.appspot.com');


  //  = await auth.currentUser()
  File _image2;
  String _firebaseUser ;
  //    final uid = user.uid



  String itemName = '';
  String categoryName = 'PIZZA'.toUpperCase();
  String ingredients = '';
  bool isHot=true;
  String priceInEuro = '';

  String imageURL = '';
  bool isAvailable = true;
//  String StoragePNGURL ='';



  // unseen fields:
  String itemId;
  //  itemId

  String  uploadedBy = '';
  Timestamp date ;

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


  set itemCategoryName (String name){

    print('setting category name to: $name');
    categoryName= name.toUpperCase();
  }

  double get getPriceInEuro{
//      double.parse(doc['priceinEuro'])
//          .toStringAsFixed(2);

    if(priceInEuro !=''){

      double price = double.parse(priceInEuro);
      print ('price ------------------- |||||||||||: $price');

      return price;
    }
    else return 0.0;
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

  Future<String> save() async {
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
      return "error";
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

    DocumentReference document = await firestoreFoodItems.add(<String, dynamic>{
      'priceinEuro': priceInEuro,
      'isHot':isHot,
      'itemName':itemName,
      'categoryName': categoryName,
      'ingredients':ingredients,
      'imageURL':imageURL,
      'isAvailable':isAvailable,
      'itemId': itemId,
      'uploadedBy':_firebaseUser,
      'uploadDate':FieldValue.serverTimestamp(),
      'otherPrices':{
        'LASTEN': getPriceInEuro*(1),
        'NORMAL':getPriceInEuro*(1.2),
        'MEDIUM':getPriceInEuro*(1.5),

        'PERHE':getPriceInEuro*(2.5),
        'PANNU':getPriceInEuro*(4),
        'GLUTEENITON': getPriceInEuro*(1),
      }

    });
    print('added document: ${document.documentID}');
    //    }

    return document.documentID;

  }
}


//itemData:{
//price in Euro.: String.
//Hot or not hot: boolean.
//name of product:
//ingredients:
//imageURL:
//isAvailable:
//}
//
//itemId:
//uploadedBy:
//date: