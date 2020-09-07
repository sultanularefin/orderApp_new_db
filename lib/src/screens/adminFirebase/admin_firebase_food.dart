
// dependency files
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/NewCategoryItem.dart';

// import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/AdminFirebaseFoodBloc.dart';
//import '../../BLoC/bloc_provider.dart';
//import './../../BLoC/AdminFirebaseFoodBloc.dart';
import 'package:logger/logger.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

//import 'package:fluttercrud/src/shared/category_Constants.dart' as CategoryItems;


final Firestore firestore = Firestore();


/*
class CategoryItem {
  CategoryItem(this.index,this.name,this.icon);
  final int index;
  final String name;
  final String shortName;
  final Icon icon;

}

*/

//class Item {
//  const Item(this.name,this.icon);
//  final String name;
//  final Icon icon;
//}


class AdminFirebaseFood extends StatefulWidget {
//  AdminFirebaseFood({this.firestore});

  final Widget child;

//  final Firestore firestore = Firestore.instance;

  AdminFirebaseFood({Key key, this.child}) : super(key: key);
  _AddDataState createState() => _AddDataState();

}


class _AddDataState extends State<AdminFirebaseFood> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _AddDataState({firestore});
  File _image;


  final _formKey = GlobalKey<FormState>();

  int _currentCategory= 0;
  bool _loadingState = false;




  void setCategoryValue(int categoryValue){

    /*
    final blocAdminFoodFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);



    print('categoryItems[_currentCategory].name: ${categoryItems[categoryValue].categoryName}');
    print('categoryItems[_currentCategory].fireStoreFieldName: ${categoryItems[categoryValue].fireStoreFieldName}');

    // final blocAdminFoodFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
    blocAdminFoodFBase.setCategoryValue(categoryItems[categoryValue].categoryName,
        categoryItems[categoryValue].fireStoreFieldName);


    */

    setState(() {
      _currentCategory =categoryValue;
    });

  }


  Future getImage() async {


    final blocAdminFoodFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);

    var image = await ImagePicker.pickImage(
//        source: ImageSource.camera
        source:ImageSource.gallery
    );


    /*
    var image = await ImagePicker.getImage(
//        source: ImageSource.camera
        source:ImageSource.gallery
    );

    */

    print('_image initially: $_image');
    print('image at getImage: $image');

    print('_currentCategory: $_currentCategory');


//


    //The method setImage isn't defined for the class 'ItemData';

//    _itemData.setImage = image;

    blocAdminFoodFBase.setImage(image);



    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();


    blocAdminFoodFBase.setUser(user.email);

//    _itemData.setUser =user.email;


    setState(() {
      _image = image;
    });
  }

  final Firestore firestore = Firestore.instance;

  CollectionReference get messages => firestore.collection('messages');


//  @override
//  Widget build(BuildContext context) {
//
//    print("at AdminFirebaseFood");
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Admin FireBase Page',),
//
//      ),
//      body: AddData(firestore: firestore),
//
//    );
//  }
  @override
  Widget build(BuildContext context) {
    var logger = Logger(
      printer: PrettyPrinter(),
    );

    logger.w('at build of AdminFirebaseFood');


    final blocAdminFoodFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);


