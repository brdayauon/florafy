import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:camera/camera.dart';
import 'package:flutterappflorafy/take_picture_page.dart';
import 'dart:async';
import 'package:flutterappflorafy/home_page.dart';


import 'home_page.dart';

class PlantProfilePage extends StatefulWidget {
  PlantProfilePage({Key key, this.title, this.uid}) : super(key: key);
  final String uid;
  final String title;

  @override
  _PlantProfilePageState createState() => _PlantProfilePageState();
}

class _PlantProfilePageState extends State<PlantProfilePage> {
  var plantProfile;
  var timestamp = new DateTime.now().millisecondsSinceEpoch;

  @override
  void initState(){
    //TODO: implement init state
    super.initState();

    FirebaseAuth.instance.currentUser().then((value) {
      var uid = value.uid;
      FirebaseDatabase.instance.reference().child("user/" + uid).once()
      .then((ds) {
        plantProfile = ds.value;
        setState(() {

        });
      }).catchError((error) {
        print("Failed to get user information.");
      });
    });
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference ref = FirebaseDatabase.instance.reference();

  var currentUser = "";
  var seedlingController = TextEditingController();
  static var nameEditController = TextEditingController();
  static var sizeEditController = TextEditingController();
  static var shapeEditController = TextEditingController();
  static var currLocationEditController = TextEditingController();
  static var ageEditController = TextEditingController();
  static var fertilizerUsedEditController = TextEditingController();
  static var colorLeafEditController = TextEditingController();
  static var environmentEditController = TextEditingController();
  static var soilTypeEditController = TextEditingController();
  static var waterRequirementEditController = TextEditingController();

  _PlantProfilePageState() {
    _auth.currentUser().then((user) {
      setState(() {
        currentUser = user.uid;
      });
    }).catchError((e) {
      print("Failed to get the current user!" + e.toString());
    });
  }

  final List<String> entries = <String>[
    'Name',
    'Location',
    'Age',
    'Fertilizer Used',
    'Size',
    'Leaf Shape',
    'Leaf Color',
    'Environment',
    'Water Requirement',
  ];
  final List<TextEditingController> controllers = <TextEditingController>[
    nameEditController,
    currLocationEditController,
    ageEditController,
    fertilizerUsedEditController,
    sizeEditController,
    shapeEditController,
    colorLeafEditController,
    environmentEditController,
    soilTypeEditController,
    waterRequirementEditController,
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Create Plant Profile')),
      body: Column(children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 60,
                  child: Center(
                    child: TextField(
                      controller: controllers[index],
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: ('${entries[index]}')),
                    ),
                  ),
                );
              }),
        ),
        RaisedButton(  //camera button
            child: Text('Take photo and add plant Profile'),
            color: Colors.teal,
            onPressed: () async {

              final cameras = await availableCameras();
              final firstCamera = cameras.first;

              var result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera)),
              );
            setState(() {
                FirebaseDatabase.instance.reference()
                    .child("user/" + currentUser + "/plantProfile/plant" + timestamp.toString())
                    .set({
                  "name": nameEditController.text,
                  "location": currLocationEditController.text,
                  "age": ageEditController.text,
                  "fertilizer": fertilizerUsedEditController.text,
                  "size": sizeEditController.text,
                  "shape": shapeEditController.text,
                  "color": colorLeafEditController.text,
                  "environment": environmentEditController.text,
                  "soilType": soilTypeEditController.text,
                  "waterRequirement": waterRequirementEditController.text,
                  'image' : result,
                })
                    .then((value) {
                  print("Successfully added plant profile");
                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );

                }).catchError((error) {
                  print("Failed to add the user profile");
                });
              });

            }),
//        RaisedButton(
//            child: Text('Add plant Profile'),
//            color: Colors.teal,
//            onPressed: () {
//              print(nameEditController.text);
//              FirebaseDatabase.instance
//                  .reference()
//                  .child("user/" + currentUser + "/plantProfile/plant" + timestamp.toString())    //timestamp.toString())
//                  .set({
//                "name": nameEditController.text,
//                "location": currLocationEditController.text,
//                "age": ageEditController.text,
//                "fertilizer": fertilizerUsedEditController.text,
//                "size": sizeEditController.text,
//                "shape": shapeEditController.text,
//                "color": colorLeafEditController.text,
//                "environment": environmentEditController.text,
//                "soilType": soilTypeEditController.text,
//                "waterRequirement": waterRequirementEditController.text,
//              }).then((value) {
//                print("Successfully added the plant");
//
//              }).catchError((error) {
//                print("Failed to add. " + error.toString());
//              });
//
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => HomePage()),
//              );
//            })
      ]),
    );
  }


}
