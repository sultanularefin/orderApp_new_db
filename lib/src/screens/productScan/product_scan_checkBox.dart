import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';



//import 'detector_painters.dart';



class ProductScannerCheckBox extends StatefulWidget {

  @override
  _ProductScannerCheckBoxState createState() => _ProductScannerCheckBoxState();
}



class _ProductScannerCheckBoxState extends State<ProductScannerCheckBox> {





  dynamic _scanResults;
  dynamic _barcodeValue;

  List<String> data = [];
  File tempImageFile;

  List<String> _imageFiles = [];
  int _value;
  int _radioValue = 0;
  int _itemCount = 1;






  Container ImageCarousel (String imageUrl, String heading, String subHeading){

    return Container(
      width: 160.0,
      // typical mobile screen width is 360
      child: Card(
        child: Wrap(
          children: <Widget>[
            Image.network(imageUrl),
            //           Image.file(''),
            ListTile(
              title: Text(heading),
              subtitle: Text(subHeading),
            )
          ],
        ),
      ),
    ); // First Card

  }


  Widget categoryItem(Color color, String name,int index) {
    return GestureDetector(

      onTap: () {
//        print('_handleRadioValueChange called from Widget categoryItem ');

        _handleRadioValueChange(index);
      },
      child:Container(
        child: _radioValue == index ?
        (
            Card(
              color: color,
              elevation: 2.5,
              shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                borderRadius: BorderRadius.circular(35.0),
              ),
              child:Stack(
                  children:[
                    Align(
                        alignment: Alignment.center,
                        child: Text(name, style: TextStyle(color: Colors.white))
                    ),

                    new Positioned(left:110,
//                  top:-10,
                      top:0,
                      child:
                      IconButton(
                        icon: Icon(Icons.check_box,color: Colors.limeAccent,
                            size: 30.0),
                        tooltip: 'Decrease product count by 1',
                        onPressed: () {
                          print('check Button in the categoryItem Widget pressed.');
                          _handleRadioValueChange(index);
                        },
//                              size: 24,
                        color: Colors.grey,
                      ),
                    ),
                  ]
              ),
            )):(Card(
          color: color,
          elevation: 2.5,
          shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
            borderRadius: BorderRadius.circular(35.0),
          ),
          child:Align(
              alignment: Alignment.center,
              child: Text(name, style: TextStyle(color: Colors.white))
          ),
        )
        ),
      ),
    );

  }


  void _handleRadioValueChange(int value) {
    // print('at _handleRadioValueChange() method ???????????');
    print('value is: $value');
    setState(() {

      switch (_radioValue) {
        case 0:
          _radioValue = value;
          //print('case 0: $value');
          break;
        case 1:
          _radioValue = value;
          //print('case 1: $value');
          break;
        case 2:
          _radioValue = value;
          //print('case 2: $value');
          break;
        case 3:
          _radioValue = value;
          //print('case 0: $value');
          break;
        case 4:
          _radioValue = value;
          //print('case 1: $value');
          break;
        case 5:
          _radioValue = value;
          //print('case 2: $value');
          break;
      }
    });
  }


  int _submitbuttonTapped(){

    print('submit button Tapped');
    print('submit button Tapped');

    print('_barcodeValue: $_barcodeValue');
    print('_imageFiles: $_imageFiles');
    print('_value: $_value');
    print('_radioValue: $_radioValue');
    print('_itemCount: $_itemCount');

    return 1;

  }



  Future<void> _getAndScanImage() async {
//    data.add(barcode.displayValue);
    print('at _getAndScanImage() async ');

    tempImageFile =await ImagePicker.pickImage(source: ImageSource.camera);


    print(tempImageFile.path);


    setState(() {
      _imageFiles.add(tempImageFile.path);
    });


  }



  Widget _dialogBuilder(BuildContext context, String imageSource,int Index){

    return SimpleDialog(
//      contentPadding: EdgeInsets.zero,
      title: Center(child:Text('Image Details: ', style: TextStyle(fontWeight: FontWeight.bold,color:Colors.blue ),


      ),),

      children: [Image.asset(
        imageSource,
        fit: BoxFit.fill,
      ),
        Padding(padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[Text
            ('Image: $Index', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),)
            ,]
            ,)
          ,)

      ],
    );
  }

  Widget _listItemBuilder(BuildContext context, int index){
    // children: _imageFiles.map((item)=>
//  {
//                                int itemIndex = _imageFiles.indexOf(item);
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    print('deviceWidth*0.4: ${deviceWidth*0.4}');
    print('deviceHeight*0.15: ${deviceHeight*0.15}');

    print('*************** deviceWidth ********************* : $deviceWidth');
    print('deviceHeight: $deviceHeight');

    return new GestureDetector(
      onTap: ()=> showDialog(context: context,
          builder: (context) => _dialogBuilder(context, _imageFiles[index],index)),
      child:Container(
//                                      width: 160.0,
        width:deviceWidth*0.21,
        height:deviceHeight*0.42,

        // typical mobile screen width is 360
        child: Card(
          child: Wrap(
            children: <Widget>[
              Image.asset(_imageFiles[index]),
              //           Image.file(''),
              ListTile(
                title: Center(child:Text('Image: $index', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),


                ),),
//                                              subtitle: Text('subHeading'),
              )
            ],
          ),
        ),
      ),
    );
