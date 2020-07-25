

//food_gallery.dart



// dependency files
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide Image;
//import 'package:image/image.dart';
import 'package:flutter/services.dart'; // InputFormatters.
import 'package:image/image.dart' as ImageAliasAnotherSource;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
import 'package:foodgallery/src/DataLayer/models/OrderedItem.dart';
import 'package:foodgallery/src/DataLayer/models/Restaurant.dart';
//import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';
import 'package:dotted_border/dotted_border.dart';


/* classes added */
//import 'dart:convert';
//import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

//import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:oktoast/oktoast.dart';
import 'dart:async';

//  TODO: REdirect to food gallery page after pay button is pressed.

/*
* MODIFICATIONS: for REAL DEVICES.
1.
onTap: () =>  _testPrintDummyDevices(blueToothDevicesState[index]),

above to below for real devices.

onTap: () => _testPrint(blueToothDevicesState[index]),
* _testPrint(blueToothDevicesFromStream[index])

*
*
*
*
2.
  void _startScanDummyDevices() {
  *
  *
  * above to below for real devices.

  void _startScanDevices() {


* */




import 'package:foodgallery/src/BLoC/bloc_provider.dart';
//import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
import 'package:foodgallery/src/BLoC/shoppingCart_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
//import 'package:foodgallery/src/screens/foodGallery/foodgallery2.dart';



import 'package:foodgallery/src/screens/shoppingCart/widgets/FoodImage_inShoppingCart.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import 'package:logger/logger.dart';

import 'package:foodgallery/src/DataLayer/models/Order.dart';

// model files

import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
//import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/OrderTypeSingleSelect.dart';
import 'package:foodgallery/src/DataLayer/models/PaymentTypeSingleSelect.dart';

// LOCAL SCREEN FILES:

import './widgets/ShoppingCartPagePainters.dart';

final Firestore firestore = Firestore();



class ShoppingCart extends StatefulWidget {
//  AdminFirebase({this.firestore});


  final Widget child;
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//  final FoodItem oneFoodItemData;

//  FoodItemWithDocID oneFoodItem =new FoodItemWithDocID(


  ShoppingCart({Key key, this.child}) : super(key: key);

  @override
  _ShoppingCartState createState() => new _ShoppingCartState();

//  _FoodItemDetailsState createState() => _FoodItemDetailsState();


}


class _ShoppingCartState extends State<ShoppingCart> {


  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final GlobalKey<ScaffoldState> _scaffoldKeyShoppingCartPage = new GlobalKey<
      ScaffoldState>();

//  String _currentSize;
//  int _itemCount = 1;
  int _currentOrderTypeIndex = 0; // phone, takeaway, delivery, dinning.
  int _currentPaymentTypeIndex = 2; // PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)
  bool showFullOrderType = true;
  bool showUserInputOptionsLikeFirstTime = true;
  bool showCustomerInformationHeader = false;
  bool showFullPaymentType = true;

  bool showEditingCompleteCustomerAddressInformation = false;
  bool showEditingCompleteCustomerHouseFlatIformation = false;
  bool showEditingCompleteCustomerPhoneIformation = false;
  bool showEditingCompleteCustomerReachoutIformation = false;


//  bool showInputtedCustomerIformation = false;

  final addressController = TextEditingController();
  final houseFlatNumberController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final etaController = TextEditingController();


  /*
  * PRINTING RELATED STATE VARIABLES ARE HERE.
  * */

//  PrinterNetworkManager printerManager = PrinterNetworkManager();


  PrinterBluetoothManager printerManager = PrinterBluetoothManager();

//  List<PrinterBluetooth> blueToothDevicesState = [];
//  bool localScanAvailableState = true; // meant not busy.

//  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
//  List<PrinterBluetooth> _devices = [];

  /*
  String localIp = '';
  List<String> devices = [];
  bool isDiscovering = false;
  int found = -1;
  TextEditingController portController = TextEditingController(text: '9100');

  */
  /*
  * PRINTING RELATED STATE VARIABLES ENDS HERE.
  * */

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
    addressController.dispose();
    houseFlatNumberController.dispose();
    phoneNumberController.dispose();
    etaController.dispose();
  }


//  color: Color(0xff34720D),
//  VS 0xffFEE295 3 0xffFEE295 false
//  ORG 0xff739DFA 4 0xff739DFA false


/*
  @override
  void initState() {
//    setDetailForFood();
//    retrieveIngredientsDefault();

//    checkBlueToothDevices();




    print('debug print came to init State');
    print('debug print before invoking printerManager.scanResults.listen((devices) async { ');

    printerManager.scanResults.listen((devices) async {
      print('UI: Devices found ${devices.length}');
      setState(() {
        blueToothDevicesState = devices;
//        localScanAvailableState=!localScanAvailableState;
      });
    });

    super.initState();
  }

  */


//  void _startScanDummyDevices() {
  void _startScanDevices() {
    print('debug print inside _startScanDevices() method ');

    setState(() {
      // blueToothDevicesState = [];
    });

    print('debug print blueToothDevicesState set to empty/ []  ');
    print(
        'debug print before calling  printerManager.startScan(Duration(seconds: 4));  ');

    // temporarily closing (COMMENTING).. july 12. 8:30 pm. for debugging...
    printerManager.startScan(Duration(seconds: 4));

    print(
        'debug print after calling  printerManager.startScan(Duration(seconds: 4));'
            ' inside _startScanDevices() method   ');
    // Test devices added.

    /*
    PaymentTypeSingleSelect Later = new PaymentTypeSingleSelect(
      borderColor: '0xff739DFA',
      index: 0,
      isSelected: false,
      paymentTypeName: 'Later',
      iconDataString: 'FontAwesomeIcons.facebook',

      paymentIconName: 'Later',
    );
    */

    /*
    BluetoothDevice _x = new BluetoothDevice();
    _x.name = 'Restaurant Printer';
    _x.address = '0F:02:18:51:23:46';
    _x.type = 3;
    _x.connected = null;


    PrinterBluetooth x = new PrinterBluetooth(_x);

    BluetoothDevice _y = new BluetoothDevice();
    _y.name = 'JBL Charge 4';
    _y.address = '98:52:3D:BB:18:26';
    _y.type = 3;
    _y.connected = null;


    PrinterBluetooth y = new PrinterBluetooth(_y);

    List<PrinterBluetooth> tempBlueToothDevices = new List<PrinterBluetooth>();
    tempBlueToothDevices.addAll([x, y]);

    setState(() {
      blueToothDevicesState = tempBlueToothDevices;
    });

    */
  }


  void _startScanDummyDevices() {
    print('debug print inside _startScanDevices() method ');

    /*
    setState(() {
      blueToothDevicesState = [];
    });
    */
    print('debug print blueToothDevicesState set to empty/ []  ');
    print(
        'debug print before calling  printerManager.startScan(Duration(seconds: 4));  ');

    // temporarily closing (COMMENTING).. july 12. 8:30 pm. for debugging...
    /* printerManager.startScan(Duration(seconds: 4)); */

    print(
        'debug print after calling  printerManager.startScan(Duration(seconds: 4));'
            ' inside _startScanDevices() method   ');
    // Test devices added.

    /*
    PaymentTypeSingleSelect Later = new PaymentTypeSingleSelect(
      borderColor: '0xff739DFA',
      index: 0,
      isSelected: false,
      paymentTypeName: 'Later',
      iconDataString: 'FontAwesomeIcons.facebook',

      paymentIconName: 'Later',
    );
    */


    BluetoothDevice _x = new BluetoothDevice();
    _x.name = 'Restaurant Printer';
    _x.address = '0F:02:18:51:23:46';
    _x.type = 3;
    _x.connected = null;


    PrinterBluetooth x = new PrinterBluetooth(_x);

    BluetoothDevice _y = new BluetoothDevice();
    _y.name = 'JBL Charge 4';
    _y.address = '98:52:3D:BB:18:26';
    _y.type = 3;
    _y.connected = null;


    PrinterBluetooth y = new PrinterBluetooth(_y);

    List<PrinterBluetooth> tempBlueToothDevices = new List<PrinterBluetooth>();
    tempBlueToothDevices.addAll([x, y]);

    setState(() {
      // blueToothDevicesState = tempBlueToothDevices;
    });
  }

  void _stopScanDevices() {
    print('debug print inside _stopScanDevices() method ');
    printerManager.stopScan();
    print(
        'debug print inside _stopScanDevices() method and finished calling printerManager.stopScan() method');
  }

  // Future<void> return type .  ??

  //  No longer requiered.

  /*
  Future<void> checkBlueToothDevices () async {
//    final identityBlockinInitState = BlocProvider.of<IdentityBloc>(context);

    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

    List<PrinterBluetooth> tempTestDevices = await shoppingCartBloc
        .discoverDevicesInitState();

    if (tempTestDevices == null) {
      print('no devices found from init State Future completed');
    }
    else if (tempTestDevices.length == 0) {
      print('0 devices found from init State Future completed');
    }

    else {
      setState(() {
        blueToothDevicesState = tempTestDevices;
      });
    }
  }

  */


/*
  Future<void> _onBackPressed() {
//    shoppingCartBloc.
//    return StreamBuilder<List<SelectedFood>>(
//      stream: shoppingCartbloc.getExpandedFoodsStream,
    List<SelectedFood> expandedFoodReturnTemp= new List<SelectedFood>(0);
    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
    expandedFoodReturnTemp = shoppingCartBloc.getExpandedSelectedFood;

    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to go to home page'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(expandedFoodReturnTemp),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(expandedFoodReturnTemp),
            child: Text("YES"),
          ),
        ],
      ),
    ) ??
        return null;
  }
  */

/*
  Widget _onBackPressed2() async {

    //    shoppingCartBloc.
//    return StreamBuilder<List<SelectedFood>>(
//      stream: shoppingCartbloc.getExpandedFoodsStream,

//    List<SelectedFood> expandedFoodReturnTemp= new List<SelectedFood>(0);

    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

    Order backReturnOrder = shoppingCartBloc.getCurrentOrder;

    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select some Food, please'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
//                        Text('you haven\'t selected any food yet, please select some food'),
                Text('You need to select some food item in order to go to the shopping cart page.'),
              ],
            ),
          ),

            actions: <Widget>[
              FlatButton(
                child: Text('Go to home page'),
                onPressed: () {
                  return Navigator.pop(context,backReturnOrder);
//                Navigator.of(context).pop(backReturnOrder);
                },
              ),

              FlatButton(
                child: Text('Stay here'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

          ],
        );
      },
    );

    /*
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Go to home page'),
              onPressed: () {
                return Navigator.pop(context,backReturnOrder);
//                Navigator.of(context).pop(backReturnOrder);
              },
            ),

            FlatButton(
              child: Text('Stay here'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    */
  }

  */

  /// Creates an image from the given widget by first spinning up a element and render tree,
  /// then waiting for the given [wait] amount of time and then creating an image via a [RepaintBoundary].
  ///
  /// The final image will be of size [imageSize] and the the widget will be layout, ... with the given [logicalSize].
//  Future<Uint8List> createImageFromWidget(
  Future<Uint8List> createImageFromWidget(Widget widget,
      {
        /* Duration wait, */
        Size logicalSize,
        Size imageSize}) async {
    print('at here: $createImageFromWidget');


    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

    logicalSize ??= ui.window.physicalSize / ui.window.devicePixelRatio;
    imageSize ??= ui.window.physicalSize;

    assert(logicalSize.aspectRatio == imageSize.aspectRatio);

    final RenderView renderView = RenderView(
      window: null,
      child: RenderPositionedBox(
          alignment: Alignment.center, child: repaintBoundary),
      configuration: ViewConfiguration(
        size: logicalSize,
        devicePixelRatio: 1.0,
      ),
    );

    final PipelineOwner pipelineOwner = PipelineOwner();
    final BuildOwner buildOwner = BuildOwner();

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    final RenderObjectToWidgetElement<RenderBox>
    rootElement = RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: widget,
    ).attachToRenderTree(buildOwner);

    buildOwner.buildScope(rootElement);

//    if (wait != null) {
//      await Future.delayed(wait);
//    }
//    print('wait ** ** **: $wait');

    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();

    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    final ui.Image image = await repaintBoundary.toImage(
        pixelRatio: imageSize.width / logicalSize.width);
    final ByteData byteData = await image.toByteData(
        format: ui.ImageByteFormat.png);

//    final Uint8List bytes =  byteData.buffer.asUint8List();

//    final Uint8List bytes = data.buffer.asUint8List();
//    final Image image = decodeImage(bytes);
//
//    final Image oneImage = ImageAliasAnotherSource.decodeImage(bytes);
    // decodePng(bytes);
//    decodeImage(bytes)

//    bytesArefins = bytes;
//    uint8LIstController.sink.add(bytesArefins);

    print('byteData: $byteData');
    return
      byteData.buffer.asUint8List();

//  return;
  }

//  paidStatus
//  Widget restaurantName(String name) {

//  orderInformationAndCustomerInformationWidget

  Widget orderInformationAndCustomerInformationWidget(
      OneOrderFirebase oneOrderForReceipt) {
    print(
        'at paidUnpaidDeliveryType: && oneOrderForReceipt.orderBy: ${oneOrderForReceipt
            .orderBy}'
            'oneOrderForReceipt.paidStatus: ${oneOrderForReceipt.paidStatus}');

    CustomerInformation customerForReciteGeneration = oneOrderForReceipt
        .oneCustomer;
//  Widget paidUnpaidDeliveryType =
    return new Directionality(
      textDirection: TextDirection.ltr,
      child:
      Container(

        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 3.6,
          ),
//                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(35.0),
//                    color: Colors.black,

        ),
        height: 170,

//        margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
        width: 300,
        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(6, 15, 0,0),

//            color:Colors.yellow,

//            color:Colors.yellowAccent,
              height: 152,
              width: 105,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Text(
                    (oneOrderForReceipt.orderBy.toLowerCase() == 'delivery')
                        ? 'Delivery'
                        :
                    (oneOrderForReceipt.orderBy.toLowerCase() == 'phone') ?
                    'Phone' : (oneOrderForReceipt.orderBy.toLowerCase() ==
                        'takeaway') ? 'TakeAway' : 'Dinning Room',
//                    oneOrderForReceipt.orderBy
//                    'dinning room',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 20, fontFamily: 'Itim-Regular',),
                  ),

                  // 1 ends here.


                  Text(
                    '${oneOrderForReceipt
                        .formattedOrderPlacementDatesTimeOnly}',

                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 20, fontFamily: 'Itim-Regular',),
                  ),


                  // 2 ends here.
                  Text('${oneOrderForReceipt.orderProductionTime} min',

                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 20, fontFamily: 'Itim-Regular',),
                  ),

                  // 3 ends here.
                ],
              ),
            ),


            /// toDo: multiline. maxlines
            Container(

              padding: EdgeInsets.fromLTRB(0, 8, 0,0),
//            color:Colors.yellow,

//            color:Colors.yellowAccent,
              height: 160,
              width: 175,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Container(
                    height:49,
                    width: 160,
                    padding:EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Text(
                      ((customerForReciteGeneration.address == null) ||
                          (customerForReciteGeneration.address.length == 0)) ?
                      'EMPTY' :customerForReciteGeneration.address.length>20?
                      customerForReciteGeneration.address.substring(0,17) +'...':
                      customerForReciteGeneration.address,

                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: TextStyle(
//                      fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 20, fontFamily: 'Itim-Regular',),
//                      maxLines: 2,
//                      textAlign: TextAlign.left,
                    ),
                  ),

                  // 1 ends here.

//                    .length>12?
////              stringifiedFoodItemIngredients.substring(0,12)+'...':

                  Container(
                    height:49,
                    width: 160,
                    padding:EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Text(
                      ((customerForReciteGeneration.flatOrHouseNumber == null) ||
                          (customerForReciteGeneration.flatOrHouseNumber.length ==
                              0)) ?
                      'EMPTY' :customerForReciteGeneration.flatOrHouseNumber.length>20?
                      customerForReciteGeneration.flatOrHouseNumber.substring(0,17) +'...':
                      customerForReciteGeneration.flatOrHouseNumber,

                      maxLines:2,
                      textAlign: TextAlign.left,
                      style: TextStyle(
//                      fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 20, fontFamily: 'Itim-Regular',),

                    ),
                  ),

                  Container(
                    height:50,
                    width: 160,
                    padding:EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Text(

                      ((customerForReciteGeneration.phoneNumber == null) ||
                          (customerForReciteGeneration.phoneNumber.length == 0)) ?
                      'EMPTY' :customerForReciteGeneration.phoneNumber.length>20?
                    customerForReciteGeneration.phoneNumber.substring(0,17) +'...':
                      customerForReciteGeneration.phoneNumber,
                      maxLines: 2,

                      textAlign: TextAlign.left,
                      style: TextStyle(
//                      fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 20, fontFamily: 'Itim-Regular',),

                    ),
                  ),


                  // 3 ends here.
                ],
              ),
            )

            //rounded rectangle border and text conted inside it ends here.

          ],
        ),
      ),
    );
  }


  Widget paidUnpaidDeliveryType(OneOrderFirebase oneOrderForReceipt) {
    print(
        'at paidUnpaidDeliveryType: && oneOrderForReceipt.orderBy: ${oneOrderForReceipt
            .orderBy}'
            'oneOrderForReceipt.paidStatus: ${oneOrderForReceipt.paidStatus}');
//  Widget paidUnpaidDeliveryType =
    return new Directionality(
      textDirection: TextDirection.ltr,
      child:
      Container(
//        color: Colors.blue,
//        width: displayWidth(context) / 1.8,
        height: 60,

//        margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(

//            color:Colors.yellow,

//            color:Colors.yellowAccent,
              height: 55,
              width: 40,

              decoration: BoxDecoration(
                border: Border.all(

                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 1.0,

                ),
                shape: BoxShape.circle,
                color: Colors.black,


              ),

              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                child: Icon(
//        getIconForName(orderTypeName),
//        IconData:

                  oneOrderForReceipt.paidStatus.toLowerCase() == 'paid' ? Icons.thumb_up :
                  Icons.pan_tool,
//        FontAwesomeIcons.bookmark,
                  color: Colors.white,
                  size: 35,
                ),
              ),


            ),

            //rounded rectangle border and text conted inside it begins here.


            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 3.6,
                ),
//                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(35.0),
//                    color: Colors.black,

              ),

              width: 200,
              height: 50,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <
                    Widget>[
                  //  SizedBox(width: 5,),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      oneOrderForReceipt.paidStatus.toLowerCase() == 'paid' ?
                      'paid' : 'unpaid',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                          color: Color(0xffF50303),
                        fontSize: 17, fontFamily: 'Itim-Regular',),
                    ),
                  ),
                  Text(
                    (oneOrderForReceipt.orderBy.toLowerCase() == 'delivery')
                        ? 'Delivery'
                        :
                    (oneOrderForReceipt.orderBy.toLowerCase() == 'phone') ?
                    'Phone' : (oneOrderForReceipt.orderBy.toLowerCase() ==
                        'takeaway') ? 'TakeAway' : 'Dinning Room',
//                    oneOrderForReceipt.orderBy
//                    'dinning room',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 17, fontFamily: 'Itim-Regular',),
                  ),
                ],
              ),
            ),

            Container(

//            color:Colors.yellow,

//            color:Colors.yellowAccent,
              height: 55,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
//                  style: BorderStyle.solid,
                  width: 1.0,
                ),
                shape: BoxShape.circle,
                color: Colors.black,
              ),

              child: Icon(
//        getIconForName(orderTypeName),
//        IconData:
                (oneOrderForReceipt.orderBy.toLowerCase() == 'delivery') ? Icons
                    .motorcycle :
                (oneOrderForReceipt.orderBy.toLowerCase() == 'phone') ?
                Icons.phone_in_talk : (oneOrderForReceipt.orderBy
                    .toLowerCase() == 'takeaway')
                    ? Icons.business_center
                    : Icons.local_dining,
//                Icons.local_dining,
//        FontAwesomeIcons.bookmark,
                color: Colors.white,
                size: 35,

              ),


            ),

            //rounded rectangle border and text conted inside it ends here.


          ],
        ),
      ),
    );
  }

  Widget restaurantName(String name) {
    return Directionality(
      textDirection:
      TextDirection.ltr,
      child: Text('${name.toLowerCase()}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle
            (
            fontSize: 24,
            fontWeight:
            FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Itim-Regular',
          )
      ),
    );
  }

  Widget subTotalTotalDeliveryCost(double subtotal,
      {double deliveryCost: 2.50}) {
    Path customPathTotalCost = Path()
      ..moveTo(200, 120)
      ..lineTo(0, 120);

    return Directionality(

      textDirection: TextDirection.ltr,
      child:
      Container(
//        color:Colors.green,
        height: 170,

//        margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
        width: 300,
        /*
        decoration: BoxDecoration(
          border: Border.all(

            color: Colors.black,
            style: BorderStyle.solid,
            width: 1.0,

          ),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(35.0),

        ),
        */
        child:

        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[


            //rounded rectangle border and text conted inside it begins here.


            Container(
//                    height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <
                    Widget>[
                  //  SizedBox(width: 5,),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      'SUBTOTAL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
//                            fontWeight: FontWeight.bold,
                        color: Colors.black,
//                          color: Color(0xffF50303),
                        fontSize: 14, fontFamily: 'Itim-Regular',),
                    ),
                  ),

                  // qwe
//                          '${
//                              (unObsecuredInputandPayment.totalPrice
//                                  /* * unObsecuredInputandPayment.totalPrice */).toStringAsFixed(2)} '
//                              '\u20AC',
                  Text(subtotal.toStringAsFixed(2) + '\u20AC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
//                          fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 14, fontFamily: 'Itim-Regular',),
                  ),
                ],
              ),
            ),

            // 1st row ends here.


            Container(
//                    height: 50,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <
                    Widget>[
                  //  SizedBox(width: 5,),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      'Delivery Cost',
                      textAlign: TextAlign.center,
                      style: TextStyle(
//                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                          color: Color(0xffF50303),
                        fontSize: 14, fontFamily: 'Itim-Regular',),
                    ),
                  ),
                  Text(deliveryCost.toStringAsFixed(2) + '\u20AC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
//                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 14, fontFamily: 'Itim-Regular',),
                  ),
                ],
              ),
            ),

            /*
              DottedBorder(
//                dashPattern: [6, 3,2, 3],
                dashPattern: [9, 6,],
                customPath: (size) => customPath2,
                child: Text('abc',style:TextStyle(
                  color:Colors.indigo,
                )
                  ,),
              ),

              */
            /*
              DottedBorder(
                customPath: (size) => customPath, // PathBuilder
                color: Colors.indigo,
                dashPattern: [8, 4],
                strokeWidth: 2,
                child: Container(
                  height: 220,
                  width: 120,
                  color: Colors.green.withAlpha(20),
                ),
              ),

*/

//              DottedBorder(
//              child:StrokeCap.Butt),


            //2nd row ends here.


            Container(
//              height: 50,
//              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <
                    Widget>[
                  //  SizedBox(width: 5,),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      'TOTAL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                          color: Color(0xffF50303),
                        fontSize: 17, fontFamily: 'Itim-Regular',),
                    ),
                  ),
                  Text(
                    (deliveryCost + subtotal).toStringAsFixed(2) + '\u20AC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 17, fontFamily: 'Itim-Regular',),
                  ),
                ],
              ),
            ),

            // total ends here.


          ],
        ),

      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);


    var logger = Logger(
      printer: PrettyPrinter(),
    );


    return GestureDetector(
        onTap: () {
          print('s');
//                      Navigator.pop(context);
          FocusScopeNode currentFocus = FocusScope.of(
              context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
//                  Navigator.pop(context);

          }
        },


        child:
        Scaffold(
          key: _scaffoldKeyShoppingCartPage,
          backgroundColor: Colors.white.withOpacity(0.05),
//          backgroundColor: Colors.purpleAccent,

//      resizeToAvoidBottomPadding: false ,
          // appBar: AppBar(title: Text('Food Gallery')),
          body:
          WillPopScope(
            onWillPop: () {
              final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(
                  context);
              print('at WillPopScope: ');

              List<SelectedFood> backUP = shoppingCartBloc
                  .getExpandedSelectedFood;
              print('at WillPopScope : $backUP');

              Order z = shoppingCartBloc.getCurrentOrder;
              z.selectedFoodInOrder = backUP;

              shoppingCartBloc.clearSubscription();

              logger.e('at WillPopScope Quantity: ${z.selectedFoodInOrder[0]
                  .quantity}');

              Navigator.pop(context, z);
              return new Future(() => false);
            }, child:
          SafeArea(
            child: SingleChildScrollView(
              child:

              StreamBuilder<Order>(


                  stream: shoppingCartBloc.getCurrentOrderStream,
                  initialData: shoppingCartBloc.getCurrentOrder,

                  builder: (context, snapshot) {
//            if (snapshot.hasData) {

//              print('snapshot.hasData in main build(BuildContext context) : ${snapshot.hasData}');
                    // ---

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Container(
                          margin: EdgeInsets.fromLTRB(
                              0, displayHeight(context) / 2, 0, 0),
                          child: Center(
                            child: Column(
                              children: <Widget>[

                                Center(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: new CircularProgressIndicator(
                                          backgroundColor: Colors
                                              .lightGreenAccent)
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
                                          backgroundColor: Color(0xffFC0000))
                                  ),
                                ),
                              ],
                            ),
                          ),

                        );
                        break;

                      case ConnectionState.active:
                      default:
                        if (snapshot.data == null) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(
                                0, displayHeight(context) / 2, 0, 0),
                            child: Center(
                              child: Column(
                                children: <Widget>[

                                  Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: new CircularProgressIndicator(
                                            backgroundColor: Colors
                                                .lightGreenAccent)
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
                                            backgroundColor: Color(0xffFC0000))
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          );
                        }
                        else {
                          Order oneOrder = snapshot.data;

                          if((oneOrder.paymentButtonPressed==true) && (oneOrder.recitePrinted==false)){
                            return Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, displayHeight(context) / 2, 0, 0),
                              child: Center(
                                child: Column(
                                  children: <Widget>[

                                    Center(
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: new CircularProgressIndicator(
                                              backgroundColor: Colors
                                                  .lightGreenAccent)
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'printing recite... please wait.'
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: new CircularProgressIndicator(
                                              backgroundColor: Color(0xffFC0000))
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            );
                          }


//              int x = 5;

                          CustomerInformation x = oneOrder.orderingCustomer;

//              logger.e(' oneOrder.paymentTypeIndex: ${oneOrder.paymentTypeIndex}');


//                  Scaffold(
//                    key: _scaffoldKey,


//                      backgroundColor: Colors.white,
                          // this is the main reason of transparency at next screen.
                          // I am ignoring rest implementation but what i have achieved is you can see.


                          logger.e(
                              '\n\n AM I EXECUTED TWICE snapshot.data !=null  in build method  ;;; \n\n ');

                          return Container(
//                            height: displayHeight(context) -
//                                MediaQuery
//                                    .of(context)
//                                    .padding
//                                    .top -
//                                kToolbarHeight,
//                            backgroundColor: Colors.white.withOpacity(0.05),
//                          backgroundColor: Colors.white.withOpacity(0.05),
                            height: displayHeight(context),
                            child: Column(
                              children: <Widget>[
                                Container(


//                              alignment: Alignment.bottomCenter,
                                  height: displayHeight(context) / 1.10,
                                  //width:displayWidth(context) / 1.5, /* 3.8*/
                                  width: displayWidth(context)
                                      - displayWidth(context) /
                                          5 /* this is about the width of yellow side menu */
                                  ,
//                  color:Colors.lightGreenAccent,
                                  margin: EdgeInsets.fromLTRB(
                                      12, displayHeight(context) / 16, 10, 0),


                                  child: Neumorphic(
                                    // State of Neumorphic (may be convex, flat & emboss)

//                                      NeumorphicStyle
//                                      NeumorphicBoxShape
//                                      boxShape:

                                    curve: Neumorphic.DEFAULT_CURVE,
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape
                                          .concave,
                                      depth: 8,
                                      lightSource: LightSource
                                          .topLeft,
                                      color: Colors.white,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.all(Radius.circular(15)),

                                      ),
                                    ),


                                    // THIS CHILD COLUMNS HOLDS THE CONTENTS OF THIS PAGE. BEGINS HERE.


                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: <Widget>[

//                                          /WWW??


                                        // IMAGES OF FOODS   QUANTITY TIMES PUT HERE


                                        Container(
                                          width: displayWidth(context) / 1.1,
                                          height: displayHeight(context) / 20,
                                          color: Color(0xffffffff),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start
                                            ,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: <Widget>[


                                              Container(
                                                width: displayWidth(context) /
                                                    1.5,
                                                height: displayHeight(
                                                    context) / 20,
                                                color: Color(0xffffffff),

                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start
                                                    ,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    children: <Widget>[

                                                      Container(
                                                        margin: EdgeInsets
                                                            .fromLTRB(
                                                            20, 0, 10, 0),
                                                        alignment: Alignment
                                                            .center,
                                                        child: Text(
                                                            'Shopping Cart',
                                                            style: TextStyle(
                                                              fontSize: 30,
                                                              fontWeight: FontWeight
                                                                  .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                                              color: Color(
                                                                  0xff000000),
                                                            )
                                                        ),
                                                      ),

                                                      CustomPaint(
                                                        size: Size(0, 19),
                                                        painter: LongHeaderPainterAfterShoppingCartPage(
                                                            context),
                                                      ),


                                                    ]
                                                ),

                                              ),

                                              // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                                              Container(
//                                                  alignment: Alignment.center,
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 2, 0, 0),
                                                width: displayWidth(context) /
                                                    16,
//                                                height: displayHeight(context)/20,
                                                color: Color(0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                child: Container(
                                                  padding: EdgeInsets
                                                      .fromLTRB(0, 0, 200, 0),
                                                  child: Icon(

                                                    Icons.add_shopping_cart,
                                                    size: 30,
                                                    color: Color(0xff54463E),
                                                  ),
                                                ),


                                              ),


                                              // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                                            ],
                                          ),
                                        ),

                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
//                                                      padding::::
//                                          color: Colors.amberAccent,
                                          color: Colors.white,
//                                      FROM height: displayHeight(context) / 5.2 TO 4.8 ON JUNE 16
                                          height: displayHeight(context) / 4.8,
                                          width: displayWidth(context)
                                              - displayWidth(context) /
                                                  5, /* this is about the width of yellow side menu */

//                                            width: displayWidth(context) * 0.57,
                                          child:

                                          //ssd

                                          StreamBuilder<List<SelectedFood>>(
                                              stream: shoppingCartBloc
                                                  .getExpandedFoodsStream,
                                              initialData: shoppingCartBloc
                                                  .getExpandedSelectedFood,

                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  List<
                                                      SelectedFood> expandedSelectedFoodInOrder = snapshot
                                                      .data;


//            logger.e(
//                'selectedFoodListLength: ${qTimes.selectedFoodListLength}');

//    final foodItemDetailsbloc = BlocProvider.of<ShoppingCartBloc>(context);

                                                  if (expandedSelectedFoodInOrder ==
                                                      null) {
                                                    print('Order has no data');
                                                    print(
                                                        'this will never happen don\'t worry');
//        return Center(child: new LinearProgressIndicator());
                                                    return Container(
                                                        child: Text(
                                                            'expandedSelectedFoodInOrder == Null'));
                                                  }

                                                  //    VIEW MODEL CHANGE THUS CONDITION CHANGE 1.
                                                  /*
    if ((qTimes.foodItemName == '') && (qTimes.quantity == 0)) {
      print('Order has no data');
      print('this will never happen don\'t worry');
//        return Center(child: new LinearProgressIndicator());
      return Container(child: Text('Null'));
    }
    */
                                                  else {
//      int quantity = qTimes.quantity;
//      int quantity = qTimes.selectedFoodInOrder.length;

                                                    List<
                                                        SelectedFood> allOrderedFoods = expandedSelectedFoodInOrder;


                                                    logger.e(
                                                        '\n\n AM I EXECUTED TWICE  ;;;'
                                                            ' allOrderedFoods.length: ${allOrderedFoods
                                                            .length} \n\n ');
                                                    return Container(
//                color: Colors.green,
                                                      color: Color(0xffFFFFFF),

                                                      child: ListView.builder(
                                                        scrollDirection: Axis
                                                            .horizontal,

                                                        reverse: false,

                                                        shrinkWrap: false,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
//          itemCount: quantity,
                                                        itemCount: allOrderedFoods
                                                            .length,
                                                        // List<SelectedFood> tempSelectedFoodInOrder = totalCartOrder.selectedFoodInOrder;


                                                        itemBuilder: (_,
                                                            int index) {
//            return Text('ss');

                                                          return FoodImageInShoppingCart(
                                                              allOrderedFoods[index]
                                                                  .foodItemImageURL, /*OrderedFoodImageURL,*/
                                                              allOrderedFoods[index]
                                                                  .foodItemName, /*OrderedFoodItemName, */
                                                              allOrderedFoods[index]
                                                                  .selectedIngredients,
                                                              allOrderedFoods[index]
                                                                  .unitPrice,
                                                              index
                                                          );
//          oneMultiSelectInDetailsPage(foodItemPropertyOptions[index],
//            index);


                                                        },
                                                      ),


                                                      // M VSM ORG VS TODO. ENDS HERE.
                                                    );
                                                  }
                                                }
                                                else {
                                                  print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
                                                  return Container(
                                                      child: Text('Null'));
                                                }
                                              }
                                          ),
                                          //ssd
                                        ),


                                        // work 1
                                        Container(
//                                        width: displayWidth(context) /1.8,
                                          width: displayWidth(context) / 1.1,
                                          child:
                                          AnimatedSwitcher(
                                            duration: Duration(
                                                milliseconds: 1000),
//
                                            child: showFullOrderType
                                                ?
                                            animatedWidgetShowFullOrderType()
                                                : /*1 */
                                            animatedWidgetShowSelectedOrderType(), /* 2*/
                                            // 1 => displayHeight(context) / 20 + displayHeight(context) / 7
                                            // 2 => height: displayHeight(context) / 9,

                                          ),


                                        ),


                                        /*
                                            * INITIAL CHOOSE ORDER TYPE ENDS HERE.*/


                                        // work 2
                                        Container(
//                                          color: Colors.red,
//                                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                        width: displayWidth(context) /1.8,
                                          width: displayWidth(context) / 1.1,
                                          height: displayHeight(context) / 2.2,
//                                            height: displayWidth(context)/2.2
//                                          height: displayHeight(context)/2-42,
                                          // THIS HEIGHT SHOULDN'T BE GIVEN OTHERWISE
                                          // A CERTAIN PORTION OF OF THE CONTAINER
                                          // WITH YELLOW ACCENT BG COLOR IS
                                          // THERE WHEN THE CHILD WIDGETS ARE NOT
                                          // BIG ENOGH LIKE , AS BIG AS displayHeight(context)/2.5,


                                          //Text('AnimatedSwitcher('),
                                          child: AnimatedSwitcher(
                                            duration: Duration(
                                                milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
                                            child: oneOrder.orderTypeIndex == 0
                                                ?
                                            _buildShoppingCartInputFieldsUNObscuredTakeAway(
                                                oneOrder)
                                                : oneOrder.orderTypeIndex == 1 ?
                                            _buildShoppingCartInputFieldsUNObscured(
                                                oneOrder)
                                                : oneOrder.orderTypeIndex == 2 ?
                                            _buildShoppingCartInputFieldsUNObscured(
                                                oneOrder) :
                                            //OBSCURED NOT REQUIRED SINCE FOR DINNING ROOM OPTION WE WILL HAVE
                                            // WHEN DO YOU WANT THE FOOD ON YOUR TABLE.
//                                        _buildShoppingCartInputFieldsUNObscuredTakeAway(oneOrder)
                                            _buildShoppingCartInputFieldsUNObscuredDinningRoom(
                                                oneOrder),
//                                        animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


                                          ),


                                        ),


                                        /*
                                        // workTest
                                        Container(
                                          height:68,
//                                          color:Colors.lightBlueAccent,
                                          child: showAvailableDevices(),
                                        ),


                                        */

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          );
                        }
                    }
                  }
              ),
            ),


          ),
          ),
          floatingActionButton: StreamBuilder<bool>(
            stream: printerManager.isScanningStream,
            // dEFINED IN HERE: C:\src\flutter\.pub-cache\hosted\
            // pub.dartlang.org\esc_pos_bluetooth-0.2.8\lib\
            // src\printer_bluetooth_manager.dart
            initialData: false,
            builder: (c, snapshot) {
              if (snapshot.data) {
                return FloatingActionButton(
                  child: Icon(Icons.stop),
//                  onPressed: _stopScanDevices,
                  onPressed: () =>
                  {
                    print(
                        'debug print in onPressed() of floating action button: before calling _stopScanDevices'),
                    _stopScanDevices(),

                    /*
                  setState(() {
                  localScanAvailableState = !localScanAvailableState;
                  })
                    */


                  },
                  backgroundColor: Colors.red,
                );
              } else {
                return FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () =>
                  {
                    print(
                        'debug print in onPressed() of floating action button: before calling _startScanDevices'),
                    _startScanDevices(),

                    /*
                    setState(() {
                      localScanAvailableState = !localScanAvailableState;
                    })
                    */

                  },
//                  onPressed: _startScanDevices,
                );
              }
            },
          ),
        )
    );
    //return Text('${x.toString()}');

