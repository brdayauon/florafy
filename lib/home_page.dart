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
    // if (index == 1) {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return new PlantProfilePage();
    }));
//    }
//    else if (index == 2){
//      Navigator.of(context)
//          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
//        return new SignUpPage();
//      }));
//      else{
//
//    }
//    }
  }

  var plantProfileList = [];
  var plantDetailsList = [];

  //static PlantProfile plantProfile = plantProfile1;

  _HomePageState() {
    //load all plant profile from firebase database and
    // display in ListView
    FirebaseDatabase.instance
        .reference()
        .child("user/Ue3zbFg0TpgxtXkP5ETqPJpxomm2")
        .once()
        .then((datasnapshot) {
      print("Successfully loaded the data");
      print(datasnapshot);
      print("Key:");
      print(datasnapshot.key);
      print("Value: ");
      print(datasnapshot.value);
      print("iterating the value map:");
      var plantTmpList = [];
      datasnapshot.value.forEach((k, v) {
        print(k);
        print(v);
        plantTmpList.add(v);
      });
      print("Final Plant List: ");
      print(plantTmpList);
      plantProfileList = plantTmpList;
      setState(() {});
    }).catchError((error) {
      print("Failed to load the data!");
      print(error);
    });
  }
//
//  Widget getPlantProfile(
//      BuildContext context, PlantProfile profile, int index) {
//    return Container(
//        child: Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        Container(
//          margin: EdgeInsets.all(5),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Row(
//                //profile picture. username  ROW.
//                children: <Widget>[
//                  Container(
//                    margin: EdgeInsets.only(right: 10),
////                        child: CircleAvatar(backgroundImage: NetworkImage(plantProfileList['image'] == null ? 'https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png' : plantProfileList['image']),
////                      ),
//                    //  Text(PlantProfile.user.username,)
//                  )
//                ],
//              ),
//              IconButton(
//                icon: Icon(Icons.more_horiz),
//                onPressed: () {},
//              )
//            ],
//          ),
//        ),
//        Container(
//          constraints: BoxConstraints.expand(height: 1),
//          color: Colors.grey,
//        ),
//        Container(
//          constraints: BoxConstraints(maxHeight: 282),
//          decoration:
//              BoxDecoration(image: DecorationImage(image: profile.image)),
//        ),
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[],
//        ),
//      ],
//    ));
//  }

  @override
  Widget build(BuildContext context) {
    var usersPlant = plantProfileList[0]["uid"];
    FirebaseDatabase.instance
        .reference()
        .child("user/" + usersPlant + "/plantProfile")
        .once()
        .then((dns) {
      var usertmpList = [];
      dns.value.forEach((k, v) {
        print(k);
        print(v);
        usertmpList.add(v);
      });
      print("PLANT DETAILS LIST IS: ");

      //print(usertmpList);
      plantDetailsList = usertmpList;
      print(plantDetailsList);
      print(plantDetailsList == plantProfileList);

//      print(" ");
//      print("Plant Profile list is: ");
//      print(plantProfileList);
    }).catchError((error) {
      print("failed to put stuff in usersPlant");
      print(error);
    });
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Column(children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: plantProfileList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 60,
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage('${plantDetailsList[index]['image']}'),
                      // fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
        ),
        Text('usersplant: ${[usersPlant]}'),
        Text('age: ${plantDetailsList[0]['age']}'),
        Text('Name: ${plantProfileList[0]['name']}'),
        Text('Image: ${plantProfileList[0]['image']}'),
      ]),
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

//class PlantProfile {
//  //each post has a picture and description.
//  // So each picture has picture description of plant
//  //
//  AssetImage image;
//  String description;
//  User user;
//
//  PlantProfile(this.image, this.user, this.description);
//}

//class User {
//  //name of user
//  // profile picture
//  String username;
//  AssetImage profilePicture;
//  User(this.username, this.profilePicture);
//}
