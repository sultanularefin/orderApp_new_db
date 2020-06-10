import 'package:flutter/material.dart';

import 'package:foodgallery/src/BLoC/app_bloc.dart';
//extends InheritedWidget
class BlocProvider2 extends /* StatefulWidget */ InheritedWidget {
  final AppBloc bloc;

  final Widget child;
//  final T bloc;
  BlocProvider2({Key key, this.bloc, /*child*/ @required this.child}) : super(key: key, child: child /**/);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider2) as BlocProvider2).bloc;

//  (context.dependOnInheritedWidgetOfExactType(/*BlocProvider*/) as BlocProvider).bloc;


//
//  @override
//  _WelcomePageState createState() => _WelcomePageState();
//  @override
//  StatefulElement createElement() => StatefulElement(this);

  // STATEFUL WDIGET
//  @override
//  _BlocProvider2State createState() => _BlocProvider2State();
}

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
