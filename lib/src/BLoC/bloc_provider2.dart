import 'package:flutter/material.dart';

import 'package:foodgallery/src/BLoC/app_bloc.dart';

class BlocProvider2 extends InheritedWidget {
  final AppBloc bloc;

  BlocProvider2({Key key, this.bloc, child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider2) as BlocProvider2).bloc;

//  (context.dependOnInheritedWidgetOfExactType(/*BlocProvider*/) as BlocProvider).bloc;
}