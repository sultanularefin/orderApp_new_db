
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_color/random_color.dart';


RandomColor _randomColor = RandomColor();

Color _color = _randomColor.randomColor(
    colorSaturation: ColorSaturation.highSaturation
);



class MultipleSlivers extends StatefulWidget{

  _MultipleSliverState createState() => _MultipleSliverState();
//  fetchPost createState()=> fetchPost();
}

class _MultipleSliverState extends State<MultipleSlivers>{



  //Add your own Json fetch function

  @override
  Widget build(BuildContext context) {
    return Container(child:CustomScrollView(


      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          brightness: Brightness.light,
          title:Text('ss'),
        ),

        SliverPadding(

          padding: EdgeInsets.all(0.0),

          sliver :
          SliverList(

            delegate: SliverChildListDelegate([
              Container(
                width:100,
                child: Row(
                    children: <Widget>[
                      Text('a'),
                      Text('b'),
                    ]

                ),
              ),

              Container(color: Colors.red, height: 150.0,width:100),
              Container(color: Colors.purple, height: 150.0,width:100),
              Container(color: Colors.green, height: 150.0,width:100),
              Container(color: Colors.red, height: 150.0,width:100),
              Container(color: Colors.purple, height: 150.0,width:100),
              Container(color: Colors.green, height: 150.0,width:100),
              Container(color: Colors.red, height: 150.0,width:100),
              Container(color: Colors.purple, height: 150.0,width:100),
              Container(color: Colors.green, height: 150.0,width:100),
            ],
            ),
          ),

        ),

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
// This builds an infinite scrollable list of differently colored
// Containers.

      ],
    ),);

  }

/*
  Widget firstWidget(){
    return Column(

        SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return new Container(
                      color: randomColor(),
                      height: 150.0);
                }
            );
/*
        GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,crossAxisSpacing: 0.0, childAspectRatio: 1/1),
          itemCount: recent == null ? 0 : list.length,
          itemBuilder: (BuildContext context, int index, ) {
            return Column(
              children: <Widget>[
                Card(
                  child: Column(
                    children: <Widget>[
                      new Image.network('asset/image']),
                      new ListTile(
                        title: new Text(''),
                        subtitle: Text("",),
                        onTap: () {Navigator.push(
                          context, new MaterialPageRoute(
                          builder: (context) => new nextclass(),
                        ),
                        );
                        },
                        dense: true,
                      ),
                    ],
                  ),
                )
              ],
            );
          },shrinkWrap: true,
          physics: ClampingScrollPhysics(),
        )
            */
    );
  }

 */
  Widget nextWidget(){
    return Column(
        children: <Widget>[
          Text('a'),
          Text('b'),
        ]
      //your custom widget
    );
  }

}