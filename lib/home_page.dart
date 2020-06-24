import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterappflorafy/plant_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _onTap(int index) {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return new PlantProfilePage();
    }));
  }

  var plantProfileList = []; //user
  var plantDetailsList = []; //plant profiles
  var plantContents = [];

  _HomePageState() {
    //load all plant profile from firebase database and
    // display in ListView
    FirebaseDatabase.instance.reference().child("user").once()
        .then((datasnapshot) {
//      print("Successfully loaded the data");
//      print(datasnapshot);
//      print("Key:");
//      print(datasnapshot.key);
//      print("Value: ");
//      print(datasnapshot.value);
//      print("iterating the value map:");
      var plantTmpList = [];
      datasnapshot.value.forEach((k, v) {
//        print(k);
//        print(v);
        plantTmpList.add(v);
      });
//      print("Final Plant List: ");
//      print(plantTmpList);
      plantProfileList = plantTmpList;
      setState(() {});
    }).catchError((error) {
//      print("Failed to load the data!");
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    var db = FirebaseDatabase.instance.reference().child("user");
    db.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
        print("TEST FUCKING WORK PLEASE");
        print(values["plantProfile"].runtimeType);
        //print(plantDetailsList);
        plantDetailsList.add(values["plantProfile"]);
        //add to a list

      });
    });

    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: ListView.builder(
          itemCount: plantDetailsList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Column(
                children: [
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage('${plantDetailsList[index]['profilePicture']}'),
                          ),
                        ),
                        Text('${plantDetailsList[index]['name']}'),
                        IconButton(
                          icon: Icon(Icons.more_horiz),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
              Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: NetworkImage('${plantDetailsList[index]['image']}'),
                        ),
                        Text('${plantDetailsList[index].toString()}'),
                      ],
                    ),
                ],
              ),

              


            );
          }),

//      body: Column(children: <Widget>[
//        Expanded(
//          child: ListView.builder(
//              itemCount: plantProfileList.length,
//              itemBuilder: (BuildContext context, int index) {
//                return Container(
//                  height: 60,
//                  child: Center(
//                    child: CircleAvatar(
//                      backgroundImage:
//                      NetworkImage('${plantProfileList[index]['name']}'),
//                      // fit: BoxFit.cover,
//                    ),
//                  ),
//                );
//              }),
//        ),
//        Text('uid: ${plantProfileList[0]['uid']}'),
//        Text('uid: ${plantProfileList[0]['uid']}'),
//        Text('Image: ${plantProfileList[0]['image']}'),
//        Text('PlantProfile: ${plantProfileList[0]['plantProfile']}'),
//
//      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        onTap: _onTap,
      ),
    );
  }

  final _items = [
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
  ];
}
