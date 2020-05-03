import 'package:flutter/material.dart';



// above are local files i.e. pages .
import 'package:foodgallery/src/identity/loginPage.dart';
import 'package:foodgallery/src/identity/signup.dart';
import 'package:foodgallery/src/screens/drawerScreen/drawerScreen.dart';
import 'package:foodgallery/src/screens/homeScreen/food_gallery.dart';
// above are local file.


// 3rd party packages:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';


//TODO STATE ful widget not required
//class MyApp extends StatelessWidget {
class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  // Login Button.
  Widget _submitButton() {
    return InkWell(
      onTap: () {

        //              Scaffold.of(context).showSnackBar(
        //                  SnackBar(content: Row(
        //                    children:[
        //                      Icon(Icons.thumb_up),
        //                      SizedBox(width:20),
        //                      Expanded(child: Text("Hello",
        //                        style: TextStyle(fontSize: 20,
        //                            color: Colors.lightBlueAccent,
        //                            backgroundColor:Colors.deepOrange ),
        //                      ),),],),
        //                    duration: Duration(seconds: 4),
        //                  )
        //              );
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
        ),
      ),
    );
  }


  // Register.
  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          'Register now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Quick login with Touch ID',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(Icons.fingerprint, size: 90, color: Colors.white),
            SizedBox(
              height: 20,
            ),
            Text(
              'Touch ID',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ));
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'd',
//          style: TextStyle(fontStyle: FontStyle.italic),
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'ev',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'rnz',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ]),
    );
  }


  loadUser(/*String uid*/) async {

    print('at loadUser of Welcome Page');
    SharedPreferences prefs = await SharedPreferences.getInstance();

//    ??=
//    Assign the value only if the variable is null



    final resultString =  prefs.getString("userInfo");

    print('resultString in Welcome Page $resultString');

    if(resultString!=null) {
      Map<String, dynamic> user = jsonDecode(
          resultString
      );

      print('Howdy, ${user['email']}!');


      print('password ${user['password']}.');

      print('result_in_prefs: WelCome Page ' + resultString);

      String email = user['email'];

      String passWord = user['password'];
      String uid = user['uid'];

      print('email $email');
      print('password $passWord');
      print('uid $passWord');

      if ((email != null) && (passWord != null)) {
        print("email && password found");
        return Navigator.push(context,
            MaterialPageRoute(builder: (context) => drawerScreen())


        );
      }
    }
    print("not found");

    //1 means SharedPreference not empty.

  }


  //  assert(user.displayName != null);


  @override
  void initState(){

    print('at initState of welcomePage');
    super.initState();
    loadUser();
  }




  @override
  Widget build(BuildContext context) {

    print('width: ${MediaQuery.of(context).size.width}');
    print('Height: ${MediaQuery.of(context).size.height}');

    print('at build of welcomePage');
    return Scaffold(
      body:SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
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
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xfffbb448), Color(0xffe46b10)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _title(),
              SizedBox(
                height: 80,
              ),
              _submitButton(),
              SizedBox(
                height: 20,
              ),
              _signUpButton(),
              SizedBox(
                height: 20,
              ),
              _label()
              // Touch
            ],
          ),
        ),
      ),
    );
  }
}