//  }
//    }
//}
//
////---
//);
////    }
  }


  double tryCast<num>(dynamic x, {num fallback }) {
//    print(" at tryCast");
//    print('x: $x');

    bool status = x is num;

//    print('status : x is num $status');
//    print('status : x is dynamic ${x is dynamic}');
//    print('status : x is int ${x is int}');
    if (status) {
      return x.toDouble();
    }

    if (x is int) {
      return x.toDouble();
    }
    else if (x is double) {
      return x.toDouble();
    }


    else
      return 0.0;
  }


  Widget test1(Order oneOrder) {
//    final Order oneOrder = snapshot.data;
//              _currentPaymentTypeIndex = oneOrder.paymentTypeIndex;


  }


  Widget animatedWidgetShowFullOrderType() {
//    print ('at animatedWidgetShowFullOrderType() ');

    return
      Container(
        height: displayHeight(context) / 20
            /* HEIGHT OF CHOOSE ORDER TYPE TEXT PORTION */
            + displayHeight(context) / 11 /* HEIGHT OF MULTI SELECT PORTION */,
//        from 7 to /8.5 on june 03

        child: Column(
          children: <Widget>[
            Container(
              width: displayWidth(context) / 1.1,
              height: displayHeight(context) / 20,
              color: Color(0xffffffff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .start
                ,
                crossAxisAlignment: CrossAxisAlignment
                    .center,
                children: <Widget>[


                  Container(
                    width: displayWidth(context) /
                        1.5,
                    height: displayHeight(
                        context) / 20,
                    color: Color(0xffffffff),

                    child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets
                                .fromLTRB(
                                20, 0, 10, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                'Choose Order Type',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),

                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForChooseOrderTypeUpdated(
                                context),
                          ),


                        ]
                    ),

                  ),

                  // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                  /*
                                                        Container(
//                                                  alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(
                                                              0, 2, 0, 0),
                                                          width: displayWidth(context) /
                                                              16,
//                                                height: displayHeight(context)/20,
                                                          color: Color(0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0, 200, 0),
                                                            child: Icon(

                                                              Icons.add_shopping_cart,
                                                              size: 30,
                                                              color: Color(0xff54463E),
                                                            ),
                                                          ),


                                                        ),
                                                        */


                  // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                  ////WWWEEEQQQ


                ],
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
//                                                      padding::::
//              color:Colors.green,
              color: Colors.white,
//                                            height: 200,
              height: displayHeight(context) / 11,
              width: displayWidth(context)
                  - displayWidth(context) /
                      5,
//                                            width: displayWidth(context) * 0.57,
              child: _buildOrderTypeSingleSelectOption(),

            ),
          ],
        ),
      );
  }


  Widget _buildOrderTypeSingleSelectOption() {
//   height: 40,
//   width: displayWidth(context) * 0.57,


    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return StreamBuilder(
        stream: shoppingCartbloc.getCurrentOrderTypeSingleSelectStream,
        initialData: shoppingCartbloc.getCurrentOrderType,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Container(child: Text('Null'));
          }
          else {
            List<OrderTypeSingleSelect> allOrderTypesSingleSelect = snapshot
                .data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

            print('orderTypes: $allOrderTypesSingleSelect');
            OrderTypeSingleSelect selectedOne = allOrderTypesSingleSelect
                .firstWhere((oneOrderType) =>
            oneOrderType.isSelected == true);
            _currentOrderTypeIndex = selectedOne.index;


            return Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,

//              reverse: true,

//              shrinkWrap: false,
                shrinkWrap: true,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
                itemCount: allOrderTypesSingleSelect.length,

                itemBuilder: (_, int index) {
                  return oneSingleDeliveryType(
                      allOrderTypesSingleSelect[index],
                      index);
                },
              ),
            );
          }
        }

      // M VSM ORG VS TODO. ENDS HERE.
    );
  }


  Widget animatedWidgetShowSelectedOrderType() {
    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return Container(
      height: displayHeight(context) / 9,
      child: StreamBuilder(
          stream: shoppingCartbloc.getCurrentOrderTypeSingleSelectStream,
          initialData: shoppingCartbloc.getCurrentOrderType,

          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
              return Container(child: Text('Null'));
            }
            else {
              List<OrderTypeSingleSelect> allOrderTypesSingleSelect = snapshot
                  .data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

//            print('orderTypes: $allOrderTypesSingleSelect');
              OrderTypeSingleSelect selectedOne = allOrderTypesSingleSelect
                  .firstWhere((oneOrderType) =>
              oneOrderType.isSelected == true);
              _currentOrderTypeIndex = selectedOne.index;


              String orderTypeName = selectedOne.orderType;
              String orderIconName = selectedOne.orderIconName;
              String borderColor = selectedOne.borderColor;
              const Color OrderTypeIconColor = Color(0xff070707);


              return Container(
                width: displayWidth(context) / 1.1,
                height: displayHeight(context) / 12,
                color: Color(0xffffffff),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[


                    Container(
                      width: displayWidth(context) /
                          1.5,
                      height: displayHeight(
                          context) / 20,
                      color: Color(0xffffffff),

                      child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start
                          ,
                          crossAxisAlignment: CrossAxisAlignment
                              .center,
                          children: <Widget>[

                            Container(
                              margin: EdgeInsets
                                  .fromLTRB(
                                  20, 0, 10, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  'Choose Order Type',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),

                            CustomPaint(
                              size: Size(0, 19),
                              painter: LongPainterForanimatedWidgetShowSelectedOrderType(
                                  context),
                            ),

                          ]
                      ),

                    ),
                    // THE ABOVE PART DEALS WITH LINES AND TEXT,
                    // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:

                    Container(

                      width: displayWidth(context) / 8,
                      height: displayHeight(context) / 10,
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
                      child:
                      InkWell(
//                        color: Color(0xff000000),

//          elevation: 2.5,
                        // RoundedRectangleBorder
//          shape: CircleBorder(

                        /*
                        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(
                            color:Color(0xff000000),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        */
                        child: Container(
//                        alignment: Alignment.topCenter,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .start
                            ,
//                          crossAxisAlignment: CrossAxisAlignment
//                              .center,
//                          AA
                            children: <Widget>[

                              new Container(

//                                width: displayWidth(context) * 0.09,
//                                height: displayWidth(context) * 0.11,

                                width: displayWidth(context) / 8.4,
                                height: displayHeight(context) / 15,
//                decoration: new BoxDecoration(
//                  color: Colors.orange,
//                  shape: BoxShape.circle,
//                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
//                    color: Colors.black,
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 1.0,

                                  ),
                                  shape: BoxShape.circle,
//                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
//                padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),


                                child: Icon(
                                  getIconForName(orderTypeName),
                                  color: Colors.black,
                                  size: displayHeight(context) / 24,

                                ),
                              ),

                              Container(

                                alignment: Alignment.center,
                                child: Text(
                                  orderTypeName, style:
                                TextStyle(
                                    color: Color(0xffFC0000),

                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          //final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                          //shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(x,index,_currentOrderTypeIndex);

                          // only one instance of this animatedWidgetShowSelectedOrderType() IS AVAILABLE AND IN below ().
                          // animatedWidgetShowSelectedOrderType()
                          setState(() {
                            showFullOrderType =
                            !showFullOrderType;

//                            showFullOrderType
                            /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
                            showCustomerInformationHeader = false;
                            showUserInputOptionsLikeFirstTime = true;
                            showFullPaymentType = true; //DEFAULT.

                            // JUST LIKE THE FIRST TIME.
                            showEditingCompleteCustomerAddressInformation =
                            false;
                            showEditingCompleteCustomerHouseFlatIformation =
                            false;
                            showEditingCompleteCustomerPhoneIformation = false;
                            showEditingCompleteCustomerReachoutIformation =
                            false;
                          });
                        },
                      ),
                      // : Container for 2nd argument of ternary condition ends here.

                    )


                    //ZZZZ


                  ],
                ),
              );
            }
          }
      ),
    );
  }

/*
  Widget animatedUnObscuredTextInputContainer(Order forUnObscured){

    print('at animated Un Obscured Text Input Container');
    return
      Container(
//            height: displayWidth(context)/2,
//          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
////                                                      padding::::
//          color:Colors.orange,
////                                            height: 200,
//          height: displayHeight(context) /2,
//          width: displayWidth(context)
//              - displayWidth(context) / 5,
//                                            width: displayWidth(context) * 0.57,

            child: _buildShoppingCartInputFieldsUNObscured(forUnObscured)



      );


  }
  */

  Widget animatedObscuredTextInputContainer(
      CustomerInformation forObscuredCustomerInputDisplay) {
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print('at animated Obscured Text Input Container');
    return
      AbsorbPointer(
        child: Opacity(
          opacity: 0.4,
          child: Container(
//            Colors.white.withOpacity(0.10),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                                      padding::::
              color: Colors.white,
//                                            height: 200,
              height: displayHeight(context) / 4,
              width: displayWidth(context)
                  - displayWidth(context) /
                      5,
//                                            width: displayWidth(context) * 0.57,
              /*
                                                    child:  AbsorbPointer(
                                                      child: _buildShoppingCartInputFields()
                                                  ),
                                                  */
              child: _buildShoppingCartInputFieldsObscured(
                  forObscuredCustomerInputDisplay)


          ),
        ),
      );
  }


  /*
  Widget _buildQuantityTimesofFood(/*Order qTimes */) {
//   height: 40,
//   width: displayWidth(context) * 0.57,

    var logger = Logger(
      printer: PrettyPrinter(),
    );

    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);



    return StreamBuilder<List<SelectedFood>>(
        stream: shoppingCartbloc.getExpandedFoodsStream,
        initialData: shoppingCartbloc.getExpandedSelectedFood,

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SelectedFood> expandedSelectedFoodInOrder = snapshot.data;


//            logger.e(
//                'selectedFoodListLength: ${qTimes.selectedFoodListLength}');

//    final foodItemDetailsbloc = BlocProvider.of<ShoppingCartBloc>(context);

            if (expandedSelectedFoodInOrder == null) {
              print('Order has no data');
              print('this will never happen don\'t worry');
//        return Center(child: new LinearProgressIndicator());
              return Container(child: Text('expandedSelectedFoodInOrder == Null'));
            }

            //    VIEW MODEL CHANGE THUS CONDITION CHANGE 1.
            /*
    if ((qTimes.foodItemName == '') && (qTimes.quantity == 0)) {
      print('Order has no data');
      print('this will never happen don\'t worry');
//        return Center(child: new LinearProgressIndicator());
      return Container(child: Text('Null'));
    }
    */
            else {
//      int quantity = qTimes.quantity;
//      int quantity = qTimes.selectedFoodInOrder.length;

              List<SelectedFood> allOrderedFoods = expandedSelectedFoodInOrder;
/*
//      int tempItemCount = allOrderedFoods.fold(0, (t, e) => t + e.quantity);

//      const tempAllOptionsState =ChildrensFromData.map((oneQuestion,index) => {
//      const opt1 = Array(oneQuestion.option1.length).fill({...templateOptionsState, key: index + 'o1'})
//      for(let i=0; i<opt1.length;i++){
//        opt1[i]= {key:index+'_o1_'+i,value:false};
//
//        }

//      void forEach(void f(E element)) {
//        for (E element in this) f(element);
//      }
              List<SelectedFood> selectedFoodforDisplay = new List<
                  SelectedFood>();

//      List<SelectedFood> test = makeMoreFoodByQuantity(allOrderedFoods.first);


              allOrderedFoods.forEach((oneFood) {
                print('oneFood details: ===> ===> ');
                print('oneFood: ${oneFood.foodItemName}');
                print('oneFood: ${oneFood.quantity}');
//         print('oneFood: ${oneFood.foodItemName}');
                List<SelectedFood> test = makeMoreFoodByQuantity(oneFood);

                print('MOMENT OF TRUTH: ');
                print(':::: ::: :: $test');
                selectedFoodforDisplay.addAll(test);
              });


//      selectedFoodforDisplay.addAll(test);

              logger.i('|| || || || forDisplay: $selectedFoodforDisplay');
              print('item count : ${selectedFoodforDisplay.length}');

              print('\n\n AM I EXECUTED TWICE  ;;; \n\n ');
//       allOrderedFoods.map((oneFood)=>
//      makeMoreFoodByQuantity(oneFood.quantity));
//      String OrderedFoodItemName = qTimes.foodItemName;
//      String OrderedFoodImageURL = qTimes.foodItemImageURL;

//      final String imageURLBig;
//      final String foodItemName;

//      final List<NewIngredient> selectedIngredients =qTimes.ingredients;
//      final double price = qTimes.unitPrice;

              */

              logger.e('\n\n AM I EXECUTED TWICE  ;;; \n\n ');
              print('expandedSelectedFoodInOrder: $expandedSelectedFoodInOrder');

              return Container(

//                color: Colors.green,
                color: Color(0xffFFFFFF),

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,

                  reverse: false,

                  shrinkWrap: false,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
//          itemCount: quantity,
                  itemCount: allOrderedFoods.length,
                  // List<SelectedFood> tempSelectedFoodInOrder = totalCartOrder.selectedFoodInOrder;


                  itemBuilder: (_, int index) {
//            return Text('ss');

                    return FoodImageInShoppingCart(
                        allOrderedFoods[index].foodItemImageURL, /*OrderedFoodImageURL,*/
                        allOrderedFoods[index].foodItemName, /*OrderedFoodItemName, */
                        allOrderedFoods[index].selectedIngredients,
                        allOrderedFoods[index].unitPrice,
                        index
                    );
//          oneMultiSelectInDetailsPage(foodItemPropertyOptions[index],
//            index);


                  },
                ),


                // M VSM ORG VS TODO. ENDS HERE.
              );
            }
          }
          else {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Container(child: Text('Null'));
          }
        }
    );
  }

   */


