

//### EXTERNAL PACKAGES
import 'dart:async';
import 'package:logger/logger.dart';


//### LOCAL DATA RELATED RESOURCES
import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


//import 'package:foodgallery/src/DataLayer/Order.dart';
//import 'package:foodgallery/src/DataLayer/OrderTypeSingleSelect.dart';
//import 'package:foodgallery/src/DataLayer/CustomerInformation.dart';


//MODELS


class IdentityBloc implements Bloc {



  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final _client = FirebaseClient();


//  List<Order> _curretnOrder = [];

  FirebaseUser _currentFBUser;

  //  Order _curretnOrder ;
  //  List<OrderTypeSingleSelect> _orderType;
  //  CustomerInformation _oneCustomerInfo;


//  List<Order> get getCurrentOrder => _curretnOrder;
  FirebaseUser get getCurrentFirebaseUser => _currentFBUser;
//  List<OrderTypeSingleSelect> get getCurrentOrderType => _orderType;
//  CustomerInformation get getCurrentCustomerInfo => _oneCustomerInfo;



  final _firebaseUserController = StreamController <FirebaseUser>();
//  final _orderTypeController = StreamController <List<OrderTypeSingleSelect>>.broadcast();
//  final _orderTypeController = StreamController <List<OrderTypeSingleSelect>>.broadcast();
//  final _customerInformationController = StreamController <CustomerInformation>();
//  final _customerInformationController = StreamController <CustomerInformation>.broadcast();

  Stream<FirebaseUser> get getCurrentFirebaseUserStream => _firebaseUserController.stream;

//  Stream<Order> get getCurrentOrderStream => _orderController.stream;
//
//  Stream  <List<OrderTypeSingleSelect>> get getCurrentOrderTypeSingleSelectStream =>
//      _orderTypeController.stream;
//
//  Stream<CustomerInformation> get getCurrentCustomerInformationStream =>
//      _customerInformationController.stream;



  // CONSTRUCTOR BEGINS HERE.


  IdentityBloc(

      ) {

    print("at the begin of Constructor [IdentityBloc]");

    // TO  DO NEED TO CHECK SHARED PREFERENCES.
    // MAY BE MORE CHECK FIREBASE , TOO FOR THAT REGARD.


    //CONSTRUCTOR SEED FUNCTION EXAMPLE MAY BE USED LATER.

    //    initiateOrderTypeSingleSelectOptions();
    //    initiateCustomerInformation();


    loadUserFromConstructor();

  }
// CONSTRUCTOR ENDS HERE.

  Future<AuthResult> handleSignInFromLoginPage(String email,String password) async {

    AuthResult result = await _auth.signInWithEmailAndPassword(email:
    email,password: password);

//  print('result: '  + result);


    if(result.user.email != null){
      FirebaseUser fireBaseUserRemote = result.user;

      _currentFBUser = fireBaseUserRemote;
      _firebaseUserController.sink.add(_currentFBUser);

      return result;
    }
    else{
      return result;
    }



//    AssertionError(result.user.email);
//    print('result: ' + result.user.email);



  }


  Future<FirebaseUser> _handleSignIn(String email,String password) async {


    AuthResult result = await _auth.signInWithEmailAndPassword(email:
    email,password: password);

//  print('result: '  + result);

    print('result: ' + result.user.email);

    FirebaseUser fireBaseUserRemote = result.user;


    return fireBaseUserRemote;

  }



  // Future<void> setAllIngredients() async {
  // FROM WELCOME PAGE ==>



  void loadUserFromConstructor(/*String uid*/) async {

    print('at loadUser of Welcome Page');
    SharedPreferences prefs = await SharedPreferences.getInstance();

//    ??=
//    Assign the value only if the variable is null



    final resultString =  prefs.getString("userInfo");

    if(resultString != null) {
      print('resultString in Welcome Page $resultString');

      Map<String, dynamic> user = jsonDecode(
          resultString
      );

      print('Howdy, ${user['email']}!');


      print('password ${user['password']}.');

      print('result_in_prefs: WelCome Page ' + resultString);

      String storedEmail = user['email'];

      String storedPassWord = user['password'];

      print('email $storedEmail');
      print('password $storedPassWord');

      if ((storedEmail != null) && (storedPassWord != null)) {
        print("email && password found");

        // NOW I NEED TO CHECK THIS STORED CREDENTIALS WITH FIREBASE AUTHENTICATION.

        FirebaseUser ourUser = await _handleSignIn(storedEmail, storedPassWord);

//      return Navigator.push(context,
//          MaterialPageRoute(builder: (context) => drawerScreen())
//
//      );


//      _allIngItems = ingItems;
        _currentFBUser = ourUser;
        _firebaseUserController.sink.add(_currentFBUser);

//      _allIngredientListController.sink.add(ingItems);

      }
    }
    print("at not found of loadUser From Constructor");

    //1 means SharedPreference not empty.

  }

  Future loadUserNotConstructor(/*String uid*/) async {

    print('at loadUser of Welcome Page');
    SharedPreferences prefs = await SharedPreferences.getInstance();

//    ??=
//    Assign the value only if the variable is null



    final resultString =  prefs.getString("userInfo");

    print('resultString in Welcome Page $resultString');

    Map<String,  dynamic> user = jsonDecode(
        resultString
    );

    print('Howdy, ${user['email']}!');


    print('password ${user['password']}.');

    print('result_in_prefs: WelCome Page ' + resultString);

    String storedEmail = user['email'];

    String storedPassWord = user['password'];

    print('email $storedEmail');
    print('password $storedPassWord');

    if((storedEmail!= null) && (storedPassWord!=null)){

      print("email && password found");

      // NOW I NEED TO CHECK THIS STORED CREDENTIALS WITH FIREBASE AUTHENTICATION.

      FirebaseUser ourUser = await _handleSignIn(storedEmail,storedPassWord);

//      return Navigator.push(context,
//          MaterialPageRoute(builder: (context) => drawerScreen())
//
//      );


//      _allIngItems = ingItems;
//
//      _allIngredientListController.sink.add(ingItems);

    }
    print("not found");

    //1 means SharedPreference not empty.

  }



  @override
  void dispose() {
    _firebaseUserController.close();
//    _orderController.close();
//    _orderTypeController.close();
//    _customerInformationController.close();
//    _multiSelectForFoodController.close();

  }
}