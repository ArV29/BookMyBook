import 'package:book_my_book/screens/add_ad.dart';
import 'package:book_my_book/screens/chooseCity.dart';
import 'package:book_my_book/screens/delete_ad.dart';
import 'package:book_my_book/screens/homepage.dart';
import 'package:book_my_book/screens/product_details.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors

        // Once complete, show your application
        return MyApp();

        // Otherwise, show something whilst waiting for initialization to complete
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          ProductDetails.id: (context) => ProductDetails(),
          Homepage.id: (context) => Homepage(),
          CityChooser.id: (context) => CityChooser(),
          AddAd.id: (context) => AddAd(),
          DeleteAd.id: (context) => DeleteAd(),
        });
  }
}