//  animatedShowUserAddressDetailsInLineTakeAway

  Widget animatedShowUserAddressDetailsInLineDinningRoom(
      CustomerInformation currentUserForInline) {
    return Container(
      width: displayWidth(context) / 1.1,
      height: displayHeight(context) / 21 + displayHeight(context) / 15,
//      height: displayHeight(context) / 8,
      // CHANGED FROM THIS */*  height: displayHeight(context) / 8, */ TO
      // THIS :  height: displayHeight(context) / 20, ON june  04 2020.
      color: Color(0xFFffffff),
      child: Column(
          children: <Widget>[
            Container(
              height: displayHeight(context) / 21,
//              color:Colors.purple,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[


                  Container(
                    width: displayWidth(context) /
                        1.5,
                    height: displayHeight(
                        context) / 21,
                    color: Color(0xffffffff),

                    child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets
                                .fromLTRB(
                                20, 0, 10, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                'when you want to receive it',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),

                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForanimatedWidgetShowSelectedOrderType(
                                context),
                          ),

                        ]
                    ),

                  ),
                  // THE ABOVE PART DEALS WITH LINES AND TEXT,
                  // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:


                  //ZZZZ


                ],
              ),
            ),
            // ABOVE ROW CONTROLS THE TEXT AND LINE PAINTER AND EDIT BUTTON.


            // BELOW ROW HANDLES THE CUSTOMER INFORMATION ALONG WITH ICON AND POSSIBLY EDIT BUTTON.
            //HHH

            Container(
              height: displayHeight(context) / 15,
//              color:Colors.amber,
              color: Colors.white,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: <Widget>[


                  RaisedButton(
                    color: Color(0xffFC0000),
//                    color:Color(0xffFC0000),
                    // highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    // clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.etaTimeInMinutes != -1 ?
                    Container(
                      color: Color(0xffFC0000),
//                       width:displayWidth(context) /10,
                      width: displayWidth(context) / 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.watch,
                              size: 32.0,
                              color: Colors.black
                          ),


                          // : Container for 2nd argument of ternary condition ends here.


                          Container(
                            padding: EdgeInsets
                                .fromLTRB(
                                5, 0, 5, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                '${currentUserForInline.etaTimeInMinutes}',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),
                    ) : Container(
                      width: displayWidth(context) / 4,
//                       width:displayWidth(context) /10,
                    )

                    // THIS CONTAINER ABOVE IS ABOUT ETA INFORMATION ENDS HERE.
                    ,
                    onPressed: () =>
                    {
                      setState(() {
                        showEditingCompleteCustomerReachoutIformation =
                        !showEditingCompleteCustomerReachoutIformation;


                        etaController.text =
                            currentUserForInline.etaTimeInMinutes.toString();


//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                  /*
                   Container(
                     height: 50,
                     color: Colors.amber[500],
                     child: const Center(child: Text('Entry B')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   */
                ],
              ),

            )


          ]
      ),
    );
//          }
//        }
//    );
  }

  Widget animatedShowUserAddressDetailsInLineTakeAway(
      CustomerInformation currentUserForInline) {
//    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);
//
//    return StreamBuilder(
//        stream: shoppingCartbloc.getCurrentOrderTypeSingleSelectStream,
//        initialData: shoppingCartbloc.getCurrentOrderType,
//
//        builder: (context, snapshot)
//        {
//          if (!snapshot.hasData) {
//            print('!snapshot.hasData');
////        return Center(child: new LinearProgressIndicator());
//            return Container(child: Text('Null'));
//          }
//          else {
//            List<OrderTypeSingleSelect> allOrderTypesSingleSelect = snapshot.data;
//
////            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;
//
//            print('orderTypes: $allOrderTypesSingleSelect');
//            OrderTypeSingleSelect selectedOne = allOrderTypesSingleSelect
//                .firstWhere((oneOrderType) => oneOrderType.isSelected == true);
//            _currentOrderTypeIndex = selectedOne.index;
//
//
//            String orderTypeName = selectedOne.orderType;
//            String orderIconName = selectedOne.orderIconName;
//            String borderColor = selectedOne.borderColor;
//            const Color OrderTypeIconColor=Color(0xff070707);


//    currentUserForInline

    return Container(
      width: displayWidth(context) / 1.1,
      height: displayHeight(context) / 21 + displayHeight(context) / 15,
//      height: displayHeight(context) / 8,
      // CHANGED FROM THIS */*  height: displayHeight(context) / 8, */ TO
      // THIS :  height: displayHeight(context) / 20, ON june  04 2020.
      color: Color(0xffffffff),
      child: Column(
          children: <Widget>[
            Container(
              height: displayHeight(context) / 21,
//              color:Colors.purple,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[


                  Container(
                    width: displayWidth(context) /
                        1.5,
                    height: displayHeight(
                        context) / 21,
                    color: Color(0xffffffff),

                    child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets
                                .fromLTRB(
                                20, 0, 10, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                'when you want to receive it',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),

                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForanimatedWidgetShowSelectedOrderType(
                                context),
                          ),

                        ]
                    ),

                  ),
                  // THE ABOVE PART DEALS WITH LINES AND TEXT,
                  // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:


                  //ZZZZ


                ],
              ),
            ),
            // ABOVE ROW CONTROLS THE TEXT AND LINE PAINTER AND EDIT BUTTON.


            // BELOW ROW HANDLES THE CUSTOMER INFORMATION ALONG WITH ICON AND POSSIBLY EDIT BUTTON.
            //HHH

            Container(
              height: displayHeight(context) / 15,
//              color:Colors.amber,
              color: Colors.white,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: <Widget>[

                  /*
                  RaisedButton(
                    color:Color(0xffFC0000),
                    // highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.address != ''? Container(
                      color:Colors.lightBlueAccent,
                      width:displayWidth(context) /2.6,
                      height:displayHeight(
                          context) / 20,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(

                            width: displayWidth(context)/34,
//                             height: displayHeight(context) /28,
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child:
                            Icon(Icons.location_on,
                                size: 32.0,
                                color: Colors.black),



                            //final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                            //shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(x,index,_currentOrderTypeIndex);

//                    setState(() {
//                      showFullOrderType = !showFullOrderType;
//                    });




                            // : Container for 2nd argument of ternary condition ends here.

                          ),
                          Expanded(
                            child: Container(
                              color:Color(0xffFC0000),
//                                  height: displayHeight(context) /28,
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .centerLeft,
                              child: Text(
                                  '${currentUserForInline.address}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
//                                      textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),




                          //ZZZZ


                        ],
                      ),):  Container(
                      width:displayWidth(context) /4.9,
//                              width:displayWidth(context) /5.5
                    ),

                    onPressed: ()=>{
                      setState(() {

                        showEditingCompleteCustomerAddressInformation = !showEditingCompleteCustomerAddressInformation;
                        addressController.text = currentUserForInline.address;

//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),
                  RaisedButton(
                    color:Color(0xffFC0000),
                    // highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.flatOrHouseNumber != ''?
                    Container(
                      color:Colors.brown,
//                       width:displayWidth(context) /2.6,
                      width:displayWidth(context) /4,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.home,
                              size: 32.0,
                              color: Colors.black
                          ),



                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  '${currentUserForInline.flatOrHouseNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),




                          //ZZZZ


                        ],
                      ),):  Container(
//                              width:displayWidth(context) /5.5
//                       width:displayWidth(context) /8,
                      width:displayWidth(context) /4,
                    )
                    ,
                    onPressed: ()=>{
                      setState(() {

                        showEditingCompleteCustomerHouseFlatIformation =
                        !showEditingCompleteCustomerHouseFlatIformation;

                        addressController.text = currentUserForInline.address;
                        houseFlatNumberController.text = currentUserForInline.flatOrHouseNumber;

//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                  // THIS CONTAINER ABOVE IS ABOUT HOUSE OR FLAT NUMBER INFORMATION ENDS HERE.
                  // THIS CONTAINER BELOW IS ABOUT PHONE NUMBER INFORMATION BEGINS HERE.
                  RaisedButton(
                    color:Color(0xffFC0000),
                    // highlightColor: Colors.lightGreenAccent,
//                        highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.phoneNumber != ''?
                    Container(
                      color:Colors.lightGreenAccent,
                      width:displayWidth(context) /3,

                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Icon(Icons.phone,
                              size: 32.0,
                              color: Colors.black)
                          ,


                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  '${currentUserForInline.phoneNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),




                          //ZZZZ


                        ],
                      ),):  Container(
                      width:displayWidth(context) /3,
//                              width:displayWidth(context) /5.5
//                       width:displayWidth(context) /5.9,
                    )
                    ,
                    onPressed: ()=>{
                      setState(() {

                        showEditingCompleteCustomerPhoneIformation =
                        !showEditingCompleteCustomerPhoneIformation;


                        phoneNumberController.text = currentUserForInline.phoneNumber;



//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),
                  */
                  RaisedButton(
                    color: Color(0xffFC0000),
                    // highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    // clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
                    highlightElevation: 12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: currentUserForInline.etaTimeInMinutes != -1 ?
                    Container(
                      color: Color(0xffFC0000),
//                       width:displayWidth(context) /10,
                      width: displayWidth(context) / 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.watch,
                              size: 32.0,
                              color: Colors.black
                          ),


                          // : Container for 2nd argument of ternary condition ends here.


                          Container(
                            padding: EdgeInsets
                                .fromLTRB(
                                5, 0, 5, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                '${currentUserForInline.etaTimeInMinutes}',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),
                    ) : Container(
                      width: displayWidth(context) / 4,
//                       width:displayWidth(context) /10,
                    )

                    // THIS CONTAINER ABOVE IS ABOUT ETA INFORMATION ENDS HERE.
                    ,
                    onPressed: () =>
                    {
                      setState(() {
                        showEditingCompleteCustomerReachoutIformation =
                        !showEditingCompleteCustomerReachoutIformation;


                        etaController.text =
                            currentUserForInline.etaTimeInMinutes.toString();


//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                  /*
                   Container(
                     height: 50,
                     color: Colors.amber[500],
                     child: const Center(child: Text('Entry B')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   */
                ],
              ),

            )


          ]
      ),
    );
//          }
//        }
//    );
  }

//}

  Widget animatedShowUserAddressDetailsInLine(
      CustomerInformation currentUserForInline) {
//    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);
//
//    return StreamBuilder(
//        stream: shoppingCartbloc.getCurrentOrderTypeSingleSelectStream,
//        initialData: shoppingCartbloc.getCurrentOrderType,
//
//        builder: (context, snapshot)
//        {
//          if (!snapshot.hasData) {
//            print('!snapshot.hasData');
////        return Center(child: new LinearProgressIndicator());
//            return Container(child: Text('Null'));
//          }
//          else {
//            List<OrderTypeSingleSelect> allOrderTypesSingleSelect = snapshot.data;
//
////            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;
//
//            print('orderTypes: $allOrderTypesSingleSelect');
//            OrderTypeSingleSelect selectedOne = allOrderTypesSingleSelect
//                .firstWhere((oneOrderType) => oneOrderType.isSelected == true);
//            _currentOrderTypeIndex = selectedOne.index;
//
//
//            String orderTypeName = selectedOne.orderType;
//            String orderIconName = selectedOne.orderIconName;
//            String borderColor = selectedOne.borderColor;
//            const Color OrderTypeIconColor=Color(0xff070707);


//    currentUserForInline

    return Container(
//      color:Colors.pink,
      width: displayWidth(context) / 1.1,
      height: displayHeight(context) / 21 + displayHeight(context) / 15,
//      height: displayHeight(context) / 8,
      // CHANGED FROM THIS */*  height: displayHeight(context) / 8, */ TO
      // THIS :  height: displayHeight(context) / 20, ON june  04 2020.
      color: Color(0xffffffff),
      child: Column(
          children: <Widget>[
            Container(
              height: displayHeight(context) / 21,
//              color:Colors.purple,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[


                  Container(
                    width: displayWidth(context) /
                        1.5,
                    height: displayHeight(
                        context) / 21,
                    color: Color(0xffffffff),

                    child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets
                                .fromLTRB(
                                20, 0, 10, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                'Enter user address',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),

                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForanimatedWidgetShowSelectedOrderType(
                                context),
                          ),

                        ]
                    ),

                  ),
                  // THE ABOVE PART DEALS WITH LINES AND TEXT,
                  // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:


                  //ZZZZ


                ],
              ),
            ),
            // ABOVE ROW CONTROLS THE TEXT AND LINE PAINTER AND EDIT BUTTON.


            // BELOW ROW HANDLES THE CUSTOMER INFORMATION ALONG WITH ICON AND POSSIBLY EDIT BUTTON.
            //HHH

            Container(
              height: displayHeight(context) / 15,
//              color:Colors.amber,
              color: Colors.white,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  RaisedButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                    splashColor: Color(0xffEEF6CE),
                    highlightColor: Color(0xffEEF6CE),
                    color: Color(0xffFFFFFF),
                    // highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    // clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
//                    highlightElevation: 12,


                    child: currentUserForInline.address != '' ? Container(
                      color: Color(0xffFFFFFF),
//                      color:Colors.lightBlueAccent,
                      width: displayWidth(context) / 4.9,
                      height: displayHeight(
                          context) / 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(

                            width: displayWidth(context) / 34,
//                             height: displayHeight(context) /28,
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child:
                            Icon(Icons.location_on,
                                size: 32.0,
                                color: Colors.black),


                            //final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                            //shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(x,index,_currentOrderTypeIndex);

//                    setState(() {
//                      showFullOrderType = !showFullOrderType;
//                    });


                            // : Container for 2nd argument of ternary condition ends here.

                          ),
                          Expanded(
                            child: Container(
                              color: Color(0xffFFFFFF),
//                              color:Color(0xffFC0000),
//                                  height: displayHeight(context) /28,
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .centerLeft,
                              child: Text(
                                  '${currentUserForInline.address}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
//                                      textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),) : Container(
                      color: Color(0xffFFFFFF),
//                      color:Colors.lightBlueAccent,
                      width: displayWidth(context) / 4.9,
                      height: displayHeight(
                          context) / 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(

                            width: displayWidth(context) / 34,
//                             height: displayHeight(context) /28,
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child:
                            Icon(Icons.location_on,
                                size: 32.0,
                                color: Colors.black),


                            //final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                            //shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(x,index,_currentOrderTypeIndex);

//                    setState(() {
//                      showFullOrderType = !showFullOrderType;
//                    });


                            // : Container for 2nd argument of ternary condition ends here.

                          ),
                          Expanded(
                            child: Container(
                              color: Color(0xffFFFFFF),
//                              color:Color(0xffFC0000),
//                                  height: displayHeight(context) /28,
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .centerLeft,
                              child: Text(
                                  'address',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
//                                      textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),),

                    onPressed: () =>
                    {
                      setState(() {
                        showEditingCompleteCustomerAddressInformation =
                        !showEditingCompleteCustomerAddressInformation;
                        addressController.text = currentUserForInline.address;

//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),
                  RaisedButton(

                    splashColor: Color(0xffEEF6CE),
                    highlightColor: Color(0xffEEF6CE),
                    color: Color(0xffFFFFFF),
//                    color:Color(0xffFFFFFF),
//                    color:Color(0xffFC0000),
                    // highlightColor: Colors.lightGreenAccent,
//
//
                    /*
//                  highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
                    highlightElevation: 12,

                    */
                    /*
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),

                    */
                    child: currentUserForInline.flatOrHouseNumber != '' ?
                    Container(
//                      color:Colors.brown,
                      color: Color(0xffFFFFFF),
//                       width:displayWidth(context) /2.6,
                      width: displayWidth(context) / 5.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.home,
                              size: 32.0,
                              color: Colors.black
                          ),


                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  '${currentUserForInline.flatOrHouseNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),) : Container(
//                      color:Colors.brown,
                      color: Color(0xffFFFFFF),
//                       width:displayWidth(context) /2.6,
                      width: displayWidth(context) / 5.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.home,
                              size: 32.0,
                              color: Colors.black
                          ),


                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  'flat number',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),)
                    ,
                    onPressed: () =>
                    {
                      setState(() {
                        showEditingCompleteCustomerHouseFlatIformation =
                        !showEditingCompleteCustomerHouseFlatIformation;

                        addressController.text = currentUserForInline.address;
                        houseFlatNumberController.text =
                            currentUserForInline.flatOrHouseNumber;

//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                  // THIS CONTAINER ABOVE IS ABOUT HOUSE OR FLAT NUMBER INFORMATION ENDS HERE.
                  // THIS CONTAINER BELOW IS ABOUT PHONE NUMBER INFORMATION BEGINS HERE.
                  RaisedButton(
                    splashColor: Color(0xffEEF6CE),
                    highlightColor: Color(0xffEEF6CE),
                    color: Color(0xffFFFFFF),
                    /*
                    color:Color(0xffFFFFFF),
//                    color:Color(0xffFC0000),
                    // highlightColor: Colors.lightGreenAccent,
//                        highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,
                    // splashColor: Color(0xffFC0000),
                    highlightElevation: 12,
                    */
                    /*
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    */
                    child: currentUserForInline.phoneNumber != '' ?
                    Container(
                      color: Color(0xffFFFFFF),
//                      color:Colors.lightGreenAccent,
                      width: displayWidth(context) / 5.5,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Icon(Icons.phone,
                              size: 32.0,
                              color: Colors.black)
                          ,


                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  '${currentUserForInline.phoneNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),) : Container(
                      color: Color(0xffFFFFFF),
//                      color:Colors.lightGreenAccent,
                      width: displayWidth(context) / 5.5,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Icon(Icons.phone,
                              size: 32.0,
                              color: Colors.black)
                          ,


                          // : Container for 2nd argument of ternary condition ends here.


                          Expanded(
                            child: Container(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  5, 0, 5, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  'phone',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),)
                    ,
                    onPressed: () =>
                    {
                      setState(() {
                        showEditingCompleteCustomerPhoneIformation =
                        !showEditingCompleteCustomerPhoneIformation;


                        phoneNumberController.text =
                            currentUserForInline.phoneNumber;


//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),
                  RaisedButton(
                    splashColor: Color(0xffEEF6CE),
                    highlightColor: Color(0xffEEF6CE),
                    color: Color(0xffFFFFFF),

                    /*
                    color:Color(0xffFFFFFF),
//                    color:Color(0xffFC0000),
//                    // highlightColor: Colors.lightGreenAccent,
//                    // splashColor: Color(0xffFC0000),
//                                                                          highlightedBorderColor: Colors.blueAccent,
                    clipBehavior: Clip.hardEdge,

                    highlightElevation: 12,
                    */
                    /*
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
//            width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),

                    */

                    child: currentUserForInline.etaTimeInMinutes != -1 ?
                    Container(
                      color: Color(0xffFFFFFF),
//                      color:Color(0xffFC0000),
//                       width:displayWidth(context) /10,
                      width: displayWidth(context) / 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.watch,
                              size: 32.0,
                              color: Colors.black
                          ),


                          // : Container for 2nd argument of ternary condition ends here.


                          Container(
                            padding: EdgeInsets
                                .fromLTRB(
                                5, 0, 5, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                '${currentUserForInline.etaTimeInMinutes}',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),
                    ) : Container(
                      color: Color(0xffFFFFFF),
//                      color:Color(0xffFC0000),
//                       width:displayWidth(context) /10,
                      width: displayWidth(context) / 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[


                          Icon(
                              Icons.watch,
                              size: 32.0,
                              color: Colors.black
                          ),


                          // : Container for 2nd argument of ternary condition ends here.


                          Container(
                            padding: EdgeInsets
                                .fromLTRB(
                                5, 0, 5, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                'ETA',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),


                          //ZZZZ


                        ],
                      ),
                    )

                    // THIS CONTAINER ABOVE IS ABOUT ETA INFORMATION ENDS HERE.
                    ,
                    onPressed: () =>
                    {
                      setState(() {
                        showEditingCompleteCustomerReachoutIformation =
                        !showEditingCompleteCustomerReachoutIformation;


                        etaController.text =
                            currentUserForInline.etaTimeInMinutes.toString();


//                      showFullOrderType = !showFullOrderType;
                      })
                    },
                  ),

                  /*
                   Container(
                     height: 50,
                     color: Colors.amber[500],
                     child: const Center(child: Text('Entry B')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   */
                ],
              ),

            )


          ]
      ),
    );
//          }
//        }
//    );
  }


// YYYY

  Widget unobscureInputandRestforDinningRoom(Order unObsecuredInputandPayment) {
    CustomerInformation currentUser = unObsecuredInputandPayment
        .orderingCustomer;
    // means
    // 1. Row Holding user's information.
    // 2. means holding the inputFields for User Input.
    // 3. If all 4 inputs are there show user the payment
    return Container(

      height: displayHeight(context) / 2.2,
//        height: displayHeight(context)/2.5,
      width: displayWidth(context) / 1.1,
//        height: displayHeight(context) / 2,
//      color: Colors.tealAccent,
      color: Colors.white,

      child: Column(
        children: <Widget>[


          // 1ST CONTAINER OF INPUTS BEGINS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher


          // COMMENTING THIS FOR TAKE AWAY, WE DON'T NEED ANIMATION HERE.
          /*
          Container(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
              child: (showUserInputOptionsLikeFirstTime == false)?
//      unobscureInputandRest(unObsecuredInputandPayment)

              animatedShowUserAddressDetailsInLineTakeAway(currentUser)


                  :

                  */

          /*
          Container(
            child:

            animatedShowUserAddressDetailsInLineDinningRoom(currentUser),
          ),
          */

          Container(
            width: displayWidth(context) / 1.1,
            height: displayHeight(context) / 20,
            color: Color(0xffffffff),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .start
              ,
              crossAxisAlignment: CrossAxisAlignment
                  .center,
              children: <Widget>[


                Container(
                  width: displayWidth(context) /
                      1.5,
                  height: displayHeight(
                      context) / 20,
                  color: Color(0xffffffff),

                  child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start
                      ,
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets
                              .fromLTRB(
                              20, 0, 10, 0),
                          alignment: Alignment
                              .center,
                          child: Text(
                              'possible dinning time ',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight
                                    .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(
                                    0xff000000),
                              )
                          ),
                        ),

                        CustomPaint(
                          size: Size(0, 19),
                          painter: LongPainterForDinning(
                              context),
                        ),


                      ]
                  ),

                ),

                // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                /*
                                                        Container(
//                                                  alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(
                                                              0, 2, 0, 0),
                                                          width: displayWidth(context) /
                                                              16,
//                                                height: displayHeight(context)/20,
                                                          color: Color(0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0, 200, 0),
                                                            child: Icon(

                                                              Icons.add_shopping_cart,
                                                              size: 30,
                                                              color: Color(0xff54463E),
                                                            ),
                                                          ),


                                                        ),
                                                        */


                // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                ////WWWEEEQQQ


              ],
            ),
          ),
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


          // ),
          // ),

          // 1ST CONTAINER OF INPUTS ENDS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher


          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.
          // BEGINS HERE.

          Container(
//            color:Colors.white38,
//            color:Colors.amber,
            color: Colors.white,

//            height: displayWidth(context)/2.6,
            height: displayWidth(context) / 2.1,
            child: Stack(
              children: <Widget>[
                Positioned(
//                  left:0,
                  // top:20,//displayHeight(context)/10,
                  // initial Case.
//            getNumberOfInputsFilledUp
//            getNumberOfInputsFilledUpDinningRoom

                  bottom:
                  getNumberOfInputsFilledUpDinningRoom(
                      unObsecuredInputandPayment.orderingCustomer) > 0
                      ? 22 : -10,
                  /*
                  0:
                  getNumberOfInputsFilledUp (
                      unObsecuredInputandPayment.ordersCustomer) <= 2?

                  0:
                  getNumberOfInputsFilledUp (
                      unObsecuredInputandPayment.ordersCustomer) == 3?
                  */

                  // from top to top distance offset related to Starting (top ) of
                  // orance Container.
//                  right:0,
//                  bottom:0,
                  child:
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
                    // zeroORMoreInputsEmpty
                    // zeroORMoreInputsEmptyTakeAway
                    // zeroORMoreInputsEmptyDinningRoom
                    child:
                    zeroORMoreInputsEmptyDinningRoom
                      (unObsecuredInputandPayment.orderingCustomer) == true ?

                    // animatedObscuredPaymentSelectContainerTakeAway
                    // animatedUnObscuredPaymentTypeUnSelectedContainerTakeAway
                    // animatedUnObscuredPaymentUnSelectContainer
                    // animatedObscuredPaymentSelectContainerTakeAway and Dinning Room
                    animatedObscuredPaymentSelectContainerTakeAway
                      (unObsecuredInputandPayment) :
                    animatedUnObscuredPaymentTypeUnSelectedContainerTakeAway
                      (unObsecuredInputandPayment),


                  ),
                  // ),

                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  top:
                  0,
//                  displayHeight(context)/4,
//                  getNumberOfInputsFilledUp (
//                      unObsecuredInputandPayment.ordersCustomer) ==4?


//                  displayWidth(context)/2.6 - displayWidth(context)/2,

                  // bottom 0 means full of green Container content shown.

                  child:
                  Container(
//                        alignment:Alignment.topCenter,0


                    // QQQ RoDo height
//                      height: displayWidth(context)/2.6,
                      child: Container(
//                            height: displayWidth(context)/2.6,
//                            height: displayHeight(context) / 3.7,
                        padding: EdgeInsets.fromLTRB(
                            (displayWidth(context) / 1.1) / 4,
                            15,
                            (displayWidth(context) / 1.1) / 4,
                            0

//                          horizontal: (displayWidth(context)/1.1)/4,
                        ),
//                        color: Colors.green,
                        color: Colors.white,
                        child: Center(
//                    color:Colors.white.withOpacity(0.9),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[


                                // CUSTOMER LOCATION ADDRESS CONTAINER BEGINS HERE.
//                            showEditingCompleteCustomerAddressInformation
//                            showEditingCompleteCustomerHouseFlatIformation
//                            showEditingCompleteCustomerPhoneIformation
//                            showEditingCompleteCustomerReachoutIformation
//                                showEditingCompleteCustomerAddressInformation BEGINS HERE.
                                /*
                                Container(
                                  child: showEditingCompleteCustomerAddressInformation?
                                  Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
                                    decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(

                                        color: Color(0xffBCBCBD),
                                        style: BorderStyle.solid,
                                        width: 2.0,


                                      ),

                                      boxShadow: [
                                        BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                            color: Color(0xffFFFFFF),
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 2.0))
                                      ],


                                      color: Color(0xffFFFFFF),
//                                      Colors.black54
                                    ),

//                                  color: Color(0xffFFFFFF),
                                    width: displayWidth(context) / 2.5,
                                    height: displayHeight(context) / 24,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 3, bottom: 3, right: 3),
                                    child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(

                                          height: 25,
                                          width: 5,
                                          margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                          child: Icon(
//                                          Icons.add_shopping_cart,
                                            Icons.location_on,

                                            size: 28,
                                            color: Color(0xffBCBCBD),
                                          ),


                                        ),

                                        Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                          alignment: Alignment.center,
                                          width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                          // do it in both Container
                                          child: TextField(
                                            controller: addressController,

                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),


                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              focusColor: Color(0xffFC0000),
//                                                            fillColor: Color(0xffFC0000),
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter delivery location',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                      currentUser
//                                        labelText: 'Search about meal.'
                                            ),


                                            onChanged: (text) {
                                              //RRRR

                                              print('at address of unobsecured (deliver loc)');

                                              final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//
                                              shoppingCartBloc.setAddressForOrder(text);
                                              if((text.trim().length) >0){
                                                print('at (text.trim().length) >0)');
                                                setState(() =>

                                                {
//                                          showEditingCompleteCustomerAddressInformation = true ,
                                                  showFullOrderType = false,

                                                });
                                              }
                                              else {
                                                setState(() =>

                                                {
                                                  showFullOrderType = false,

//                                                showCustomerInformationHeader = true,

                                                });
                                              }



                                              /*
                                                        setState(() =>
                                                        {
                                                          showFullOrderType = false,
//                                                showCustomerInformationHeader = true,
                                                        }

                                                        );
                                                        */
                                            },

                                            onTap: () {

                                              setState(() =>
                                              {
                                                showFullOrderType = false,

                                              });

                                            },




                                            /*
                                                      onTap: () {

                                                        print('on tap of line # 1607');

                                                        if((currentUser.phoneNumber.trim().length) >0 ||
                                                            (currentUser.flatOrHouseNumber.trim().length) >0 ||
                                                            (currentUser.etaTimeInMinutes != null)  )
                                                        {
                                                          showEditingCompleteCustomerAddressInformation = true;
                                                        } else {
                                                          setState(() =>
                                                          {
                                                            showFullOrderType = false,
//                                        showCustomerInformationHeader = true,
                                                          });
                                                        }
                                                      },
                                                      */
//                                              setState(() =>
//                                              {
//                                                showFullOrderType = false,
////                                                showCustomerInformationHeader = true,
//                                              }

                                            //);
//                                            },
//                                          },


                                            onEditingComplete: () {
                                              print('at editing complete of address ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerAddressInformation =
                                                true
//                                          showInputtedCustomerIformation= true,
                                              }
                                              );
                                            },
                                            /*


                                                                        onSubmitted: (String value) async {
                                                                          await showDialog<void>(
                                                                            context: context,
                                                                            builder: (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: const Text('Thanks!'),
                                                                                content: Text ('You typed "$value".'),
                                                                                actions: <Widget>[
                                                                                  FlatButton(
                                                                                    onPressed: () { Navigator.pop(context); },
                                                                                    child: const Text('OK'),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                    */


                                            style: TextStyle(
                                                color: Color(0xffFC0000), fontSize: 16),
                                          ),

                                        )

//                                  Spacer(),

//                                  Spacer(),

                                      ],
                                    ),
                                  ),
                                ),

                                */


                                // CUSTOMER LOACATION ADDRESS CONTAINER ENDS HERE.

                                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER BEGINS HERE.

                                //
//                                showEditingCompleteCustomerHouseFlatIformation BEGINS HERE


                                /*
                                Container(

                                  child: showEditingCompleteCustomerHouseFlatIformation?Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
                                    decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(

                                        color: Color(0xffBCBCBD),
                                        style: BorderStyle.solid,
                                        width: 2.0,


                                      ),

                                      boxShadow: [
                                        BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                            color: Color(0xffFFFFFF),
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 2.0))
                                      ],


                                      color: Color(0xffFFFFFF),
//                                      Colors.black54
                                    ),

//                                  color: Color(0xffFFFFFF),
                                    width: displayWidth(context) / 2.5,
                                    height: displayHeight(context) / 24,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 3, bottom: 3, right: 3),
                                    child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(

                                          height: 25,
                                          width: 5,
                                          margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                          child: Icon(
//                                          Icons.add_shopping_cart,
                                            Icons.home,
                                            size: 28,
                                            color: Color(0xffBCBCBD),
                                          ),


                                        ),

                                        Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                          alignment: Alignment.center,
                                          width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                          // do it in both Container
                                          child: TextField(
                                            controller: houseFlatNumberController,


                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter House/Flat address/number',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                        labelText: 'Search about meal.'
                                            ),

                                            onChanged: (text) {
                                              final shoppingCartBloc = BlocProvider.of<
                                                  ShoppingCartBloc>(context);
//
                                              shoppingCartBloc
                                                  .setHouseorFlatNumberForOrder(text);

                                              setState(() => showFullOrderType = false);
                                              // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                            },
                                            onTap: () {

                                              setState(() =>
                                              {
                                                showFullOrderType = false,

                                              });

                                            },


                                            /*
                                                      onTap: () {


                                                        if ((currentUser.address
                                                            .trim()
                                                            .length) > 0 ||
                                                            (currentUser.flatOrHouseNumber
                                                                .trim()
                                                                .length) > 0 ||
                                                            (currentUser.etaTimeInMinutes !=-1
                                                                )) {
                                                          showEditingCompleteCustomerHouseFlatIformation =
                                                          true;
                                                        } else {
                                                          setState(() =>
                                                          showFullOrderType = false);
                                                        }
                                                      },

                                                      */


                                            onEditingComplete: () {

                                              print('at editing complete of House or Flat Iformation ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerHouseFlatIformation =
                                                true
//                                          showInputtedCustomerIformation= true,
                                              }
                                              );
                                            },
                                            /*



                                                                        onSubmitted: (String value) async {
                                                                          await showDialog<void>(
                                                                            context: context,
                                                                            builder: (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: const Text('Thanks!'),
                                                                                content: Text ('You typed "$value".'),
                                                                                actions: <Widget>[
                                                                                  FlatButton(
                                                                                    onPressed: () { Navigator.pop(context); },
                                                                                    child: const Text('OK'),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },

                                                                        */

                                            style: TextStyle(
                                                color: Color(0xffFC0000), fontSize: 16),
                                          ),

                                        )

//                                  Spacer(),

//                                  Spacer(),

                                      ],
                                    ),
                                  ),
                                ),

                                */


                                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER ENDS HERE.

                                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER BEGINS HERE.

                                //  showEditingCompleteCustomerPhoneIformation BEGINS HERE.


                                /*
                                Container(

                                  child: showEditingCompleteCustomerPhoneIformation? Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
                                    decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(

                                        color: Color(0xffBCBCBD),
                                        style: BorderStyle.solid,
                                        width: 2.0,


                                      ),

                                      boxShadow: [
                                        BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                            color: Color(0xffFFFFFF),
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 2.0))
                                      ],


                                      color: Color(0xffFFFFFF),
//                                      Colors.black54
                                    ),

//                                  color: Color(0xffFFFFFF),
                                    width: displayWidth(context) / 2.5,
                                    height: displayHeight(context) / 24,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 3, bottom: 3, right: 3),
                                    child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(

                                          height: 25,
                                          width: 5,
                                          margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                          child: Icon(
//                                          Icons.add_shopping_cart,
                                            Icons.phone,
                                            size: 28,
                                            color: Color(0xffBCBCBD),
                                          ),


                                        ),

                                        Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                          alignment: Alignment.center,
                                          width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                          // do it in both Container
                                          child: TextField(
                                            controller: phoneNumberController,


                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),

                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter phone / telephone number',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                        labelText: 'Search about meal.'
                                            ),

                                            style: TextStyle(
                                                color: Color(0xffFC0000), fontSize: 16),

                                            onChanged: (text) {
                                              print("33: $text");

                                              final shoppingCartBloc = BlocProvider.of<
                                                  ShoppingCartBloc>(context);
//
                                              shoppingCartBloc.setPhoneNumberForOrder(
                                                  text);

                                              setState(() => showFullOrderType = false);
                                              // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                            },

                                            /*
                                                      onTap: () {
                                                        if ((currentUser.address
                                                            .trim()
                                                            .length) > 0 ||
                                                            (currentUser.flatOrHouseNumber
                                                                .trim()
                                                                .length) > 0 ||
                                                            (currentUser.etaTimeInMinutes !=-1
                                                                )) {
                                                          showEditingCompleteCustomerHouseFlatIformation =
                                                          true;
                                                        } else {
                                                          setState(() =>
                                                          showFullOrderType = false);
                                                        }
                                                      },
                                                      */

                                            onTap: () {

                                              setState(() =>
                                              {
                                                showFullOrderType = false,

                                              });

                                            },
                                            onEditingComplete: () {
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');

                                              print('at editing complete of Customer Phone Iformation ');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerPhoneIformation =
                                                true
//                                          showInputtedCustomerIformation= true,

                                              }

                                              );
                                            },

/*
                                                                        onSubmitted: (String value) async {
                                                                          await showDialog<void>(
                                                                            context: context,
                                                                            builder: (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: const Text('Thanks!'),
                                                                                content: Text ('You typed "$value".'),
                                                                                actions: <Widget>[
                                                                                  FlatButton(
                                                                                    onPressed: () { Navigator.pop(context); },
                                                                                    child: const Text('OK'),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                          */
                                          ),

                                        )

//                                  Spacer(),

//                                  Spacer(),

                                      ],
                                    ),
                                  ),
                                ),

                                */


                                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER ENDS HERE.

                                // CUSTOMER LOCATION REACH OUT TIME CONTAINER BEGINS HERE.

//                                showEditingCompleteCustomerReachoutIformation BEGINS HERE.
                                Container(

                                  child: showEditingCompleteCustomerReachoutIformation
                                      ? Container()
                                      :
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, 0, 0, 15),
                                    decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(

                                        color: Color(0xffBCBCBD),
                                        style: BorderStyle.solid,
                                        width: 2.0,


                                      ),

                                      boxShadow: [
                                        BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                            color: Color(0xffFFFFFF),
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 2.0))
                                      ],


                                      color: Color(0xffFFFFFF),
//                                      Colors.black54
                                    ),

//                                  color: Color(0xffFFFFFF),
                                    width: displayWidth(context) / 2.5,
                                    height: displayHeight(context) / 24,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 3, bottom: 3, right: 3),
                                    child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        Container(

//                                          height: 25,
                                          height: displayHeight(context) / 40,
                                          width: 5,
                                          margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                          child: Icon(
//                                          Icons.add_shopping_cart,
                                            Icons.watch_later,
                                            size: 28,
                                            color: Color(0xffBCBCBD),
                                          ),


                                        ),

                                        Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                          alignment: Alignment.center,
                                          width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                          // do it in both Container
                                          child: TextField(

                                            controller: etaController,


                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              WhitelistingTextInputFormatter
                                                  .digitsOnly
                                            ],

                                            textInputAction: TextInputAction
                                                .done,
//
                                            onSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .unfocus(),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
//                                              hintText: 'Enter when you want your ordered foods',
                                              hintText: 'After XX minutes',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                        labelText: 'Search about meal.'
                                            ),

                                            style: TextStyle(
                                                color: Color(0xffFC0000),
                                                fontSize: 16),

                                            onChanged: (text) {
                                              print("0444: $text");


                                              print("33: $text");
                                              final shoppingCartBloc = BlocProvider
                                                  .of<
                                                  ShoppingCartBloc>(context);

                                              shoppingCartBloc.setETAForOrder(
                                                  text);
                                              setState(() {
                                                showFullOrderType = false;

                                                // showFullOrderType
                                                /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                showCustomerInformationHeader =
                                                true;
                                                showUserInputOptionsLikeFirstTime =
                                                false;
                                                showFullPaymentType =
                                                true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                              }


                                              );
                                            },


                                            onTap: () {
                                              if ((currentUser.address
                                                  .trim()
                                                  .length) > 0 ||
                                                  (currentUser.flatOrHouseNumber
                                                      .trim()
                                                      .length) > 0 ||
                                                  (currentUser.phoneNumber
                                                      .trim()
                                                      .length) > 0) {
                                                showEditingCompleteCustomerHouseFlatIformation =
                                                true;
                                              } else {
                                                setState(() {
                                                  showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                                }

                                                );
                                              }
                                            },


//                                            onTap: () {
//                                              setState(() => showFullOrderType = false);
//                                            },
                                            onEditingComplete: () {
                                              print(
                                                  'at editing complete of Customer\'s address ETA Time:');
//                                              setState(() =>
//                                              {
//                                                showEditingCompleteCustomerReachoutIformation =
//                                                true
//                                              }
//                                              );

                                            },


/*

                                    onSubmitted: (String value) async {
                                      await showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Thanks!'),
                                              content: Text ('You typed "$value".'),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () { Navigator.pop(context); },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                        },
                                      );
                                    },
                                    */
                                          ),

                                        )


                                      ],
                                    ),
                                  ),
                                ),

                                // showEditingCompleteCustomerReachoutIformation ENDS HERE.
                                // CUSTOMER LOCATION REACH OUT TIME CONTAINER ENDS HERE.


                              ],
                            )
                        ),
                      )

                  ),

                )
              ],
            ),
          ),

          // ENDS HERE.
          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.


//            OOOO


          //VVVVVV

          // PAYMENT RELATED CONTAINER INVOKED FROM HERE:

//                        Flexible(
//                          child:

          // 3.


          // 3. ends here.
        ],

        //showInputtedCustomerIformation
      ),
    );
