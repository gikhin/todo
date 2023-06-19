import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:untitled20/TODO/EditTask.dart';


class Mytask extends StatefulWidget {
  const Mytask({Key? key}) : super(key: key);

  @override
  State<Mytask> createState() => _MytaskState();
}

class _MytaskState extends State<Mytask> {
  final CollectionReference todoapp =
  FirebaseFirestore.instance.collection('todo');void delete(docId) {todoapp.doc(docId).delete();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('My Task',style: TextStyle
        (color: Colors.teal,fontWeight:
      FontWeight.bold,)),backgroundColor: Colors.white,centerTitle: true,
        actions: [Icon(Icons.notification_add,color: Colors.teal,)],

      ),
      body:   StreamBuilder(
          stream: todoapp.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot appsnap = snapshot.data!.docs[index];
                  return  Card(
                    child: ListTile(
                      title: Text(appsnap ['taskname']),
                      subtitle: Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(appsnap ['starttime']),
                          Text(appsnap ['endtime']),
                        ],
                      ),
                      leading: CircleAvatar(backgroundColor: Colors.tealAccent.withOpacity(0.2),
                          child: Icon(Icons.play_circle_outlined,color: Colors.teal,)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      IconButton(
                      icon: Icon(
                      Icons.edit,
                        size: 30,
                        color: Colors.teal,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/Edittask',
                            arguments: {
                              'taskname':appsnap['taskname'],
                              'starttime':appsnap['starttime'],
                              'endtime':appsnap['endtime'],
                              'date':appsnap['date'],
                              'description':appsnap['description'],
                              'id':appsnap.id
                            }

                        );
                      }
                      ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.teal,
                      ),
                      onPressed: () {
                        delete(appsnap.id);
                      }
                      )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            else{
              return Center(child: Text('No Data'));
            }

          }
      ),
    );
  }
}