import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class app extends StatefulWidget {
  const app({Key? key}) : super(key: key);

  @override
  State<app> createState() => _appState();
}

class _appState extends State<app> {
  String locatemessage = '';
  void getcurrentlocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    setState(() {
      locatemessage = "Latitude: ${position.latitude},Longitude: ${position.longitude}";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.deepOrangeAccent,
    title: Text("get location",)),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            locatemessage,style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(side: BorderSide(width: 20)),
              onPressed: getcurrentlocation, child: Text('Get Location'))
        ],
      ),
    ),
    );
  }
}
