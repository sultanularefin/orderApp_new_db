import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import './../../models/dummy.dart';
import './../../models/FoodItem.dart';



class WastedCardItem extends StatelessWidget {
  WastedCardItem({
    Key key,
//    @required this.dummy,
@required this.f,
  }) : super(key: key);

//  final Dummy dummy;
  final FoodItem f;

  @override
  Widget build(BuildContext context) {
    return Container(


      child: Column(
        children: <Widget>[
          Text(
            'item name',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
                fontSize: 16),
          ),
          SizedBox(height: 10),
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
                  imageUrl: f.imageURL,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => new CircularProgressIndicator(),
                ),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          ),
          SizedBox(height: 10),
          Text(
            '3€',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 14),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.remove_circle,
                size: 24,
                color: Colors.grey,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
//                '${dummy.counter}',
                '${f.itemName}',
                style: TextStyle(
                  color: Colors.blueGrey[800],
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.add_circle,
                size: 24,
                color: Colors.grey,
              ),
            ],
          )
        ],
      ),
    );
  }
}
