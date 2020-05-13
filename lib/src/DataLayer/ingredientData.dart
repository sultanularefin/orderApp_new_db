import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:logger/logger.dart';
//import 'package:basic_utils/basic_utils.dart';
// import 'package:flutter/material.dart';





import 'package:firebase_storage/firebase_storage.dart';


class IngredientData {
  //  static const String PassionCooking = 'cooking';
  //  static const String PassionHiking = 'hiking';
  //  static const String PassionTraveling = 'traveling';

  var logger = Logger(
    printer: PrettyPrinter(),
  );


  final Firestore firestore = Firestore.instance;

//  final StorageReference a1 = storage.ref('ff');

//  var parentRef = storage.ref('');

  CollectionReference get firestoreFoodItems => firestore.collection('ingredientitems');


  final FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://foodgalleryarefin.appspot.com');


  File _image2;
  String _firebaseUser ;
  //    final uid = user.uid



  String ingredientName = '';


  String imageURL = '';
  bool isAvailable = true;
//  String StoragePNGURL ='';



  // UNSEEN fields:
  String ingredientId;
  //  itemId

  String  uploadedBy = '';
  Timestamp date ;

  bool newsletter = false;

  set setImage(var param){
    _image2=param;

  }


//  set itemCategoryName (String name){
//
//    print('setting category name to: $name');
//    categoryName= name.toUpperCase();
//  }

  set setUser(var param){
    _firebaseUser = param;

  }

  Future<String> generateIngredientId(int length)  async {
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


  Future<String> _uploadFile() async {

    print('at _uploadFile: ');

//    print('foodItemsStorageReference: $foodItemsStorageReference');


//    print('categoryName: $categoryName); //to upper case



    print('ingredientId: $ingredientId');
    StorageReference storageReference_1 = storage.ref().child('ingredientitems').
    child(_firebaseUser).child(
        'ingredientname'+ingredientId+'.png');



//    print('storageReference: $storageReference');
//    final StorageReference storageReference_1 = storageReference.child('ss.png');


    print('_image2: $_image2');

    StorageUploadTask uploadTask = storageReference_1.putFile(_image2,
      StorageMetadata(

          contentType: 'image/jpg',
          cacheControl: 'no-store', // disable caching
          customMetadata: {
            'ingredientName': ingredientName,
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

    ingredientId = await generateIngredientId(6);
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

    print('ingredientId: $ingredientId');
    print('ingredientName: $ingredientName');

    print('isAvailable: $isAvailable');

    print('_image2: $_image2');


    //    print('itemCategory: $itemCategory');
    //    _addMessage()
    print('saving user using a web service');


    ingredientName = titleCase(ingredientName);


    DocumentReference document = await firestoreFoodItems.add(<String, dynamic>{

      'ingredientName':ingredientName,
      'imageURL':imageURL,
      'isAvailable':isAvailable,
      'ingredientId': ingredientId,
      'uploadedBy':_firebaseUser,
      'uploadDate':FieldValue.serverTimestamp(),

    });
    print('added document: ${document.documentID}');

    return(1);

  }
}


