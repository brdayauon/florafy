import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

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
  ];
  final List<TextEditingController> controllers = <TextEditingController>[
    nameEditController,
    currLocationEditController,
    ageEditController,
    fertilizerUsedEditController,
    sizeEditController,
    shapeEditController,
    colorLeafEditController,
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
          }
        )

        ]

      ),

     );
  }
}