// GGG),

  }

  Widget unobscureInputandRestforTakeAway(Order unObsecuredInputandPayment) {
    CustomerInformation currentUser = unObsecuredInputandPayment
        .orderingCustomer;
    // means
    // 1. Row Holding user's information.
    // 2. means holding the inputFields for User Input.
    // 3. If all 4 inputs are there show user the payment
    return Container(

      height: displayHeight(context) / 2.2,
//        height: displayHeight(context)/2.5,
      width: displayWidth(context) / 1.1,
//        height: displayHeight(context) / 2,
//      color: Colors.tealAccent,
      color: Colors.white,

      child: Column(
        children: <Widget>[


          // 1ST CONTAINER OF INPUTS BEGINS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher


          // COMMENTING THIS FOR TAKE AWAY, WE DON'T NEED ANIMATION HERE.
          /*
          Container(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
              child: (showUserInputOptionsLikeFirstTime == false)?
//      unobscureInputandRest(unObsecuredInputandPayment)

              animatedShowUserAddressDetailsInLineTakeAway(currentUser)


                  :

                  */

          /*
          Container(
            child:

            animatedShowUserAddressDetailsInLineTakeAway(currentUser),
          ),

          */
          Container(
            width: displayWidth(context) / 1.1,
            height: displayHeight(context) / 20,
            color: Color(0xffffffff),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .start
              ,
              crossAxisAlignment: CrossAxisAlignment
                  .center,
              children: <Widget>[


                Container(
                  width: displayWidth(context) /
                      1.5,
                  height: displayHeight(
                      context) / 20,
                  color: Color(0xffffffff),

                  child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start
                      ,
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets
                              .fromLTRB(
                              20, 0, 10, 0),
                          alignment: Alignment
                              .center,
                          child: Text(
                              'when you will pick the Order',
//                              'when you want to receive your order'
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight
                                    .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(
                                    0xff000000),
                              )
                          ),
                        ),

                        CustomPaint(
                          size: Size(0, 19),
                          painter: LongPainterForETA(
                              context),
                        ),


                      ]
                  ),

                ),

                // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                /*
                                                        Container(
//                                                  alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(
                                                              0, 2, 0, 0),
                                                          width: displayWidth(context) /
                                                              16,
//                                                height: displayHeight(context)/20,
                                                          color: Color(0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0, 200, 0),
                                                            child: Icon(

                                                              Icons.add_shopping_cart,
                                                              size: 30,
                                                              color: Color(0xff54463E),
                                                            ),
                                                          ),


                                                        ),
                                                        */


                // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                ////WWWEEEQQQ


              ],
            ),
          ),
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


          // ),
          // ),

          // 1ST CONTAINER OF INPUTS ENDS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher


          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.
          // BEGINS HERE.

          Container(
//            color:Colors.white38,
//            color:Colors.amber,
            color: Colors.white,
//            height: displayWidth(context)/2.6,
            height: displayWidth(context) / 2.1,
            child: Stack(
              children: <Widget>[
                Positioned(
//                  left:0,
                  // top:20,//displayHeight(context)/10,
                  // initial Case.
//            getNumberOfInputsFilledUp
                  bottom:
                  getNumberOfInputsFilledUpTakeAway(
                      unObsecuredInputandPayment.orderingCustomer) > 0
                      ? 22 : -10,
                  /*
                  0:
                  getNumberOfInputsFilledUp (
                      unObsecuredInputandPayment.ordersCustomer) <= 2?

                  0:
                  getNumberOfInputsFilledUp (
                      unObsecuredInputandPayment.ordersCustomer) == 3?
                  */

                  // from top to top distance offset related to Starting (top ) of
                  // orance Container.
//                  right:0,
//                  bottom:0,
                  child:
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
                    // zeroORMoreInputsEmpty
                    // zeroORMoreInputsEmptyTakeAway
                    child:
                    zeroORMoreInputsEmptyTakeAway
                      (unObsecuredInputandPayment.orderingCustomer) == true ?

                    // animatedObscuredPaymentSelectContainerTakeAway
                    // animatedUnObscuredPaymentTypeUnSelectedContainerTakeAway
                    // animatedUnObscuredPaymentUnSelectContainer
                    animatedObscuredPaymentSelectContainerTakeAway
                      (unObsecuredInputandPayment) :
                    animatedUnObscuredPaymentTypeUnSelectedContainerTakeAway
                      (unObsecuredInputandPayment),


                  ),
                  // ),

                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  top:
                  0,
//                  displayHeight(context)/4,
//                  getNumberOfInputsFilledUp (
//                      unObsecuredInputandPayment.ordersCustomer) ==4?


//                  displayWidth(context)/2.6 - displayWidth(context)/2,

                  // bottom 0 means full of green Container content shown.

                  child:
                  Container(
//                        alignment:Alignment.topCenter,0


                    // QQQ RoDo height
//                      height: displayWidth(context)/2.6,
                      child: Container(
//                            height: displayWidth(context)/2.6,
//                            height: displayHeight(context) / 3.7,
                        padding: EdgeInsets.fromLTRB(
                            (displayWidth(context) / 1.1) / 4,
                            15,
                            (displayWidth(context) / 1.1) / 4,
                            0

//                          horizontal: (displayWidth(context)/1.1)/4,
                        ),
//                        color: Colors.green,
                        color: Colors.white,
                        child: Center(
//                    color:Colors.white.withOpacity(0.9),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[


                                // CUSTOMER LOCATION ADDRESS CONTAINER BEGINS HERE.
//                            showEditingCompleteCustomerAddressInformation
//                            showEditingCompleteCustomerHouseFlatIformation
//                            showEditingCompleteCustomerPhoneIformation
//                            showEditingCompleteCustomerReachoutIformation
//                                showEditingCompleteCustomerAddressInformation BEGINS HERE.
                                /*
                                Container(
                                  child: showEditingCompleteCustomerAddressInformation?
                                  Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
                                    decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(

                                        color: Color(0xffBCBCBD),
                                        style: BorderStyle.solid,
                                        width: 2.0,


                                      ),

                                      boxShadow: [
                                        BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                            color: Color(0xffFFFFFF),
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 2.0))
                                      ],


                                      color: Color(0xffFFFFFF),
//                                      Colors.black54
                                    ),

//                                  color: Color(0xffFFFFFF),
                                    width: displayWidth(context) / 2.5,
                                    height: displayHeight(context) / 24,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 3, bottom: 3, right: 3),
                                    child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(

                                          height: 25,
                                          width: 5,
                                          margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                          child: Icon(
//                                          Icons.add_shopping_cart,
                                            Icons.location_on,

                                            size: 28,
                                            color: Color(0xffBCBCBD),
                                          ),


                                        ),

                                        Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                          alignment: Alignment.center,
                                          width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                          // do it in both Container
                                          child: TextField(
                                            controller: addressController,

                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),


                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              focusColor: Color(0xffFC0000),
//                                                            fillColor: Color(0xffFC0000),
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter delivery location',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                      currentUser
//                                        labelText: 'Search about meal.'
                                            ),


                                            onChanged: (text) {
                                              //RRRR

                                              print('at address of unobsecured (deliver loc)');

                                              final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//
                                              shoppingCartBloc.setAddressForOrder(text);
                                              if((text.trim().length) >0){
                                                print('at (text.trim().length) >0)');
                                                setState(() =>

                                                {
//                                          showEditingCompleteCustomerAddressInformation = true ,
                                                  showFullOrderType = false,

                                                });
                                              }
                                              else {
                                                setState(() =>

                                                {
                                                  showFullOrderType = false,

//                                                showCustomerInformationHeader = true,

                                                });
                                              }



                                              /*
                                                        setState(() =>
                                                        {
                                                          showFullOrderType = false,
//                                                showCustomerInformationHeader = true,
                                                        }

                                                        );
                                                        */
                                            },

                                            onTap: () {

                                              setState(() =>
                                              {
                                                showFullOrderType = false,

                                              });

                                            },




                                            /*
                                                      onTap: () {

                                                        print('on tap of line # 1607');

                                                        if((currentUser.phoneNumber.trim().length) >0 ||
                                                            (currentUser.flatOrHouseNumber.trim().length) >0 ||
                                                            (currentUser.etaTimeInMinutes != null)  )
                                                        {
                                                          showEditingCompleteCustomerAddressInformation = true;
                                                        } else {
                                                          setState(() =>
                                                          {
                                                            showFullOrderType = false,
//                                        showCustomerInformationHeader = true,
                                                          });
                                                        }
                                                      },
                                                      */
//                                              setState(() =>
//                                              {
//                                                showFullOrderType = false,
////                                                showCustomerInformationHeader = true,
//                                              }

                                            //);
//                                            },
//                                          },


                                            onEditingComplete: () {
                                              print('at editing complete of address ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerAddressInformation =
                                                true
//                                          showInputtedCustomerIformation= true,
                                              }
                                              );
                                            },
                                            /*


                                                                        onSubmitted: (String value) async {
                                                                          await showDialog<void>(
                                                                            context: context,
                                                                            builder: (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: const Text('Thanks!'),
                                                                                content: Text ('You typed "$value".'),
                                                                                actions: <Widget>[
                                                                                  FlatButton(
                                                                                    onPressed: () { Navigator.pop(context); },
                                                                                    child: const Text('OK'),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                    */


                                            style: TextStyle(
                                                color: Color(0xffFC0000), fontSize: 16),
                                          ),

                                        )

//                                  Spacer(),

//                                  Spacer(),

                                      ],
                                    ),
                                  ),
                                ),

                                */


                                // CUSTOMER LOACATION ADDRESS CONTAINER ENDS HERE.

                                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER BEGINS HERE.

                                //
//                                showEditingCompleteCustomerHouseFlatIformation BEGINS HERE


                                /*
                                Container(

                                  child: showEditingCompleteCustomerHouseFlatIformation?Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
                                    decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(

                                        color: Color(0xffBCBCBD),
                                        style: BorderStyle.solid,
                                        width: 2.0,


                                      ),

                                      boxShadow: [
                                        BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                            color: Color(0xffFFFFFF),
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 2.0))
                                      ],


                                      color: Color(0xffFFFFFF),
//                                      Colors.black54
                                    ),

//                                  color: Color(0xffFFFFFF),
                                    width: displayWidth(context) / 2.5,
                                    height: displayHeight(context) / 24,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 3, bottom: 3, right: 3),
                                    child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(

                                          height: 25,
                                          width: 5,
                                          margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                          child: Icon(
//                                          Icons.add_shopping_cart,
                                            Icons.home,
                                            size: 28,
                                            color: Color(0xffBCBCBD),
                                          ),


                                        ),

                                        Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                          alignment: Alignment.center,
                                          width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                          // do it in both Container
                                          child: TextField(
                                            controller: houseFlatNumberController,


                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter House/Flat address/number',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                        labelText: 'Search about meal.'
                                            ),

                                            onChanged: (text) {
                                              final shoppingCartBloc = BlocProvider.of<
                                                  ShoppingCartBloc>(context);
//
                                              shoppingCartBloc
                                                  .setHouseorFlatNumberForOrder(text);

                                              setState(() => showFullOrderType = false);
                                              // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                            },
                                            onTap: () {

                                              setState(() =>
                                              {
                                                showFullOrderType = false,

                                              });

                                            },


                                            /*
                                                      onTap: () {


                                                        if ((currentUser.address
                                                            .trim()
                                                            .length) > 0 ||
                                                            (currentUser.flatOrHouseNumber
                                                                .trim()
                                                                .length) > 0 ||
                                                            (currentUser.etaTimeInMinutes !=-1
                                                                )) {
                                                          showEditingCompleteCustomerHouseFlatIformation =
                                                          true;
                                                        } else {
                                                          setState(() =>
                                                          showFullOrderType = false);
                                                        }
                                                      },

                                                      */


                                            onEditingComplete: () {

                                              print('at editing complete of House or Flat Iformation ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerHouseFlatIformation =
                                                true
//                                          showInputtedCustomerIformation= true,
                                              }
                                              );
                                            },
                                            /*



                                                                        onSubmitted: (String value) async {
                                                                          await showDialog<void>(
                                                                            context: context,
                                                                            builder: (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: const Text('Thanks!'),
                                                                                content: Text ('You typed "$value".'),
                                                                                actions: <Widget>[
                                                                                  FlatButton(
                                                                                    onPressed: () { Navigator.pop(context); },
                                                                                    child: const Text('OK'),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },

                                                                        */

                                            style: TextStyle(
                                                color: Color(0xffFC0000), fontSize: 16),
                                          ),

                                        )

//                                  Spacer(),

//                                  Spacer(),

                                      ],
                                    ),
                                  ),
                                ),

                                */


                                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER ENDS HERE.

                                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER BEGINS HERE.

                                //  showEditingCompleteCustomerPhoneIformation BEGINS HERE.


                                /*
                                Container(

                                  child: showEditingCompleteCustomerPhoneIformation? Container():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,0,0,15),
                                    decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(

                                        color: Color(0xffBCBCBD),
                                        style: BorderStyle.solid,
                                        width: 2.0,


                                      ),

                                      boxShadow: [
                                        BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                            color: Color(0xffFFFFFF),
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 2.0))
                                      ],


                                      color: Color(0xffFFFFFF),
//                                      Colors.black54
                                    ),

//                                  color: Color(0xffFFFFFF),
                                    width: displayWidth(context) / 2.5,
                                    height: displayHeight(context) / 24,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 3, bottom: 3, right: 3),
                                    child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(

                                          height: 25,
                                          width: 5,
                                          margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                          child: Icon(
//                                          Icons.add_shopping_cart,
                                            Icons.phone,
                                            size: 28,
                                            color: Color(0xffBCBCBD),
                                          ),


                                        ),

                                        Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                          alignment: Alignment.center,
                                          width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                          // do it in both Container
                                          child: TextField(
                                            controller: phoneNumberController,


                                            textInputAction: TextInputAction.next,
                                            onSubmitted: (_) => FocusScope.of(context).nextFocus(),

                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
                                              hintText: 'Enter phone / telephone number',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                        labelText: 'Search about meal.'
                                            ),

                                            style: TextStyle(
                                                color: Color(0xffFC0000), fontSize: 16),

                                            onChanged: (text) {
                                              print("33: $text");

                                              final shoppingCartBloc = BlocProvider.of<
                                                  ShoppingCartBloc>(context);
//
                                              shoppingCartBloc.setPhoneNumberForOrder(
                                                  text);

                                              setState(() => showFullOrderType = false);
                                              // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                            },

                                            /*
                                                      onTap: () {
                                                        if ((currentUser.address
                                                            .trim()
                                                            .length) > 0 ||
                                                            (currentUser.flatOrHouseNumber
                                                                .trim()
                                                                .length) > 0 ||
                                                            (currentUser.etaTimeInMinutes !=-1
                                                                )) {
                                                          showEditingCompleteCustomerHouseFlatIformation =
                                                          true;
                                                        } else {
                                                          setState(() =>
                                                          showFullOrderType = false);
                                                        }
                                                      },
                                                      */

                                            onTap: () {

                                              setState(() =>
                                              {
                                                showFullOrderType = false,

                                              });

                                            },
                                            onEditingComplete: () {
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');

                                              print('at editing complete of Customer Phone Iformation ');
                                              setState(() =>
                                              {
                                                showEditingCompleteCustomerPhoneIformation =
                                                true
//                                          showInputtedCustomerIformation= true,

                                              }

                                              );
                                            },

/*
                                                                        onSubmitted: (String value) async {
                                                                          await showDialog<void>(
                                                                            context: context,
                                                                            builder: (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: const Text('Thanks!'),
                                                                                content: Text ('You typed "$value".'),
                                                                                actions: <Widget>[
                                                                                  FlatButton(
                                                                                    onPressed: () { Navigator.pop(context); },
                                                                                    child: const Text('OK'),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                          */
                                          ),

                                        )

//                                  Spacer(),

//                                  Spacer(),

                                      ],
                                    ),
                                  ),
                                ),

                                */


                                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER ENDS HERE.

                                // CUSTOMER LOCATION REACH OUT TIME CONTAINER BEGINS HERE.

//                                showEditingCompleteCustomerReachoutIformation BEGINS HERE.
                                Container(

                                  child: showEditingCompleteCustomerReachoutIformation
                                      ? Container()
                                      :
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, 0, 0, 15),
                                    decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(

                                        color: Color(0xffBCBCBD),
                                        style: BorderStyle.solid,
                                        width: 2.0,


                                      ),

                                      boxShadow: [
                                        BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                            color: Color(0xffFFFFFF),
                                            blurRadius: 10.0,
                                            offset: Offset(0.0, 2.0))
                                      ],


                                      color: Color(0xffFFFFFF),
//                                      Colors.black54
                                    ),

//                                  color: Color(0xffFFFFFF),
                                    width: displayWidth(context) / 2.5,
                                    height: displayHeight(context) / 24,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 3, bottom: 3, right: 3),
                                    child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        Container(

//                                          height: 25,
                                          height: displayHeight(context) / 40,
                                          width: 5,
                                          margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                          child: Icon(
//                                          Icons.add_shopping_cart,
                                            Icons.watch_later,
                                            size: 28,
                                            color: Color(0xffBCBCBD),
                                          ),


                                        ),

                                        Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                          alignment: Alignment.center,
                                          width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                          // do it in both Container
                                          child: TextField(

                                            controller: etaController,


                                            keyboardType: TextInputType.number,
//                                            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              WhitelistingTextInputFormatter
                                                  .digitsOnly
                                            ],
//inputFormatters: <TextInputFormatter>[
//    WhitelistingTextInputFormatter.digitsOnly
//],
                                            textInputAction: TextInputAction
                                                .done,
//
                                            onSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .unfocus(),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                              border: InputBorder.none,
//                                              hintText: 'Enter when you want your ordered foods',
                                              hintText: 'After XX minutes',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 17),

//                                        labelText: 'Search about meal.'
                                            ),

                                            style: TextStyle(
                                                color: Color(0xffFC0000),
                                                fontSize: 16),

                                            onChanged: (text) {
                                              print("0444: $text");


                                              print("33: $text");
                                              final shoppingCartBloc = BlocProvider
                                                  .of<
                                                  ShoppingCartBloc>(context);

                                              shoppingCartBloc.setETAForOrder(
                                                  text);
                                              setState(() {
                                                showFullOrderType = false;

                                                // showFullOrderType
                                                /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                showCustomerInformationHeader =
                                                true;
                                                showUserInputOptionsLikeFirstTime =
                                                false;
                                                showFullPaymentType =
                                                true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                              }


                                              );
                                            },


                                            onTap: () {
                                              if ((currentUser.address
                                                  .trim()
                                                  .length) > 0 ||
                                                  (currentUser.flatOrHouseNumber
                                                      .trim()
                                                      .length) > 0 ||
                                                  (currentUser.phoneNumber
                                                      .trim()
                                                      .length) > 0) {
                                                showEditingCompleteCustomerHouseFlatIformation =
                                                true;
                                              } else {
                                                setState(() {
                                                  showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                                }

                                                );
                                              }
                                            },


//                                            onTap: () {
//                                              setState(() => showFullOrderType = false);
//                                            },
                                            onEditingComplete: () {
                                              print(
                                                  'at editing complete of Customer\'s address ETA Time:');
//                                              setState(() =>
//                                              {
//                                                showEditingCompleteCustomerReachoutIformation =
//                                                true
//                                              }
//                                              );

                                            },


/*

                                    onSubmitted: (String value) async {
                                      await showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Thanks!'),
                                              content: Text ('You typed "$value".'),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () { Navigator.pop(context); },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                        },
                                      );
                                    },
                                    */
                                          ),

                                        )


                                      ],
                                    ),
                                  ),
                                ),

                                // showEditingCompleteCustomerReachoutIformation ENDS HERE.
                                // CUSTOMER LOCATION REACH OUT TIME CONTAINER ENDS HERE.


                              ],
                            )
                        ),
                      )

                  ),

                )
              ],
            ),
          ),

          // ENDS HERE.
          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.


//            OOOO


          //VVVVVV

          // PAYMENT RELATED CONTAINER INVOKED FROM HERE:

//                        Flexible(
//                          child:

          // 3.


          // 3. ends here.
        ],

        //showInputtedCustomerIformation
      ),
    );
// GGG),

  }

// unobscureInputandRest(
// unobscureInputandRestDeliveryPhone
  Widget unobscureInputandRestDeliveryPhone(Order unObsecuredInputandPayment) {
    CustomerInformation currentUser = unObsecuredInputandPayment
        .orderingCustomer;
    // means
    // 1. Row Holding user's information.
    // 2. means holding the inputFields for User Input.
    // 3. If all 4 inputs are there show user the payment
    return Container(

      height: displayHeight(context) / 2.2,
//        height: displayHeight(context)/2.5,
      width: displayWidth(context) / 1.1,
//        height: displayHeight(context) / 2,
//      color: Colors.tealAccent,
//      color: Colors.deepPurpleAccent,

      child: Column(
        children: <Widget>[


          // 1ST CONTAINER OF INPUTS BEGINS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher
          Container(

            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
              child: (showUserInputOptionsLikeFirstTime == false) ?
//      unobscureInputandRest(unObsecuredInputandPayment)

              animatedShowUserAddressDetailsInLine(currentUser)


                  : Container(
                width: displayWidth(context) / 1.1,
                height: displayHeight(context) / 20,
//                color:Colors.blue,
//                color: Color(0xffffffff),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .start
                  ,
                  crossAxisAlignment: CrossAxisAlignment
                      .center,
                  children: <Widget>[


                    Container(
                      width: displayWidth(context) /
                          1.5,
                      height: displayHeight(
                          context) / 20,
                      color: Color(0xffffffff),

                      child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start
                          ,
                          crossAxisAlignment: CrossAxisAlignment
                              .center,
                          children: <Widget>[

                            Container(
                              margin: EdgeInsets
                                  .fromLTRB(
                                  20, 0, 10, 0),
                              alignment: Alignment
                                  .center,
                              child: Text(
                                  'Enter user address',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight
                                        .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Color(
                                        0xff000000),
                                  )
                              ),
                            ),

                            CustomPaint(
                              size: Size(0, 19),
                              painter: LongPainterForChooseOrderTypeAdress(
                                  context),
                            ),


                          ]
                      ),

                    ),

                    // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                    /*
                                                        Container(
//                                                  alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(
                                                              0, 2, 0, 0),
                                                          width: displayWidth(context) /
                                                              16,
//                                                height: displayHeight(context)/20,
                                                          color: Color(0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0, 200, 0),
                                                            child: Icon(

                                                              Icons.add_shopping_cart,
                                                              size: 30,
                                                              color: Color(0xff54463E),
                                                            ),
                                                          ),


                                                        ),
                                                        */


                    // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                    ////WWWEEEQQQ


                  ],
                ),
              ),
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


            ),
          ),

          // 1ST CONTAINER OF INPUTS ENDS HERE. HOLDS
          // LABEL TEXT, OR
          // LABEL TEXT + USER INPUT INLINE IN AN AnimatedSwitcher


          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.
          // BEGINS HERE.

          Container(
//            color:Colors.white38,
//            color:Colors.black87,
//            color:Colors.black87,
//            height: displayWidth(context)/2.6,
            height: displayHeight(context) / 2.2 - displayHeight(context) / 20 -
                100,
//            height: displayHeight(context)/2 - displayHeight(context) / 20,
            // height: HEIGHT OF PARENT - HEIGHT OF HEADER TEXT FOR USER INPUT..,
            child: Stack(
              children: <Widget>[
                Positioned(
//                  left:0,
                  // top:20,//displayHeight(context)/10,
                  // initial Case.
//                  height: displayWidth(context)/2.2-displayHeight(context) / 20,
                  bottom: getNumberOfInputsFilledUp(
                      unObsecuredInputandPayment.orderingCustomer) <= 1 ?
                  -60 :
                  getNumberOfInputsFilledUp(
                      unObsecuredInputandPayment.orderingCustomer) <= 2 ?
                  -80 :
                  getNumberOfInputsFilledUp(
                      unObsecuredInputandPayment.orderingCustomer) == 3 ?

                  -80 : -0,
                  // from top to top distance offset related to Starting (top ) of
                  // orance Container.
//                  right:0,
//                  bottom:0,
                  child:
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
                    child:
                    zeroORMoreInputsEmpty
                      (unObsecuredInputandPayment.orderingCustomer) == true ?

                    animatedObscuredPaymentSelectContainer
                      (unObsecuredInputandPayment) :
                    animatedUnObscuredPaymentUnSelectContainerDeliveryPhone
                      (unObsecuredInputandPayment),


                  ),
                  // ),

                ),
                Container(
//                  height: displayWidth(context)/2.2
//                      -displayHeight(context) / 15,
                  child: AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    top:
                    0,
//                  displayHeight(context)/4,
//                  getNumberOfInputsFilledUp (
//                      unObsecuredInputandPayment.ordersCustomer) ==4?


//                  displayWidth(context)/2.6 - displayWidth(context)/2,

                    // bottom 0 means full of green Container content shown.

                    child:
                    Container(
//                        alignment:Alignment.topCenter,0


                      // QQQ RoDo height
//                      height: displayWidth(context)/2.6,
                        child: Container(
//                            height: displayWidth(context)/2.6,
//                            height: displayHeight(context) / 3.7,
                          padding: EdgeInsets.fromLTRB(
                              (displayWidth(context) / 1.1) / 4,
                              10,
                              (displayWidth(context) / 1.1) / 4,
                              0

//                          horizontal: (displayWidth(context)/1.1)/4,
                          ),
//                        color: Colors.green,
                          color: Color(0xffFFFFFF),
                          child: Center(
//                    color:Colors.white.withOpacity(0.9),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[


                                  // CUSTOMER LOCATION ADDRESS CONTAINER BEGINS HERE.
//                            showEditingCompleteCustomerAddressInformation
//                            showEditingCompleteCustomerHouseFlatIformation
//                            showEditingCompleteCustomerPhoneIformation
//                            showEditingCompleteCustomerReachoutIformation
//                                showEditingCompleteCustomerAddressInformation BEGINS HERE.
                                  Container(
                                    child: showEditingCompleteCustomerAddressInformation
                                        ?
                                    Container()
                                        :
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(

                                          color: Color(0xffBCBCBD),
                                          style: BorderStyle.solid,
                                          width: 2.0,


                                        ),

                                        boxShadow: [
                                          BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                              color: Color(0xffFFFFFF),
                                              blurRadius: 10.0,
                                              offset: Offset(0.0, 2.0))
                                        ],


                                        color: Color(0xffFFFFFF),
//                                      Colors.black54
                                      ),

//                                  color: Color(0xffFFFFFF),
                                      width: displayWidth(context) / 2.5,
                                      height: displayHeight(context) / 24,
                                      padding: EdgeInsets.only(
                                          left: 4, top: 3, bottom: 3, right: 3),
                                      child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Container(

//                                            height: 25,
                                            height: displayHeight(context) / 40,
                                            width: 5,
                                            margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                            child: Icon(
//                                          Icons.add_shopping_cart,
                                              Icons.location_on,

                                              size: 28,
                                              color: Color(0xffBCBCBD),
                                            ),


                                          ),

                                          Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                            alignment: Alignment.center,
                                            width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                            // do it in both Container
                                            child: TextField(
                                              controller: addressController,

                                              textInputAction: TextInputAction
                                                  .next,
                                              onSubmitted: (_) =>
                                                  FocusScope.of(context)
                                                      .nextFocus(),


                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                focusColor: Color(0xffFC0000),
//                                                            fillColor: Color(0xffFC0000),
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                                border: InputBorder.none,
                                                hintText: 'Enter delivery location',
                                                hintStyle: TextStyle(
                                                    color: Color(0xffFC0000),
                                                    fontSize: 17),

//                                      currentUser
//                                        labelText: 'Search about meal.'
                                              ),


                                              onChanged: (text) {
                                                //RRRR

                                                print(
                                                    'at address of unobsecured (deliver loc)');

                                                final shoppingCartBloc = BlocProvider
                                                    .of<ShoppingCartBloc>(
                                                    context);
//
                                                shoppingCartBloc
                                                    .setAddressForOrder(text);
                                                if ((text
                                                    .trim()
                                                    .length) > 0) {
                                                  print(
                                                      'at (text.trim().length) >0)');
                                                  setState(() {
//                                          showEditingCompleteCustomerAddressInformation = true ,
                                                    showFullOrderType = false;
//                                                showFullOrderType = false;
                                                    // showFullOrderType
                                                    /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                    showCustomerInformationHeader =
                                                    true;
                                                    showUserInputOptionsLikeFirstTime =
                                                    false;
                                                    showFullPaymentType =
                                                    true; // default.// NOTHING TO DO WITH INPUT FIELDS.

                                                  });
                                                }
                                                else {
                                                  setState(() {
                                                    showFullOrderType = false;
                                                    // showFullOrderType = false;
                                                    // showFullOrderType
                                                    /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                    showCustomerInformationHeader =
                                                    true;
                                                    showUserInputOptionsLikeFirstTime =
                                                    false;
                                                    showFullPaymentType =
                                                    true; // default.// NOTHING TO DO WITH INPUT FIELDS.

//                                                showCustomerInformationHeader = true,

                                                  });
                                                }


                                                /*
                                                          setState(() =>
                                                          {
                                                            showFullOrderType = false,
//                                                showCustomerInformationHeader = true,
                                                          }

                                                          );
                                                          */
                                              },

                                              onTap: () {
                                                setState(() {
                                                  showFullOrderType = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.

                                                });
                                              },


                                              /*
                                                        onTap: () {

                                                          print('on tap of line # 1607');

                                                          if((currentUser.phoneNumber.trim().length) >0 ||
                                                              (currentUser.flatOrHouseNumber.trim().length) >0 ||
                                                              (currentUser.etaTimeInMinutes != null)  )
                                                          {
                                                            showEditingCompleteCustomerAddressInformation = true;
                                                          } else {
                                                            setState(() =>
                                                            {
                                                              showFullOrderType = false,
//                                        showCustomerInformationHeader = true,
                                                            });
                                                          }
                                                        },
                                                        */
//                                              setState(() =>
//                                              {
//                                                showFullOrderType = false,
////                                                showCustomerInformationHeader = true,
//                                              }

                                              //);
//                                            },
//                                          },


                                              onEditingComplete: () {
                                                print(
                                                    'at editing complete of address ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                                setState(() =>
                                                {
                                                  showEditingCompleteCustomerAddressInformation =
                                                  true
//                                          showInputtedCustomerIformation= true,
                                                }
                                                );
                                              },
                                              /*


                                                                          onSubmitted: (String value) async {
                                                                            await showDialog<void>(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return AlertDialog(
                                                                                  title: const Text('Thanks!'),
                                                                                  content: Text ('You typed "$value".'),
                                                                                  actions: <Widget>[
                                                                                    FlatButton(
                                                                                      onPressed: () { Navigator.pop(context); },
                                                                                      child: const Text('OK'),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                      */


                                              style: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 16),
                                            ),

                                          )

//                                  Spacer(),

//                                  Spacer(),

                                        ],
                                      ),
                                    ),
                                  ),


                                  // CUSTOMER LOACATION ADDRESS CONTAINER ENDS HERE.

                                  // CUSTOMER HOUSE || FLAT NUMBER CONTAINER BEGINS HERE.

                                  //
//                                showEditingCompleteCustomerHouseFlatIformation BEGINS HERE

                                  Container(

                                    child: showEditingCompleteCustomerHouseFlatIformation
                                        ? Container()
                                        :
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(

                                          color: Color(0xffBCBCBD),
                                          style: BorderStyle.solid,
                                          width: 2.0,


                                        ),

                                        boxShadow: [
                                          BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                              color: Color(0xffFFFFFF),
                                              blurRadius: 10.0,
                                              offset: Offset(0.0, 2.0))
                                        ],


                                        color: Color(0xffFFFFFF),
//                                      Colors.black54
                                      ),

//                                  color: Color(0xffFFFFFF),
                                      width: displayWidth(context) / 2.5,
                                      height: displayHeight(context) / 24,
                                      padding: EdgeInsets.only(
                                          left: 4, top: 3, bottom: 3, right: 3),
                                      child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Container(

//                                            height: 25,
                                            height: displayHeight(context) / 40,
                                            width: 5,
                                            margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                            child: Icon(
//                                          Icons.add_shopping_cart,
                                              Icons.home,
                                              size: 28,
                                              color: Color(0xffBCBCBD),
                                            ),


                                          ),

                                          Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                            alignment: Alignment.center,
                                            width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                            // do it in both Container
                                            child: TextField(
                                              controller: houseFlatNumberController,


                                              textInputAction: TextInputAction
                                                  .next,
                                              onSubmitted: (_) =>
                                                  FocusScope.of(context)
                                                      .nextFocus(),
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                                border: InputBorder.none,
                                                hintText: 'Enter House/Flat address/number',
                                                hintStyle: TextStyle(
                                                    color: Color(0xffFC0000),
                                                    fontSize: 17),

//                                        labelText: 'Search about meal.'
                                              ),

                                              onChanged: (text) {
                                                final shoppingCartBloc = BlocProvider
                                                    .of<
                                                    ShoppingCartBloc>(context);
//
                                                shoppingCartBloc
                                                    .setHouseorFlatNumberForOrder(
                                                    text);

                                                setState(() {
                                                  showFullOrderType = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                                }
                                                );
                                                // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                              },
                                              onTap: () {
                                                setState(() {
                                                  showFullOrderType = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.

                                                });
                                              },


                                              /*
                                                        onTap: () {


                                                          if ((currentUser.address
                                                              .trim()
                                                              .length) > 0 ||
                                                              (currentUser.flatOrHouseNumber
                                                                  .trim()
                                                                  .length) > 0 ||
                                                              (currentUser.etaTimeInMinutes !=-1
                                                                  )) {
                                                            showEditingCompleteCustomerHouseFlatIformation =
                                                            true;
                                                          } else {
                                                            setState(() =>
                                                            showFullOrderType = false);
                                                          }
                                                        },

                                                        */


                                              onEditingComplete: () {
                                                print(
                                                    'at editing complete of House or Flat Iformation ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                                                setState(() =>
                                                {
                                                  showEditingCompleteCustomerHouseFlatIformation =
                                                  true
//                                          showInputtedCustomerIformation= true,
                                                }
                                                );
                                              },
                                              /*



                                                                          onSubmitted: (String value) async {
                                                                            await showDialog<void>(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return AlertDialog(
                                                                                  title: const Text('Thanks!'),
                                                                                  content: Text ('You typed "$value".'),
                                                                                  actions: <Widget>[
                                                                                    FlatButton(
                                                                                      onPressed: () { Navigator.pop(context); },
                                                                                      child: const Text('OK'),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            );
                                                                          },

                                                                          */

                                              style: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 16),
                                            ),

                                          )

