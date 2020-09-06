
// dependency files
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodgallery/src/BLoC/AdminFirebaseIngredientBloc.dart';
import 'package:foodgallery/src/BLoC/bloc_provider.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:shared_preferences/shared_preferences.dart';

// Screen files.
//import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/screens/foodGallery/foodgallery2.dart';
//import 'package:foodgallery/src/screens/workspace_spinkit.dart';

// model, dummy data file:

//import '../../models/itemData.dart';

//import '../../models/itemData.dart';



//final Firestore firestore = Firestore();

class CategoryItem {
  CategoryItem(this.index,this.name,this.icon);
  final int index;
  final String name;
  final Icon icon;

}



class AdminFirebaseIngredient extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;

  final Firestore firestore = Firestore.instance;

  AdminFirebaseIngredient({Key key, this.child}) : super(key: key);
  _AddDataState createState() => _AddDataState();

}


class _AddDataState extends State<AdminFirebaseIngredient> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _AddDataState({firestore});
  File _image;

  //  final _formKey = GlobalKey();

  final _formKey = GlobalKey<FormState>();

  //  final _itemData = new ItemData();

//  final _ingredientData = IngredientData();

  int _currentCategory= 0;
  bool _loadingState = false;


  Future getImage() async {

    var image = await ImagePicker.pickImage(
//        source: ImageSource.camera
        source:ImageSource.gallery
    );

    print('_image initially: $_image');
    print('image at getImage: $image');

    final blocAdminIngredientFBase = BlocProvider.of<AdminFirebaseIngredientBloc>(context);



//


    //The method setImage isn't defined for the class 'ItemData';
/*
    _ingredientData.setImage = image;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();

    _ingredientData.setUser =user.email;

    setState(() {
      _image = image;
    });

    */


    blocAdminIngredientFBase.setImage(image);



    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();


    blocAdminIngredientFBase.setUser(user.email);

//    _itemData.setUser =user.email;


    setState(() {
      _image = image;
    });
  }

//  final Firestore firestore = Firestore.instance;

//  CollectionReference get messages => firestore.collection('messages');


  @override
  Widget build(BuildContext context) {

    final blocAdminIngredientFBase =
    /*final blocAdminFoodFBase = */ BlocProvider.of<AdminFirebaseIngredientBloc>(context);


//    scaffoldKey
    if(_loadingState ==true){
      return new Scaffold(
        key:_scaffoldKey,
        backgroundColor: Colors.blue,
        body:Center(
          child:Text('...'),
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
//              ....
            child: StreamBuilder<NewIngredient>(
                stream: blocAdminIngredientFBase.thisIngredientItemStream, //null,
                initialData: blocAdminIngredientFBase.getCurrentIngredientItem,
                builder: (context, snapshot) {
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


                        final NewIngredient currentIngredient = snapshot.data;





//              ....
//    return Builder(
//    builder: (context) =>
//    Form(

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
                                            InputDecoration(labelText: 'Ingredient Name'),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter the Ingredient Name';
                                              }
                                            },
                                            onSaved: (val) =>
                                                blocAdminIngredientFBase.setItemName(val),
//                                      blocAdminFoodFBase.setItemName(val),
//                                      setState(() => _ingredientData.ingredientName = val),
                                          ),



                                          /*
                                    SwitchListTile(
                                      title: const Text('Is Available'),
                                      value:currentIngredient.isAvailable,
                                      onChanged: (bool val) =>
                                          setState(() =>
                                              blocAdminIngredientFBase.setIsAvailable(val)),
//    _itemData.isAvailable = val)
                                    ),
//
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
                                                              new Text("uploading ingredient data....",style:
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
                                                                    AdminFirebaseIngredient()));
                                                      }




/*
                                                int loginRequiredStatus = await _ingredientData
                                                    .save(); // invokes the method in ItemData class.
*/
                                                      int loginRequiredStatus =  await blocAdminIngredientFBase.save();


                                                      if (loginRequiredStatus == 1) {
                                                        return Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    FoodGallery2())


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
                        );
                      };
                  }
                }
            ),
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

}


class SpinkitTest extends StatelessWidget {
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
            child: LinearProgressIndicator(),

            //WorkspaceSpinkit(),
          ),
        ),
      ),
    );

  }
}
