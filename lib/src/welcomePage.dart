import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';



//import 'package:foodgallery/src
// above are local files i.e. pages .
import 'package:foodgallery/src/identity/loginPage.dart';
import 'package:foodgallery/src/identity/signup.dart';
//import 'package:foodgallery/src/screens/drawerScreen/drawerScreen.dart';
//import 'package:foodgallery/src/screens/homeScreen/food_gallery.dart';
// above are local file.


// 3rd party packages:

//import 'package:google_fonts/google_fonts.dart';



//TODO STATE ful widget not required
//class MyApp extends StatelessWidget {
/*  Block related Files BELOW */

import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/identity_bloc.dart';
import 'package:foodgallery/src/screens/foodGallery/foodgallery2.dart';

/*  Block related Files ABOVE */
class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  // Login Button.
  Widget _loginButton() {
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

//            BlocProvider<FoodItemDetailsBloc>(
//              bloc: FoodItemDetailsBloc(
//                  oneFoodItem,
//                  allIngredients),
//
//
//              child: FoodItemDetails2()
//
//              ,),
            context, MaterialPageRoute(builder: (context) => LoginPage())

        );
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



  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'F',
//          style: TextStyle(fontStyle: FontStyle.italic),
//            style: GoogleFonts.portLligatSans(
//            textStyle: Theme.of(context).textTheme.display1,
//            fontSize: 30,
//            fontWeight: FontWeight.w700,
//            color: Colors.white,
//          ),
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'ood',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Gallery',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ]),
    );
  }


  @override
  void initState(){

    // possible scenarios:


    // 1. no local storage, (app deleted and reinstalled || or first time user ) go to Login page.
    // MORE AT HERE : localStorageCheck();

    // 2. if the email found in loCAL STORAGE, LOCAL STORAGE ARE CREATED ONLY WHEN SUCCESSFUL LOGIN WERE MADE WITH
    // CERTAIN EMAIL AND PASSWORD.
    // THUS THERE COULD BE 2 SCENARIOS{
    /*
     1. CHECK WITH THIS CREDENTIALS WITH FIRE BASE AUTH IF SUCCESS GO TO FIREBASE PAGE.
     2. ADMIN CAN DELETE THE USER FROM FIREBASE AUTH LIST THEN USER CAN'T LOGIN AND HE NEEDS TO LOGIN AGAIN WITH THE
     ADMIN RPOVIDE USER NAME AND PASSWROD.

     3. I THINK I IMPLEMENTED ALL BUT SOME NETWORKING RELATED CODE LIKE connectionState etc needs to be checked again.
     in the future (might not need now.).

     */
    localStorageCheck();

    //  this requred since stream can only handle one kind of variale. In this page FirebaseUser.

    //  // check paper why we need it.
    // check the data Type at here.
    /*
    stream: identityBloc.getCurrentFirebaseUserStream,
            initialData: identityBloc.getCurrentFirebaseUser,
    */

    super.initState();

  }

  // Future<void> return type .  ??
  localStorageCheck () async{

    // 3 scenarios.



    print('< >   <   >   <    >  :: // ::  // at here: localStorageCheck');
    final identityBlockinInitState = BlocProvider.of<IdentityBloc>(context);

    bool x= await identityBlockinInitState.checkUserinLocalStorage();

    if (x==false){

      return Navigator.push(

          context, MaterialPageRoute(builder: (context) => LoginPage())

      );
    }

  }







  @override
  Widget build(BuildContext context) {

    final identityBloc = BlocProvider.of<IdentityBloc>(context);


    print('width: ${MediaQuery.of(context).size.width}');
    print('Height: ${MediaQuery.of(context).size.height}');

    print('at build of welcomePage');
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child:StreamBuilder<FirebaseUser>(

            stream: identityBloc.getCurrentFirebaseUserStream,
            initialData: identityBloc.getCurrentFirebaseUser,
            builder: (context, snapshot) {

              print('snapshot.hasData: ${snapshot.hasData}');


              if(snapshot.connectionState == ConnectionState.done) {

                if (snapshot.hasError) {
                  return  Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('something went wrong'),
                    ),
                  );
                }

                if (snapshot.hasData) {
                  print('snapshot.hasData is ${snapshot
                      .hasData} in Welcome page ');
                  /*
                return
                  BlocProvider<FoodGalleryBloc>(
                    bloc: FoodGalleryBloc(),
                    child: FoodGallery2(),
                  );
                */

                  return (
                      BlocProvider<FoodGalleryBloc>(
                          bloc: FoodGalleryBloc(),
                          child: FoodGallery2()

                      )
                  );
                }
                else{

                  return LoginPage();

                }
              }

              // (snapshot.connectionState == ConnectionState.active)
              //  inclued in else statement
//                else if (snapshot.connectionState == ConnectionState.active)  {


              else{

                print('at else of this condition (snapshot.connectionState == ConnectionState.done) ');

                return Center(
                  child: Column(
                    children: <Widget>[

                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: new CircularProgressIndicator(backgroundColor: Colors.lightGreenAccent)
                        ),
                      ),
                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: new CircularProgressIndicator(backgroundColor: Colors.yellow,)
                        ),
                      ),
                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: new CircularProgressIndicator(backgroundColor: Colors.redAccent )
                        ),
                      ),
                    ],
                  ),
                );
              }


              
            }
        ),

      ),

    );
  }
}
