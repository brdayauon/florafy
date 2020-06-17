import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'home_page.dart';


class PlantProfilePage extends StatefulWidget {
  PlantProfilePage({Key key, this.title, this.uid}) : super(key: key);
  final String uid;
  final String title;

  @override
  _PlantProfilePageState createState() => _PlantProfilePageState();
}

class _PlantProfilePageState extends State<PlantProfilePage> {
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
      body: Column(
        children: <Widget>[
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

          RaisedButton(
          child: Text('Add plant Profile'),
          color: Colors.teal,
          onPressed: (){
            /*
                ref.child("students/003").set(
                  {
                    "name" : nameEditController.text.toString();
                    "size" : sizeEditController.text.toString();
                  }
                )
                 */
            print(nameEditController.text);
            var timestamp = new DateTime.now().millisecondsSinceEpoch;
            FirebaseDatabase.instance.reference().child("plants/plant" + timestamp.toString()).set(
              {
                "name" : nameEditController.text,
                "location" : currLocationEditController.text,
                "age" : ageEditController.text,
                "fertilizer" : fertilizerUsedEditController.text,
                "size" : sizeEditController.text,
                "shape" : shapeEditController.text,
                "color" : colorLeafEditController.text,
                "environment" : environmentEditController.text,
                "soilType" : soilTypeEditController.text,
                "waterRequirement" : waterRequirementEditController.text,
              }
            ).then((value) {
              print("Successfully added the plant");
            }).catchError((error){
              print("Failed to add. " + error.toString());
            });

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );

          }
        )

        ]

      ),

     );
  }
}
