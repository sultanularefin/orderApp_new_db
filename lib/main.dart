import 'package:flutter/material.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';
import 'package:foodgallery/src/BLoC/identity_bloc.dart';
import 'package:foodgallery/src/welcomePage.dart';
//import 'package:foodgallery/src/screens/foodGallery/food_gallery.dart';
//import 'package:google_fonts/google_fonts.dart';

import 'src/screens/foodGallery/foodgallery2.dart';

//import 'src/welcomePage.dart';


//import 'package:foodgallery/src/
import 'package:foodgallery/src/BLoC/bloc_provider.dart';
//import 'package:foodgallery/src/BLoC/favorite_bloc.dart';
import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';


void main() => runApp(MyApp());




class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return
      BlocProvider<IdentityBloc>(
        bloc: IdentityBloc(),

//        child:BlocProvider<FoodGalleryBloc>(
//
//          bloc:FoodGalleryBloc(),
          child: MaterialApp(

            title: 'Flutter Demo',
            // commented for Tablet testing on april 25.
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
              // This makes the visual density adapt to the platform that you run
              // the app on. For desktop platforms, the controls will be smaller and
              // closer together (more dense) than on mobile platforms.
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            debugShowCheckedModeBanner: false,
//      home: WelcomePage(),
            home:WelcomePage(),


//      home: FoodGallery(),
          ),
        // ),
//        ),
      );
  }
}
