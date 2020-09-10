

//### EXTERNAL PACKAGES
import 'dart:async';

//import 'package:logger/logger.dart';


//### LOCAL DATA RELATED RESOURCES
import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';


//import 'package:foodgallery/src/DataLayer/Order.dart';
//import 'package:foodgallery/src/DataLayer/OrderTypeSingleSelect.dart';
//import 'package:foodgallery/src/DataLayer/CustomerInformation.dart';


//MODELS




class IdentityBloc implements Bloc {


//  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;



//  var logger = Logger(
//    printer: PrettyPrinter(),
//  );







  final _client = FirebaseClient();


//  List<Order> _curretnOrder = [];

  User _currentFBUser;

  //  Order _curretnOrder ;
  //  List<OrderTypeSingleSelect> _orderType;
  //  CustomerInformation _oneCustomerInfo;


//  List<Order> get getCurrentOrder => _curretnOrder;
  User get getCurrentFirebaseUser => _currentFBUser;

//  List<OrderTypeSingleSelect> get getCurrentOrderType => _orderType;
//  CustomerInformation get getCurrentCustomerInfo => _oneCustomerInfo;


  final _firebaseUserController = StreamController <User>();

//  final _orderTypeController = StreamController <List<OrderTypeSingleSelect>>.broadcast();
//  final _orderTypeController = StreamController <List<OrderTypeSingleSelect>>.broadcast();
//  final _customerInformationController = StreamController <CustomerInformation>();
//  final _customerInformationController = StreamController <CustomerInformation>.broadcast();

  Stream<User> get getCurrentFirebaseUserStream =>
      _firebaseUserController.stream;

//  Future<FirebaseUser> get getCurrentFirebaseUserStream =>
//      _firebaseUserController.stream;

//  getCurrentFirebaseUserStream

//  Stream<Order> get getCurrentOrderStream => _orderController.stream;
//
//  Stream  <List<OrderTypeSingleSelect>> get getCurrentOrderTypeSingleSelectStream =>
//      _orderTypeController.stream;
//
//  Stream<CustomerInformation> get getCurrentCustomerInformationStream =>
//      _customerInformationController.stream;


  // CONSTRUCTOR BEGINS HERE.


  IdentityBloc() {
    // print("at the begin of Constructor [IdentityBloc]");

    // TO  DO NEED TO CHECK SHARED PREFERENCES.
    // MAY BE MORE CHECK FIREBASE , TOO FOR THAT REGARD.


    //CONSTRUCTOR SEED FUNCTION EXAMPLE MAY BE USED LATER.

    //    initiateOrderTypeSingleSelectOptions();
    //    initiateCustomerInformation();


    loadUserFromConstructor();
  }



// CONSTRUCTOR ENDS HERE.


//  Future<AuthResult> handleSignInFromLoginPage(String email,
//      String password) async {

  Future<UserCredential> handleSignInFromLoginPage(String email,
      String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(email:
    email, password: password);

  print('result:  IIIII   >>>>>  $result'  );


    if (result.user.email != null) {
      User fireBaseUserRemote = result.user;

      _currentFBUser = fireBaseUserRemote;

      await _saveUser(fireBaseUserRemote, email, password);


      _firebaseUserController.sink.add(_currentFBUser);

      return result;
    }
    else {
      return result;
    }

//    AssertionError(result.user.email);
//    print('result: ' + result.user.email);

  }

  _saveUser(/*String uid*/ User x, String loggerEmail,
      String loggerPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

//    ??=
//    Assign the value only if the variable is null

    Map<String, dynamic> toJson() =>
        {
          'email': loggerEmail,
          'password': loggerPassword,
//      'uid': uid,
        };


  //  print('setString method going to be called where key is userInfo');
    prefs.setString('userInfo', jsonEncode({
      'email': loggerEmail,
      'password': loggerPassword,
//      'uid': uid,
    })).then((onValue) =>
    {
    //  print('at then of prefs.setString(userInfo.....')
    });


   // print('user set in mobile storage');


    final resultString = prefs.getString("userInfo");

    Map<String, dynamic> user = jsonDecode(
        resultString
    );

   // print('Howdy, ${user['email']}');


   // print('password ${user['password']}');

  //  print('result_in_prefs: ' + resultString);
  }

//  Future<FirebaseUser> _handleSignIn(String email, String password) async {
  Future<User> _handleSignIn(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(email:
    email, password: password);

//  print('result: '  + result);

   // print('result: ' + result.user.email);

    User fireBaseUserRemote = result.user;


    return fireBaseUserRemote;
  }


  // Future<void> setAllIngredients() async {
  // FROM WELCOME PAGE ==>

  Future <bool> checkUserinLocalStorage() async {


  SharedPreferences prefs = await SharedPreferences.getInstance();

//    ??=
//    Assign the value only if the variable is null


  final resultString = prefs.getString("userInfo");

  if (resultString == null){
    // first time this will be the condition.
    // no need to further check go to login page.

    return false;
  }
  else{
    Map<String, dynamic> user = jsonDecode(
        resultString
    );

    // NEEED TO CHECK ABOVE '$user' again in future.
    if(user['email']== null){
      return false;
    }
    else return true;
  }


}

  void loadUserFromConstructor(/*String uid*/) async {

   // print('at loadUser of Welcome Page');
    SharedPreferences prefs = await SharedPreferences.getInstance();

//    ??=
//    Assign the value only if the variable is null



    final resultString =  prefs.getString("userInfo");

    if(resultString != null) {
   //   print('resultString in Welcome Page $resultString');

      Map<String, dynamic> user = jsonDecode(
          resultString
      );

     // print('Howdy, ${user['email']}!');


    //  print('password ${user['password']}.');

    //  print('result_in_prefs: WelCome Page ' + resultString);

      String storedEmail = user['email'];

      String storedPassWord = user['password'];

     // print('email $storedEmail');
     // print('password $storedPassWord');

      if ((storedEmail != null) && (storedPassWord != null)) {
      //  print("email && password found");

        // NOW I NEED TO CHECK THIS STORED CREDENTIALS WITH FIREBASE AUTHENTICATION.

        User ourUser = await _handleSignIn(storedEmail, storedPassWord);

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
    else {
     // print("at not found of loadUser From Constructor");
    }
    //1 means SharedPreference not empty.

  }

  Future loadUserNotConstructor(/*String uid*/) async {

    // print('at loadUser of Welcome Page');
    SharedPreferences prefs = await SharedPreferences.getInstance();

//    ??=
//    Assign the value only if the variable is null



    final resultString =  prefs.getString("userInfo");

  //  print('resultString in Welcome Page $resultString');

    Map<String,  dynamic> user = jsonDecode(
        resultString
    );

   // print('Howdy, ${user['email']}!');


    // print('password ${user['password']}.');

  //  print('result_in_prefs: WelCome Page ' + resultString);

    String storedEmail = user['email'];

    String storedPassWord = user['password'];

   // print('email $storedEmail');
    // print('password $storedPassWord');

    if((storedEmail!= null) && (storedPassWord!=null)){

    //  print("email && password found");

      // NOW I NEED TO CHECK THIS STORED CREDENTIALS WITH FIREBASE AUTHENTICATION.

      User ourUser = await _handleSignIn(storedEmail,storedPassWord);

//      return Navigator.push(context,
//          MaterialPageRoute(builder: (context) => drawerScreen())
//
//      );


//      _allIngItems = ingItems;
//
//      _allIngredientListController.sink.add(ingItems);

    }
   // print("not found");

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