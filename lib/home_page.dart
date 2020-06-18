import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var plantProfileList = [];

  _HomePageState() {
    //load all plant profile from firebase database and
    // display in ListView
    FirebaseDatabase.instance.reference().child("plants").once()
        .then((datasnapshot) {
          print("Successfully loaded the data");
          print(datasnapshot);
          print("Key:");
          print(datasnapshot.key);
          print("Value: ");
          print(datasnapshot.value);
          print("iterating the value map:");
          var plantTmpList = [];
          datasnapshot.value.forEach((k,v) {
            print(k);
            print(v);
            plantTmpList.add(v);
          });
          print("Final Friend List: ");
          print(plantTmpList);
          plantProfileList = plantTmpList;
          setState(() {

          });

    }).catchError((error) {
      print("Failed to load the data!");
      print(error);
    });
  }
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: ListView.builder(
          itemCount: plantProfileList.length,
          itemBuilder: (BuildContext context, int index){
            return ListTile(
              
            );
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            title: Text('Add Plant Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text('View Plant Profile'),
          ),
        ],
      ),
    );
  }
}