//                                  Spacer(),

//                                  Spacer(),

                                        ],
                                      ),
                                    ),
                                  ),


                                  // CUSTOMER HOUSE || FLAT NUMBER CONTAINER ENDS HERE.

                                  // CUSTOMER PHONE || MOBILE NUMBER CONTAINER BEGINS HERE.

                                  //  showEditingCompleteCustomerPhoneIformation BEGINS HERE.

                                  Container(

                                    child: showEditingCompleteCustomerPhoneIformation
                                        ? Container()
                                        :
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(

                                          color: Color(0xffBCBCBD),
                                          style: BorderStyle.solid,
                                          width: 2.0,


                                        ),

                                        boxShadow: [
                                          BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                              color: Color(0xffFFFFFF),
                                              blurRadius: 10.0,
                                              offset: Offset(0.0, 2.0))
                                        ],


                                        color: Color(0xffFFFFFF),
//                                      Colors.black54
                                      ),

//                                  color: Color(0xffFFFFFF),
                                      width: displayWidth(context) / 2.5,
                                      height: displayHeight(context) / 24,
                                      padding: EdgeInsets.only(
                                          left: 4, top: 3, bottom: 3, right: 3),
                                      child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Container(

//                                            height: 25,
                                            height: displayHeight(context) / 40,
                                            width: 5,
                                            margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                            child: Icon(
//                                          Icons.add_shopping_cart,
                                              Icons.phone,
                                              size: 28,
                                              color: Color(0xffBCBCBD),
                                            ),


                                          ),

                                          Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                            alignment: Alignment.center,
                                            width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                            // do it in both Container
                                            child: TextField(
                                              controller: phoneNumberController,


                                              textInputAction: TextInputAction
                                                  .next,
                                              onSubmitted: (_) =>
                                                  FocusScope.of(context)
                                                      .nextFocus(),

                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                                border: InputBorder.none,
                                                hintText: 'Enter phone / telephone number',
                                                hintStyle: TextStyle(
                                                    color: Color(0xffFC0000),
                                                    fontSize: 17),

//                                        labelText: 'Search about meal.'
                                              ),

                                              style: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 16),

                                              onChanged: (text) {
                                                print("33: $text");

                                                final shoppingCartBloc = BlocProvider
                                                    .of<
                                                    ShoppingCartBloc>(context);
//
                                                shoppingCartBloc
                                                    .setPhoneNumberForOrder(
                                                    text);

                                                setState(() {
                                                  showFullOrderType
                                                  = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                                }
                                                );
                                                // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                                              },

                                              /*
                                                        onTap: () {
                                                          if ((currentUser.address
                                                              .trim()
                                                              .length) > 0 ||
                                                              (currentUser.flatOrHouseNumber
                                                                  .trim()
                                                                  .length) > 0 ||
                                                              (currentUser.etaTimeInMinutes !=-1
                                                                  )) {
                                                            showEditingCompleteCustomerHouseFlatIformation =
                                                            true;
                                                          } else {
                                                            setState(() =>
                                                            showFullOrderType = false);
                                                          }
                                                        },
                                                        */

                                              onTap: () {
                                                setState(() {
                                                  showFullOrderType
                                                  = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.
//                                                showFullOrderType = false,

                                                });
                                              },
                                              onEditingComplete: () {
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');

                                                print(
                                                    'at editing complete of Customer Phone Iformation ');
                                                setState(() =>
                                                {
                                                  showEditingCompleteCustomerPhoneIformation =
                                                  true
//                                          showInputtedCustomerIformation= true,

                                                }

                                                );
                                              },

/*
                                                                          onSubmitted: (String value) async {
                                                                            await showDialog<void>(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return AlertDialog(
                                                                                  title: const Text('Thanks!'),
                                                                                  content: Text ('You typed "$value".'),
                                                                                  actions: <Widget>[
                                                                                    FlatButton(
                                                                                      onPressed: () { Navigator.pop(context); },
                                                                                      child: const Text('OK'),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                            */
                                            ),

                                          )

//                                  Spacer(),

//                                  Spacer(),

                                        ],
                                      ),
                                    ),
                                  ),


                                  // CUSTOMER PHONE || MOBILE NUMBER CONTAINER ENDS HERE.

                                  // CUSTOMER LOCATION REACH OUT TIME CONTAINER BEGINS HERE.

//                                showEditingCompleteCustomerReachoutIformation BEGINS HERE.
                                  Container(

                                    child: showEditingCompleteCustomerReachoutIformation
                                        ? Container()
                                        :
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(

                                          color: Color(0xffBCBCBD),
                                          style: BorderStyle.solid,
                                          width: 2.0,


                                        ),

                                        boxShadow: [
                                          BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                                              color: Color(0xffFFFFFF),
                                              blurRadius: 10.0,
                                              offset: Offset(0.0, 2.0))
                                        ],


                                        color: Color(0xffFFFFFF),
//                                      Colors.black54
                                      ),

//                                  color: Color(0xffFFFFFF),
                                      width: displayWidth(context) / 2.5,
                                      height: displayHeight(context) / 24,
                                      padding: EdgeInsets.only(
                                          left: 4, top: 3, bottom: 3, right: 3),
                                      child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Container(

//                                            height: 25,
                                            height: displayHeight(context) / 40,
                                            width: 5,
                                            margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                            child: Icon(
//                                          Icons.add_shopping_cart,
                                              Icons.watch_later,
                                              size: 28,
                                              color: Color(0xffBCBCBD),
                                            ),


                                          ),

                                          Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                                            alignment: Alignment.center,
                                            width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                                            // do it in both Container
                                            child: TextField(

                                              controller: etaController,


                                              keyboardType: TextInputType
                                                  .number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                WhitelistingTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              textInputAction: TextInputAction
                                                  .done,
//
                                              onSubmitted: (_) =>
                                                  FocusScope.of(context)
                                                      .unfocus(),
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                                                border: InputBorder.none,
                                                hintText: 'Enter reach out time',
                                                hintStyle: TextStyle(
                                                    color: Color(0xffFC0000),
                                                    fontSize: 17),

//                                        labelText: 'Search about meal.'
                                              ),

                                              style: TextStyle(
                                                  color: Color(0xffFC0000),
                                                  fontSize: 16),

                                              onChanged: (text) {
                                                print("0444: $text");


                                                print("33: $text");
                                                final shoppingCartBloc = BlocProvider
                                                    .of<
                                                    ShoppingCartBloc>(context);

                                                shoppingCartBloc.setETAForOrder(
                                                    text);
                                                setState(() {
                                                  // showFullOrderType = false;
                                                  showFullOrderType
                                                  = false;
                                                  // showFullOrderType = false;
                                                  // showFullOrderType
                                                  /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                                                  showCustomerInformationHeader =
                                                  true;
                                                  showUserInputOptionsLikeFirstTime =
                                                  false;
                                                  showFullPaymentType =
                                                  true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                                                }

                                                );
                                              },


                                              onTap: () {
                                                if ((currentUser.address
                                                    .trim()
                                                    .length) > 0 ||
                                                    (currentUser
                                                        .flatOrHouseNumber
                                                        .trim()
                                                        .length) > 0 ||
                                                    (currentUser.phoneNumber
                                                        .trim()
                                                        .length) > 0) {
                                                  showEditingCompleteCustomerHouseFlatIformation =
                                                  true;
                                                } else {
                                                  setState(() {
                                                    // showFullOrderType = false;
                                                    showFullOrderType
                                                    = false;
                                                    // showFullOrderType = false;
                                                    // showFullOrderType
                                                    /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                  showCustomerInformationHeader = false;
                                                    showCustomerInformationHeader =
                                                    true;
                                                    showUserInputOptionsLikeFirstTime =
                                                    false;
                                                    showFullPaymentType =
                                                    true; // default.// NOTHING TO DO WITH INPUT FIELDS.;
                                                  }
//                                                }
//                                                showFullOrderType = false


                                                  );
                                                }
                                              },


//                                            onTap: () {
//                                              setState(() => showFullOrderType = false);
//                                            },
                                              onEditingComplete: () {
                                                print(
                                                    'at editing complete of Customer\'s address ETA Time:');
                                                setState(() =>
                                                {
                                                  showEditingCompleteCustomerReachoutIformation =
                                                  true
                                                }
                                                );
                                              },


/*

                                      onSubmitted: (String value) async {
                                        await showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Thanks!'),
                                                content: Text ('You typed "$value".'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () { Navigator.pop(context); },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                          },
                                        );
                                      },
                                      */
                                            ),

                                          )


                                        ],
                                      ),
                                    ),
                                  ),

                                  // showEditingCompleteCustomerReachoutIformation ENDS HERE.
                                  // CUSTOMER LOCATION REACH OUT TIME CONTAINER ENDS HERE.


                                ],
                              )
                          ),
                        )

                    ),

                  ),
                )
              ],
            ),
          ),

          // ENDS HERE.
          // 2ND CONTAINER HOLDING THE INPUT FIELDS
          // AND THE PAYMENT OPTIONS IN A STACK
          // PAYMENT STACK IS BEHIND THE CUSTOMER INPUT STACK.


//            OOOO


          //VVVVVV

          // PAYMENT RELATED CONTAINER INVOKED FROM HERE:

//                        Flexible(
//                          child:

          // 3.


          // 3. ends here.
        ],

        //showInputtedCustomerIformation
      ),
    );
// GGG),

  }


  Widget _buildShoppingCartInputFieldsUNObscuredDinningRoom(
      Order unObsecuredInputandPayment) {
    CustomerInformation x = unObsecuredInputandPayment.orderingCustomer;
    //if(getOneOrdercustomerInfoFieldsNotEmpty(x)!=0){

    CustomerInformation currentUser = x;

    print('currentUser.address: ${currentUser.address}');
    print('currentUser.flatOrHouseNumber: ${currentUser.flatOrHouseNumber}');
    print('currentUser.phoneNumber: ${currentUser.phoneNumber}');
    print('currentUser.etaTimeInMinutes: ${currentUser.etaTimeInMinutes}');

//    animatedObscuredTextInputContainer
//    if((showEditingCompleteCustomerAddressInformation == true)||
//        (showEditingCompleteCustomerHouseFlatIformation == true)||
//        (showEditingCompleteCustomerPhoneIformation == true)||
//        (showEditingCompleteCustomerReachoutIformation == true)){

//    return unobscureInputandRestforTakeAway(unObsecuredInputandPayment);
    return unobscureInputandRestforDinningRoom(unObsecuredInputandPayment);


    /*
      return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
      child: (showFullOrderType == false)?
      unobscureInputandRest(unObsecuredInputandPayment)

          :unobsuredEsleFirstTime(unObsecuredInputandPayment),
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


    );
     */


  }

  Widget _buildShoppingCartInputFieldsUNObscuredTakeAway(
      Order unObsecuredInputandPayment) {
    CustomerInformation x = unObsecuredInputandPayment.orderingCustomer;
    //if(getOneOrdercustomerInfoFieldsNotEmpty(x)!=0){

    CustomerInformation currentUser = x;

    print('currentUser.address: ${currentUser.address}');
    print('currentUser.flatOrHouseNumber: ${currentUser.flatOrHouseNumber}');
    print('currentUser.phoneNumber: ${currentUser.phoneNumber}');
    print('currentUser.etaTimeInMinutes: ${currentUser.etaTimeInMinutes}');

//    animatedObscuredTextInputContainer
//    if((showEditingCompleteCustomerAddressInformation == true)||
//        (showEditingCompleteCustomerHouseFlatIformation == true)||
//        (showEditingCompleteCustomerPhoneIformation == true)||
//        (showEditingCompleteCustomerReachoutIformation == true)){

    return
      unobscureInputandRestforTakeAway(unObsecuredInputandPayment);


    /*
      return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
      child: (showFullOrderType == false)?
      unobscureInputandRest(unObsecuredInputandPayment)

          :unobsuredEsleFirstTime(unObsecuredInputandPayment),
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


    );
     */


  }

// work 3
  Widget _buildShoppingCartInputFieldsUNObscured(
      Order unObsecuredInputandPayment) {
    CustomerInformation x = unObsecuredInputandPayment.orderingCustomer;
    //if(getOneOrdercustomerInfoFieldsNotEmpty(x)!=0){

    CustomerInformation currentUser = x;

    print('currentUser.address: ${currentUser.address}');
    print('currentUser.flatOrHouseNumber: ${currentUser.flatOrHouseNumber}');
    print('currentUser.phoneNumber: ${currentUser.phoneNumber}');
    print('currentUser.etaTimeInMinutes: ${currentUser.etaTimeInMinutes}');

//    animatedObscuredTextInputContainer
//    if((showEditingCompleteCustomerAddressInformation == true)||
//        (showEditingCompleteCustomerHouseFlatIformation == true)||
//        (showEditingCompleteCustomerPhoneIformation == true)||
//        (showEditingCompleteCustomerReachoutIformation == true)){

    return
      unobscureInputandRestDeliveryPhone(unObsecuredInputandPayment);


    /*
      return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
      child: (showFullOrderType == false)?
      unobscureInputandRest(unObsecuredInputandPayment)

          :unobsuredEsleFirstTime(unObsecuredInputandPayment),
//      _buildShoppingCartInputFieldsUNObscured(oneOrder)
//      _buildShoppingCartInputFieldsUNObscured (oneOrder):
//      animatedObscuredTextInputContainer (oneOrder.ordersCustomer),


    );
     */


  }


  Widget _buildShoppingCartInputFieldsObscured(
      CustomerInformation obscuredDisplay) {
    //    CustomerInformation
//  final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//
//  return StreamBuilder(
//      stream: shoppingCartBloc.getCurrentCustomerInformationStream,
//      initialData: shoppingCartBloc.getCurrentCustomerInfo,
//
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) {
//          print('!snapshot.hasData');
////        return Center(child: new LinearProgressIndicator());
//          return Container(child: Text('Null'));
//        }
//        else {

    CustomerInformation currentUser = obscuredDisplay;
    // THIS INFORMATION ABOVE IS NOT USED NOW.

    return Center(

        child: Container(
//                  color: Colors.green,
//                    color:Colors.white.withOpacity(0.9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                Container(
                    alignment: Alignment.center,

                    child: Text('Enter user address',
                      style: TextStyle(
                        color:
                        Color(0xffFC0000),
                        fontSize: 30,
                      ),)
                ),


                // CUSTOMER LOCATION ADDRESS CONTAINER BEGINS HERE.
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0),
                  decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(

                      color: Color(0xffBCBCBD),
                      style: BorderStyle.solid,
                      width: 2.0,


                    ),

                    boxShadow: [
                      BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                          color: Color(0xffFFFFFF),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 2.0))
                    ],


                    color: Color(0xffFFFFFF),
//                                      Colors.black54
                  ),

//                                  color: Color(0xffFFFFFF),
                  width: displayWidth(context) / 2.5,
                  height: displayHeight(context) / 24,
                  padding: EdgeInsets.only(
                      left: 4, top: 3, bottom: 3, right: 3),
                  child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(

//                        height: 25,
                        height: displayHeight(context) / 40,
                        width: 5,
                        margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                        child: Icon(
//                                          Icons.add_shopping_cart,
                          Icons.location_on,

                          size: 28,
                          color: Color(0xffBCBCBD),
                        ),


                      ),

                      Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                        alignment: Alignment.center,
                        width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                        // do it in both Container
                        child: TextField(
                          controller: addressController,

                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
                            focusColor: Color(0xffFC0000),
//                                                            fillColor: Color(0xffFC0000),
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                            border: InputBorder.none,
                            hintText: 'Enter delivery location',
                            hintStyle: TextStyle(
                                color: Color(0xffFC0000), fontSize: 17),

//                                      currentUser
//                                        labelText: 'Search about meal.'
                          ),

                          onChanged: (text) {
                            //RRRR

                            final shoppingCartBloc = BlocProvider.of<
                                ShoppingCartBloc>(context);
//
                            shoppingCartBloc.setAddressForOrder(text);

                            setState(() {
                              // showFullOrderType = false;
                              showFullOrderType
                              = false;
                              // showFullOrderType = false;
                              // showFullOrderType
                              /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }
//                            showFullOrderType = false;
                            );
                          },

                          onTap: () {
                            setState(() {
                              // showFullOrderType = false;
                              showFullOrderType
                              = false;
                              // showFullOrderType = false;
                              // showFullOrderType
                              /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }

                            );
                          },
                          /*

                                                            onEditingComplete: (){
                                                              logger.i('onEditingComplete  of condition 4');
                                                              print('called onEditing complete');
                                                              setState(() => _searchString = "");
                                                            },



                                                            onSubmitted: (String value) async {
                                                              await showDialog<void>(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Thanks!'),
                                                                    content: Text ('You typed "$value".'),
                                                                    actions: <Widget>[
                                                                      FlatButton(
                                                                        onPressed: () { Navigator.pop(context); },
                                                                        child: const Text('OK'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                          */


                          style: TextStyle(
                              color: Color(0xffFC0000), fontSize: 16),
                        ),

                      )

//                                  Spacer(),

//                                  Spacer(),

                    ],
                  ),
                ),

                // CUSTOMER LOACATION ADDRESS CONTAINER ENDS HERE.

                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER BEGINS HERE.
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0),
                  decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(

                      color: Color(0xffBCBCBD),
                      style: BorderStyle.solid,
                      width: 2.0,


                    ),

                    boxShadow: [
                      BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                          color: Color(0xffFFFFFF),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 2.0))
                    ],


                    color: Color(0xffFFFFFF),
//                                      Colors.black54
                  ),

//                                  color: Color(0xffFFFFFF),
                  width: displayWidth(context) / 2.5,
                  height: displayHeight(context) / 24,
                  padding: EdgeInsets.only(
                      left: 4, top: 3, bottom: 3, right: 3),
                  child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(

//                        height: 25,
                        height: displayHeight(context) / 40,
                        width: 5,
                        margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                        child: Icon(
//                                          Icons.add_shopping_cart,
                          Icons.home,
                          size: 28,
                          color: Color(0xffBCBCBD),
                        ),


                      ),

                      Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                        alignment: Alignment.center,
                        width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                        // do it in both Container
                        child: TextField(

                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                            border: InputBorder.none,
                            hintText: 'Enter House/Flat address/number',
                            hintStyle: TextStyle(
                                color: Color(0xffFC0000), fontSize: 17),

//                                        labelText: 'Search about meal.'
                          ),

                          onChanged: (text) {
                            final shoppingCartBloc = BlocProvider.of<
                                ShoppingCartBloc>(context);
//
                            shoppingCartBloc
                                .setHouseorFlatNumberForOrder(
                                text);

                            setState(() {
                              // showFullOrderType = false;
                              showFullOrderType
                              = false;
                              // showFullOrderType = false;
                              // showFullOrderType
                              /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;

                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.


//                              showFullOrderType = false;
                            });
                          },


                          onTap: () {
                            setState(() {
//                              showFullOrderType = false;

                              // showFullOrderType = false;
                              showFullOrderType
                              = false;
                              // showFullOrderType = false;
                              // showFullOrderType
                              /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.

//                              showFullOrderType = false;
                            });
                          },
                          /*

                                                            onEditingComplete: (){
                                                              logger.i('onEditingComplete  of condition 4');
                                                              print('called onEditing complete');
                                                              setState(() => _searchString = "");
                                                            },

                                                            onSubmitted: (String value) async {
                                                              await showDialog<void>(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Thanks!'),
                                                                    content: Text ('You typed "$value".'),
                                                                    actions: <Widget>[
                                                                      FlatButton(
                                                                        onPressed: () { Navigator.pop(context); },
                                                                        child: const Text('OK'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },

                                                            */

                          style: TextStyle(
                              color: Color(0xffFC0000), fontSize: 16),
                        ),

                      )

//                                  Spacer(),

//                                  Spacer(),

                    ],
                  ),
                ),


                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER ENDS HERE.

                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER BEGINS HERE.
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0),
                  decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(

                      color: Color(0xffBCBCBD),
                      style: BorderStyle.solid,
                      width: 2.0,


                    ),

                    boxShadow: [
                      BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                          color: Color(0xffFFFFFF),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 2.0))
                    ],


                    color: Color(0xffFFFFFF),
//                                      Colors.black54
                  ),

//                                  color: Color(0xffFFFFFF),
                  width: displayWidth(context) / 2.5,
                  height: displayHeight(context) / 24,
                  padding: EdgeInsets.only(
                      left: 4, top: 3, bottom: 3, right: 3),
                  child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(

//                        height: 25,
                        height: displayHeight(context) / 40,
                        width: 5,
                        margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                        child: Icon(
//                                          Icons.add_shopping_cart,
                          Icons.phone,
                          size: 28,
                          color: Color(0xffBCBCBD),
                        ),


                      ),

                      Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                        alignment: Alignment.center,
                        width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                        // do it in both Container
                        child: TextField(

                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                            border: InputBorder.none,
                            hintText: 'Enter phone / telephone number',

                            hintStyle: TextStyle(
                                color: Color(0xffFC0000), fontSize: 17),

//                                        labelText: 'Search about meal.'
                          ),

                          style: TextStyle(
                              color: Color(0xffFC0000), fontSize: 16),

                          onChanged: (text) {
                            print("33: $text");

                            final shoppingCartBloc = BlocProvider.of<
                                ShoppingCartBloc>(context);
//
                            shoppingCartBloc.setPhoneNumberForOrder(
                                text);

                            setState(() {
                              showFullOrderType = false;
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }


                            );
                          },


                          onTap: () {
                            setState(() {
                              showFullOrderType = false;

//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }
                            );
                          },
                          /*

                                                            onEditingComplete: (){
                                                              logger.i('onEditingComplete  of condition 4');
                                                              print('called onEditing complete');
                                                              setState(() => _searchString = "");
                                                            },

                                                            onSubmitted: (String value) async {
                                                              await showDialog<void>(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Thanks!'),
                                                                    content: Text ('You typed "$value".'),
                                                                    actions: <Widget>[
                                                                      FlatButton(
                                                                        onPressed: () { Navigator.pop(context); },
                                                                        child: const Text('OK'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                              */
                        ),

                      )

//                                  Spacer(),

//                                  Spacer(),

                    ],
                  ),
                ),


                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER ENDS HERE.

                // CUSTOMER LOCATION REACH OUT TIME CONTAINER BEGINS HERE.

                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0),
                  decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(

                      color: Color(0xffBCBCBD),
                      style: BorderStyle.solid,
                      width: 2.0,


                    ),

                    boxShadow: [
                      BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                          color: Color(0xffFFFFFF),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 2.0))
                    ],


                    color: Color(0xffFFFFFF),
//                                      Colors.black54
                  ),

//                                  color: Color(0xffFFFFFF),
                  width: displayWidth(context) / 2.5,
                  height: displayHeight(context) / 24,
                  padding: EdgeInsets.only(
                      left: 4, top: 3, bottom: 3, right: 3),
                  child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(

//                        height: 25,
                        height: displayHeight(context) / 40,
                        width: 5,
                        margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                        child: Icon(
//                                          Icons.add_shopping_cart,
                          Icons.watch_later,
                          size: 28,
                          color: Color(0xffBCBCBD),
                        ),


                      ),

                      Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                        alignment: Alignment.center,
                        width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                        // do it in both Container
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => FocusScope.of(context).unfocus(),

                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                            border: InputBorder.none,
                            hintText: 'Enter reach out time',
                            hintStyle: TextStyle(
                                color: Color(0xffFC0000), fontSize: 17),

//                                        labelText: 'Search about meal.'
                          ),

                          style: TextStyle(
                              color: Color(0xffFC0000), fontSize: 16),

                          onChanged: (text) {
                            print("0444: $text");


                            print("33: $text");
                            final shoppingCartBloc = BlocProvider.of<
                                ShoppingCartBloc>(context);

                            shoppingCartBloc.setETAForOrder(text);
                            setState(() {
                              showFullOrderType = false;

//                            showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                              showUserInputOptionsLikeFirstTime = false;
                            });
                          },

                          onTap: () {
                            setState(() {
                              showFullOrderType = false;
//                              showCustomerInformationHeader = false;
                              showUserInputOptionsLikeFirstTime = false;
                              showCustomerInformationHeader = true;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }
                            );
                          },
                          /*



                                                            onEditingComplete: (){
                                                              logger.i('onEditingComplete  of condition 4');
                                                              print('called onEditing complete');
                                                              setState(() => _searchString = "");
                                                            },



                          onSubmitted: (String value) async {
                            await showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Thanks!'),
                                  content: Text ('You typed "$value".'),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () { Navigator.pop(context); },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          */
                        ),

                      )

//                                  Spacer(),

