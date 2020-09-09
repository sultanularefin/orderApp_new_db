
// dependency files
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/NewCategoryItem.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';

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

    setState(() {
      _currentCategory =categoryValue;
    });

  }



  Widget _buildOneCheckBoxCheeseItem(CheeseItem ct, int index) {
    return Container(
        child: ct.isSelected ==true

            ? Container(
          margin: EdgeInsets.fromLTRB(2, 0, 2, 3),
          width: displayWidth(context) / 2.8,
          //color:Colors.red,
          child: RaisedButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xffFFE18E),
            elevation: 2.5,
            shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Color(0xffF7F0EC),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(35.0),
            ),

            child: Container(
//              alignment: Alignment.center,
              child:
              CheckboxListTile(
                  title: Text('${ct.cheeseItemName}'),
//                  value: _itemData.passions[ItemData.PassionCooking],
                  value: ct.isSelected,
                  onChanged: (val) {


                    final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
                    blocAdminIngredientFBase.toggoleMultiSelectCheeseValue(index);

                  }

              ),



            ),
            onPressed: () {

              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectCheeseValue(index);

            },
          ),
        )
            : Container(

          margin: EdgeInsets.fromLTRB(2, 0, 2, 3),
          // margin: EdgeInsets.fromLTRB(5, 2, 5, 5),
          width: displayWidth(context) / 2.8,
          //color:Colors.red,
          child: OutlineButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xffFEE295),
            // clipBehavior:Clip.hardEdge,

            borderSide: BorderSide(
              color: Color(0xff53453D), // 0xff54463E
              style: BorderStyle.solid,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: Container(

              child:

              CheckboxListTile(
                  title: Text('${ct.cheeseItemName}'),

                  value: ct.isSelected,
                  onChanged: (val) {


                    final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
                    blocAdminIngredientFBase.toggoleMultiSelectCheeseValue(index);

                  }

              ),
            ),
            onPressed: () {

              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectCheeseValue(index);

            },
          ),
        ));
  }




  Widget _buildOneCheckBoxIngredient(NewIngredient ct, int index) {
    return Container(
        child: ct.isDefault ==true

            ? Container(
          margin: EdgeInsets.fromLTRB(2, 0, 2, 3),
          width: displayWidth(context) / 2.8,
          //color:Colors.red,
          child: RaisedButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xffFFE18E),
            elevation: 2.5,
            shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Color(0xffF7F0EC),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(35.0),
            ),

            child: Container(
//              alignment: Alignment.center,
              child:
              CheckboxListTile(
                  title: Text('${ct.ingredientName}'),
//                  value: _itemData.passions[ItemData.PassionCooking],
                  value: ct.isDefault,
                  onChanged: (val) {


                    final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
                    blocAdminIngredientFBase.toggoleMultiSelectSauceItemValue(index);

                  }

              ),



            ),
            onPressed: () {

              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectSauceItemValue(index);

            },
          ),
        )
            : Container(

          margin: EdgeInsets.fromLTRB(2, 0, 2, 3),
          // margin: EdgeInsets.fromLTRB(5, 2, 5, 5),
          width: displayWidth(context) / 2.8,
          //color:Colors.red,
          child: OutlineButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xffFEE295),
            // clipBehavior:Clip.hardEdge,

            borderSide: BorderSide(
              color: Color(0xff53453D), // 0xff54463E
              style: BorderStyle.solid,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: Container(

              child:

              CheckboxListTile(
                  title: Text('${ct.ingredientName}'),

                  value: ct.isDefault,
                  onChanged: (val) {


                    final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
                    blocAdminIngredientFBase.toggoleMultiSelectSauceItemValue(index);

                  }

              ),
            ),
            onPressed: () {

              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectSauceItemValue(index);


            },
          ),
        ));
  }




  Widget _buildOneCheckBoxSauceItem(SauceItem ct, int index) {
    return Container(
        child: ct.isSelected ==true

            ? Container(
          margin: EdgeInsets.fromLTRB(2, 0, 2, 3),
          width: displayWidth(context) / 2.8,
          //color:Colors.red,
          child: RaisedButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xffFFE18E),
            elevation: 2.5,
            shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Color(0xffF7F0EC),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(35.0),
            ),

            child: Container(

              child:
              CheckboxListTile(
                  title: Text('${ct.sauceItemName}'),

                  value: ct.isSelected,
                  onChanged: (val) {


                    final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
                    blocAdminIngredientFBase.toggoleMultiSelectSauceItemValue(index);

                  }

              ),



            ),
            onPressed: () {

              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectSauceItemValue(index);

            },
          ),
        )
            : Container(

          margin: EdgeInsets.fromLTRB(2, 0, 2, 3),
          // margin: EdgeInsets.fromLTRB(5, 2, 5, 5),
          width: displayWidth(context) / 2.8,
          //color:Colors.red,
          child: OutlineButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xffFEE295),
            // clipBehavior:Clip.hardEdge,

            borderSide: BorderSide(
              color: Color(0xff53453D), // 0xff54463E
              style: BorderStyle.solid,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: Container(

              child:

              CheckboxListTile(
                  title: Text('${ct.sauceItemName}'),
                  value: ct.isSelected,
                  onChanged: (val) {

                    final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
                    blocAdminIngredientFBase.toggoleMultiSelectSauceItemValue(index);


                  }

              ),
            ),
            onPressed: () {

              final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
              blocAdminIngredientFBase.toggoleMultiSelectSauceItemValue(index);


            },
          ),
        ));
  }



  Future getImage() async {


    final blocAdminFoodFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);

    var image = await ImagePicker.pickImage(
//        source: ImageSource.camera
        source:ImageSource.gallery
    );


    print('_image initially: $_image');
    print('image at getImage: $image');

    print('_currentCategory: $_currentCategory');



    blocAdminFoodFBase.setImage(image);





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
              const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 10.0),
              child: StreamBuilder<FoodItemWithDocID>(
                stream: blocAdminFoodFBase.thisFoodItemStream, //null,
                initialData: blocAdminFoodFBase.getCurrentFoodItem,
                builder: (context, snapshot) {
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
                                        }, child: new CircleAvatar(

                                          backgroundColor: Colors.lightBlueAccent,
                                          radius: 120.0,

                                          child: new Container(
                                              padding: const EdgeInsets.all(0.0),
                                              child: new Container(
                                                child: Text('No foodItem selected.',

                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                                    color: Colors.redAccent,
                                                    fontFamily: 'Itim-Regular',

                                                  ),
                                                ),
                                              )

                                          )
                                      ),
                                      ) : GestureDetector(
                                        onTap: () {
                                          getImage();

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
                                      InputDecoration(labelText: 'foodItem Name',

                                        labelStyle:TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                          color: Colors.redAccent,
                                          fontFamily: 'Itim-Regular',

                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter the foodItem Name';
                                        }
                                      },
                                      onSaved: (val) =>
                                          blocAdminFoodFBase.setItemName(val),

                                    ),

                                    /*
                                    Container(child:Text('${currentFood.sequenceNo}',

                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                          color: Colors.redAccent,
                                          fontFamily: 'Itim-Regular',

                                        )
                                    ),
                                    ),

                                    */

                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 20),

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


                                            SizedBox(width: 10),

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
                                                            .setCategoryValue(_currentCategory,
                                                          /*
                                                            allCategories[_currentCategory]
                                                                .categoryName,
                                                            allCategories[_currentCategory]
                                                                .fireStoreFieldName */

                                                        );
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

                                      child: Text('select ingredients for food: ',

                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 29,
                                            fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                            color: Colors.redAccent,
                                            fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ),


                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 50, 0, 20),

                                      child:


                                      StreamBuilder<List<NewIngredient>>(
                                        stream: blocAdminFoodFBase.getExtraIngredientItemsStream ,
                                        initialData:blocAdminFoodFBase.getAllExtraIngredients,
                                        builder: (context, snapshot) {
                                          final List<NewIngredient> allNewIngredients = snapshot.data;
                                          logger.w(' allNewIngredients.length: ${ allNewIngredients.length}');
                                          return

                                            GridView.builder(
                                              itemCount: allNewIngredients.length,
                                              gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                                                //Above to below for 3 not 2 Food Items:
                                                maxCrossAxisExtent: 220,
                                                mainAxisSpacing: 10, // H  direction
                                                crossAxisSpacing: 20,
                                                childAspectRatio: 200 / 110, /* (h/vertical)*/
                                              ),
                                              shrinkWrap: true,

//        reverse: true,
                                              itemBuilder: (_, int index) {

                                                return _buildOneCheckBoxIngredient(
                                                    allNewIngredients[index], index);
                                              },
                                            );


                                        }

                                        ,
                                      ),
                                    ),



                                    // select cheese begins here....

                                    Container(

                                      child: Text('select cheese for food: ',

                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 29,
                                            fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                            color: Colors.redAccent,
                                            fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ),


                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 50, 0, 20),

                                      child:


                                      StreamBuilder<List<CheeseItem>>(
                                        stream: blocAdminFoodFBase.getCheeseItemsStream ,
                                        initialData:blocAdminFoodFBase.getAllCheeseItemsAdminFoodUpload,
                                        builder: (context, snapshot) {
                                          final List<CheeseItem> allCheeseItems = snapshot.data;

                                          logger.w('allCheeseItems.length: ${allCheeseItems.length}');

                                          return

                                            GridView.builder(
                                              itemCount: allCheeseItems.length,
                                              gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                                                //Above to below for 3 not 2 Food Items:
                                                maxCrossAxisExtent: 220,
                                                mainAxisSpacing: 10, // H  direction
                                                crossAxisSpacing: 20,
                                                childAspectRatio: 200 / 110, /* (h/vertical)*/
                                              ),
                                              shrinkWrap: true,

//        reverse: true,
                                              itemBuilder: (_, int index) {

                                                return _buildOneCheckBoxCheeseItem(
                                                    allCheeseItems[index], index);
                                              },
                                            );


                                        }

                                        ,
                                      ),
                                    ),


                                    // select cheese ends here....


                                    // select sauce begins here....
                                    Container(

                                      child: Text('select Sauces for food: ',

                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 29,
                                            fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                            color: Colors.redAccent,
                                            fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ),


                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 50, 0, 20),

                                      child:


                                      StreamBuilder<List<SauceItem>>(
                                        stream: blocAdminFoodFBase.getSauceItemsStream ,
                                        initialData:blocAdminFoodFBase.getAllSauceItemsFoodUploadAdmin,
                                        builder: (context, snapshot) {
                                          final List<SauceItem> allSauces = snapshot.data;

                                          logger.w('allSauces.length: ${allSauces.length}');

                                          return

                                            GridView.builder(
                                              itemCount: allSauces.length,
                                              gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                                                //Above to below for 3 not 2 Food Items:
                                                maxCrossAxisExtent: 220,
                                                mainAxisSpacing: 10, // H  direction
                                                crossAxisSpacing: 20,
                                                childAspectRatio: 200 / 110, /* (h/vertical)*/
                                              ),
                                              shrinkWrap: true,

//        reverse: true,
                                              itemBuilder: (_, int index) {

                                                return _buildOneCheckBoxSauceItem(
                                                    allSauces[index], index);
                                              },
                                            );


                                        }

                                        ,
                                      ),
                                    ),

                                    // select sauce ends here....


                                    Container(
                                      height: 100,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        child: RaisedButton(
                                            color: Colors.yellowAccent,
                                            child: Text('Save',
                                              style: TextStyle(
                                                  fontSize: 40, color: Colors
                                                  .lightBlueAccent),),
                                            onPressed: () async {

//                                                    911_1

                                              final blocAdminFoodFBase = BlocProvider.of<AdminFirebaseFoodBloc>(context);
                                              final form = _formKey.currentState;

                                              print('form: $_formKey.currentState');
                                              print('at onPressed ');

                                              final FirebaseAuth _auth = FirebaseAuth.instance;
                                              final FirebaseUser user = await _auth.currentUser();


                                              blocAdminFoodFBase.setUser(user.email);


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

                                                /*
                                                if (_image == null) {
                                                  _showDialogImageNotAdded(context);
                                                  return Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AdminFirebaseFood()));
                                                }

                                                */



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
                                                          new Text("food item uploaded in DB....",style:
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

