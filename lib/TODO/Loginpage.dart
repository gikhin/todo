import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled20/TODO/Homepage.dart';
import 'package:untitled20/TODO/Navigation.dart';
import 'package:untitled20/TODO/Signup.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();


  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );Fluttertoast.showToast(msg: 'User Successfully Loggedin');
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Error'),
          content: const Text('Failed to login. Please check your Email or Password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(20.0),
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Container(
                          alignment: Alignment.topCenter,
                          height: 450,
                          width: 330,
                          color: Colors.teal.withOpacity(0.1),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 90),
                                child: Text(
                                  'TODO',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal[900],
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 60,
                                  right: 25,
                                  left: 25,
                                ),
                                child: TextFormField(
                                  controller: email,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Please enter your email";
                                    } else if (!val.contains('@')) {
                                      return "Please enter a valid email";
                                    }
                                    return null;
                                  },
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Enter your email',
                                    labelText: 'Email',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 30,
                                  right: 25,
                                  left: 25,
                                  bottom: 10,
                                ),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: password,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Password cannot be empty";
                                    } else if (val.length < 8) {
                                      return "Password must be 8 characters long";
                                    }
                                    return null;
                                  },
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Enter your password',
                                    labelText: 'Password',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
                      height: 45,
                      width: 330,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            debugPrint("All validation passed");
                            Fluttertoast.showToast(
                              msg: "User successfully logged in",
                            );
                            //postData();
                            _login();
                          }
                        },
                        child: Text('Login'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesome.facebook,
                        ),
                        SizedBox(width: 20),
                        Icon(
                          FontAwesome.twitter,
                        ),
                        SizedBox(width: 20),
                        Icon(
                          FontAwesome.google,
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text(
                      "Don't have an account? Register",
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