//                                  Spacer(),

                    ],
                  ),
                ),

                // CUSTOMER LOCATION REACH OUT TIME CONTAINER ENDS HERE.


              ],
            )
        )

    );
  }


  Widget animatedUnObscuredPaymentTypeUnSelectedContainerTakeAway(
      Order orderObjectTakeAway) {
    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

    print('at animated Un Obscured Card UnSelect Container');
    return
      Column(
        children: <Widget>[
          Container(
//          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                                      padding::::
              color: Colors.white,
//              color:Colors.lightBlueAccent,
//                                            height: 200,
//          height: displayHeight(context) /3,
              width: displayWidth(context)
                  - displayWidth(context) / 5,
//                                            width: displayWidth(context) * 0.57,

              // Work 5.
              child: Container(child:
              AnimatedSwitcher(
                duration: Duration(milliseconds: 0),
//
                // animatedWidgetShowSelectedPaymentType
                // _buildShoppingCartPaymentMethodsUNObscuredUnSelected
                // animatedWidgetShowSelectedPaymentType
                // _buildShoppingCartPaymentMethodsUNObscuredUnSelected
                // animatedWidgetShowSelectedPaymentTypeTakeAway
                // _buildShoppingCartPaymentMethodsUNObscuredUnSelectedTakeAway
                child: showFullPaymentType == false ?

                animatedWidgetShowSelectedPaymentTypeTakeAway(
                    orderObjectTakeAway) :
                _buildShoppingCartPaymentMethodsUNObscuredUnSelectedTakeAway(
                    orderObjectTakeAway),
              ),
              )
            //HHHH


          ),

          Container(
            height: displayHeight(context) / 20,
//          color:Colors.blue,
            width: displayWidth(context)
                - displayWidth(context) / 5,


//            alignment: Alignment.center,
            /*
    padding: EdgeInsets.fromLTRB(displayWidth(context)/3,
                0, 0, 0),
            */
            child:
            AnimatedSwitcher(
              duration: Duration(milliseconds: 0),
//
              // animatedUnObscuredCancelPayButtonTakeAway
              // animatedObscuredCancelPayButtonTakeAway
              // animatedUnObscuredCancelPayButton
              // animatedObscuredCancelPayButton
              child: showFullPaymentType == false ?
              animatedUnObscuredCancelPayButtonTakeAway(orderObjectTakeAway) :
              animatedObscuredCancelPayButtonTakeAway(orderObjectTakeAway)

              ,

            ),
          ),


//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),
//          Text('ss'),
//          Text('bb'),
//          Text('gg'),

          /*
          Container(
            height:20,
//                                                          color:Colors.lightBlueAccent,
            child: StreamBuilder<List<String>>(

              stream: shoppingCartBloc.getDevicesStream,
              initialData: shoppingCartBloc.getDevices,
              builder: (context, snapshot) {
                if ((snapshot.hasError) || (!snapshot.hasData)) {
                  return Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(''),
                    ),
                  );
                }
                else {

//                    SelectedFood incrementCurrentFoodProcessing = snapshot.data;
                  List<String> devicesFromStream = snapshot.data;

                  return ListView.builder(

                    scrollDirection: Axis.horizontal,
                    itemCount: devicesFromStream.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OutlineButton(
                        onPressed: () => testPrint(devicesFromStream[index], context),
                        child:
                                        Text(
                                          '${devicesFromStream[index]}:${portController.text}',
                                          style: TextStyle(fontSize: 16),
                                        ),

                      );
                    },
                  );


                }
                },
                )
          ),

          */


        ],
      );
  }


  Widget animatedUnObscuredPaymentUnSelectContainerDeliveryPhone(
      Order unObsecuredInputandPayment) {
    print('at animated Un Obscured Card UnSelect Container');
    return
      Column(
        children: <Widget>[
          Container(
//          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                                      padding::::
              color: Colors.white,
//                                            height: 200,
//          height: displayHeight(context) /3,
              width: displayWidth(context)
                  - displayWidth(context) / 5,
//                                            width: displayWidth(context) * 0.57,


              // Work 5.
              child: Container(child:
              AnimatedSwitcher(
                duration: Duration(milliseconds: 0),
//
                child: showFullPaymentType == false
                    ? animatedWidgetShowSelectedPaymentTypeDeliveryPhone(
                    unObsecuredInputandPayment)
                    :
                _buildShoppingCartPaymentMethodsUNObscuredUnSelected(
                    unObsecuredInputandPayment)
                ,

              ),


              )
            //HHHH


          ),

          Container(

//            alignment: Alignment.center,
            /*
    padding: EdgeInsets.fromLTRB(displayWidth(context)/3,
                0, 0, 0),


            */

            width: displayWidth(context)
                - displayWidth(context) / 5,
            child:
            AnimatedSwitcher(
              duration: Duration(milliseconds: 0),
//
              child: showFullPaymentType == false ?
              animatedUnObscuredCancelPayButtonDeliveryPhone(
                  unObsecuredInputandPayment) :
              animatedObscuredCancelPayButtonDeliveryPhone(
                  unObsecuredInputandPayment)

              ,

            ),
          ),


        ],
      );
  }


  Widget animatedObscuredCancelPayButtonTakeAway(Order cancelPaySelect) {
    //  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Cancel Pay Button()');
    return
      AbsorbPointer(
        child: Opacity(
          opacity: 0.2,
          child: Container(

            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[


                Container(
                  width: displayWidth(context) / 4,
                  height: displayHeight(context) / 24,
                  child: OutlineButton(
                    onPressed: () {
                      print('Cancel Pressed obscured');
//                    onPressed: _testPrintDummyDe
//                    return Navigator.pop(context,true);
                    },
                    color: Color(0xffFC0000),
                    // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                    borderSide: BorderSide(
                      color: Color(0xffFC0000), // 0xff54463E
                      style: BorderStyle.solid,
                      width: 7.6,
                    ),
                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Container(

//              alignment: Alignment.center,
                      child: Text('Cancel',
                        style: TextStyle(color: Color(0xffFC0000),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,),),

                    ),
                  ),

                ),


                SizedBox(width: displayWidth(context) / 12,),
                Container(
                  width: displayWidth(context) / 4,
//                  width:displayWidth(context)/3.1,
                  height: displayHeight(context) / 24,
                  child: OutlineButton(
                    onPressed: () async {
                      print('obscure pay');
                    },
                    color: Colors.green,
                    // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                    borderSide: BorderSide(
                      color: Colors.green, // 0xff54463E
                      style: BorderStyle.solid,
                      width: 7.6,
                    ),
                    shape: RoundedRectangleBorder(


                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Container(

//              alignment: Alignment.center,

                      child: Text('Pay', style: TextStyle(color: Colors.green,
                        fontSize: 30, fontWeight: FontWeight.bold,),
                      ),),
                  ),


                ),


              ],
            ),
          ),


          /*
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[




                Container(
                  width:displayWidth(context)/3.1,
                  child: OutlineButton(
                    onPressed: (){ print('Cancel Pressed obscured');
//                    onPressed: _testPrintDummyDe
//                    return Navigator.pop(context,true);
                    },
                    child: Text('Cancel',style: TextStyle(color: Color(0xffFC0000),fontSize: 30),),

                    shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color:Color(0xffFC0000),
                        style: BorderStyle.solid,
                        width:7.6,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),




                  ),

                ),


                SizedBox(width: displayWidth(context)/12,),
                Container(
                  width:displayWidth(context)/3.1,
                  child: OutlineButton(
                    onPressed: () async {

                      print('obscure pay');

                    },
                    child: Text('Pay',style: TextStyle(color: Colors.green,fontSize: 30),),
                    shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color:Colors.green,
                        style: BorderStyle.solid,
                        width:7.6,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),



                ),


              ],
            ),
          ),
          */
        ),
      );
  }

  Widget animatedObscuredCancelPayButtonDeliveryPhone(Order cancelPaySelect) {
//  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Cancel Pay Button()');
    return
      AbsorbPointer(
        child: Opacity(
          opacity: 0.2,
          child:
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  width: displayWidth(context) / 4,
                  height: displayHeight(context) / 24,
                  child: OutlineButton(
                    onPressed: () {
                      print('Cancel Pressed obscured delivery phone obscured');
//                    onPressed: _testPrintDummyDe
//                    return Navigator.pop(context,true);
                    },
                    color: Color(0xffFC0000),
                    // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                    borderSide: BorderSide(
                      color: Color(0xffFC0000), // 0xff54463E
                      style: BorderStyle.solid,
                      width: 7.6,
                    ),
                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Container(

//              alignment: Alignment.center,
                      child: Text('Cancel',
                        style: TextStyle(color: Color(0xffFC0000),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,),),

                    ),
                  ),

                ),


                SizedBox(width: displayWidth(context) / 12,),
                Container(
                  width: displayWidth(context) / 4,
                  height: displayHeight(context) / 24,
                  child: OutlineButton(
                    onPressed: () async {
                      print(
                          'pay button Pressed obscured delivery phone obscured');
                    },
                    color: Colors.green,
                    // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                    borderSide: BorderSide(
                      color: Colors.green, // 0xff54463E
                      style: BorderStyle.solid,
                      width: 7.6,
                    ),
                    shape: RoundedRectangleBorder(


                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Container(

//              alignment: Alignment.center,

                      child: Text('Pay', style: TextStyle(color: Colors.green,
                        fontSize: 30, fontWeight: FontWeight.bold,),
                      ),),
                  ),


                ),


              ],
            ),
          ),

          /*Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  child: OutlineButton(
                    onPressed: (){ print('Cancel Pressed obsured ...');

//                    return Navigator.pop(context,true);
                    },
                    child: Text('Cancel',style: TextStyle(color: Color(0xffFC0000),fontSize: 30),),
                    shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color:Color(0xffFC0000),
                        style: BorderStyle.solid,
                        width:7.6,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),

                ),
                SizedBox(width: displayWidth(context)/12,),
                Container(
                  child: OutlineButton(
                    onPressed: (){

                      print('on Pressed of Pay obscured');
//                      return Navigator.pop(context,false);


                    },
                    child: Text('Pay',style: TextStyle(color: Colors.green,fontSize: 30),),
                    shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color:Colors.green,
                        style: BorderStyle.solid,
                        width:7.6,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),

                ),
              ],
            ),
          ),
          */
        ),
      );
  }


  // work 01_9thJuly.
  Widget animatedUnObscuredCancelPayButtonTakeAway(
      Order cancelPaySelectUNObscuredTakeAway) {
    //  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Cancel Pay Button()');
    return
      Container(
        margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: displayWidth(context) / 4,
              height: displayHeight(context) / 24,
              child: OutlineButton(
                color: Color(0xffFC0000),
                // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                borderSide: BorderSide(
                  color: Color(0xffFC0000), // 0xff54463E
                  style: BorderStyle.solid,
                  width: 7.6,
                ),
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Container(

//              alignment: Alignment.center,
                  child: Text('Cancel',
                    style: TextStyle(color: Color(0xffFC0000),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,),),

                ),
                onPressed: () {
                  print(
                      'on Pressed of Cancel of animatedUnObscuredCancelPayButtonTakeAway');

                  /*
                        cancelPaySelect.page=1;
                        return Navigator.of(context).pop(
                            BlocProvider<ShoppingCartBloc>(
                                bloc: ShoppingCartBloc(cancelPaySelect),
                            child:
                            BlocProvider<FoodGalleryBloc>(
                                bloc: FoodGalleryBloc(),
                                child: FoodGallery2()
                            )
                        ),);
                        */

                  print(
                      'debug print before invoking _stopScanDevices(); in cancelPaySelectUNObscuredTakeAway cancel button ');
                  _stopScanDevices();
                  print(
                      'debug print after invoking _stopScanDevices(); in cancelPaySelectUNObscuredTakeAway cancel button');


                  final shoppingCartBloc = BlocProvider.of<
                      ShoppingCartBloc>(context);
                  shoppingCartBloc.clearSubscription();


//                  List<SelectedFood> expandedFoodReturnTemp= new List<SelectedFood>(0);
//                  List<SelectedFood> expandedFoodReturnTemp= [];
//                  shoppingCartBloc.getExpandedSelectedFood;


                  cancelPaySelectUNObscuredTakeAway.isCanceled = true;

                  /*
                  //MIGHT NOT BE NECESSARY.

                  setState(() {
                    localScanAvailableState = !localScanAvailableState;
                  });
                  */


                  return Navigator.pop(
                      context, cancelPaySelectUNObscuredTakeAway);


//                  return Navigator.pop(context,expandedFoodReturnTemp);
                },
              ),
            ),

            SizedBox(width: displayWidth(context) / 12,),

            Container(
              width: displayWidth(context) / 4,
              height: displayHeight(context) / 24,
              child: OutlineButton(
                color: Colors.green,
                // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                borderSide: BorderSide(
                  color: Colors.green, // 0xff54463E
                  style: BorderStyle.solid,
                  width: 7.6,
                ),
                shape: RoundedRectangleBorder(


                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Container(

//              alignment: Alignment.center,

                  child: Text('Pay', style: TextStyle(color: Colors.green,
                    fontSize: 30, fontWeight: FontWeight.bold,),
                  ),),
                onPressed: () async {
//                  print('on Pressed of Pay');
//                  return Navigator.pop(context,false);

                  final shoppingCartBloc = BlocProvider.of<
                      ShoppingCartBloc>(context);

//                        final identityBlocLoginPage =
//                        BlocProvider.of<IdentityBloc>(context);

                  /*

                  Future<List<String>> testDevices =
                  shoppingCartBloc.discoverDevices2('9100');

//                            _handleSignIn();


                  testDevices.whenComplete(() {

                    print("called when future completes");

                  }
                  ).then((onValue){

//                          setState(() {
//                            isDiscovering = false;
//                            found = devices.length;
                    devices=onValue;

                    print('onValue: $onValue');
//                          });
//
                    logger.i('isDiscovering: $isDiscovering');
                    logger.i('found: $found');
                    logger.i('devices: $devices');

                  }).catchError((onError){
                    print('some  ERROR **** at onError $onError ***');


                  });

                  */


/*
    final identityBlocLoginPage =
    BlocProvider.of<IdentityBloc>(context);


    Future<AuthResult> userCheck=
    identityBlocLoginPage.handleSignInFromLoginPage(emailState.trim(),passwordState.trim());

//                            _handleSignIn();

    userCheck.whenComplete(() {

    print("called when future completes");

    }
    ).then((onValue){

    }
        */

//                        await int foundCount=  discover(context);


                  print(
                      'cancelPaySelect.paymentTypeIndex: ${cancelPaySelectUNObscuredTakeAway
                          .paymentTypeIndex}');


                  // PRINTING CODES WILL BE PUTTED HERE.

                  print(
                      'debug print before invoking _startScanDevices(); in cancelPaySelectUNObscuredTakeAway || pay button');
                  _startScanDevices();
//                  _startScanDummyDevices();
                  print(
                      'debug print after invoking _startScanDevices(); in cancelPaySelectUNObscuredTakeAway || pay button');


                  Order tempOrderWithdocId = await shoppingCartBloc
                      .paymentButtonPressed(cancelPaySelectUNObscuredTakeAway);


                  /*
                  setState(() {
                    localScanAvailableState = !localScanAvailableState;
                  });
                  */


                  if ((tempOrderWithdocId.paymentButtonPressed == true) &&
                      (tempOrderWithdocId.orderdocId == '')) {
                    _scaffoldKeyShoppingCartPage.currentState
//                  Scaffold.of(context)
//                    ..removeCurrentSnackBar()
                        .showSnackBar(
                        SnackBar(content: Text("someThing went wrong")));
                    print('something went wrong');
                  }
                  else {
                    print('tempOrderWithdocId.orderdocId: ${tempOrderWithdocId
                        .orderdocId}');

                    List<
                        PrinterBluetooth> blueToothDevicesState = shoppingCartBloc
                        .getDevices;

                    print('blueToothDevicesState.length: ${blueToothDevicesState
                        .length}');

                    print('blueToothDevicesState.length == 0 ${blueToothDevicesState.length == 0}');


                    if (blueToothDevicesState.length == 0) {
                      logger.i('___________ blueTooth device not found _____');

                      // UNCOMMENT THIS LINE... BELOW  //_showMyDialog2('___________ blueTooth device not found _____');
                      _showMyDialog2(
                          '___________ blueTooth device not found _____');
//                      shoppingCartBloc.clearSubscription();

                      // NEED THIS LINES COMMENTING BEGINNING..


                      /*

                      BluetoothDevice _x = new BluetoothDevice();
                      _x.name = 'Restaurant Printer';
                      _x.address = '0F:02:18:51:23:46';
                      _x.type = 3;
                      _x.connected = null;


                      PrinterBluetooth x = new PrinterBluetooth(_x);


                      _testPrintDummyDevices(x);


                      */

                      // NEED THIS LINES COMMENTING ENDS HERE..


                      return;
                    }


                    bool found = false;
                    int index = -1;
                    for (int i = 0; i < blueToothDevicesState.length; i++) {
                      ++index;

                      print(
                          'blueToothDevicesState[$i].name: ${blueToothDevicesState[i]
                              .name}');
                      print(
                          'oneBlueToothDevice[$i].address: ${blueToothDevicesState[i]
                              .address}');
                      if ((blueToothDevicesState[i].name ==
                          'Restaurant Printer') ||
                          (blueToothDevicesState[i].address ==
                              '0F:02:18:51:23:46')) {
                        found = true;
                        break;

                        // _testPrint(oneBlueToothDevice);

                      }
                    };

                    logger.w('check device listed or not');
                    print('index: $index');
                    print('value of found: $found');

                    if (found == true) {
                      print('found == true');
                      await _testPrint(blueToothDevicesState[index]);

//                      _testPrintDummyDevices(blueToothDevicesState[index]);


                      shoppingCartBloc.clearSubscription();
                      return Navigator.pop(context, tempOrderWithdocId);
                    }

                    else {
                      logger.i('___________ blueTooth device not found  printing wasn\'t successfull _____');
                      _showMyDialog2(
                          '___________ blueTooth device not found   printing wasn\'t successfull_____');

                      // COMMENT FROM HERE TO END


                      BluetoothDevice _x = new BluetoothDevice();
                      _x.name = 'Restaurant Printer';
                      _x.address = '0F:02:18:51:23:46';
                      _x.type = 3;
                      _x.connected = null;


                      PrinterBluetooth x = new PrinterBluetooth(_x);


                      _testPrintDummyDevices(x);



                      shoppingCartBloc.clearSubscription();
                      return Navigator.pop(context,tempOrderWithdocId);

                      // END
//                      return;
                    }
                  }
                },
              ),
            ),


          ],
        ),


      );
  }


  Future<void> _showMyDialog2(String message) async {

    logger.e('in showMyDialog2');
    print(' at the beginning of  _showMyDialog2 ....');


    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$message'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$message'),

              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('return shopping Cart page.'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


// animatedUnObscuredCancelPayButton
// animatedUnObscuredCancelPayButtonDeliveryPhone
  Widget animatedUnObscuredCancelPayButtonDeliveryPhone(
      Order cancelPaySelectUnobscuredDeliveryPhone) {
//  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Cancel Pay Button()');
    return
      Container(
        margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[


            Container(
              width: displayWidth(context) / 4,
              height: displayHeight(context) / 24,
              child: OutlineButton(
                color: Color(0xffFC0000),
                // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                borderSide: BorderSide(
                  color: Color(0xffFC0000), // 0xff54463E
                  style: BorderStyle.solid,
                  width: 7.6,
                ),
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Container(

//              alignment: Alignment.center,
                  child: Text('Cancel',
                    style: TextStyle(color: Color(0xffFC0000),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,),),

                ),
                onPressed: () {
                  print(
                      'on Pressed of Cancel of animatedUnObscuredCancelPayButtonTakeAway');

                  /*
                  cancelPaySelect.page=1;
                  return Navigator.of(context).pop(
                      BlocProvider<ShoppingCartBloc>(
                          bloc: ShoppingCartBloc(cancelPaySelect),
                      child:
                      BlocProvider<FoodGalleryBloc>(
                          bloc: FoodGalleryBloc(),
                          child: FoodGallery2()
                      )
                  ),);
                  */


                  print(
                      'debug print before invoking _stopScanDevices(); in cancelPaySelectUnobscuredDeliveryPhone cancel button ');
                  _stopScanDevices();
                  print(
                      'debug print after invoking _stopScanDevices(); in cancelPaySelectUnobscuredDeliveryPhone cancel button');


                  final shoppingCartBloc = BlocProvider.of<
                      ShoppingCartBloc>(context);
                  shoppingCartBloc.clearSubscription();

//                  List<SelectedFood> expandedFoodReturnTemp= new List<SelectedFood>(0);
//                  shoppingCartBloc.getExpandedSelectedFood;
                  cancelPaySelectUnobscuredDeliveryPhone.isCanceled = true;


                  /*
                  //MIGHT NOT BE NECESSARY.
                  setState(() {
                    localScanAvailableState = !localScanAvailableState;
                  });
                  */


                  return Navigator.pop(
                      context, cancelPaySelectUnobscuredDeliveryPhone);
//                  return Navigator.pop(context,cancelPaySelect);

//                  return Navigator.pop(context,expandedFoodReturnTemp);
                },
              ),
            ),

            SizedBox(width: displayWidth(context) / 12,),

            Container(
              width: displayWidth(context) / 4,
              height: displayHeight(context) / 24,
              child: OutlineButton(
                color: Colors.green,
                // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                borderSide: BorderSide(
                  color: Colors.green, // 0xff54463E
                  style: BorderStyle.solid,
                  width: 7.6,
                ),
                shape: RoundedRectangleBorder(


                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Container(

//              alignment: Alignment.center,

                  child: Text('Pay', style: TextStyle(color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,),
                  ),),
                onPressed: () async {
//                  print('on Pressed of Pay');
//                  return Navigator.pop(context,false);

                  final shoppingCartBloc = BlocProvider.of<
                      ShoppingCartBloc>(context);

                  print(
                      'debug print before invoking _startScanDevices(); in cancelPaySelectUnobscuredDeliveryPhone cancel button ');

//                  _startScanDevices();

//                  _startScanDummyDevices();
                  print(
                      'debug print after invoking _startScanDevices(); in cancelPaySelectUnobscuredDeliveryPhone cancel button');

                  print(
                      'cancelPaySelect.paymentTypeIndex: ${cancelPaySelectUnobscuredDeliveryPhone
                          .paymentTypeIndex}');

                  Order tempOrderWithdocId = await shoppingCartBloc
                      .paymentButtonPressed(
                      cancelPaySelectUnobscuredDeliveryPhone);

                  /*

                  setState(() {
                    localScanAvailableState = !localScanAvailableState;
                  });
                  */


                  if ((tempOrderWithdocId.paymentButtonPressed == true) &&
                      (tempOrderWithdocId.orderdocId == '')) {
                    _scaffoldKeyShoppingCartPage.currentState
//                  Scaffold.of(context)
//                    ..removeCurrentSnackBar()
                        .showSnackBar(
                        SnackBar(content: Text("someThing went wrong")));
                    print('something went wrong');
                  }
                  else {
                    print('tempOrderWithdocId.orderdocId: ${tempOrderWithdocId
                        .orderdocId}');

                    List<
                        PrinterBluetooth> blueToothDevicesState = shoppingCartBloc
                        .getDevices;

                    print('blueToothDevicesState.length: ${blueToothDevicesState
                        .length}');

                    if (blueToothDevicesState.length == 0) {
                      logger.i('___________ blueTooth device not found _____');

                      _showMyDialog2(
                          '___________ blueTooth device not found _____ delivery phone pay button');

                      // NEED THIS LINES COMMENTING BEGINNING..

                      /*

                      BluetoothDevice _x = new BluetoothDevice();
                      _x.name = 'Restaurant Printer';
                      _x.address = '0F:02:18:51:23:46';
                      _x.type = 3;
                      _x.connected = null;


                      PrinterBluetooth x = new PrinterBluetooth(_x);


                      _testPrintDummyDevices(x);


                      */

                      // NEED THIS LINES COMMENTING ENDS HERE..


                      return;
                    }


                    bool found = false;
                    int index = -1;
                    for (int i = 0; i < blueToothDevicesState.length; i++) {
                      ++index;

                      print(
                          'blueToothDevicesState[$i].name: ${blueToothDevicesState[i]
                              .name}');
                      print(
                          'oneBlueToothDevice[$i].address: ${blueToothDevicesState[i]
                              .address}');

                      if ((blueToothDevicesState[i].name ==
                          'Restaurant Printer') ||
                          (blueToothDevicesState[i].address ==
                              '0F:02:18:51:23:46')) {
                        found = true;
                        break;

                        // _testPrint(oneBlueToothDevice);

                      }
                    };

                    logger.w('check device listed or not');
                    print('index: $index');
                    print('found == true ${found == true}');

                    if (found == true) {

                      print('found == true');
                      await _testPrint(blueToothDevicesState[index]);
//                      _testPrintDummyDevices(blueToothDevicesState[index]);
                      shoppingCartBloc.clearSubscription();
//                      return Navigator.pop(context,tempOrderWithdocId);
                      return Navigator.pop(context, tempOrderWithdocId);
                    }

                    else {
                      logger.i('___________ blueTooth device not found _____ printing wasn\'t successfull');
                      _showMyDialog2('___________ blueTooth device not found  printing wasn\'t successfull _____');


                      // COMMENT FROM HERE TO END...




                      BluetoothDevice _x = new BluetoothDevice();
                      _x.name = 'Restaurant Printer';
                      _x.address = '0F:02:18:51:23:46';
                      _x.type = 3;
                      _x.connected = null;


                      PrinterBluetooth x = new PrinterBluetooth(_x);


                      _testPrintDummyDevices(x);

                      

                      //END

                      shoppingCartBloc.clearSubscription();
                      return Navigator.pop(context,tempOrderWithdocId);
//                      return Navigator.pop(context, tempOrderWithdocId);
//                      return;


                    }
                  }

                  /*

                  String docId = await shoppingCartBloc.paymentButtonPressed(cancelPaySelect);

                  _scaffoldKey.currentState
//                  Scaffold.of(context)
//                    ..removeCurrentSnackBar()
                      .showSnackBar(SnackBar(content: Text("Order document Id : $docId")));
                  print('on Pressed of Pay of animatedUnObscuredCancelPayButtonTakeAwayDocID=> $docId');

                  */

                },
              ),
            ),
            /*
            Container(
              child: OutlineButton(
                onPressed: (){
                  print('on Pressed of Cancel animatedUnObscuredCancelPayButtonDeliveryPhone');

                  /*
                  cancelPaySelect.page=1;
                  return Navigator.of(context).pop(
                    BlocProvider<ShoppingCartBloc>(
                        bloc: ShoppingCartBloc(cancelPaySelect),
                        child:
                        BlocProvider<FoodGalleryBloc>(
                            bloc: FoodGalleryBloc(),
                            child: FoodGallery2()

                        )
                    ),);
                  */
//                  shoppingCartBloc.cancelButtonPressed();


                  final shoppingCartBloc = BlocProvider.of<
                      ShoppingCartBloc>(context);
                  shoppingCartBloc.cancelButtonPressed();



                  return Navigator.pop(context,true);
                },
                child: Text('Cancel',style: TextStyle(color: Color(0xffFC0000),fontSize: 30),),
                shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(
                    color: Color(0xffFC0000),
                    style: BorderStyle.solid,
                    width: 3.6,
                  ),
                  borderRadius: BorderRadius.circular(35.0),
                ),
              ),

            ),
            SizedBox(width: displayWidth(context)/12,),
            Container(
              child: OutlineButton(
                onPressed: () async{



                  final shoppingCartBloc = BlocProvider.of<
                      ShoppingCartBloc>(context);

                  String docId = await shoppingCartBloc.paymentButtonPressed(cancelPaySelect);

//                  print('on Pressed of Pay of animatedUnObscuredCancelPayButtonTakeAway DocID=> $docId');

                  _scaffoldKey.currentState
//                  Scaffold.of(context)
//                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text("Order document Id : $docId")));

                  print('docId: $docId');
                  /*
                  if(docId !=null)
                  {
                    return Navigator.pop(context,false);
                  }

                   */

                  //   return Navigator.pop(context,false);

                  //   print('on Pressed of Pay');
                  //   return Navigator.pop(context,false);
                },
                child: Text('Pay',style: TextStyle(color: Colors.green,fontSize: 30),),
                shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(
                    color:Colors.green,
                    style: BorderStyle.solid,
                    width: 3.6,
                  ),
                  borderRadius: BorderRadius.circular(35.0),
                ),
              ),

            ),

            */
          ],
        ),
      );
  }


  Widget animatedWidgetShowSelectedPaymentTypeTakeAway(
      Order unObsecuredInputandPayment) {
    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return Container(
      height: displayHeight(context) / 8.2,
//      height: displayHeight(context) / 10,
      child: StreamBuilder(
          stream: shoppingCartbloc.getCurrentPaymentTypeSingleSelectStream,
          initialData: shoppingCartbloc.getCurrentPaymentType,

          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
              return Container(child: Text('Null'));
            }
            else {
              List<
                  PaymentTypeSingleSelect> allPaymentTypesSingleSelect = snapshot
                  .data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

//            print('orderTypes: $allOrderTypesSingleSelect');
              PaymentTypeSingleSelect selectedOne = allPaymentTypesSingleSelect
                  .firstWhere((onePaymentType) =>
              onePaymentType.isSelected == true);

              _currentPaymentTypeIndex = selectedOne.index;

              /*
              logger.e('selectedOne.index',selectedOne.index);
              logger.e('selectedOne.isSelected',selectedOne.isSelected);
              */


              String orderTypeName = selectedOne.paymentTypeName;
              String orderIconName = selectedOne.paymentIconName;
              String borderColor = selectedOne.borderColor;
              const Color OrderTypeIconColor = Color(0xff070707);


              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: displayWidth(context) / 1.1,
                      height: displayHeight(context) / 11,
                      color: Color(0xFFffffff),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[


                          Container(
                            width: displayWidth(context) /
                                1.5,
                            height: displayHeight(
                                context) / 20,
                            color: Color(0xffffffff),

                            child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start
                                ,
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: <Widget>[

                                  Container(
                                    margin: EdgeInsets
                                        .fromLTRB(
                                        20, 0, 10, 0),
                                    alignment: Alignment
                                        .center,
                                    child: Text(
                                        'Payment Method',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight
                                              .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                          color: Color(
                                              0xff000000),
                                        )
                                    ),
                                  ),

                                  CustomPaint(
                                    size: Size(0, 19),
                                    painter: LongPainterForanimatedWidgetShowSelectedOrderType(
                                        context),
                                  ),

                                ]
                            ),

                          ),
                          // THE ABOVE PART DEALS WITH LINES AND TEXT,
                          // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:

                          Container(

//                            width: 100,
                            width: displayWidth(context) / 8,
                            height: displayHeight(context) / 10,
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child:
                            OutlineButton(
                              color: Color(0xff000000),

//          elevation: 2.5,
                              // RoundedRectangleBorder
//          shape: CircleBorder(
                              shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                  color: Color(0xff000000),
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              child: Container(
//                        alignment: Alignment.topCenter,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start
                                  ,
//                          crossAxisAlignment: CrossAxisAlignment
//                              .center,
//                          AA
                                  children: <Widget>[

                                    new Container(

//                                width: displayWidth(context) * 0.09,
//                                height: displayWidth(context) * 0.11,

                                      width: 90,
                                      height: displayHeight(context) / 14,
//                decoration: new BoxDecoration(
//                  color: Colors.orange,
//                  shape: BoxShape.circle,
//                ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
//                    color: Colors.black,
                                          color: Colors.black,
                                          style: BorderStyle.solid,
                                          width: 1.0,

                                        ),
                                        shape: BoxShape.circle,
//                    borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
//                padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),


                                      child: Icon(
                                        getIconForName(orderTypeName),
                                        color: Colors.black,
                                        size: displayHeight(context) / 34,

                                      ),
                                    ),

                                    Container(

                                      alignment: Alignment.center,
                                      child: Text(
                                        orderTypeName, style:
                                      TextStyle(
                                          color: Color(0xffFC0000),

                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                //final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//                          final ShoppingCartBlock = BlocProvider.of<ShoppingCartBloc>(context);
//                          ShoppingCartBlock.setPaymentTypeSingleSelectOptionForOrder(selectedOne,4,_currentOrderTypeIndex);

                                setState(() {
                                  showFullPaymentType = !showFullPaymentType;
//                            _currentPaymentTypeIndex= 4;
//                            showFullOrderType = !showFullOrderType;
                                });
                              },
                            ),
                            // : Container for 2nd argument of ternary condition ends here.

                          )


                          //ZZZZ


                        ],
                      ),
                    ),
                    Container(

                      padding: EdgeInsets
                          .fromLTRB(
                          300, 0, 10, 0),
                      alignment: Alignment
                          .center,
                      child: Row(
                        children: <Widget>[
                          Text(
                              'TOTAL : ',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight
                                    .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(0xffFC0000)
                                ,
                              )
                          ),

                          Text(
                              '${
                                  (unObsecuredInputandPayment.totalPrice
                                      /* * unObsecuredInputandPayment.totalPrice */)
                                      .toStringAsFixed(2)} '
                                  '\u20AC',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight
                                    .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(0xffFC0000)
                                ,
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }
      ),
    );
  }

//  Widget animatedWidgetShowSelectedPaymentTypeTakeAway(Order unObsecuredInputandPayment){
//animatedWidgetShowSelectedPaymentType
//animatedWidgetShowSelectedPaymentTypeDeliveryPhone

  // work 4
  Widget animatedWidgetShowSelectedPaymentTypeDeliveryPhone(
      Order unObsecuredInputandPayment) {
    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    // work -3
    return Container(
//      height: displayHeight(context) / 9,
      height: displayHeight(context) / 8.2,
      child: StreamBuilder(
          stream: shoppingCartbloc.getCurrentPaymentTypeSingleSelectStream,
          initialData: shoppingCartbloc.getCurrentPaymentType,

          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
              return Container(child: Text('Null'));
            }
            else {
              List<
                  PaymentTypeSingleSelect> allPaymentTypesSingleSelect = snapshot
                  .data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

//            print('orderTypes: $allOrderTypesSingleSelect');
              PaymentTypeSingleSelect selectedOne = allPaymentTypesSingleSelect
                  .firstWhere((onePaymentType) =>
              onePaymentType.isSelected == true);

              _currentPaymentTypeIndex = selectedOne.index;
//              logger.e('selectedOne.index',selectedOne.index);
//              logger.e('selectedOne.isSelected',selectedOne.isSelected);


              String orderTypeName = selectedOne.paymentTypeName;
              String orderIconName = selectedOne.paymentIconName;
              String borderColor = selectedOne.borderColor;
              const Color OrderTypeIconColor = Color(0xff070707);


              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: displayWidth(context) / 1.1,
                      height: displayHeight(context) / 11,
//                height: displayHeight(context) / 12,

                      color: Color(0xffffffff),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[


                          Container(
                            width: displayWidth(context) /
                                1.5,
                            height: displayHeight(
                                context) / 20,
                            color: Color(0xffffffff),

                            child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start
                                ,
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: <Widget>[

                                  Container(
                                    margin: EdgeInsets
                                        .fromLTRB(
                                        20, 0, 10, 0),
                                    alignment: Alignment
                                        .center,
                                    child: Text(
                                        'Payment Method',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight
                                              .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                          color: Color(
                                              0xff000000),
                                        )
                                    ),
                                  ),

                                  CustomPaint(
                                    size: Size(0, 19),
                                    painter: LongPainterForanimatedWidgetShowSelectedOrderType(
                                        context),
                                  ),

                                ]
                            ),

                          ),
                          // THE ABOVE PART DEALS WITH LINES AND TEXT,
                          // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:

                          Container(

//                            width: 100,
                            width: displayWidth(context) / 8,
                            height: displayHeight(context) / 10,
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
                            child:
                            OutlineButton(
                              color: Color(0xff000000),

//          elevation: 2.5,
                              // RoundedRectangleBorder
//          shape: CircleBorder(
                              shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                  color: Color(0xff000000),
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              child: Container(
//                        alignment: Alignment.topCenter,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start
                                  ,
//                          crossAxisAlignment: CrossAxisAlignment
//                              .center,
//                          AA
                                  children: <Widget>[

                                    new Container(

//                                width: displayWidth(context) * 0.09,
//                                height: displayWidth(context) * 0.11,

                                      width: 90,
                                      height: displayHeight(context) / 14,
//                decoration: new BoxDecoration(
//                  color: Colors.orange,
//                  shape: BoxShape.circle,
//                ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
//                    color: Colors.black,
                                          color: Colors.black,
                                          style: BorderStyle.solid,
                                          width: 1.0,

                                        ),
                                        shape: BoxShape.circle,
//                    borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
//                padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),


                                      child: Icon(
                                        getIconForName(orderTypeName),
                                        color: Colors.black,
                                        size: displayHeight(context) / 30,

                                      ),
                                    ),

                                    Container(

                                      alignment: Alignment.center,
                                      child: Text(
                                        orderTypeName, style:
                                      TextStyle(
                                          color: Color(0xffFC0000),

                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                //final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//                          final ShoppingCartBlock = BlocProvider.of<ShoppingCartBloc>(context);
//                          ShoppingCartBlock.setPaymentTypeSingleSelectOptionForOrder(selectedOne,4,_currentOrderTypeIndex);

                                setState(() {
                                  showFullPaymentType = !showFullPaymentType;
//                            _currentPaymentTypeIndex= 4;
//                            showFullOrderType = !showFullOrderType;
                                });
                              },
                            ),
                            // : Container for 2nd argument of ternary condition ends here.

                          )


                          //ZZZZ


                        ],
                      ),
                    ),

                    Container(

                      padding: EdgeInsets
                          .fromLTRB(
                          300, 0, 10, 0),
                      alignment: Alignment
                          .center,
                      child: Row(
                        children: <Widget>[
                          Text(
                              'TOTAL : ',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight
                                    .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(0xffFC0000)
                                ,
                              )
                          ),

                          Text(
                              '${
                                  (unObsecuredInputandPayment.totalPrice
                                      /* * unObsecuredInputandPayment.totalPrice */)
                                      .toStringAsFixed(2)} '
                                  '\u20AC',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight
                                    .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(0xffFC0000)
                                ,
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }
      ),
    );
  }

  Widget _buildShoppingCartPaymentMethodsUNObscuredUnSelectedTakeAway(
      Order unObsecuredInputandPayment) {
    //XYZ
    return
      Container(
//        color: Colors.blueGrey,
        color: Colors.white,
        height: displayHeight(context) /
            20 /* HEIGHT OF CHOOSE ORDER TYPE TEXT PORTION */ +
            displayHeight(context) / 7 /* HEIGHT OF MULTI SELECT PORTION */,
        child: Column(
          children: <Widget>[
            Container(
              width: displayWidth(context) / 1.1,
              height: displayHeight(context) / 20,
//              color: Color(0xffffffff),
//              color: Colors.blueGrey,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .start
                ,
                crossAxisAlignment: CrossAxisAlignment
                    .center,
                children: <Widget>[


                  Container(
                    width: displayWidth(context) /
                        1.5,
                    height: displayHeight(
                        context) / 20,
                    color: Color(0xffffffff),

                    child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets
                                .fromLTRB(
                                20, 0, 10, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                'Payment Method',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),

                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForPaymentUnSelected(
                                context),
                          ),


                        ]
                    ),

                  ),

                  // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                  /*
                                                        Container(
//                                                  alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(
                                                              0, 2, 0, 0),
                                                          width: displayWidth(context) /
                                                              16,
//                                                height: displayHeight(context)/20,
                                                          color: Color(0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0, 200, 0),
                                                            child: Icon(

                                                              Icons.add_shopping_cart,
                                                              size: 30,
                                                              color: Color(0xff54463E),
                                                            ),
                                                          ),


                                                        ),
                                                        */


                  // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                  ////WWWEEEQQQ


                ],
              ),
            ),