//    scaffoldKey
    if(_loadingState ==true){
      return new Scaffold(
        key:_scaffoldKey,
        backgroundColor: Colors.blue,
        body:Center(
          child: Text('....please wait....'),

          /*
          SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : Colors.green,
                ),
              );
            },
          ),

          */
        ),
      );
    }
    else {

      print('at _loadingState == false in AdminFirebase food...');
      return new Scaffold(
          key:_scaffoldKey,
          appBar: AppBar(title: Text('Admin Firebase')),
          body: Container(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: StreamBuilder<FoodItemWithDocID>(
                stream: blocAdminFoodFBase.thisFoodItemStream, //null,
                initialData: blocAdminFoodFBase.getCurrentFoodItem,
                builder: (context, snapshot) {
                  /*
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(

                        child: Text('.....'),

                      );
                      break;
                    case ConnectionState.active:
                    default:
                      if (!snapshot.hasData) {
                        return Text('Loading...');
                      }
//          return Center(child:
//          Text('${messageCount.toString()}')
//          );
                      else {


                        */
                  final FoodItemWithDocID currentFood = snapshot.data;






                  return Builder(
                      builder: (context) =>
                          Form(
                              key: _formKey,
                              child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    new Container(
                                      child: _image == null
                                          ?
                                      GestureDetector(
                                        onTap: () {
                                          getImage();
//                              _getBarCode(context);

//                                print('onTap pressed instead of _getBarCode(context)');
//                                print('Number: 1');
                                        }, child: new CircleAvatar(

                                          backgroundColor: Colors.lightBlueAccent,
                                          radius: 80.0,

                                          child: new Container(
                                              padding: const EdgeInsets.all(0.0),
                                              child: new Container(
                                                child: Text('No image selected.'),)

                                          )

                                      ),
                                      ) : GestureDetector(
                                        onTap: () {
                                          getImage();
//                              _getBarCode(context);

//                                print('onTap pressed instead of _getBarCode(context)');
//                                print('Number: 2');
                                        }, child: new CircleAvatar(

                                          backgroundColor: Colors.lightBlueAccent,
                                          radius: 80.0,

                                          child: new Container(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Image.file(_image),

                                          )

                                      ),
                                      ),
                                    ),


                                    TextFormField(
                                      decoration:
                                      InputDecoration(labelText: 'Item Name'),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter the Item Name';
                                        }
                                      },
                                      onSaved: (val) =>
                                          blocAdminFoodFBase.setItemName(val),
//                                      setState(() => _itemData.itemName = val),


                                    ),


                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 50, 0, 20),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 50, 0, 20),
                                              child: Text('food Category: ',
                                                style: TextStyle(fontSize: 20,
                                                    color: Colors
                                                        .lightBlueAccent),),
                                            ),

//                                  Icon(Icons.thumb_up),
                                            SizedBox(width: 10),
//                                  ButtonTheme(
//                                  alignedDropdown:true,
//                                  Container(
//                                    width: 150.0,
                                            Container(

                                              width: displayWidth(context)/2,


                                              child:


                                              StreamBuilder<List<NewCategoryItem>>(
                                                stream: blocAdminFoodFBase.getCategoryDropDownControllerStream,
                                                initialData: blocAdminFoodFBase.getCategoryTypesForDropDown,
                                                builder: (context, snapshot) {

                                                  final List<NewCategoryItem> allCategories = snapshot.data;


//                                                              _currentCategory=cu

                                                  return DropdownButtonFormField(


                                                      value: _currentCategory != null ?
                                                      allCategories[_currentCategory]
                                                          .sequenceNo
                                                          : allCategories[0].sequenceNo,

                                                      items: allCategories.map((oneItem) {
                                                        return DropdownMenuItem(


                                                          value: oneItem.sequenceNo,
                                                          child: Row(
                                                            children: <Widget>[
//                                                        oneItem.icon,
                                                              SizedBox(width: 10,),
                                                              Text(
                                                                oneItem.categoryName,
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                ),
                                                              ),

                                                            ],
                                                          ),
//                                          child: Text(oneItem.name),
                                                        );
                                                      }).toList(),
                                                      onChanged: (val) {
                                                        blocAdminFoodFBase
                                                            .setCategoryValue(
                                                            allCategories[_currentCategory]
                                                                .categoryName,
                                                            allCategories[_currentCategory]
                                                                .fireStoreFieldName);
                                                        setCategoryValue(val);

                                                      }

                                                  );
                                                }

                                                ,
                                              ),
                                            ),
                                          ]
                                      ),
//                            Text('Subscribe'),
                                    ),

