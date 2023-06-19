import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Abc extends StatefulWidget {
  const Abc({Key? key}) : super(key: key);

  @override
  State<Abc> createState() => _AbcState();
}

class _AbcState extends State<Abc> {
  var dateController = TextEditingController();
  Future<void> getData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Calender'),backgroundColor: Colors.teal,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: dateController,
              decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today_outlined),
                  labelText: "Enter Date"
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickeddate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2050),
                );
                if (pickeddate != null) {
                  print(pickeddate);
                  String formeddate = DateFormat('dd-MM-yyyy').format(pickeddate);
                  print(formeddate);
                  setState(() {
                    dateController.text = formeddate;
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                getData();
              },
              child: Text("Set"),
            ),
          ),
        ],
      ),
    );
  }
}