//            GYG
            // 2ND CONTAINER HOLDS THE total price BEGINS HERE..
            Container(

              padding: EdgeInsets
                  .fromLTRB(
                  300, 0, 10, 0),
              alignment: Alignment
                  .center,
              child: Row(
                children: <Widget>[
                  Text(
                      'TOTAL : ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight
                            .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                        color: Color(0xffFC0000)
                        ,
                      )
                  ),

                  Text(
                      '${
                          (unObsecuredInputandPayment.totalPrice
                              /* * unObsecuredInputandPayment.totalPrice */)
                              .toStringAsFixed(2)} '
                          '\u20AC',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight
                            .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                        color: Color(0xffFC0000)
                        ,
                      )
                  )
                ],
              ),
            ),

            Container(
//              padding: EdgeInsets.fromLTRB(displayWidth(context)/6, 20, 0, 5),
//              alignment:Alignment.center,
//
//                                                      padding::::
//              color: Colors.blueGrey,
              color: Colors.white,
//              color:Colors.white,
//                                            height: 200,
              height: displayHeight(context) / 9,
              width: displayWidth(context)
                  - displayWidth(context) /
                      5,
//                                            width: displayWidth(context) * 0.57,
              child: _buildPaymentTypeSingleSelectOption(),

            ),
          ],
        ),
      );
  }


  Widget _buildShoppingCartPaymentMethodsUNObscuredUnSelected(
      Order unObsecuredInputandPayment) {
//    XYZ
    return
      Container(
//        color: Colors.blueGrey,
        color: Colors.white,
        height: displayHeight(context) /
            20 /* HEIGHT OF CHOOSE ORDER TYPE TEXT PORTION */ +
            displayHeight(context) / 7 /* HEIGHT OF MULTI SELECT PORTION */,
        child: Column(
          children: <Widget>[
            Container(
              width: displayWidth(context) / 1.1,
              height: displayHeight(context) / 20,
//              color: Color(0xffffffff),
//              color: Colors.blueGrey,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .start
                ,
                crossAxisAlignment: CrossAxisAlignment
                    .center,
                children: <Widget>[


                  Container(
                    width: displayWidth(context) /
                        1.5,
                    height: displayHeight(
                        context) / 20,
                    color: Color(0xffffffff),

                    child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start
                        ,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets
                                .fromLTRB(
                                20, 0, 10, 0),
                            alignment: Alignment
                                .center,
                            child: Text(
                                'Payment Method',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight
                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                  color: Color(
                                      0xff000000),
                                )
                            ),
                          ),

                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForPaymentUnSelected(
                                context),
                          ),


                        ]
                    ),

                  ),

                  // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                  /*
                                                        Container(
//                                                  alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(
                                                              0, 2, 0, 0),
                                                          width: displayWidth(context) /
                                                              16,
//                                                height: displayHeight(context)/20,
                                                          color: Color(0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0, 200, 0),
                                                            child: Icon(

                                                              Icons.add_shopping_cart,
                                                              size: 30,
                                                              color: Color(0xff54463E),
                                                            ),
                                                          ),


                                                        ),
                                                        */


                  // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                  ////WWWEEEQQQ


                ],
              ),
            ),

//            GYG
            // 2ND CONTAINER HOLDS THE total price BEGINS HERE..
            Container(

              padding: EdgeInsets
                  .fromLTRB(
                  300, 0, 10, 0),
              alignment: Alignment
                  .center,
              child: Row(
                children: <Widget>[
                  Text(
                      'TOTAL : ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight
                            .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                        color: Color(0xffFC0000)
                        ,
                      )
                  ),

                  Text(
                      '${
                          (unObsecuredInputandPayment.totalPrice
                              /* * unObsecuredInputandPayment.totalPrice */)
                              .toStringAsFixed(2)} '
                          '\u20AC',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight
                            .bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                        color: Color(0xffFC0000)
                        ,
                      )
                  )
                ],
              ),
            ),

            Container(
//              padding: EdgeInsets.fromLTRB(displayWidth(context)/6, 20, 0, 5),
//              alignment:Alignment.center,
//
//                                                      padding::::
//              color: Colors.blueGrey,
              color: Colors.white,
//              color:Colors.white,
//                                            height: 200,
              height: displayHeight(context) / 9,
              width: displayWidth(context)
                  - displayWidth(context) /
                      5,
//                                            width: displayWidth(context) * 0.57,
              child: _buildPaymentTypeSingleSelectOption(),

            ),
          ],
        ),
      );
  }


  int getNumberOfInputsFilledUpDinningRoom(
      CustomerInformation customerInfoFieldsCheck) {
    print(' U   U    U  ?   U   ? getNumberOfInputsFilledUp');
    int total = 0;
    switch (customerInfoFieldsCheck.address
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.flatOrHouseNumber
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.phoneNumber
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.etaTimeInMinutes) {
      case -1:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }


    print('-----  ||  ** **  **TOTAL : $total');
    return total;


//    else{
//      return false;
//      // empty; 3 inputs are not filled.
//    }

  }


  int getNumberOfInputsFilledUpTakeAway(
      CustomerInformation customerInfoFieldsCheck) {
    print(' U   U    U  ?   U   ? getNumberOfInputsFilledUp');
    int total = 0;
    switch (customerInfoFieldsCheck.address
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.flatOrHouseNumber
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.phoneNumber
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.etaTimeInMinutes) {
      case -1:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }


    print('-----  ||  ** **  **TOTAL : $total');
    return total;


//    else{
//      return false;
//      // empty; 3 inputs are not filled.
//    }

  }


  int getNumberOfInputsFilledUp(CustomerInformation customerInfoFieldsCheck) {
    print(' U   U    U  ?   U   ? getNumberOfInputsFilledUp');
    int total = 0;
    switch (customerInfoFieldsCheck.address
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.flatOrHouseNumber
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.phoneNumber
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.etaTimeInMinutes) {
      case -1:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }


    print('-----  ||  ** **  **TOTAL : $total');
    return total;


//    else{
//      return false;
//      // empty; 3 inputs are not filled.
//    }

  }


  IconData getIconForName(String iconName) {
    print('iconName at getIconForName: $iconName');
    switch (iconName) {
      case 'facebook':
        {
//        return FontAwesomeIcons.facebook;
          return FontAwesomeIcons.facebook;
        }
        break;

      case 'twitter':
        {
          return FontAwesomeIcons.twitter;
        }
        break;
      case 'TakeAway':
        {
          return Icons.work;
        }
        break;
      case 'Delivery':
        {
          return Icons.local_shipping;
        }
        break;
      case 'Phone':
        {
          return Icons.phone_in_talk;
        }
        break;
      case 'DinningRoom':
        {
          return Icons.fastfood;
        }

      case 'Card':
        {
          return FontAwesomeIcons.solidCreditCard;
        }
        break;
      case 'Cash':
        {
          return FontAwesomeIcons.moneyBill;
        }
        break;
      case 'Later':
        {
          return FontAwesomeIcons.bookmark;
        }
        break;


      default:
        {
          return FontAwesomeIcons.home;
        }
    }
  }

//  oneSingleDeliveryType to be replaced with oneSinglePaymentType
  Widget oneSingleDeliveryType(OrderTypeSingleSelect x, int index) {
    String orderTypeName = x.orderType;
    String orderIconName = x.orderIconName;
    String borderColor = x.borderColor;
    const Color OrderTypeIconColor = Color(0xff070707);
    return Container(
      child: index == _currentOrderTypeIndex ?

      Container(

        width: displayWidth(context) / 6,
        height: displayHeight(context) / 11,
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child:
        InkWell(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: <Widget>[

                new Container(

                  width: displayWidth(context) / 10.8,
                  height: displayWidth(context) / 10.8,

                  decoration: BoxDecoration(
                    border: Border.all(

                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0,

                    ),
                    shape: BoxShape.circle,

                  ),

                  child: Icon(
                    getIconForName(orderTypeName),
                    color: Color(0xffFC0000),
                    size: displayWidth(context) / 16,

                  ),

                ),
                Container(

                  alignment: Alignment.center,
                  child: Text(
                    orderTypeName, style:
                  TextStyle(
                      color: Color(0xffFC0000),

                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

            shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(
                x, index, _currentOrderTypeIndex);
            showEditingCompleteCustomerAddressInformation = false;
            showEditingCompleteCustomerHouseFlatIformation = false;
            showEditingCompleteCustomerPhoneIformation = false;
            showEditingCompleteCustomerReachoutIformation = false;

            // WORK -2


          },
        ),
        // : Container for 2nd argument of ternary condition ends here.


        // : Container for 2nd argument of ternary condition ends here.

      ) :
      Container(
        width: displayWidth(context) / 6,
        height: displayHeight(context) / 11,
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child:
        InkWell(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: <Widget>[
                new Container(
                  width: displayWidth(context) / 10.8,
                  height: displayWidth(context) / 10.8,
                  decoration: BoxDecoration(
                    border: Border.all(

                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0,

                    ),
                    shape: BoxShape.circle,

                  ),

                  child: Icon(
                    getIconForName(orderTypeName),
                    color: Colors.black,
                    size: displayWidth(context) / 16,
                  ),
                ),
                Container(

                  alignment: Alignment.center,
                  child: Text(
                    orderTypeName, style:
                  TextStyle(
                      color: Color(0xffFC0000),

                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

            shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(
                x, index, _currentOrderTypeIndex);

            setState(() {
              showCustomerInformationHeader = true;
              showUserInputOptionsLikeFirstTime = true;
              // MAKEING THEM AS THEY ARE IN THE FIRST TIME:

              showEditingCompleteCustomerAddressInformation = false;
              showEditingCompleteCustomerHouseFlatIformation = false;
              showEditingCompleteCustomerPhoneIformation = false;
              showEditingCompleteCustomerReachoutIformation = false;


              // WE ARE oneSingleDeliveryType;
//            showFullPaymentType = false;  = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
            }
            );
          },
        ),
      ),

    );
  }

// PAYMENT RELATED WIDGETS ARE HERE  --- below:


  Widget animatedObscuredPaymentSelectContainerTakeAway(
      Order priceandselectedCardFunctionality) {
//  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Card Select Container()');
    return
      Container(
        height: displayWidth(context) / 2.5,
        child: AbsorbPointer(
          child: Opacity(
            opacity: 0.2,
            child: Container(
                color: Colors.greenAccent,
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                width: displayWidth(context)
                    - displayWidth(context) / 5,
                child: _buildShoppingCartPaymentMethodsUNObscuredUnSelected(
                    priceandselectedCardFunctionality)

            ),
          ),
        ),
      );
  }


  Widget animatedObscuredPaymentSelectContainer(
      Order priceandselectedCardFunctionality) {
    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Card Select Container()');
    return
      Container(
        height: displayWidth(context) / 2.5,
        child: AbsorbPointer(
          child: Opacity(
            opacity: 0.2,
            child: Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                width: displayWidth(context)
                    - displayWidth(context) / 5,
                child: _buildShoppingCartPaymentMethodsUNObscuredUnSelected(
                    priceandselectedCardFunctionality)
            ),
          ),
        ),
      );
  }


  bool zeroORMoreInputsEmptyDinningRoom(
      CustomerInformation customerInfoFieldsCheck) {
    print(
        ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber}'
        ' A :${customerInfoFieldsCheck.address} '
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}');

//    assert(customerInfoFieldsCheck.address.trim().length >0);
//    assert(customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.phoneNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.etaTimeInMinutes != -1);
    if
//    (customerInfoFieldsCheck.address.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.phoneNumber.trim().length >0)
//        &&
    (customerInfoFieldsCheck.etaTimeInMinutes != -1) {
      print('WILL RETURN FALSE');
      return false;
    }

    else {
      print('WILL RETURN TRUE');
      return true; // empty; one or more of the user inputs are.
    }
  }


  bool zeroORMoreInputsEmptyTakeAway(
      CustomerInformation customerInfoFieldsCheck) {
    print(
        ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber}'
        ' A :${customerInfoFieldsCheck.address} '
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}');

//    assert(customerInfoFieldsCheck.address.trim().length >0);
//    assert(customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.phoneNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.etaTimeInMinutes != -1);
    if
//    (customerInfoFieldsCheck.address.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.phoneNumber.trim().length >0)
//        &&
    (customerInfoFieldsCheck.etaTimeInMinutes != -1) {
      print('WILL RETURN FALSE');
      return false;
    }

    else {
      print('WILL RETURN TRUE');
      return true; // empty; one or more of the user inputs are.
    }
  }

  bool zeroORMoreInputsEmpty(CustomerInformation customerInfoFieldsCheck) {
    print(
        ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber}'
        ' A :${customerInfoFieldsCheck.address} '
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}');

//    assert(customerInfoFieldsCheck.address.trim().length >0);
//    assert(customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.phoneNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.etaTimeInMinutes != -1);
    if (
    (customerInfoFieldsCheck.address
        .trim()
        .length > 0)
        &&
        (customerInfoFieldsCheck.flatOrHouseNumber
            .trim()
            .length > 0)
        &&
        (customerInfoFieldsCheck.phoneNumber
            .trim()
            .length > 0)
        &&
        (customerInfoFieldsCheck.etaTimeInMinutes != -1)
    ) {
      print('WILL RETURN FALSE');
      return false;
    }

    else {
      print('WILL RETURN TRUE');
      return true; // empty; one or more of the user inputs are.
    }
  }


// 3926 IS FOR THE UNOBSCURE PART.
// 4511 is for the OBSCURED PART.
  Widget _buildPaymentTypeSingleSelectOption() {
//    logger.i('at here: _buildPaymentTypeSingleSelectOption');
//   height: 40,
//   width: displayWidth(context) * 0.57,


    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return StreamBuilder(
        stream: shoppingCartbloc.getCurrentPaymentTypeSingleSelectStream,
        initialData: shoppingCartbloc.getCurrentPaymentType,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Container(child: Text('Null'));
          }
          else {
            List<PaymentTypeSingleSelect> allPaymentTypesSingleSelect = snapshot
                .data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

            print('paymentTypes: $allPaymentTypesSingleSelect');

            /*
            PaymentTypeSingleSelect selectedOne = allPaymentTypesSingleSelect.firstWhere(
                    (onePaymentType) =>
                    onePaymentType.isSelected==true);
            _currentPaymentTypeIndex = selectedOne.index;

            print('_currentPaymentTypeIndex: at 4237 000  0000 $_currentPaymentTypeIndex');


             */


            return Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,

//              reverse: true,

                shrinkWrap: true,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
                itemCount: allPaymentTypesSingleSelect.length,

                itemBuilder: (_, int index) {
                  return oneSinglePaymentType(
                      allPaymentTypesSingleSelect[index],
                      index);
                },

              ),
            );
          }
        }

      // M VSM ORG VS TODO. ENDS HERE.
    );
  }