//


                                    SwitchListTile(
                                        title: const Text('Is Hot'),
                                        value: currentFood.isHot, //_itemData.isHot,
                                        onChanged: (bool val) =>
                                            blocAdminFoodFBase.setIsHot(val)

                                    ),


                                    SwitchListTile(
                                      title: const Text('Is Available'),
                                      value:currentFood.isAvailable,
                                      onChanged: (bool val) =>
                                          setState(() =>
                                              blocAdminFoodFBase.setIsAvailable(val)),
//    _itemData.isAvailable = val)
                                    ),


                                    // Cooking checkBox
                                    /*

                              CheckboxListTile(
                                  title: const Text('Cooking'),
                                  value: _itemData.passions[ItemData.PassionCooking],
                                  onChanged: (val) {
                                    setState(() =>
                                    _itemData.passions[ItemData.PassionCooking] = val);
                                  }),

                              */

                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        child: RaisedButton(
                                            color: Colors.yellowAccent,
                                            child: Text('Save',
                                              style: TextStyle(
                                                  fontSize: 20, color: Colors
                                                  .lightBlueAccent),),
                                            onPressed: () async {

//                                                    911_1

                                              final blocAdminFoodFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
                                              final form = _formKey.currentState;

                                              print('form: $_formKey.currentState');
                                              print('at onPressed ');


                                              //   the method 'validate' isn't defined for the class 'State'

                                              if (form.validate()) {
                                                form.save();

                                                _scaffoldKey.currentState.showSnackBar(
                                                  new SnackBar(duration: new Duration(seconds: 5), content:Container(
                                                    child:
                                                    new Row(
                                                      children: <Widget>[
                                                        new CircularProgressIndicator(),
                                                        new Text("uploading food data....",style:
                                                        TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                      ],
                                                    ),
                                                  )),);

//                                            showDialog(
//                                                context: context,
//                                                builder: (BuildContext context) {
//                                                  return Center(child: CircularProgressIndicator(),);
//                                                });

                                                if (_image == null) {
                                                  _showDialogImageNotAdded(context);
                                                  return Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AdminFirebaseFood()));
                                                }




                                                /*
                                                      await _itemData
                                                          .save();

                                                      // invokes the method in ItemData class.
*/
                                                int successValue=  await blocAdminFoodFBase.save();





                                                if(successValue==0){


                                                  _scaffoldKey.currentState.showSnackBar(
                                                    new SnackBar(duration: new Duration(seconds: 2), content:Container(
                                                      child:
                                                      new Row(
                                                        children: <Widget>[
                                                          new CircularProgressIndicator(),
                                                          new Text("Something went wrong, Try VPN.",style:
                                                          TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                        ],
                                                      ),
                                                    )),);
                                                }
                                                // }
                                                else {

                                                  _scaffoldKey.currentState.showSnackBar(
                                                    new SnackBar(duration: new Duration(seconds: 2), content:Container(
                                                      child:
                                                      new Row(
                                                        children: <Widget>[
                                                          new CircularProgressIndicator(),
                                                          new Text("Something went wrong, Try VPN.",style:
                                                          TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                                        ],
                                                      ),
                                                    )),);


                                                }
                                              }
                                              else{

                                                Scaffold.of(context)
                                                    .showSnackBar(
                                                  SnackBar(content: Row(
                                                    children: [
                                                      Icon(Icons.thumb_up),
                                                      SizedBox(width: 20),
                                                      Expanded(child: Text(
                                                        "Please check the fields",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors
                                                                .lightBlueAccent,
                                                            backgroundColor: Colors
                                                                .deepOrange),
                                                      ),),
                                                    ],),
                                                    duration: Duration(seconds: 4),
                                                  ),
                                                );
                                              }

                                            }

                                        )
                                    ),
                                  ]

                              )

                          )
                  );

                },
              )
          )
      );
    }
  }
  _showDialog(BuildContext context) {

    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }

  _showDialogImageNotAdded(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Please Add an Image.')));
  }

/*
  _showSpinkit (BuildContext context) {
    final spinkit = SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    );

    return spinkit;
  }

  */




}

