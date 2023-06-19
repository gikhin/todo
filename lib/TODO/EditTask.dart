
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


class Edittask extends StatefulWidget {
  const Edittask({Key? key}) : super(key: key);

  @override
  State<Edittask> createState() => _EdittaskState();
}

class _EdittaskState extends State<Edittask> {
  final CollectionReference App = FirebaseFirestore.instance.collection('todo');
  TextEditingController taskNameController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endtimeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController =TextEditingController();
@override
late String docId;
  final CollectionReference todoapp =
  FirebaseFirestore.instance.collection('todo');
  void Editdata(docId) {
    final data = {
    'taskname': taskNameController.text,
    'starttime': startTimeController.text,
    'endtime': endtimeController.text,
    'date': dateController.text,
    'description': descriptionController.text,

  };
    todoapp.doc(docId).update(data).then((value) {
      Fluttertoast.showToast(msg: "Task Updated Successfully",);
      Navigator.pop(context);
    }).catchError((error) {Fluttertoast.showToast(msg: "Updated Failed",);
    });
}
  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    taskNameController.text=args['taskname'];
    startTimeController.text=args['starttime'].toString();
    endtimeController.text=args['endtime'].toString();
    dateController.text=args['date'];
    descriptionController.text=args['description'];
    final upId = args['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Task',
          style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [Icon(Icons.notification_add, color: Colors.teal)],
      ),
      body: SingleChildScrollView(
        child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30.0,
                      bottom: 5,
                      left: 30,
                      right: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 20,
                            right: 10,
                            left: 10,
                          ),
                          child: TextFormField(
                            controller: taskNameController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Enter Here',
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(width: 0.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 5,
                      left: 30,
                      right: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date & Time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 20,
                            right: 10,
                            left: 10,
                          ),
                          child: TextFormField(
                            controller: dateController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Enter Date',
                              icon: Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.teal,
                              ),
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(width: 0.5),
                              ),
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
                                String formeddate = DateFormat('yyyy-MM-dd').format(pickeddate);
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 5,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Start Time',
                            style:
                            TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Ending Time',
                            style:
                            TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 20,
                      right: 10,
                      left: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: TextFormField(controller: startTimeController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'Select Time',
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(width: 0.5),
                                ),
                              ),
                                onTap: () async {
                                  TimeOfDay? timepick = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    initialEntryMode: TimePickerEntryMode.input,
                                  );
                                  if (timepick != null) {
                                    print(timepick);
                                    String formattedTime = timepick.format(context);
                                    print(formattedTime);
                                    setState(() {
                                      startTimeController.text = formattedTime;
                                    });
                                  }}
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextFormField(controller: endtimeController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'Select Time',
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(width: 0.5),
                                ),
                              ),
                                onTap: () async {
                                  TimeOfDay? timepick = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    initialEntryMode: TimePickerEntryMode.input,
                                  );
                                  if (timepick != null) {
                                    print(timepick);
                                    String formattedTime = timepick.format(context);
                                    print(formattedTime);
                                    setState(() {
                                      endtimeController.text = formattedTime;
                                    });
                                  }}
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 5,
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(controller: descriptionController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Enter Here',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(width: 0.5),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 25.0,
                            right: 25.0,
                            left: 25.0,
                          ),
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
                              onPressed: (){
                                Editdata(docId);
                                Navigator.pop(context);
                              },
                              child: Text('Edit Done'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
        )
      ),
    );
  }
}
