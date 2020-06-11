import 'package:flutter/material.dart';

import 'package:foodgallery/src/BLoC/app_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
//extends InheritedWidget
class BlocProvider2 extends /* StatefulWidget */ InheritedWidget {
  /*final */final AppBloc bloc;

  final Widget child;
//  final List<NewIngredient> thisAllIngredients2;


//  final T bloc;
  BlocProvider2({Key key, this.bloc, /*child*/
    /*@required this.thisAllIngredients2,*/
    /*@required */this.child}) : super(key: key, child: child /**/);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;


  /*
  static BlocProvider2 of (BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<BlocProvider2>();
  */


  static AppBloc of(BuildContext context) /*=>*/ {
    /*
    var x =
        context.
        dependOnInheritedWidgetOfExactType<BlocProvider2>().
        thisAllIngredients2;



     */

    /*
    AppBloc.thisAllIngredients= context.
    dependOnInheritedWidgetOfExactType<BlocProvider2>().
    thisAllIngredients2;
    */
    /*
    return context
        .dependOnInheritedWidgetOfExactType<BlocProvider2>()
        .bloc;
    */

//    print('x X x  at BlocProvider2: ${AppBloc.thisAllIngredients}');
    return context
        .dependOnInheritedWidgetOfExactType<BlocProvider2>().bloc;
  }




//  .dependOnInheritedWidgetOfExactType<BlocProvider2>().bloc;



/*
class _BlocProvider2State extends State<BlocProvider2> {
  // 4
  @override
  Widget build(BuildContext context) => widget.child;

  // 5
  @override
  void dispose() {
//    widget.bloc.dispose();
    super.dispose();
  }
}

*/
}