//    ).toList(),// First Card
  }
  @override
  Widget build(BuildContext context)
  {

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

//
//    print('deviceWidth*0.4: ${deviceWidth*0.4}');
//    print('deviceHeight*0.15: ${deviceHeight*0.15}');
//
//    print('deviceWidth __ : $deviceWidth');
//    print('deviceHeight__ : $deviceHeight');

    return Scaffold(
      appBar: AppBar(
          title: new Text('Product Detail'),
          centerTitle: true
      ),

      body: Container(
        margin: EdgeInsets.only(top: statusBarHeight),
        child: Column(
          children: <Widget>[
            /*
            // REMOVED AS APPBAR CONTAINS A DEFAULT BACK BUTTON
            Align(
              alignment: Alignment.topLeft,
              child: BackButton(),
            ),
            */

            Expanded(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10, left: 40, right: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          child: _barcodeValue == null ?
                          GestureDetector(
                            onTap: ()  {
                              print('_getBarCode(context);');
                            },
                            child:Container(
                              child: Image.asset(
                                "assets/images/isbn.png", // smaple isbn barcode image
                                height: 66,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ), // when image is loaded invokes _buildImage method.
                            ),
                          ):Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[GestureDetector(
                                onTap: ()  {
                                  print('_getBarCode(context);');

                                },
                                child:Container(
                                  child: Image.asset(
                                    "assets/images/isbn.png", // smaple isbn barcode image
                                    height: 66,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ), // when image is loaded invokes _buildImage method.
                                ),
                              ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(child:  Text(_barcodeValue))
                              ]),
                        ),

                        SizedBox(
//                          height: 30,
                          height: 20,

                        ),Container(
                          child: (_imageFiles.isEmpty) ?
                          GestureDetector(
                            onTap: () {
                              print(' _getAndScanImage() called');
                              _getAndScanImage();
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(173, 179, 191, 1.0),
                                        blurRadius: 8.0,
                                        offset: Offset(0.0, 1.0))
                                  ]),

                              child: Icon(
                                Icons.camera_alt,
//                                size: 33,
                                size: 43,
                                color: Colors.white,
                              ),
                            ),
                          ):Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[   GestureDetector(
                                onTap: () {
                                  print(' _getAndScanImage() called');
                                  _getAndScanImage();
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[300],
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(173, 179, 191, 1.0),
                                            blurRadius: 8.0,
                                            offset: Offset(0.0, 1.0))
                                      ]),

                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 33,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                                /*
                                new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Expanded(child: new ListView(
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                children: widget.product.map((Product product) {
                  return new ShoppingItemList(product);
                }).toList(),
              )),
                                */
                                Container(
                                  margin:EdgeInsets.symmetric(vertical: 20.0),
                                  height: deviceHeight*0.20,
                                  //   height: 200,
                                  // width: 100,

//                                    child:ScrollView(
                                  child: Scrollbar(

                                    child: ListView.builder(
                                      itemCount: _imageFiles.length,
                                      itemExtent: 95.0,
                                      scrollDirection: Axis.horizontal,
//                                    indicatorColor:blue,
                                      itemBuilder: _listItemBuilder,


                                    ),

                                  ),
                                )
                                ,
                              ]),
                        ),
                        SizedBox(
//                          height: 30,
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Choose Category',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.blueGrey[500],
                                fontSize: 16),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
