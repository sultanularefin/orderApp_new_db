import 'package:flutter/material.dart';
//import 'package:foodgallery/src/screens/foodGallery/food_gallery.dart';
import 'package:google_fonts/google_fonts.dart';

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
      BlocProvider<FoodGalleryBloc>(
        bloc: FoodGalleryBloc(),

        child: MaterialApp(

          title: 'Flutter Demo',
          // commented for Tablet testing on april 25.
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
              body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
            ),
          ),
          debugShowCheckedModeBanner: false,
//      home: WelcomePage(),
          home:FoodGallery2(),


//      home: FoodGallery(),
        ),
      );
  }
}
