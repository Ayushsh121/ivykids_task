import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'Screens/home_screen.dart';
import 'firebase_options.dart';
import 'login_screen/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
   MyApp({super.key});
   final storage = new FlutterSecureStorage();
   Future<bool> checkLoginStatus()async{
      String? value = await storage.read(key: "uid");
      if(value == null){
        return false;
      }
      return true;
   }
  @override
  Widget build(BuildContext context) {
     return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // CHeck for Errors
        if (snapshot.hasError) {
          print("Something went Wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'ivkids task',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            debugShowCheckedModeBanner: false,
            home: FutureBuilder(
              future: checkLoginStatus(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.data==false){
                  return Login();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return HomePage();
              },),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
