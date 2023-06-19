import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:untitled20/TODO/MyTask.dart';
import 'package:untitled20/TODO/NewTask.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('todo').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Icon(Icons.notification_add, color: Colors.teal),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Newtask()),
          );
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data![index]['taskname']),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(snapshot.data![index]['starttime']),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot.data![index]['endtime']),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.tealAccent.withOpacity(0.2),
                      child: Icon(
                        Icons.play_circle_outlined,
                        color: Colors.teal,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                        color: Colors.teal,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Mytask()),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
