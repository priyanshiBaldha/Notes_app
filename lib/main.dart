import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_app/screen/Homepage.dart';
import 'package:login_app/screen/Login.dart';
import 'package:login_app/screen/SplashScreen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context)=> const SplashScreenPage(),
        'login_page': (context)=> const LoginPage(),
        'homepage': (context)=> const Homepage(),
      },
    )
  );
}