//  oneSingleDeliveryType to be replaced with oneSinglePaymentType
  Widget oneSinglePaymentType(PaymentTypeSingleSelect onePaymentType,
      int index) {
//    String color1 = x.itemTextColor.replaceAll('#', '0xff');

//    Color c1 = Color(int.parse(color1));
//    print('x: ',x.i)

//    IconData x = IconData(int.parse(x.iconDataString),fontFamily: 'MaterialIcons');

//    print('x.icondataString: ${x.iconDataString}');
//    print('x.orderType: ${x.orderType}');
//    print('isSelected check at Shopping Cart Page: ${x.isSelected}');
//    logger.i('isSelected check at Shopping Cart Page: ',x.isSelected);


//    logger.i('_currentPaymentTypeIndex: at line # 4287 $_currentPaymentTypeIndex');
    String paymentTypeName = onePaymentType.paymentTypeName;
    String paymentIconName = onePaymentType.paymentTypeName;
    String borderColor = onePaymentType.borderColor;
    const Color OrderTypeIconColor = Color(0xff070707);
    return Container(

//      height:displayHeight(context)/30,
//      width:displayWidth(context)/10,

      child: index == _currentPaymentTypeIndex ?

      Container(

//        width: 110,
        width: displayWidth(context) / 7.8,
        height: displayHeight(context) / 11,
//        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
        child:
        OutlineButton(
          color: Color(0xff000000),

//          elevation: 2.5,
          // RoundedRectangleBorder
//          shape: CircleBorder(
          shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
              color: Color(0xff000000),
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(35.0),
          ),

          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              children: <Widget>[

                new Container(

//                                width: displayWidth(context) * 0.09,
//                                height: displayWidth(context) * 0.11,
                  width: displayWidth(context) / 11.5,
                  height: displayWidth(context) / 11.5,
//                decoration: new BoxDecoration(
//                  color: Colors.orange,
//                  shape: BoxShape.circle,
//                ),
                  decoration: BoxDecoration(
                    border: Border.all(
//                    color: Colors.black,
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0,

                    ),
                    shape: BoxShape.circle,
//                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
//                padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),


                  child: Icon(
                    getIconForName(paymentTypeName),
                    color: Color(0xffFC0000),
                    size: displayWidth(context) / 20,

                  ),
//
//                child: Icon(IconData(58840, fontFamily: 'MaterialIcons')),
//                Icon(
//                  IconData(x.orderIconName),
//                               color: Color(0xffFC0000),
//                  size: 36.0,
//                ),
//                child: Icon(IconData(), color: Colors.red), todo

                ),
//              Container(
//
//                alignment: Alignment.center,
//                child: Text(
//                  orderTypeName, style:
//                TextStyle(
//                    color:Colors.white,
//
//                    fontWeight: FontWeight.bold,
//                    fontSize: 16),
//                ),
//              ),

                Container(

                  alignment: Alignment.center,
                  child: Text(
                    paymentTypeName, style:
                  TextStyle(
                      color: Color(0xffFC0000),

                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {
            final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
//    void setPaymentTypeSingleSelectOptionForOrder(PaymentTypeSingleSelect x, int newPaymentIndex,int oldPaymentIndex){
            shoppingCartBloc.setPaymentTypeSingleSelectOptionForOrder(
                onePaymentType, index, _currentPaymentTypeIndex);

            // oneSinglePaymentType
            setState(() {
              showFullPaymentType = false;
            });
          },
        ),
        // : Container for 2nd argument of ternary condition ends here.

      ) :

      Container(
//        width: 110,
        width: displayWidth(context) / 7.8,
//        width: displayWidth(context)/8,
        height: displayHeight(context) / 10,
//        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(5, 0, 3, 0),
        child:
        OutlineButton(
          color: Color(0xff000000),

//          elevation: 2.5,
          shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
              color: Color(0xff000000),
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(35.0),
          ),

          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              children: <Widget>[

                new Container(

//                                width: displayWidth(context) * 0.09,
//                                height: displayWidth(context) * 0.11,
                  width: displayWidth(context) / 11.5,
                  height: displayWidth(context) / 11.5,
                  decoration: BoxDecoration(
                    border: Border.all(
//                      color: Colors.red[500],
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0,

                    ),
                    shape: BoxShape.circle,
//                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
//                padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),


                  child: Icon(
                    getIconForName(paymentTypeName),
                    color: Colors.grey,
                    size: displayWidth(context) / 20,
                  ),
//                child: Icon(
//                  Icons.beach_access,
//                  color: Colors.grey,
//                  size: 36.0,
//                ),

                ),
//              Container(
//
//                alignment: Alignment.center,
//                child: Text(
//                  orderTypeName, style:
//                TextStyle(
//                    color:Colors.white,
//
//                    fontWeight: FontWeight.bold,
//                    fontSize: 16),
//                ),
//              ),

                Container(

                  alignment: Alignment.center,
                  child: Text(
                    paymentTypeName, style:
                  TextStyle(
                      color: Color(0xffFC0000),

                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {
            final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
            shoppingCartBloc.setPaymentTypeSingleSelectOptionForOrder(
                onePaymentType, index, _currentPaymentTypeIndex);


            // oneSinglePaymentType
            setState(() {
              showFullPaymentType = false;
            });
          },
        ),


      ),
    );
  }


  Future<void> _showMyDialog(Uint8List restaurantNameImageByte2,
      Uint8List orderInformationAndUserInformationTopInBytes,
      Uint8List totalCostDeliveryBytes3,
      Uint8List paidUnpaidDeliveryTypeWidgetBytes2) async {
    print('restaurantNameImageByte2: $restaurantNameImageByte2');
    print('totalCostDeliveryBytes3: $totalCostDeliveryBytes3');
    print(
        'paidUnpaidDeliveryTypeWidgetBytes2:$paidUnpaidDeliveryTypeWidgetBytes2');

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('you are using dummy bluetooth devices.'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'please use real blueTooth devices and also change functions in '
                        'shopping cart page.'),
                Container
                  (child: Image.memory(restaurantNameImageByte2)
                ),

                Container
                  (child: Image.memory(orderInformationAndUserInformationTopInBytes)
                ),
                Container
                  (child: Image.memory(totalCostDeliveryBytes3)
                ),

                Container
                  (child: Image.memory(paidUnpaidDeliveryTypeWidgetBytes2)
                ),
//                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('return shopping Cart page.'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void printTicketDummy(/*PaperSize paper, */ Restaurant currentRestaurant,
      OneOrderFirebase oneOrderdocument,
      ImageAliasAnotherSource.Image imageResource, Uint8List orderInformationAndUserInformationTopInBytes,
      Uint8List restaurantNameImageBytes, Uint8List totalCostDeliveryBytes2,
      Uint8List paidUnpaidDeliveryTypeWidgetBytes2) async {
    print(' came here: printTicketDummy');

//    final PosPrintResult res =
//    await printerManager.printTicket(await demoReceipt(paper,currentRestaurant, oneOrderdocument));

//    showToast('res.msg  res.msg   res.msg');


    _showMyDialog(restaurantNameImageBytes,orderInformationAndUserInformationTopInBytes, totalCostDeliveryBytes2,
        paidUnpaidDeliveryTypeWidgetBytes2);
  }


  // # number 1: demoReceipt Order Type TakeAway begins here...

  Future<Ticket> demoReceiptOrderTypeTakeAway(PaperSize paper,
      Restaurant currentRestaurant,
      OneOrderFirebase oneOrderListdocument,
      /*ImageAliasAnotherSource.Image imageResource2, */
      Uint8List restaurantNameImageBytes2,
      Uint8List customerInformationAndOrderInformationBytes,
      Uint8List totalCostDeliveryBytes2,
      Uint8List paidUnpaidDeliveryTypeWidgetBytes2
      /*PaperSize paper,Restaurant currentRestaurant  */) async {
    print('at here: Future<Ticket> demoReceiptOrderTypeTakeAway');


    CustomerInformation customerForReciteGeneration = oneOrderListdocument
        .oneCustomer;

    List<OrderedItem> orderedItems = oneOrderListdocument.orderedItems;

    final Ticket ticket = Ticket(PaperSize.mm58);

    print('paper.value: ${paper.value}');
    print('currentRestaurant: ${currentRestaurant.name}');
    print('oneOrderListdocument: $oneOrderListdocument');
    print('orderedItems: $orderedItems');
    print('customerForReciteGeneration.address: ${customerForReciteGeneration
        .address}');
    print(
        'customerForReciteGeneration.flatOrHouseNumber: ${customerForReciteGeneration
            .flatOrHouseNumber}');
    print(
        'customerForReciteGeneration.phoneNumber: ${customerForReciteGeneration
            .phoneNumber}');
    print(
        'customerForReciteGeneration.etaTimeInMinutes: ${customerForReciteGeneration
            .etaTimeInMinutes}');
    print('restaurantNameImageBytes2: $restaurantNameImageBytes2');
    print('totalCostDeliveryBytes2______: $totalCostDeliveryBytes2');
    print('oneOrderListdocument.orderProductionTime: ${oneOrderListdocument
        .orderProductionTime}');


    final ImageAliasAnotherSource
        .Image oneImageRestaurant = ImageAliasAnotherSource.decodeImage(
        restaurantNameImageBytes2);

    ticket.image(oneImageRestaurant);

    final ImageAliasAnotherSource.Image oneImageTotalCostDelivery =
    ImageAliasAnotherSource.decodeImage(totalCostDeliveryBytes2);


    orderedItems.forEach((oneFood) {
      ticket.row([

        PosColumn(text: '${oneFood.name}',
          width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
        PosColumn(text: '${oneFood.quantity}',
          width: 3, /*, styles: PosStyles(align: PosAlign.center) */),
        PosColumn(text: '${oneFood.oneFoodTypeTotalPrice}',
          width: 4, /* styles: PosStyles(align: PosAlign.right) */),

      ]);


      ticket.hr();
      // needed. as per design.

    });


    ticket.image(oneImageTotalCostDelivery);

    final ImageAliasAnotherSource.Image paidUnpaidDeliveryTypImage =
    ImageAliasAnotherSource.decodeImage(paidUnpaidDeliveryTypeWidgetBytes2);


    ticket.image(paidUnpaidDeliveryTypImage);

//    ticket.image(oneImageTotalCostDelivery);
//    oneImageTotalCostDelivery
//      ticket.image(imageTotalCostForDelivery);


    ticket.feed(2);
    ticket.cut();
    return ticket;
  }


  // # number 2: demoReceipt Order Type Delivery begins here...

//  restaurantNameImageBytes,totalCostDeliveryBytes2
  Future<Ticket> demoReceiptOrderTypeDelivery(PaperSize paper,
      Restaurant currentRestaurant,
      OneOrderFirebase oneOrderListdocument,
      /*ImageAliasAnotherSource.Image imageResource2, */
      Uint8List restaurantNameImageBytes2,
      Uint8List customerInformationAndOrderInformationBytes,
      Uint8List totalCostDeliveryBytes2,
      Uint8List paidUnpaidDeliveryTypeWidgetBytes2
      /*PaperSize paper,Restaurant currentRestaurant  */) async {
    print('at here: Future<Ticket> demoReceiptOrderTypeDelivery');


    CustomerInformation customerForReciteGeneration = oneOrderListdocument
        .oneCustomer;

    List<OrderedItem> orderedItems = oneOrderListdocument.orderedItems;

    final Ticket ticket = Ticket(PaperSize.mm58);

    print('paper.value: ${paper.value}');
    print('currentRestaurant: ${currentRestaurant.name}');
    print('oneOrderListdocument: $oneOrderListdocument');
    print('orderedItems: $orderedItems');
    print('customerForReciteGeneration.address: ${customerForReciteGeneration
        .address}');
    print(
        'customerForReciteGeneration.flatOrHouseNumber: ${customerForReciteGeneration
            .flatOrHouseNumber}');
    print(
        'customerForReciteGeneration.phoneNumber: ${customerForReciteGeneration
            .phoneNumber}');
    print(
        'customerForReciteGeneration.etaTimeInMinutes: ${customerForReciteGeneration
            .etaTimeInMinutes}');
    print('restaurantNameImageBytes2: $restaurantNameImageBytes2');
    print('totalCostDeliveryBytes2:____ $totalCostDeliveryBytes2');
    print('oneOrderListdocument.orderProductionTime: ${oneOrderListdocument
        .orderProductionTime}');


    final ImageAliasAnotherSource
        .Image oneImageRestaurant = ImageAliasAnotherSource.decodeImage(
        restaurantNameImageBytes2);

    ticket.image(oneImageRestaurant);

    final ImageAliasAnotherSource.Image oneImageTotalCostDelivery =
    ImageAliasAnotherSource.decodeImage(totalCostDeliveryBytes2);


    ticket.text('${oneOrderListdocument.orderBy}',
        styles: PosStyles(
          align: PosAlign.left,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,

        ));
    ticket.text('${oneOrderListdocument.formattedOrderPlacementDatesTimeOnly}',
        styles: PosStyles(
          align: PosAlign.left,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));
    ticket.text('${oneOrderListdocument.orderProductionTime} min',
        styles: PosStyles(
          align: PosAlign.left,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));


//    ticket.text('${oneOrderListdocument.documentId}', styles: PosStyles(align: PosAlign.right));
    ticket.text('Address: ${
        ((customerForReciteGeneration.address == null) ||
            (customerForReciteGeneration.address.length == 0)) ?
        'EMPTY' : customerForReciteGeneration.address.length > 7 ?
        customerForReciteGeneration.address.substring(0, 7) + '..' :
        customerForReciteGeneration.address
    }',
        styles: PosStyles(
          align: PosAlign.right,
          height: PosTextSize.size2,
          width: PosTextSize.size2,

        )
    );

    ticket.text('Flat #:${
        ((customerForReciteGeneration.flatOrHouseNumber == null) ||
            (customerForReciteGeneration.flatOrHouseNumber.length == 0)) ?
        'EMPTY' : customerForReciteGeneration.flatOrHouseNumber.length > 7 ?
        customerForReciteGeneration.flatOrHouseNumber.substring(0, 7) + '..' :
        customerForReciteGeneration.flatOrHouseNumber}', styles: PosStyles(

      align: PosAlign.right,
      height: PosTextSize.size2,
      width: PosTextSize.size2,


    )
    );
    ticket.text('phone #:${
        ((customerForReciteGeneration.phoneNumber == null) ||
            (customerForReciteGeneration.phoneNumber.length == 0)) ?
        'EMPTY' : customerForReciteGeneration.flatOrHouseNumber.length > 7 ?
        customerForReciteGeneration.phoneNumber.substring(0, 7) + '..' :
        customerForReciteGeneration.phoneNumber}', styles: PosStyles(

      align: PosAlign.right,
      height: PosTextSize.size2,
      width: PosTextSize.size2,


    )
    );


    orderedItems.forEach((oneFood) {
      ticket.row([

        PosColumn(text: '${oneFood.name}',
          width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
        PosColumn(text: '${oneFood.quantity}',
          width: 3, /*, styles: PosStyles(align: PosAlign.center) */),
        PosColumn(text: '${oneFood.oneFoodTypeTotalPrice}',
          width: 4, /* styles: PosStyles(align: PosAlign.right) */),

      ]);


      ticket.hr();
      // needed. as per design.

    });


//    final ImageAliasAnotherSource.Image oneImageTotalCostDelivery2 = ImageAliasAnotherSource.grayscale(oneImageTotalCostDelivery);


    ticket.image(oneImageTotalCostDelivery);

    final ImageAliasAnotherSource.Image paidUnpaidDeliveryTypImage =
    ImageAliasAnotherSource.decodeImage(paidUnpaidDeliveryTypeWidgetBytes2);


    ticket.image(paidUnpaidDeliveryTypImage);

//    ticket.image(oneImageTotalCostDelivery);
//    oneImageTotalCostDelivery
//      ticket.image(imageTotalCostForDelivery);


    ticket.feed(2);
    ticket.cut();
    return ticket;
  }


  // demoReceipt Order Type Delivery ends here...


  // # number 3: demoReceipt Order Type phone begins here...

  // demoReceipt Order Type Phone begins here...
  Future<Ticket> demoReceiptOrderTypePhone(PaperSize paper,
      Restaurant currentRestaurant,
      OneOrderFirebase oneOrderListdocument,
      /*ImageAliasAnotherSource.Image imageResource2, */
      Uint8List restaurantNameImageBytes2,
      Uint8List customerInformationAndOrderInformationBytes,
      Uint8List totalCostDeliveryBytes2,
      Uint8List paidUnpaidDeliveryTypeWidgetBytes2
      /*PaperSize paper,Restaurant currentRestaurant  */) async {
    print('at here: Future<Ticket> demoReceiptOrderTypeDelivery');


    CustomerInformation customerForReciteGeneration = oneOrderListdocument
        .oneCustomer;

    List<OrderedItem> orderedItems = oneOrderListdocument.orderedItems;

    final Ticket ticket = Ticket(PaperSize.mm58);

    print('paper.value: ${paper.value}');
    print('currentRestaurant: ${currentRestaurant.name}');
    print('oneOrderListdocument: $oneOrderListdocument');
    print('orderedItems: $orderedItems');
    print('customerForReciteGeneration.address: ${customerForReciteGeneration
        .address}');
    print(
        'customerForReciteGeneration.flatOrHouseNumber: ${customerForReciteGeneration
            .flatOrHouseNumber}');
    print(
        'customerForReciteGeneration.phoneNumber: ${customerForReciteGeneration
            .phoneNumber}');
    print(
        'customerForReciteGeneration.etaTimeInMinutes: ${customerForReciteGeneration
            .etaTimeInMinutes}');
    print('restaurantNameImageBytes2: $restaurantNameImageBytes2');
    print('totalCostDeliveryBytes2:____ $totalCostDeliveryBytes2');
    print('oneOrderListdocument.orderProductionTime: ${oneOrderListdocument
        .orderProductionTime}');


    final ImageAliasAnotherSource
        .Image oneImageRestaurant = ImageAliasAnotherSource.decodeImage(
        restaurantNameImageBytes2);

//    grayscale(oneImageRestaurant);
    ticket.image(oneImageRestaurant);

    final ImageAliasAnotherSource.Image oneImageTotalCostDelivery =
    ImageAliasAnotherSource.decodeImage(totalCostDeliveryBytes2);


    ticket.text('${oneOrderListdocument.orderBy}',
        styles: PosStyles(
          align: PosAlign.left,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,

        ));
    ticket.text('${oneOrderListdocument.formattedOrderPlacementDatesTimeOnly}',
        styles: PosStyles(
          align: PosAlign.left,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));
    ticket.text('${oneOrderListdocument.orderProductionTime} min',
        styles: PosStyles(
          align: PosAlign.left,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));


//    ticket.text('${oneOrderListdocument.documentId}', styles: PosStyles(align: PosAlign.right));
    ticket.text('Address: ${
        ((customerForReciteGeneration.address == null) ||
            (customerForReciteGeneration.address.length == 0)) ?
        'EMPTY' : customerForReciteGeneration.address.length > 7 ?
        customerForReciteGeneration.address.substring(0, 7) + '..' :
        customerForReciteGeneration.address
    }',
        styles: PosStyles(
          align: PosAlign.right,
          height: PosTextSize.size2,
          width: PosTextSize.size2,

        )
    );

    ticket.text('Flat #:${
        ((customerForReciteGeneration.flatOrHouseNumber == null) ||
            (customerForReciteGeneration.flatOrHouseNumber.length == 0)) ?
        'EMPTY' : customerForReciteGeneration.flatOrHouseNumber.length > 7 ?
        customerForReciteGeneration.flatOrHouseNumber.substring(0, 7) + '..' :
        customerForReciteGeneration.flatOrHouseNumber}', styles: PosStyles(

      align: PosAlign.right,
      height: PosTextSize.size2,
      width: PosTextSize.size2,


    )
    );
    ticket.text('phone #:${
        ((customerForReciteGeneration.phoneNumber == null) ||
            (customerForReciteGeneration.phoneNumber.length == 0)) ?
        'EMPTY' : customerForReciteGeneration.flatOrHouseNumber.length > 7 ?
        customerForReciteGeneration.phoneNumber.substring(0, 7) + '..' :
        customerForReciteGeneration.phoneNumber}', styles: PosStyles(

      align: PosAlign.right,
      height: PosTextSize.size2,
      width: PosTextSize.size2,


    )
    );


    orderedItems.forEach((oneFood) {
      ticket.row([

        PosColumn(text: '${oneFood.name}',
          width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
        PosColumn(text: '${oneFood.quantity}',
          width: 3, /*, styles: PosStyles(align: PosAlign.center) */),
        PosColumn(text: '${oneFood.oneFoodTypeTotalPrice}',
          width: 4, /* styles: PosStyles(align: PosAlign.right) */),

      ]);


      ticket.hr();
      // needed. as per design.

    });


//    final ImageAliasAnotherSource.Image oneImageTotalCostDelivery2 = ImageAliasAnotherSource.grayscale(oneImageTotalCostDelivery);


    ticket.image(oneImageTotalCostDelivery);

    final ImageAliasAnotherSource.Image paidUnpaidDeliveryTypImage =
    ImageAliasAnotherSource.decodeImage(paidUnpaidDeliveryTypeWidgetBytes2);


    ticket.image(paidUnpaidDeliveryTypImage);
//    oneImageTotalCostDelivery
//      ticket.image(imageTotalCostForDelivery);


    ticket.feed(2);
    ticket.cut();
    return ticket;
  }

// demoReceipt Order Type Phone ends here...


// # number 4: demoReceipt Order Type Dinning begins here...

  Future<Ticket> demoReceiptOrderTypeDinning(PaperSize paper,
      Restaurant currentRestaurant,
      OneOrderFirebase oneOrderListdocument,
      /*ImageAliasAnotherSource.Image imageResource2, */
      Uint8List restaurantNameImageBytes2,
      Uint8List customerInformationAndOrderInformationBytes,
      Uint8List totalCostDeliveryBytes2,
      Uint8List paidUnpaidDeliveryTypeWidgetBytes2
      /*PaperSize paper,Restaurant currentRestaurant  */) async {
    print('at here: Future<Ticket> demoReceiptOrderTypeDelivery');


    CustomerInformation customerForReciteGeneration = oneOrderListdocument
        .oneCustomer;

    List<OrderedItem> orderedItems = oneOrderListdocument.orderedItems;

    final Ticket ticket = Ticket(PaperSize.mm58);

    print('paper.value: ${paper.value}');
    print('currentRestaurant: ${currentRestaurant.name}');
    print('oneOrderListdocument: $oneOrderListdocument');
    print('orderedItems: $orderedItems');
    print('customerForReciteGeneration.address: ${customerForReciteGeneration
        .address}');
    print(
        'customerForReciteGeneration.flatOrHouseNumber: ${customerForReciteGeneration
            .flatOrHouseNumber}');
    print(
        'customerForReciteGeneration.phoneNumber: ${customerForReciteGeneration
            .phoneNumber}');
    print(
        'customerForReciteGeneration.etaTimeInMinutes: ${customerForReciteGeneration
            .etaTimeInMinutes}');
    print('restaurantNameImageBytes2: $restaurantNameImageBytes2');
    print('totalCostDeliveryBytes2:____ $totalCostDeliveryBytes2');
    print('oneOrderListdocument.orderProductionTime: ${oneOrderListdocument
        .orderProductionTime}');


    final ImageAliasAnotherSource
        .Image oneImageRestaurant = ImageAliasAnotherSource.decodeImage(
        restaurantNameImageBytes2);

    ticket.image(oneImageRestaurant);

    final ImageAliasAnotherSource.Image oneImageTotalCostDelivery =
    ImageAliasAnotherSource.decodeImage(totalCostDeliveryBytes2);


    ticket.text('${oneOrderListdocument.orderBy}',
        styles: PosStyles(
          align: PosAlign.left,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,

        ));
    ticket.text('${oneOrderListdocument.formattedOrderPlacementDatesTimeOnly}',
        styles: PosStyles(
          align: PosAlign.left,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));
    ticket.text('${oneOrderListdocument.orderProductionTime} min',
        styles: PosStyles(
          align: PosAlign.left,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));


//    ticket.text('${oneOrderListdocument.documentId}', styles: PosStyles(align: PosAlign.right));
    ticket.text('Address: ${
        ((customerForReciteGeneration.address == null) ||
            (customerForReciteGeneration.address.length == 0)) ?
        'EMPTY' : customerForReciteGeneration.address.length > 7 ?
        customerForReciteGeneration.address.substring(0, 7) + '..' :
        customerForReciteGeneration.address
    }',
        styles: PosStyles(
          align: PosAlign.right,
          height: PosTextSize.size2,
          width: PosTextSize.size2,

        )
    );

    ticket.text('Flat #:${
        ((customerForReciteGeneration.flatOrHouseNumber == null) ||
            (customerForReciteGeneration.flatOrHouseNumber.length == 0)) ?
        'EMPTY' : customerForReciteGeneration.flatOrHouseNumber.length > 7 ?
        customerForReciteGeneration.flatOrHouseNumber.substring(0, 7) + '..' :
        customerForReciteGeneration.flatOrHouseNumber}', styles: PosStyles(

      align: PosAlign.right,
      height: PosTextSize.size2,
      width: PosTextSize.size2,


    )
    );
    ticket.text('phone #:${
        ((customerForReciteGeneration.phoneNumber == null) ||
            (customerForReciteGeneration.phoneNumber.length == 0)) ?
        'EMPTY' : customerForReciteGeneration.flatOrHouseNumber.length > 7 ?
        customerForReciteGeneration.phoneNumber.substring(0, 7) + '..' :
        customerForReciteGeneration.phoneNumber}', styles: PosStyles(

      align: PosAlign.right,
      height: PosTextSize.size2,
      width: PosTextSize.size2,


    )
    );


    orderedItems.forEach((oneFood) {
      ticket.row([

        PosColumn(text: '${oneFood.name}',
          width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
        PosColumn(text: '${oneFood.quantity}',
          width: 3, /*, styles: PosStyles(align: PosAlign.center) */),
        PosColumn(text: '${oneFood.oneFoodTypeTotalPrice}',
          width: 4, /* styles: PosStyles(align: PosAlign.right) */),

      ]);


      ticket.hr();
      // needed. as per design.

    });

//    final ImageAliasAnotherSource.Image oneImageTotalCostDelivery2 = ImageAliasAnotherSource.grayscale(oneImageTotalCostDelivery);


    ticket.image(oneImageTotalCostDelivery);

    final ImageAliasAnotherSource.Image paidUnpaidDeliveryTypImage =
    ImageAliasAnotherSource.decodeImage(paidUnpaidDeliveryTypeWidgetBytes2);

    ticket.image(paidUnpaidDeliveryTypImage);

//    ticket.image(oneImageTotalCostDelivery);
//    oneImageTotalCostDelivery
//      ticket.image(imageTotalCostForDelivery);


    ticket.feed(2);
    ticket.cut();
    return ticket;
  }

// # number 4: demoReceipt Order Type Dinning ends here...



  Future <bool> printTicket(PaperSize paper,
      Restaurant currentRestaurant,
      OneOrderFirebase oneOrderdocument,Uint8List customerInformationAndOrderInformationBytes,
      Uint8List restaurantNameImageBytes,
      Uint8List totalCostDeliveryBytes2,
      Uint8List paidUnpaidDeliveryTypeWidgetBytes) async {
    // pqr
//    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
//    demoReceiptOrderTypeDinning
//    demoReceiptOrderTypeTakeAway
//    demoReceiptOrderTypePhone

    print('oneOrderdocument.orderBy: ${oneOrderdocument.orderBy}');

    final PosPrintResult res = (oneOrderdocument.orderBy.toLowerCase() ==
        'delivery') ?
    await printerManager.printTicket(await demoReceiptOrderTypeDelivery(paper,
        currentRestaurant, oneOrderdocument, restaurantNameImageBytes,customerInformationAndOrderInformationBytes,
        totalCostDeliveryBytes2, paidUnpaidDeliveryTypeWidgetBytes)) :
    (oneOrderdocument.orderBy.toLowerCase() == 'phone') ?
    await printerManager.printTicket(await demoReceiptOrderTypePhone(paper,
        currentRestaurant, oneOrderdocument, restaurantNameImageBytes,customerInformationAndOrderInformationBytes,
        totalCostDeliveryBytes2, paidUnpaidDeliveryTypeWidgetBytes)) :
    (oneOrderdocument.orderBy.toLowerCase() == 'takeaway') ?
    await printerManager.printTicket(await demoReceiptOrderTypeTakeAway(paper,
        currentRestaurant, oneOrderdocument, restaurantNameImageBytes,customerInformationAndOrderInformationBytes,
        totalCostDeliveryBytes2, paidUnpaidDeliveryTypeWidgetBytes)) :
    await printerManager.printTicket(await demoReceiptOrderTypeDinning(paper,
        currentRestaurant, oneOrderdocument, restaurantNameImageBytes,customerInformationAndOrderInformationBytes,
        totalCostDeliveryBytes2, paidUnpaidDeliveryTypeWidgetBytes));


    print('res.msg: ${res.msg}');


    showToast(res.msg);

    if (res.msg == 'Success') {
      print('at  Success');
      return true;
    }


    else {
      print('before returning false from Future <bool> printTicket ');
      return false;
    }

//    TODO: NEED TO check the res.msg
    // true means printed.


  }


  Future<bool> _testPrint(PrinterBluetooth printer) async {
    printerManager.selectPrinter(printer);

    // TODO Don't forget to choose printer's paper
    const PaperSize paper = PaperSize.mm58;

    print(" at _testPrint");


    _scaffoldKeyShoppingCartPage.currentState.showSnackBar(
        new SnackBar(duration: new Duration(seconds: 6), content:
        new Row(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text(
                "fetching data for receipt production...", style: TextStyle(
              color: Colors.white38,
            ))
          ],
        ),
        )
    );




    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

    Restaurant thisRestaurant = shoppingCartBloc.getCurrentRestaurant;

    Order oneOrderForReceipt = shoppingCartBloc.getCurrentOrder;

    print('oneOrderForReceipt.orderdocId: ${oneOrderForReceipt.orderdocId}');


    Future<OneOrderFirebase> testFirebaseOrderFetch =
    shoppingCartBloc.fetchOrderDataFromFirebase(
        oneOrderForReceipt.orderdocId.trim());

    Widget restaurantName2 = restaurantName(thisRestaurant.name);

    final Future<Uint8List> restaurantNameBytesFuture = createImageFromWidget(restaurantName2);

    Uint8List restaurantNameBytesNotFuture;

    print('restaurantNameBytes: $restaurantNameBytesNotFuture');


    ImageAliasAnotherSource.Image imageRestaurant;

    /* await */
    restaurantNameBytesFuture.whenComplete(() {
      print("restaurantNameBytes.whenComplete called when future completes");
    }
    ).then((oneImageInBytes) {
//      ImageAliasAnotherSource.Image imageRestaurant = ImageAliasAnotherSource.decodeImage(oneImageInBytes);
      print('calling ticket.image(imageRestaurant); ');
      restaurantNameBytesNotFuture = oneImageInBytes;
//      ticket.image(imageRestaurant);

    }).catchError((onError) {
      print(' error in getting restaurant name as image');
      print('false: means something wrong not printed');
      //means something wrong not printed
      return false;
    });

    // Print image
    Widget totalDeliveryWidget2 = subTotalTotalDeliveryCost(
        oneOrderForReceipt.totalPrice);
    Uint8List totalCostDeliveryBytes;

    final Future<Uint8List> totalDeliveryWidgetBytes = createImageFromWidget(
        totalDeliveryWidget2);

    /* await */
    totalDeliveryWidgetBytes.whenComplete(() {
      print("called when future completes");
    }
    ).then((oneImageInBytes) {
//      final ImageAliasAnotherSource.Image image = ImageAliasAnotherSource.decodeImage(oneImageInBytes);
      totalCostDeliveryBytes = oneImageInBytes;


//      _showMyDialog3(totalCostDeliveryBytes);
      // ssss
      print('before printing total cose for recite of delivery type order');
//      ticket.image(image);

    }).catchError((onError) {
      print(' error in getting totalDeliveryWidgetBytes');
      return false;
    });


//                            _handleSignIn();

    /* await */
    testFirebaseOrderFetch.whenComplete(() {
      print("called when future completes");
    }
    ).then((oneOrderData) {
      // TODO: any oneOrderData data validation needs to be done in  corresponding block page.
//      if ((oneOrderData.orderType == null) ||((oneOrderData.totalPrice ==null))) {
//        return false;
//      }


      print('reached here: $oneOrderData');


      Widget paidUnpaidDeliveryType2 = paidUnpaidDeliveryType(oneOrderData);

      final Future<
          Uint8List> paidUnpaidDeliveryTypeFutureWidget1 = createImageFromWidget(
          paidUnpaidDeliveryType2);

      Uint8List paidUnpaidDeliveryTypeWidgetBytes;

//      print('restaurantNameBytes: $restaurantNameBytesNotFuture');


//      ImageAliasAnotherSource.Image imageRestaurant;


      /* await */
      paidUnpaidDeliveryTypeFutureWidget1.whenComplete(() {
        print("paidUnpaidDeliveryTypeFutureWidget1.whenComplete");
      }
      ).then((paidUnpaidDeliveryTypeInBytes) {
//        ImageAliasAnotherSource.Image imageRestaurant = ImageAliasAnotherSource.decodeImage(oneImageInBytes);
        print('calling ticket.image(imageRestaurant); ');
//        paidUnpaidDeliveryTypeWidgetBytes = paidUnpaidDeliveryTypeInBytes;
        print(
            'paidUnpaidDeliveryTypeWidgetBytes: $paidUnpaidDeliveryTypeInBytes');


//        DDD
//        Widget orderInformationAndCustomerInformationWidget2 = paidUnpaidDeliveryType(
//            oneOrderData);

        Widget orderInformationAndCustomerInformationWidget2 = orderInformationAndCustomerInformationWidget(
            oneOrderData);

//        Uint8List> paidUnpaidDeliveryTypeFutureWidget1
        final Future<
            Uint8List> orderInformationAndUserInformationTop = createImageFromWidget(
            orderInformationAndCustomerInformationWidget2);

        Uint8List paidUnpaidDeliveryTypeWidgetBytes;

//      print('restaurantNameBytes: $restaurantNameBytesNotFuture');


//      ImageAliasAnotherSource.Image imageRestaurant;


        /* await */
        orderInformationAndUserInformationTop.whenComplete(() {
          print("paidUnpaidDeliveryTypeFutureWidget1.whenComplete");
        }
        ).then((orderInformationAndUserInformationTopInBytes) {
//        ImageAliasAnotherSource.Image imageRestaurant = ImageAliasAnotherSource.decodeImage(oneImageInBytes);
          print(
              'calling ticket.image(orderInformationAndUserInformationTopInBytes);');
//        paidUnpaidDeliveryTypeWidgetBytes = paidUnpaidDeliveryTypeInBytes;
          print(
              'orderInformationAndUserInformationTopInBytes: $orderInformationAndUserInformationTopInBytes');


//        oneOrderData  ssss ssss
//      ticket.image(imageRestaurant);

          Future<bool> isPrint =
          printTicket(
              paper,
              thisRestaurant,
              oneOrderData /*,imageRestaurant */,
              orderInformationAndUserInformationTopInBytes,
              restaurantNameBytesNotFuture,
              totalCostDeliveryBytes,
              paidUnpaidDeliveryTypeInBytes);

//        Future<OneOrderFirebase> testFirebaseOrderFetch=

          isPrint.whenComplete(() {
            print("called when future completes");
//          return true;
          }
          ).then((printResult) {

            if(printResult==true){

//              await
              shoppingCartBloc
                  .recitePrinted(oneOrderForReceipt,true);
//              paymentButtonPressed
//              toDo: update bloc update oneOrder.recitePrinted by calling a method:
//              oneOrder.recitePrinted==false;
            }
            print("printResult: $printResult");
            return true;
          }).catchError((onError) {
            print('printing not successful: $onError');
            return false;
          });
        }).catchError((onError) {
          print(' error handler for getting paidUnpaidDeliveryTypeFutureWidget1');
          print('false: means something wrong not printed');
          //means something wrong not printed
          return false;
        });


//      if ((oneOrderData.orderType != null) ||(oneOrderData.totalPrice !=null)) {
//      await Future.delayed(Duration(milliseconds: 1000));


        // }
        /*
      else{
        return false;
//        ALTERNATE FOR THIS:
//        if ((oneOrderData.orderType == null) || (oneOrderData.totalPrice ==null) || (oneOrderData.totalPrice ==0.0) ){
//          return false;
//        }
      }
      */

      }).catchError((onError) {
        print(' error in getting paidUnpaidDeliveryTypeInBytes');
        print('false: means something wrong not printed');
        //means something wrong not printed
        return false;
      });

    }).catchError((onError) {
      print('Order data fetch Error $onError ***');
      _scaffoldKeyShoppingCartPage.currentState.showSnackBar(
        new SnackBar(duration: new Duration(seconds: 6), content: Container(
          child:
          new Row(
            children: <Widget>[
              new CircularProgressIndicator(),
              new Text("Error: ${onError.message.substring(0, 40)}", style:
              TextStyle(/*fontSize: 10,*/ fontWeight: FontWeight.w500,
                  color: Colors.white)),
            ],
          ),
        )),);

      return false;
    });


    // final return false if true is not return from the above conditioned.
    return false;
//    });
  }

  void _testPrintDummyDevices(PrinterBluetooth printer) async {
    // NOT REQUIRED SINCE DUMMY...

    /*
    printerManager.selectPrinter(printer);

    // TODO Don't forget to choose printer's paper
    const PaperSize paper = PaperSize.mm58;

    */


    print("_testPrintDummyDevices");


    _scaffoldKeyShoppingCartPage.currentState.showSnackBar(
        new SnackBar(duration: new Duration(seconds: 6), content:
        new Row(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text(
                "fetching data for receipt production...", style: TextStyle(
              color: Colors.red,
            ))
          ],
        ),
        )
    );

    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

    Restaurant thisRestaurant = shoppingCartBloc.getCurrentRestaurant;

    Order oneOrderForReceipt = shoppingCartBloc.getCurrentOrder;

    print('oneOrderForReceipt.orderdocId: ${oneOrderForReceipt.orderdocId}');


    Future<OneOrderFirebase> testFirebaseOrderFetch =
    shoppingCartBloc.fetchOrderDataFromFirebase(
        oneOrderForReceipt.orderdocId.trim());


    Widget restaurantName2 = restaurantName(thisRestaurant.name);
    final Future<Uint8List> restaurantNameBytesFuture = createImageFromWidget(
        restaurantName2);
    Uint8List restaurantNameBytesNotFuture;

    print('restaurantNameBytes: $restaurantNameBytesNotFuture');


    ImageAliasAnotherSource.Image imageRestaurant;


    /* await */
    restaurantNameBytesFuture.whenComplete(() {
      print("restaurantNameBytes.whenComplete called when future completes");
    }
    ).then((oneImageInBytes) {
      ImageAliasAnotherSource.Image imageRestaurant = ImageAliasAnotherSource
          .decodeImage(oneImageInBytes);
      print('calling ticket.image(imageRestaurant); ');
      restaurantNameBytesNotFuture = oneImageInBytes;
//      ticket.image(imageRestaurant);

    }).catchError((onError) {
      print(' error in getting restaurant name as image');
    });

    // Print image
    Widget totalDeliveryWidget2 = subTotalTotalDeliveryCost(
        oneOrderForReceipt.totalPrice);
    Uint8List totalCostDeliveryBytes;

    final Future<Uint8List> totalDeliveryWidgetBytes = createImageFromWidget(
        totalDeliveryWidget2);

    /* await */
    totalDeliveryWidgetBytes.whenComplete(() {
      print("called when future completes");
    }
    ).then((oneImageInBytes) {
//      final ImageAliasAnotherSource.Image image = ImageAliasAnotherSource.decodeImage(oneImageInBytes);
      totalCostDeliveryBytes = oneImageInBytes;
      print('before printing total cose for recite of delivery type order');
//      ticket.image(image);

    }).catchError((onError) {
      print(' error in getting restaurant name as image');
    });


//                            _handleSignIn();

    /* await */
    testFirebaseOrderFetch.whenComplete(() {
      print("called when future completes");
    }
    ).then((oneOrderData) {
      Widget paidUnpaidDeliveryType2 = paidUnpaidDeliveryType(oneOrderData);

      final Future<Uint8List> paidUnpaidDeliveryTypeFutureWidget1 = createImageFromWidget(
          paidUnpaidDeliveryType2);

      Uint8List paidUnpaidDeliveryTypeWidgetBytes;

//      print('restaurantNameBytes: $restaurantNameBytesNotFuture');


//      ImageAliasAnotherSource.Image imageRestaurant;


      /* await */
      paidUnpaidDeliveryTypeFutureWidget1.whenComplete(() {
        print(
            "restaurantNameBytes.whenComplete called when future completes");
      }
      ).then((paidUnpaidDeliveryTypeInBytes) {
//        ImageAliasAnotherSource.Image imageRestaurant = ImageAliasAnotherSource.decodeImage(oneImageInBytes);
        print(
            'paidUnpaidDeliveryTypeInBytes: $paidUnpaidDeliveryTypeInBytes ');
//        paidUnpaidDeliveryTypeWidgetBytes = paidUnpaidDeliveryTypeInBytes;
//        print('paidUnpaidDeliveryTypeWidgetBytes: $paidUnpaidDeliveryTypeWidgetBytes');
//      ticket.image(imageRestaurant);





//        DDD
//        Widget orderInformationAndCustomerInformationWidget2 = paidUnpaidDeliveryType(
//            oneOrderData);

        Widget orderInformationAndCustomerInformationWidget2 = orderInformationAndCustomerInformationWidget(
            oneOrderData);

//        Uint8List> paidUnpaidDeliveryTypeFutureWidget1
        final Future<Uint8List> orderInformationAndUserInformationTop = createImageFromWidget(
            orderInformationAndCustomerInformationWidget2);

        Uint8List paidUnpaidDeliveryTypeWidgetBytes;








        /* await */
        orderInformationAndUserInformationTop.whenComplete(() {
          print("paidUnpaidDeliveryTypeFutureWidget1.whenComplete");
        }
        ).then((orderInformationAndUserInformationTopInBytes) {
//        ImageAliasAnotherSource.Image imageRestaurant = ImageAliasAnotherSource.decodeImage(oneImageInBytes);
          print('calling ticket.image(orderInformationAndUserInformationTopInBytes);');
//        paidUnpaidDeliveryTypeWidgetBytes = paidUnpaidDeliveryTypeInBytes;
          print(
              'orderInformationAndUserInformationTopInBytes: $orderInformationAndUserInformationTopInBytes');


//        oneOrderData  ssss ssss
//      ticket.image(imageRestaurant);






          printTicketDummy(/*paper, */
              thisRestaurant, oneOrderData, imageRestaurant,
              restaurantNameBytesNotFuture,orderInformationAndUserInformationTopInBytes,
              totalCostDeliveryBytes, paidUnpaidDeliveryTypeInBytes);
        }).catchError((onError) {
          print(' error in getting restaurant name as image');
          print('false: means something wrong not printed');
          //means something wrong not printed
          return false;
        });
      }).catchError((onError) {
        print(' error in getting restaurant name as image');
        print('false: means something wrong not printed');
        //means something wrong not printed
        return false;
      });
    }).catchError((onError) {
      print('Order data fetch Error $onError ***');
      _scaffoldKeyShoppingCartPage.currentState.showSnackBar(
        new SnackBar(duration: new Duration(seconds: 6), content: Container(
          child:
          new Row(
            children: <Widget>[
              new CircularProgressIndicator(),
              new Text("Error: ${onError.message.substring(0, 40)}", style:
              TextStyle(/*fontSize: 10,*/ fontWeight: FontWeight.w500,
                  color: Colors.white)),
            ],
          ),
        )),);
    });
  }








  Future<void> _showMyDialog3(Uint8List x) async {
    print('x: $x');
//    print('totalCostDeliveryBytes3: $totalCostDeliveryBytes3');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('you are using dummy bluetooth devices.'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'please use real blueTooth devices and also change functions in '
                        'shopping cart page.'),
                Container
                  (child: Image.memory(x)
                ),

//                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('return shopping Cart page.'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

/* PRINTING REcite related codes resides here: */

//  textDirection: TextDirection.ltr,
//  child:
//  Container(


}


//}

//  FoodDetailImage








