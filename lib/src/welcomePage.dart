import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



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





  //  assert(user.displayName != null);


  @override
  void initState(){

    print('at initState of welcomePage');
    super.initState();
//    loadUser();
  }

  /*
  // !!(NOT) NECESSARY NOW. -- CONFUSED.
  Future<void> loadUser() async {

    debugPrint("loadUser()");
    final IdentityBlockWelcomePage = BlocProvider.of<IdentityBloc>(context);

//    Future<void> setAllIngredients() async {
    await IdentityBlockWelcomePage.loadUser();


    await IdentityBlockWPage.getAllIngredients();
    List<NewIngredient> test = bloc.allIngredients;

//    print(' ^^^ ^^^ ^^^ ^^^ ### test: $test');

    print('done: ');

//    dynamic normalPrice = oneFoodItemandId.sizedFoodPrices['normal'];
//    double euroPrice1 = tryCast<double>(normalPrice, fallback: 0.00);

    setState(()
    {
      _allIngredientState = test;
//      priceByQuantityANDSize = euroPrice1;
//      initialPriceByQuantityANDSize = euroPrice1;
    }
    );



  }

  */




  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<IdentityBloc>(context);
    /*

    StreamBuilder<List<NewCategoryItem>>(

        stream:bloc.categoryItemsStream,
        initialData: bloc.allCategories,
//        initialData: bloc.getAllFoodItems(),
        builder: (context, snapshot){

      if (!snapshot.hasData) {
        return Center(child: new LinearProgressIndicator());
      }
      else{


      }
      */


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
          child: StreamBuilder<FirebaseUser>(
   /* stream:bloc.categoryItemsStream,
    initialData: bloc.allCategories,
//        initialData: bloc.getAllFoodItems(),
    builder: (context, snapshot){

    if (!snapshot.hasData) {
    return Center(child: new LinearProgressIndicator());
    }
    else{*/
            stream: bloc.getCurrentFirebaseUserStream,
              initialData: bloc.getCurrentFirebaseUser,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _title(),
                    SizedBox(
                      height: 80,
                    ),
                    _loginButton(),
                    // STRIPPED FOR NOW ON MAY 29 2020.
                    /*
                    SizedBox(
                      height: 20,
                    ),
                    _signUpButton(),
                    */
                    /*
                    SizedBox(
                      height: 20,
                    ),
                    _label()
                    */
                    // Touch
                  ],
                );

              }
              else {
                return
                  BlocProvider<IdentityBloc>(
                    bloc: IdentityBloc(),
//        child:BlocProvider<IdentityBloc>(
//
//          bloc:IdentityBloc(),
                    child: MaterialApp(

                      title: 'Flutter Demo',
                      // commented for Tablet testing on april 25.
                      theme: ThemeData(
                        // Define the default brightness and colors.
                        brightness: Brightness.dark,
                        primaryColor: Colors.lightBlue[800],
                        accentColor: Colors.cyan[600],

                        // Define the default font family.
                        fontFamily: 'Georgia',

                        // Define the default TextTheme. Use this to specify the default
                        // text styling for headlines, titles, bodies of text, and more.
                        textTheme: TextTheme(
                          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
                        ),
                      ),
                      debugShowCheckedModeBanner: false,
//      home: WelcomePage(),
                      home:LoginPage(),


//      home: FoodGallery(),
                    ),
//        ),
                  );

                return Center(child: new CircularProgressIndicator());
              }
            }
          ),
        ),
      ),
    );
  }
}
