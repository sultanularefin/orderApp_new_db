import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//import 'package:inventory_application/blocs/bloc_provider.dart';
//import 'package:inventory_application/blocs/inventory_bloc.dart';

import './../../models/dummy.dart';
import './../../models/FoodItem.dart';
import './wasted_details_item.dart';

class WastedDetails extends StatefulWidget {
  final Dummy dummy;
  static final Firestore firestore = Firestore.instance;

  WastedDetails({Key key, @required this.dummy}) : super(key: key);





//  print('x1: $x1');




  _DetailsState createState() => _DetailsState(firestore: firestore);
}

class _DetailsState extends State<WastedDetails> {

  _DetailsState({this.firestore});

//  final Stream<QuerySnapshot> x2;



  final Firestore firestore;
// below is one way.
//  final Firestore firestore;
//  _DetailsState({firestore});

//  _DetailsState({this.firestore});


//  CollectionReference get messages => firestore.collection('messages');
//  CollectionReference get foodItems => firestore.collection('foodItems');

  double kExpandedHeight = 180.0;
  ScrollController _scrollController;




  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() => setState(() {
      }));
  }


  bool get _isHide {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - 80;
  }

  int i =33;

//  static Firestore firestore2 = Firestore.instance;

//  _MapStream<QuerySnapshotPlatform, QuerySnapshot>
  var documentsTest;
  var userObject ;
  var x22;



  @override
  Widget build(BuildContext context) {
//    print('documentsTest: ========================================== $x22');
    double screenWidth = MediaQuery.of(context).size.width;
//    firestore
//        .collection("foodItems")
//        .orderBy("uploadDate", descending: true)
//        .snapshots();
//    InventoryBloc bloc = BlocProvider.of<InventoryBloc>(context);
//    declaration was done here
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
      body: StreamBuilder(
//      body: StreamBuilder<QuerySnapshot>(
//        stream: bloc.dataStream,
        stream: firestore
            .collection("foodItems")
            .orderBy("uploadDate", descending: true)
            .snapshots(),
//    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          final int docLength = snapshot.data.documents.length;

          print('docLength: $docLength');

          return
            Container(

              child: CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[

                    SliverPadding(

                      padding: EdgeInsets.all(0.0),
                      sliver :
                      SliverList(

                        delegate: SliverChildListDelegate([
                          Container(color: Colors.yellowAccent,height:150.0),
                        ],
                        ),
                      ),
                    ),

                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150.0,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 16.0,
//                      childAspectRatio: 0.6,
                        childAspectRatio: 0.1,
                      ),
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {

                          final DocumentSnapshot document = snapshot.data.documents[index];
                          final dynamic itemName = document['itemName'];
                          final dynamic imageURL = document['imageURL'];
                          final String euroPrice = document['priceinEuro'];
                          final String itemIngredients =  document['ingredients'];


                          print('document__________________________: ${document.data}');
                          Map<String, dynamic> oneFoodItemData = Map<String, dynamic>.from (document.data);
                          print('FoodItem:__________________________________________ $oneFoodItemData');

                          return Container(


//                              child: new Wrap(
                            child: Column(
                              children: <Widget>[
//                                  Text(
//                                    'item name',
//                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
//                                        color: Colors.blueGrey[800],
//                                        fontSize: 16),
//                                  ),
//                                  SizedBox(height: 10),
                                new Container(
                                  child: new Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(173, 179, 191, 1.0),
                                            blurRadius: 8.0,
                                            offset: Offset(0.0, 1.0))
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                                        imageUrl: imageURL,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => new CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                ),
                                SizedBox(height: 10),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        double.parse(euroPrice).toStringAsFixed(2),
//                                    euroPrice,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 14),
                                      ),
                                      SizedBox(width: 10),

                                      Icon(
                                        Icons.whatshot,
                                        size: 24,
                                        color: Colors.red,
                                      ),
                                    ]),

                                SizedBox(height: 10),

                                Text(
//                '${dummy.counter}',
                                  itemName,
                                  style: TextStyle(
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),

                                Text(
//                '${dummy.counter}',
//                            new Text("Error: ${onError.message.substring(0,40)}",style:
                                  itemIngredients.substring(0,10)+'..',
                                  style: TextStyle(
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
//
//

                              ],
                            ),
                          );

//                        return
//                        WastedCardItem(
////                          dummy: snapshot.data[index],
//                          f: snapshot.data[index],
//                        );
                        },
//                      childCount: snapshot.data.length,
                        childCount: docLength,
                      ),


                    ),

//                        bottom: TabBar(
//                          controller: _tabController,
//                          tabs: ['A', 'B', 'C'].map((t) => Tab(text: 'Tab $t')).toList(),
//                        ),


                    SliverPadding(

                      padding: EdgeInsets.all(0.0),
                      sliver :
                      SliverList(

                        delegate: SliverChildListDelegate([

                          Container(color: Colors.yellowAccent,height:150.0),
                          Container(color: Colors.lightGreenAccent,height:150.0),
                          Container(color: Colors.white,height:150.0),
                          Container(color: Colors.white,height:150.0),
                          Container(color: Colors.orange,height:150.0),
                          Container(color: Colors.orange,height:150.0),
                          Container(color: Colors.orange,height:150.0),
                          Container(color: Colors.lightBlueAccent,height:150.0),
                          Container(color: Colors.yellowAccent,height:150.0),
                        ],
                        ),
                      ),
                    ),







                  ]
              ),


            );

        },

//        body: Center(
//          child: Text("Sample Text"),
//        ),
      ),
    );
  }

  Widget _categorySideMenuRight() {
    List<String> litems = ["1","2","Third","4"];

    return new ListView.builder
      (
        itemCount: litems.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Text(litems[index]);
        }
    );

  }
}