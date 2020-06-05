import 'package:flutter/material.dart';

class PlantProfilePage extends StatefulWidget {
  @override
  _PlantProfilePageState createState() => _PlantProfilePageState();
}

class _PlantProfilePageState extends State<PlantProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Column Demo')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Text("Title 1"),
          ),
          Text("Title 2"),
          Text("Title 3"),
          RaisedButton(
            child: Text('Login'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
