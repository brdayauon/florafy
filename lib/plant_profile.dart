import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PlantProfilePage extends StatefulWidget {
  PlantProfilePage({Key key, this.title, this.uid}) : super(key: key);
  final String uid;
  final String title;

  @override
  _PlantProfilePageState createState() => _PlantProfilePageState();
}

class _PlantProfilePageState extends State<PlantProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var currentUser = "";
  var seedlingController = TextEditingController();
  var nameEditController = TextEditingController();
  var sizeEditController = TextEditingController();
  var shapeEditController = TextEditingController();


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
      appBar: AppBar(title: Text('Welcome ${currentUser}')),
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
            Text("Create a plant Profile"),
            RaisedButton(
              child: Text('Add Plant Profile'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
