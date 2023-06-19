import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled20/App.dart';
import 'package:untitled20/Calculator.dart';
import 'package:untitled20/TODO/EditTask.dart';
import 'package:untitled20/TODO/Navigation.dart';
import 'package:untitled20/TODO/Homepage.dart';
import 'package:untitled20/TODO/NewTask.dart';
import 'package:untitled20/TODO/Signup.dart';

import 'TODO/Loginpage.dart';
import 'TODO/MyTask.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

      initialRoute: '/',
      routes: {
        '/':(context)=> Login(),
        '/Edittask':(context)=> SignupPage(),
        '/Edittask':(context)=> Edittask(),
        
      },
    );
  }
}

