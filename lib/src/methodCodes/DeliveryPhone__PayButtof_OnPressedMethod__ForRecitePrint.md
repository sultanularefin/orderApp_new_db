

## onPressed method for TakeAwayDinningRomm_Method For Dummy Print Only:


### July 26:

```dart



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

                  // let's not use this order returned use the one from the bloc:
                  // Order tempOrderWithdocId
                  Order tempOrderWithdocId = await shoppingCartBloc
                      .paymentButtonPressed(
                      cancelPaySelectUnobscuredDeliveryPhone);

                  /*

                  setState(() {
                    localScanAvailableState = !localScanAvailableState;
                  });
                  */


                  if ((cancelPaySelectUnobscuredDeliveryPhone.paymentButtonPressed == true) &&
                      (cancelPaySelectUnobscuredDeliveryPhone.orderdocId == '')) {
                    _scaffoldKeyShoppingCartPage.currentState
//                  Scaffold.of(context)
//                    ..removeCurrentSnackBar()
                        .showSnackBar(
                        SnackBar(content: Text("someThing went wrong")));
                    print('something went wrong');
                  }
                  else {
                    print('tempOrderWithdocId.orderdocId: ${cancelPaySelectUnobscuredDeliveryPhone
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



                      BluetoothDevice _x = new BluetoothDevice();
                      _x.name = 'Restaurant Printer';
                      _x.address = '0F:02:18:51:23:46';
                      _x.type = 3;
                      _x.connected = null;


                      PrinterBluetooth x = new PrinterBluetooth(_x);


                      _testPrintDummyDevices(x);




                      // NEED THIS LINES COMMENTING ENDS HERE..


                      logger.i('__ __ ${cancelPaySelectUnobscuredDeliveryPhone.recitePrinted}');
                      logger.i('-- ___ ${cancelPaySelectUnobscuredDeliveryPhone.paymentButtonPressed}');
                      shoppingCartBloc.clearSubscription();
//                      shoppingCartBloc.clearSubscriptionPayment();
                      print('shopping Cart : shoppingCartBloc.clearSubscription() called... ');


                      return Navigator.pop(context,cancelPaySelectUnobscuredDeliveryPhone);
//                      return;
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
                      bool printResult= await _testPrint(blueToothDevicesState[index]);

//                      _testPrintDummyDevices(blueToothDevicesState[index]);


                      if(printResult==true) {
                        print('printResult==true i.e. print successfull');
                        shoppingCartBloc.clearSubscription();
                        return Navigator.pop(context, cancelPaySelectUnobscuredDeliveryPhone);
                      }
                      else{
                        print('printResult!=true i.e. print UN successfull');
                        shoppingCartBloc.clearSubscription();
                        return Navigator.pop(context, cancelPaySelectUnobscuredDeliveryPhone);
                      }
                    }


                    else {
                      logger.i('___________ blueTooth device not found _____ printing wasn\'t successfull');
                      _showMyDialog2('___________ blueTooth device not found  printing wasn\'t successfull _____');

                      String docID1;
                      // COMMENT FROM HERE TO END...





                      BluetoothDevice _x = new BluetoothDevice();
                      _x.name = 'Restaurant Printer';
                      _x.address = '0F:02:18:51:23:46';
                      _x.type = 3;
                      _x.connected = null;


                      PrinterBluetooth x = new PrinterBluetooth(_x);


                      _testPrintDummyDevices(x);

//                      print("printResult: $printResult");

                      print('docID in dummy Print: $docID1');
//                      print('docID: $docID');

                      //END



                      if(docID1!=''){
                        print('docID1!=\'\'    ----------');
                        shoppingCartBloc.clearSubscription();
                        return Navigator.pop(context,cancelPaySelectUnobscuredDeliveryPhone);
                      }
                      else{
                        print('docID1 == \'\'   ----------');
                        shoppingCartBloc.clearSubscription();
                        return Navigator.pop(context,cancelPaySelectUnobscuredDeliveryPhone);
                      }

//                      shoppingCartBloc.clearSubscription();
//                      return Navigator.pop(context,tempOrderWithdocId);
//                      return Navigator.pop(context, tempOrderWithdocId);
//                      return;

                    }
                  }



                },
```