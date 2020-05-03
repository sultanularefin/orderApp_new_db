import 'package:flutter/material.dart';
import 'package:foodgallery/src/identity/signup.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Widget/bezierContainer.dart';
import 'package:foodgallery/src/screens/drawerScreen/drawerScreen.dart';
//import 'package:foodgallery/src/screens/homeScreen/admin_firebase_food.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



//  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String emailState='';
  String passwordState = '';

  void setEmailState( text){

    print(text);
    setState(() {
      emailState = text;
    });
  }


  void setPasswordState( text){
    print(text);
    setState(() {
      passwordState = text;
    });
  }





  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;





  _saveUser(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

//    ??=
//    Assign the value only if the variable is null

    Map<String, dynamic> toJson() => {
      'name': emailState,
      'password': passwordState,
      'uid': uid,
    };


    print('setString method going to be called where key is userInfo');
    prefs.setString('userInfo', jsonEncode({
      'email': emailState,
      'password': passwordState,
      'uid': uid,
    })).then((onValue) =>{

    });

    print('user set in mobile storage');



    final resultString =  prefs.getString("userInfo");

    Map<String,  dynamic> user = jsonDecode(
        resultString
    );

    print('Howdy, ${user['email']}');

    print('password ${user['password']}');
    print('uid from storage: ${user['uid']}');

    print('result_in_prefs: ' + resultString);

  }


  Future<FirebaseUser> _handleSignIn() async {
//    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken,
//    );



    print('emailState:' + emailState);
    print('passwordState:' + passwordState);

    AuthResult result = await _auth.signInWithEmailAndPassword(email:
    emailState,password: passwordState);

    print('result: ' + result.user.uid);

    print('result: ' + result.user.email);

    FirebaseUser user = result.user;






    assert(user.email != null);
    //  assert(user.displayName != null);
    assert(!user.isAnonymous);
//    final IdTokenResult uid = await user.getIdToken();

    print("email: "+ user.email);
    print('uid: ${user.uid} ');

    String uid =user.uid;


    _saveUser(uid);


    return user;


    //    print("signed in " + user.displayName);


    //    return user;
    //
  }

  //functions marked 'async' must have a return type assignable to 'future'
  Future<bool> loadUser(/*String uid*/) async {

    print('at loadUser of Welcome Page');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //    ??=
    //    Assign the value only if the variable is null



    final resultString =   prefs.getString("userInfo");

    print('resultString in login Page $resultString');


    if(resultString == null) {

      return true;
    }
    print("found"); // thus nothing to return.
    return false;

    //1 means SharedPreference not empty.

  }


  void _showSettingsPanel() async{

    var loginRequiredStatus = await loadUser();

    print('at _showSettingsPane of Login Page: ');

    print("loginRequiredStatus: $loginRequiredStatus");



    if(loginRequiredStatus){

      //            showModalBottomSheet(context: context, builder:(context){
      //              return Container(
      //                padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 60.0),
      //                child: Text('Please Login',
      //                  style: TextStyle(
      //                      fontSize: 20,
      //                      color: Colors.redAccent,
      //                      backgroundColor:Colors.lightBlue )),
      //
      //              ); // Container
      //            });

      //      important might be needed for future.
      //            return Row(
      //              children:[
      //                Icon(Icons.thumb_up),
      //                SizedBox(width:20),
      //                Expanded(child: Text("Hello",
      //                  style: TextStyle(fontSize: 20,
      //                      color: Colors.lightBlueAccent,
      //                      backgroundColor:Colors.deepOrange ),
      //                ),),],); // Container
      //    });

      //      ABOVE ONE DISPLAYS BUT THE STYLE IS NOT GOOD.

      //      Scaffold.of(context).showSnackBar(
      //          SnackBar(content: Row(
      //            children:[
      //              Icon(Icons.thumb_up),
      //              SizedBox(width:20),
      //              Expanded(child: Text("Hello",
      //                style: TextStyle(fontSize: 20,
      //                    color: Colors.lightBlueAccent,
      //                    backgroundColor:Colors.deepOrange ),
      //              ),),],),
      //            duration: Duration(seconds: 4),
      //          )
      //      );

      return;
    };

  }



  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  // email and password input.

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              textInputAction: !isPassword? TextInputAction.done :TextInputAction.done,
              onChanged: (text) {
                !isPassword?
                setEmailState(text):setPasswordState(text);
//                print("First text field: $text");
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xffFFFA5F),
                  filled: true))
        ],
      ),
    );
  }
//  _handleSignIn
  Widget _submitButton() {

    child: return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xfffbb448),
                Color(0xfff7892b)])),

      child: Text(
        'Login',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),


    );
  }


  // or login with facebook.

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
                // tried with 60
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'd',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ev',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'rnz',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email id"),
        _entryField("Password", isPassword: true),
      ],
    );
  }


  @override
  void initState(){

    print('at initState of Login Page');
    super.initState();
    _showSettingsPanel();

  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
//    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                        _title(),
                        SizedBox(
                          height: 50,
                        ),
                        _emailPasswordWidget(),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: (){
                            print("Container clicked");
//                            showDialog(
//                                context: context,
//                                builder: (BuildContext context) {
//                                  return Center(child: CircularProgressIndicator(),);
//                                });


                            _scaffoldKey.currentState.showSnackBar(
                                new SnackBar(duration: new Duration(seconds: 3), content:
                                new Row(
                                  children: <Widget>[
                                    new CircularProgressIndicator(),
                                    new Text("  Signing-In...")
                                  ],
                                ),
                                ));
                            _handleSignIn()
                                .whenComplete(() {

                              print("called when future completes");



                            }
                            ).then((onValue){

                              /* return Navigator.push(context,
                              MaterialPageRoute(builder: (context) => drawerScreen())

                              */
                              //        MaterialPageRoute(builder: (context) => HomeScreen())
                              //
                              //        MaterialPageRoute(builder: (context) => MyHomePage())


                              return  Navigator.of(context).
                              pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  drawerScreen()), (Route<dynamic> route) => false);




                            }).catchError((onError){
                              _scaffoldKey.currentState.showSnackBar(
                                new SnackBar(duration: new Duration(seconds: 2), content:Container(
                                  child:
                                  new Row(
                                    children: <Widget>[
                                      new CircularProgressIndicator(),
                                      new Text("Error: ${onError.message.substring(0,40)}",style:
                                      TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                )),);

                            });



//                            _handleSignIn();
                          },
                          child:  _submitButton(),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password ?',
                              style:
                              TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                        _divider(),
                        _facebookButton(),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _createAccountLabel(),
                  ),
                  Positioned(top: 40, left: 0, child: _backButton()),
                  Positioned(
                      top: -MediaQuery.of(context).size.height * .15,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: BezierContainer())
                ],
              ),
            )
        )
    );
  }
}
