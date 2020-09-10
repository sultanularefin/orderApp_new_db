import 'package:flutter/material.dart';

import 'package:foodgallery/src/BLoC/identity_bloc.dart';

import 'package:foodgallery/src/welcomePage.dart';

import 'package:firebase_core/firebase_core.dart';


import 'package:foodgallery/src/BLoC/bloc_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return
      BlocProvider<IdentityBloc>(
        bloc: IdentityBloc(),

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
              appBarTheme:AppBarTheme(

                color:Colors.white,

                elevation:0,

//                shadowColor:Colors.lightBlueAccent,
//                brightness:,
//                iconTheme,
//                actionsIconTheme,
//                textTheme,
//                centerTitle,

              )

//              appBarTheme.shadowColor:

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
