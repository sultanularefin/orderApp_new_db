library constants;

//category_Constants.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




const List CATEGORY_ITEMS =[
  'PIZZA',
  'KEBAB',
  'KANA KEBAB',
  'SALAATTI',
  'HAMPURILAINEN'
      'LASTEN MENU',
  'JUOMAT',
];



class CategoryItem {
  const CategoryItem(this.index,this.name,this.icon);
  final int index;
  final String name;
  final Icon icon;

}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}


final List<CategoryItem> CategoryItems = <CategoryItem>[
  const CategoryItem(0,'PIZZA',       Icon(Icons.android,color:  const Color(0xFF167F67))),
  const CategoryItem(1,'KEBAB',       Icon(Icons.flag, color:  const Color(0xFF167F67))),
  const CategoryItem(2,'KANA KEBAB',  Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67),)),
  const CategoryItem(3,'SALAATTI',    Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67),)),
  const CategoryItem(4,'HAMPURILAINEN',Icon(Icons.flag,color:  const Color(0xFF167F67),)),
  const CategoryItem(5,'LASTEN MENU',  Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67),)),
  const CategoryItem(6,'JUOMAT',      Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67),)),
];