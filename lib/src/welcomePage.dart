import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';



//import 'package:foodgallery/src
// above are local files i.e. pages .
import 'package:foodgallery/src/identity/loginPage.dart';
import 'package:foodgallery/src/identity/signup.dart';
//import 'package:foodgallery/src/screens/drawerScreen/drawerScreen.dart';
//import 'package:foodgallery/src/screens/homeScreen/food_gallery.dart';
// above are local file.


// 3rd party packages:

//import 'package:google_fonts/google_fonts.dart';

import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

//TODO STATE ful widget not required
//class MyApp extends StatelessWidget {
/*  Block related Files BELOW */

import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/identity_bloc.dart';
import 'package:foodgallery/src/screens/foodGallery/foodgallery2.dart';

import 'package:foodgallery/src/BLoC/app_bloc.dart';
import 'package:foodgallery/src/BLoC/bloc_provider2.dart';
import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';




/*  Block related Files ABOVE */
class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {


  // Login Button.






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

    final appBloc = AppBloc();
    final AppBloc appBlockinWelcomePage =appBloc;


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
//              switch (snapshot.connectionState){
//                case ConnectionState.waiting:
//                case ConnectionState.none:
//                return Center(
//                  child: Column(
//                    children: <Widget>[
//
//                      Center(
//                        child: Container(
//                            alignment: Alignment.center,
//                            child: new CircularProgressIndicator(
//                                backgroundColor: Colors.lightGreenAccent)
//                        ),
//                      ),
//                      Center(
//                        child: Container(
//                            alignment: Alignment.center,
//                            child: new CircularProgressIndicator(
//                              backgroundColor: Colors.yellow,)
//                        ),
//                      ),
//                      Center(
//                        child: Container(
//                            alignment: Alignment.center,
//                            child: new CircularProgressIndicator(
//                                backgroundColor: Colors.redAccent)
//                        ),
//                      ),
//                    ],
//                  ),
//                );
//                case ConnectionState.active:
//                case ConnectionState.done:
//              }
//              if(snapshot.error){
//                return  Center(
//                  child: Container(
//                    alignment: Alignment.center,
//                    child: Text('something went wrong'),
//                  ),
//                );
//              }

              print('snapshot.hasData: ${snapshot.hasData}');


              if (snapshot.hasError) {
                return Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('something went wrong'),
                  ),
                );
              }

              if (snapshot.hasData) {
                print('snapshot.hasData is ${snapshot
                    .hasData} in Welcome page ');

                if (snapshot.data is FirebaseUser) {
                  /*
                return
                  BlocProvider<FoodGalleryBloc>(
                    bloc: FoodGalleryBloc(),
                    child: FoodGallery2(),
                  );
                */

                  FoodItemWithDocID emptyFoodItemWithDocID =new FoodItemWithDocID();
                  List<NewIngredient> emptyIngs = [];



//                  FoodItemWithDocID oneFoodItem, List<NewIngredient> allIngsScoped, {int fromWelComePage=0
                  return (
                      BlocProvider2(
                          bloc: AppBloc(),
                          /*
                          child: BlocProvider<FoodItemDetailsBloc>(
                              bloc:FoodItemDetailsBloc(emptyFoodItemWithDocID,emptyIngs ,fromWhichPage:0),
                              child: FoodGallery2()

                          )
                          */
                          child: FoodGallery2()
                      )

                  );
                }
                else {
                  return LoginPage();
                }
              }
              else {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:

                    return Container(
                      margin: EdgeInsets.fromLTRB(0, displayHeight(context)/2, 0, 0),
                      child: Center(
                        child: Column(
                          children: <Widget>[

                            Center(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: new CircularProgressIndicator(
                                      backgroundColor: Colors.lightGreenAccent)
                              ),
                            ),
                            Center(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: new CircularProgressIndicator(
                                    backgroundColor: Colors.yellow,)
                              ),
                            ),
                            Center(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: new CircularProgressIndicator(
                                      backgroundColor: Colors.redAccent)
                              ),
                            ),
                          ],
                        ),
                      ),

                    );
                    break;
                  case ConnectionState.active:
                    return (snapshot.data is FirebaseUser) ?

                    BlocProvider<FoodGalleryBloc>(
                        bloc: FoodGalleryBloc(),
                        child: FoodGallery2()

                    ):LoginPage();
//                  print('at ConnectionState.active of switch');
                    break;

                  case ConnectionState.done:
//                  print('at ConnectionState.done of switch');
//                break;


                    return (snapshot.data is FirebaseUser) ?

                    BlocProvider<FoodGalleryBloc>(
                        bloc: FoodGalleryBloc(),
                        child: FoodGallery2()

                    ):LoginPage();

                    break;
                  default:

                    return (snapshot.data is FirebaseUser) ?

                    BlocProvider<FoodGalleryBloc>(
                        bloc: FoodGalleryBloc(),
                        child: FoodGallery2()

                    ):LoginPage();

                }
              }

            }
        ),

      ),

    );
  }
}