//                          height: 30,
                          height: 10,
                        ),


                        GridView.extent(

                          maxCrossAxisExtent: 160,
                          controller: new ScrollController(keepScrollOffset: false),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
//                          childAspectRatio: 2.5, --bigger than 2.9
                          childAspectRatio: 3.3,


                          children: <Widget>[

                            new Container(
                              child: Stack(
                                children: <Widget>[
                                  categoryItem(Colors.green, 'Fresh',0),
                                ],
                              ),),

                            new Container(
                              child: Stack(
                                children: <Widget>[

                                  categoryItem(Colors.blue, 'Refrigerator',1),
                                ],
                              ),),
                            new Container(
                              child: Stack(
                                children: <Widget>[
                                  categoryItem(Colors.pink, 'Freezer',2),

                                ],
                              ),),

                            new Container(
                              child: Stack(
                                children: <Widget>[
                                  categoryItem(Colors.red, 'Canned',3),

                                ],
                              ),),

                            new Container(
                              child: Stack(
                                children: <Widget>[
                                  categoryItem(Color.fromRGBO(209, 191, 16, 1), 'Dry',4),

                                ],
                              ),),

                            new Container(
                              child: Stack(
                                children: <Widget>[
                                  categoryItem(Colors.deepPurple, 'Cleaning',5),
                                ],
                              ),),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Product Count'),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.remove_circle),
                              tooltip: 'Decrease product count by 1',
                              onPressed: () {
                                print('Decrease button pressed');
                                setState(() {
                                  _itemCount -= 1;
                                });
                              },
//                              size: 24,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _itemCount.toString(),
                              style: TextStyle(
                                color: Colors.blueGrey[800],
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle),
                              tooltip: 'Increase product count by 1',
                              onPressed: () {
                                print('Add button pressed');
                                setState(() {
                                  _itemCount += 1;
                                });
                              },
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        InkWell(
                          onTap: () {
                            _submitbuttonTapped();
//                            _getAndScanImage();


                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(250, 200, 200, 1.0),
                                      blurRadius: 10.0,
                                      offset: Offset(0.0, 2.0))
                                ],
                                color: Colors.blue),
                            width: 140.0,
                            height: 35.0,
                            padding: EdgeInsets.only(
                                left: 20, top: 3, bottom: 3, right: 4.5),
                            child: Row(
                              children: <Widget>[
                                Text('Submit',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                Spacer(),
                                Container(
                                  height: 25,
                                  width: 25,
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 24,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

}



class _ScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;

  _ScannerOverlayShape({
    //  this.borderColor = Colors.red,
    this.borderColor = Colors.cyanAccent,
    //  this.borderColor = Colors.limeAccent,
    this.borderWidth = 1.0,
    //  this.borderWidth = 22.0,
    // this.overlayColor = const Color(0x88824444),
    this.overlayColor = const Color(0x88000000),
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(10.0);

//  EdgeInsetsGeometry get dimensions => EdgeInsets.all(40.0);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);

    //fillType is in painting.dart class.
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path _getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return _getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );


//      ..lineTo(
//        rect.left,
//        rect.bottom,
//      )
//      ..lineTo(
//        rect.left,
//        rect.top,
//      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    const lineSize = 30;

//    rect.width defined in geometry <sky engine.
//    rect.width = 360
    final width = rect.width;
    print('============================== width at rect.width:  $width');

    final borderWidthSize = width * 10 / 100;
    final height = rect.height; // -- original

//    final height = 180;
    print('============================== height at rect.height: $width');

    final borderHeightSize = height - (width - borderWidthSize);
    final borderSize = Size(borderWidthSize / 2, borderHeightSize / 2);

    var paint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    canvas
      ..drawRect(
        Rect.fromLTRB(
            rect.left, rect.top, rect.right, borderSize.height + rect.top),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(rect.left, rect.bottom - borderSize.height, rect.right,
            rect.bottom),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(rect.left, rect.top + borderSize.height,
            rect.left + borderSize.width, rect.bottom - borderSize.height),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(
            rect.right - borderSize.width,
            rect.top + borderSize.height,
            rect.right,
            rect.bottom - borderSize.height),
        paint,
      );

    paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final borderOffset = borderWidth / 2;
    final realReact = Rect.fromLTRB(
        borderSize.width + borderOffset,
        borderSize.height + borderOffset + rect.top,
        width - borderSize.width - borderOffset,
        height - borderSize.height - borderOffset + rect.top);

    //Draw top right corner
    canvas
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.top)
            ..lineTo(realReact.right, realReact.top + lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.top)
            ..lineTo(realReact.right - lineSize, realReact.top),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.right, realReact.top)],
        paint,
      )

    //Draw top left corner
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.top)
            ..lineTo(realReact.left, realReact.top + lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.top)
            ..lineTo(realReact.left + lineSize, realReact.top),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.left, realReact.top)],
        paint,
      )

    //Draw bottom right corner
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.bottom)
            ..lineTo(realReact.right, realReact.bottom - lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.bottom)
            ..lineTo(realReact.right - lineSize, realReact.bottom),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.right, realReact.bottom)],
        paint,
      )

    //Draw bottom left corner
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.bottom)
            ..lineTo(realReact.left, realReact.bottom - lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.bottom)
            ..lineTo(realReact.left + lineSize, realReact.bottom),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.left, realReact.bottom)],
        paint,
      );
  }

  @override
  ShapeBorder scale(double t) {
    return _ScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}
