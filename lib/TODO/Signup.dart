import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:untitled20/TODO/Loginpage.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpass = TextEditingController();

  Future<void> _signup() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sign up Error'),
          content: const Text('Failed to Signup. Please check your Email or Password.'),
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
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Center(
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: 500,
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
                                return "Please Enter Your Email";
                              } else if (!val.contains('@')) {
                                return "Please enter a valid email";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Your Email',
                              labelText: 'Email',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
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
                                return "Password Cannot be Empty";
                              } else if (val.length < 8) {
                                return "Password must be 8 letters long";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Your Password',
                              labelText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
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
                            controller: confirmpass,
                            validator: (val) {
                              if (val != confirmpass.value.text) {
                                return "Passwords Do Not Match";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Confirm Your Password',
                              labelText: 'Confirm Password',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                        debugPrint("All Validation Passed");
                        //postData();
                      _signup();
                      }
                    },
                    child: Text('Sign Up'),
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
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
