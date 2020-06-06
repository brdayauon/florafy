import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PlantProfilePage extends StatefulWidget {
  PlantProfilePage({Key key, this.title, this.uid}) : super(key:key);
  final String uid;
  final String title;

  @override
  _PlantProfilePageState createState() => _PlantProfilePageState();
}

class _PlantProfilePageState extends State<PlantProfilePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var currentUser = "";

  _PlantProfilePageState(){
    _auth.currentUser().then((user){
      setState((){
        currentUser = user.uid;
      });
    }).catchError((e){
        print("Failed to get the current user!" + e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome ${currentUser}')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Text("Title 1"),
          ),
          Text("${currentUser}"),
          Text("Title 3"),
          RaisedButton(
            child: Text('Enter'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
