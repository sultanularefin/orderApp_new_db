import 'package:flutter/material.dart';
import 'package:foodgallery/src/identity/loginPage.dart';
import 'package:logger/logger.dart';

import 'package:foodgallery/src/BLoC/app_bloc.dart';
import 'package:foodgallery/src/BLoC/bloc_provider2.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';
import 'package:foodgallery/src/BLoC/identity_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/welcomePage.dart';
//import 'package:foodgallery/src/screens/foodGallery/food_gallery.dart';
//import 'package:google_fonts/google_fonts.dart';

import 'src/screens/foodGallery/foodgallery2.dart';

//import 'src/welcomePage.dart';


//import 'package:foodgallery/src/
import 'package:foodgallery/src/BLoC/bloc_provider.dart';
//import 'package:foodgallery/src/BLoC/favorite_bloc.dart';
import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';


void main() => runApp(MyApp());




class MyApp extends StatefulWidget {
  // This widget is the root of your application.



  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  List<NewIngredient> welcomPageIngredients;

  final logger = Logger(
    printer: PrettyPrinter(),
  );



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
  Future<void> localStorageCheck () async{

    // 3 scenarios.



    print('< >   <   >   <    >  :: // ::  // at here: localStorageCheck');

//    final identityBlocInvokerAppBlockWelcomPageInitState =
//        BlocProvider2.of(context).getIdentityBlocsObject;
    final identityBlockinInitStateMainPage = BlocProvider.of<IdentityBloc>(context);

    bool x= await identityBlockinInitStateMainPage.checkUserinLocalStorage();

    if (x==false){

      logger.e('going to login page from main page');
      return Navigator.push(

          context, MaterialPageRoute(builder: (context) => LoginPage())

      );
    }

    else{

      logger.e('returning from init State of main page');
      // await setAllIngredients();
      return;
    }

  }


  /*
  Future<void> setAllIngredients() async {

    debugPrint("Entering in retrieveIngredients1");

//    final bloc = BlocProvider.of<FoodGalleryBloc>(context);

//    final bloc = BlocProvider2.of(context).getFoodGalleryBlockObject;
//    await bloc.getAllIngredients();

    /*
    final identityBlockinInitState = BlocProvider.of<IdentityBloc>(context);
    await identityBlockinInitState.getAllIngredients();
    List<NewIngredient> test = identityBlockinInitState.allIngredients;

    */
//    final bloc = BlocProvider2.of(context).getFoodGalleryBlockObject;
    final identityBlocInvokerAppBlockWelcomPageInitState = BlocProvider2.of(context).getIdentityBlocsObject;
    await identityBlocInvokerAppBlockWelcomPageInitState.getAllIngredients();
    List<NewIngredient> test = identityBlocInvokerAppBlockWelcomPageInitState.allIngredients;


//    List<NewIngredient> test = bloc.allIngredients;

//    print(' ^^^ ^^^ ^^^ ^^^ ### test: $test');

    print('done: ');


//    final identityBlockinInitState = BlocProvider.of<IdentityBloc>(context);
//    await identityBlockinInitState.getAllIngredients();
//    List<NewIngredient> test = identityBlockinInitState.allIngredients;

//    dynamic normalPrice = oneFoodItemandId.sizedFoodPrices['normal'];
//    double euroPrice1 = tryCast<double>(normalPrice, fallback: 0.00);

    setState(()
    {
      logger.i('_allIngredientState length : ${test.length}');
      welcomPageIngredients = test;
//      priceByQuantityANDSize = euroPrice1;
//      initialPriceByQuantityANDSize = euroPrice1;
    }
    );



  }

  */

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    FoodItemWithDocID emptyFoodItemWithDocID =new FoodItemWithDocID();
//    List<NewIngredient> _allIngredientState=[];
    List<NewIngredient> emptyIngs = [];

    /*
      return (
                      BlocProvider2(/*thisAllIngredients2:welcomPageIngredients, */
                          bloc: AppBloc(emptyFoodItemWithDocID, welcomPageIngredients,
                              fromWhichPage:0),
                          /*
                          child: BlocProvider<FoodItemDetailsBloc>(
                              bloc:FoodItemDetailsBloc(emptyFoodItemWithDocID,emptyIngs ,fromWhichPage:0),
                              child: FoodGallery2()

                          )
                          */
                          child: FoodGallery2()
                      )

                  );
    */
    return
      BlocProvider<IdentityBloc>(
        bloc: IdentityBloc(),

        /*
        bloc: AppBloc(emptyFoodItemWithDocID,/* emptyIngs,*/
            fromWhichPage:-1),

*/




//        child:BlocProvider<FoodGalleryBloc>(
//
//          bloc:FoodGalleryBloc(),
          child: MaterialApp(

            title: 'Flutter Demo',
            // commented for Tablet testing on april 25.
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
              // This makes the visual density adapt to the platform that you run
              // the app on. For desktop platforms, the controls will be smaller and
              // closer together (more dense) than on mobile platforms.
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            debugShowCheckedModeBanner: false,
//      home: WelcomePage(),
            home:WelcomePage(),


//      home: FoodGallery(),
          ),
        // ),
//        ),
      );
  }
}
