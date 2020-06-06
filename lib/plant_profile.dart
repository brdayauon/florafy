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
  var nameEditController = TextEditingController();
  var sizeEditController = TextEditingController();
  var shapeEditController = TextEditingController();
  var currLocationEditController = TextEditingController();
  var ageEditController = TextEditingController();
  var fertilizerUsedEditController = TextEditingController();
  var colorLeafEditController = TextEditingController();

  _PlantProfilePageState() {
    _auth.currentUser().then((user) {
      setState(() {
        currentUser = user.uid;
      });
    }).catchError((e) {
      print("Failed to get the current user!" + e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Plant Profile')),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Welcome ${currentUser}',
            ),
            TextField(
              controller: nameEditController,
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Name'),
            ),
            TextField(
              controller: sizeEditController,
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Size'),
            ),
            TextField(
              controller: shapeEditController,
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Leaf Shape'),
            ),
            TextField(
              controller: colorLeafEditController,
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Leaf Color'),
            ),
            Text("Create a plant Profile"),
            RaisedButton(
              child: Text('Add Plant Profile'),
              onPressed: () {

                //write the data: key, value
                /*
                ref.child("students/003").set(
                  {
                    "name" : nameEditController.text.toString();
                    "size" : sizeEditController.text.toString();
                  }
                )
                 */

              },
            )
          ],
        ),
      ),
    );
  }
}
