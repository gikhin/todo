import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled20/TODO/Calender.dart';
import 'package:untitled20/TODO/NewTask.dart';
import 'package:untitled20/TODO/Profile.dart';

import 'Chat.dart';
import 'Homepage.dart';


class Big extends StatefulWidget {
  const Big({Key? key}) : super(key: key);

  @override
  State<Big> createState() => _BigState();
}

class _BigState extends State<Big> {
  int currentindex=0;
  final pages=[
    Home(),
    Abc(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pages[currentindex],
      bottomNavigationBar:
      BottomNavigationBar(backgroundColor: Colors.white,
          currentIndex:currentindex,
          onTap: (nav){
            setState((){currentindex=nav;

            },);
          },
          items: [BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month),label: 'Calender'),


          ]),


    );
  }
}