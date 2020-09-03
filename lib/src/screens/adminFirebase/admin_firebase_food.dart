
// dependency files
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:shared_preferences/shared_preferences.dart';

// Screen files.
// import 'package:fluttercrud/src/screens/homeScreen/food_gallery.dart';
// import 'package:fluttercrud/src/screens/workspace_spinkit.dart';

// model, dummy data file:

import '../../models/itemData.dart';


//import 'package:fluttercrud/src/shared/category_Constants.dart' as CategoryItems;


final Firestore firestore = Firestore();


class CategoryItem {
  CategoryItem(this.index,this.name,this.icon);
  final int index;
  final String name;
  final Icon icon;

}

//class Item {
//  const Item(this.name,this.icon);
//  final String name;
//  final Icon icon;
//}


class AdminFirebaseFood extends StatefulWidget {
//  AdminFirebaseFood({this.firestore});

  final Widget child;

  final Firestore firestore = Firestore.instance;

  AdminFirebaseFood({Key key, this.child}) : super(key: key);
  _AddDataState createState() => _AddDataState();

}


class _AddDataState extends State<AdminFirebaseFood> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _AddDataState({firestore});
  File _image;

  //  final _formKey = GlobalKey();

  final _formKey = GlobalKey<FormState>();

  //  final _itemData = new ItemData();
  final _itemData = ItemData();
  int _currentCategory= 0;
  bool _loadingState = false;


  pizza
  kebab
  jauheliha_kebab_vartaat
  salaatti_kasvis
  lasten_menu
  juomat
  hampurilainen

  final List<CategoryItem> categoryItems = <CategoryItem>[
    CategoryItem(0,'pizza', Icon(Icons.android,color:  const Color(0xFF167F67))),
    CategoryItem(1,'kebab', Icon(Icons.flag, color:  const Color(0xFF167F67))),
    CategoryItem(2,'jauheliha_kebab_vartaat',  Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67),)),
    CategoryItem(3,'salaatti_kasvis',  Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67),)),
    CategoryItem(4,'hampurilainen',Icon(Icons.flag,color:  const Color(0xFF167F67),)),
    CategoryItem(5,'lasten_menu',  Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67),)),
    CategoryItem(6,'juomat',   Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67),)),

  ];



  void set_CategoryValue(int categoryValue){

    print('categoryItems[_currentCategory].name: ${categoryItems[categoryValue].name}');

    _itemData.itemCategoryName  = categoryItems[categoryValue].name;

    setState(() => _currentCategory = categoryValue);


  }
  Future getImage() async {


    var image = await ImagePicker.pickImage(
//        source: ImageSource.camera
        source:ImageSource.gallery
    );

    print('_image initially: $_image');
    print('image at getImage: $image');

    print('_currentCategory: $_currentCategory');


//


    //The method setImage isn't defined for the class 'ItemData';

    _itemData.setImage = image;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();

    _itemData.setUser =user.email;


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




//    scaffoldKey
    if(_loadingState ==true){
      return new Scaffold(
        key:_scaffoldKey,
        backgroundColor: Colors.blue,
        body:Center(
          child:SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : Colors.green,
                ),
              );
            },
          ),
        ),
      );
    }
    else {
      return new Scaffold(
        key:_scaffoldKey,
          appBar: AppBar(title: Text('Admin Firebase')),
          body: Container(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Builder(
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
                                      setState(() => _itemData.itemName = val),
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
                                          child: Text('Item Category: ',
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
                                        Expanded(


                                          child: DropdownButtonFormField(


                                            value: _currentCategory != null ?
                                            categoryItems[_currentCategory]
                                                .index
                                                : categoryItems[0].index,

                                            items: categoryItems.map((oneItem) {
                                              return DropdownMenuItem(


                                                value: oneItem.index,
                                                child: Row(
                                                  children: <Widget>[
                                                    oneItem.icon,
                                                    SizedBox(width: 10,),
                                                    Text(
                                                      oneItem.name,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),

                                                  ],
                                                ),
//                                          child: Text(oneItem.name),
                                              );
                                            }).toList(),
                                            onChanged: (val) =>
                                                set_CategoryValue(val),

//                                      {
//                                        print('val: $val')},


                                          ),),
                                      ]),
//                            Text('Subscribe'),
                                ),

//
                                TextFormField(
                                    decoration:
                                    InputDecoration(
                                        labelText: 'Ingredients are:'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter the Ingredients.';
                                      }
                                    },
                                    onSaved: (val) =>
                                        setState(() =>
                                        _itemData.ingredients = val)),
                                TextFormField(
                                    decoration:
                                    InputDecoration(labelText: 'price In Euro'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter the price in Euro.';
                                      }
                                    },
                                    onSaved: (val) =>
                                        setState(() =>
                                        _itemData.priceInEuro = val)),


                                SwitchListTile(
                                    title: const Text('Is Hot'),
                                    value: _itemData.isHot,
                                    onChanged: (bool val) =>
                                        setState(() => _itemData.isHot = val)),
                                SwitchListTile(
                                    title: const Text('Is Available'),
                                    value: _itemData.isAvailable,
                                    onChanged: (bool val) =>
                                        setState(() =>
                                        _itemData.isAvailable = val)),


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
                                        onPressed: () async {
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





                                            int loginRequiredStatus = await _itemData
                                                .save(); // invokes the method in ItemData class.


                                            if (loginRequiredStatus == 1) {
                                              return Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FoodGallery())


                                              );
                                            }
                                            else{
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
                                          else {
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
                                        },
                                        child: Text('Save',
                                          style: TextStyle(
                                              fontSize: 20, color: Colors
                                              .lightBlueAccent),)
                                    )
                                ),
                              ]

                          )

                      )
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




}


class spinkitTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpinKit Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        body: SafeArea(

          child: Center(
            child: WorkspaceSpinkit(),
          ),
        ),
      ),
    );

  }
}

//Positioned.fill(

//
//child: Stack(
//children: <Widget>[
//Align(
//child: LayoutBuilder(
//builder: (context, _) {
//return IconButton(
//icon: Icon(Icons.play_circle_filled),
//iconSize: 50.0,
//onPressed: () {
//Navigator.push(
//context,
//MaterialPageRoute<void>(
//builder: (BuildContext context) => ShowCaseSpinkit(),
//fullscreenDialog: false,
//),
//);
//},
//);
//},
//),
//alignment: Alignment.bottomCenter,
//),