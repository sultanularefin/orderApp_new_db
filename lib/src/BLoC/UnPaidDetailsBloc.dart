


import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';

import 'package:foodgallery/src/DataLayer/models/FoodPropertyMultiSelect.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
import 'package:foodgallery/src/DataLayer/models/PaymentTypeSingleSelect.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';


import 'package:logger/logger.dart';

//MODELS
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';

import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';
import 'dart:async';

//Map<String, int> mapOneSize = new Map();

class UnPaidDetailsBloc /*with ChangeNotifier */ implements Bloc  {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final _client = FirebaseClient();


  // selected Sauce Items

  OneOrderFirebase _curretnFireBaseOrder ;
  OneOrderFirebase get getCurrentUnPaidFireBaseOrder => _curretnFireBaseOrder;
  final _oneFireBaseOrderController = StreamController <OneOrderFirebase>();
  Stream<OneOrderFirebase> get getCurrentUnPaidOrderStream => _oneFireBaseOrderController.stream;


  /* all _paymentType begins here.....*/

  List<PaymentTypeSingleSelect> _paymentType;
  List<PaymentTypeSingleSelect> get getCurrentPaymentType => _paymentType;
  final _paymentTypeController = StreamController <List<PaymentTypeSingleSelect>>.broadcast();
  Stream  <List<PaymentTypeSingleSelect>> get getCurrentPaymentTypeSingleSelectStream => _paymentTypeController.stream;

  /* all _paymentType ends here.....*/




  //  Stream  <List<PaymentTypeSingleSelect>> get getCurrentPaymentTypeSingleSelectStream => _paymentTypeController.stream;



  void initiatePaymentTypeSingleSelectOptionsUnPaidPage(int selectedPayment){



    PaymentTypeSingleSelect cash = new PaymentTypeSingleSelect(
      borderColor: '0xff95CB04',
      index: 0,
      isSelected: false,
      paymentTypeName: 'Cash',
      iconDataString: 'FontAwesomeIcons.twitter',

      paymentIconName: 'Cash',
    );


//     0xffFEE295 false
    PaymentTypeSingleSelect card = new PaymentTypeSingleSelect(
      borderColor: '0xffFEE295',
      index: 1,
      isSelected: false,
      paymentTypeName: 'Card',
      iconDataString: 'FontAwesomeIcons.home',

      paymentIconName: 'Card',
    );

    List <PaymentTypeSingleSelect> paymentTypeSingleSelectArray = new List<PaymentTypeSingleSelect>();


    paymentTypeSingleSelectArray.addAll([cash, card  ]);

    paymentTypeSingleSelectArray[selectedPayment].isSelected =true;

    _paymentType = paymentTypeSingleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.

    _paymentTypeController.sink.add(_paymentType);


  }


  // CONSTRUCTOR BEGINS HERE.
  UnPaidDetailsBloc(
      OneOrderFirebase oneFireBaseOrder,
      ) {

    initiatePaymentTypeSingleSelectOptionsUnPaidPage(1);
    logger.i('___ ___ || || @@@@  oneFireBaseOrder.documentId: ${oneFireBaseOrder.documentId}');

    oneFireBaseOrder.tempPaymentIndex =1;
    oneFireBaseOrder.tempPaidType='Card';

    _curretnFireBaseOrder= oneFireBaseOrder;
    _oneFireBaseOrderController.sink.add(_curretnFireBaseOrder);

  }

  // CONSTRUCTOR ENDS HERE.




  void setPaymentTypeSingleSelectOptionForOrderUnPaidDetailsPage(
      PaymentTypeSingleSelect x,
      int newPaymentIndex,
      int oldPaymentIndex
      ){

    logger.i('at setPaymentTypeSingleSelectOptionForOrder');
    print('new Payment Index is $newPaymentIndex');
    print('old Payment Index is $oldPaymentIndex');


    List <PaymentTypeSingleSelect> singleSelectArray = _paymentType;

    singleSelectArray[oldPaymentIndex].isSelected =
    !singleSelectArray[oldPaymentIndex].isSelected;


    singleSelectArray[newPaymentIndex].isSelected =
    !singleSelectArray[newPaymentIndex].isSelected;


    _paymentType = singleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.
    _paymentTypeController.sink.add(_paymentType);


    OneOrderFirebase temp = _curretnFireBaseOrder;


    temp.tempPaymentIndex = newPaymentIndex;
    temp.tempPaidType = newPaymentIndex==0?'Cash':'Card';
    _curretnFireBaseOrder = temp;
    _oneFireBaseOrderController.sink.add(_curretnFireBaseOrder);


  }



  // not added to anything yet...

  void clearSubscription(){

    _curretnFireBaseOrder = null; ;
    _paymentType = [];

    _oneFireBaseOrderController.sink.add(_curretnFireBaseOrder);
    _paymentTypeController.sink.add(_paymentType);


  }




  Future<int>  paymentButtonPressedUnPaidDetailsPage() async{
  // Future<int>  paymentButtonPressedUnPaidDetailsPage() async{

    OneOrderFirebase currenttempUnPaidOneOrderFB = _curretnFireBaseOrder;

    print('temp.documentId: ${currenttempUnPaidOneOrderFB.documentId}');
    String previouslyLaterPaidDocumentID = currenttempUnPaidOneOrderFB.documentId;

    String paidType0 =   currenttempUnPaidOneOrderFB.tempPaymentIndex==0?'Cash':'Card'; // no later option..


    print('paidType0 : $paidType0');

    var updateResult =
    await _client.updateOrderCollectionDocumentWithRecitePrintedInformation(previouslyLaterPaidDocumentID,paidType0);

    currenttempUnPaidOneOrderFB.paidStatus='Paid';
    currenttempUnPaidOneOrderFB.paidType= paidType0;


    // OneOrderFirebase returningOrder= currenttempUnPaidOneOrderFB;

    // currenttempUnPaidOneOrderFB.tempPayButtonPressed =false;

    _curretnFireBaseOrder = currenttempUnPaidOneOrderFB;
    _oneFireBaseOrderController.sink.add(_curretnFireBaseOrder);




    print('updateResult is:: :: $updateResult');
    String                    paidType2 = updateResult['paidType'];

    print('paidType2: $paidType2');

    if(paidType2==paidType0){
      print('update successfull');
      return 1;

    }


    return 0;




  }





  // HELPER METHOD tryCast Number (1)
  double tryCast<num>(dynamic x, {num fallback }) {

    print(" at tryCast");
    print('x: $x');

    bool status = x is num;

//    print('status : x is num $status');
//    print('status : x is dynamic ${x is dynamic}');
//    print('status : x is int ${x is int}');
    if(status) {
      return x.toDouble() ;
    }

    if(x is int) {return x.toDouble();}
    else if(x is double) {return x.toDouble();}

    else return 0.0;
  }




  @override
  void dispose() {


    _oneFireBaseOrderController.close();
    _paymentTypeController.close();

    // _oneFireBaseOrderController.sink.add(_curretnFireBaseOrder);
    // _paymentTypeController.sink.add(_paymentType);

  }
}


