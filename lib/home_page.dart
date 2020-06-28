import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterappflorafy/chat_page.dart';
import 'package:flutterappflorafy/plant_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expand_widget/expand_widget.dart';

import 'user_profile.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var plantProfileList = []; //user
  var plantDetailsList = []; //plant profiles
  var plantContents = [];

  _HomePageState() {

    FirebaseDatabase.instance.reference().child("user").once()
        .then((datasnapshot) {

      var plantTmpList = [];
      datasnapshot.value.forEach((k, v) {

        plantTmpList.add(v);
      });

      plantProfileList = plantTmpList;
      setState(() {
        FirebaseAuth.instance.currentUser().then((value) {
          print(value);
          var uid = value.uid;
          print("uid: " + uid);
          var userInfo = datasnapshot.value[uid];
          UserProfile.currentUser = userInfo;
          print("Current user info: " + userInfo);
        }).catchError((error) {
          print("failed to get  the user info");
          print(error);
        });
      });
    }).catchError((error) {
      print("Failed to load the data!");
      print(error);
    });


  }

  @override
  Widget build(BuildContext context) {

    var db = FirebaseDatabase.instance.reference().child("user");
    db.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
        plantDetailsList.add(values["plantProfile"]);

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
                    margin: EdgeInsets.only(top: 5, bottom: 5, left: 1, right: 1),
                    color: Colors.grey,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: CircleAvatar(
                            backgroundImage:
                            NetworkImage('${plantDetailsList[index]['image']}'),
                          ),
                        ),
                        Text('${plantProfileList[index]['name']}'),
                        Container(
                          margin: EdgeInsets.only(left: 120, right: 10, top: 5, bottom: 5),
                          child: IconButton(
                            icon: Icon(Icons.message),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChatPage(plantProfileList[index]['uid'])),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5),
                        constraints: BoxConstraints(
                        //  maxHeight: 282,
                          maxWidth: 400,
                        ),
                        child: Expanded(

                          child: Center(
                            child: Image(

                              image: NetworkImage('${plantDetailsList[index]['image']}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child:
                        Text(
                          'Description: ${plantDetailsList[index]['description']}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        ExpandChild(
                          hideArrowOnExpanded: false,
                          arrowColor: Colors.grey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(

                              ),
                              ExpandText('Plant Details',style: TextStyle(fontSize: 14, color: Colors.black38),),
                              ExpandText('Age: ${plantDetailsList[index]['age']}', style: TextStyle(fontSize: 14, color: Colors.black38),),
                              ExpandText('Color: ${plantDetailsList[index]['color']}', style: TextStyle(fontSize: 14, color: Colors.black38),),
                              ExpandText('Environment: ${plantDetailsList[index]['environment']}', style: TextStyle(fontSize: 14, color: Colors.black38),),
                              ExpandText('Location: ${plantDetailsList[index]['location']}', style: TextStyle(fontSize: 14, color: Colors.black38),),
                              ExpandText('size: ${plantDetailsList[index]['size']}', style: TextStyle(fontSize: 14, color: Colors.black38),),
                              ExpandText('Soil Type: ${plantDetailsList[index]['soilType']}', style: TextStyle(fontSize: 14, color: Colors.black38),),
                              ExpandText('Water Requirement: ${plantDetailsList[index]['waterRequirement']}', style: TextStyle(fontSize: 14, color: Colors.black38),),

                            ],
                          ),

                        ),
                      ],
                    ),
                  ),
                ],
              ),

            );
          }),

        floatingActionButton: Container(
          margin: EdgeInsets.all(2),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlantProfilePage()),
              );
            },
            tooltip: 'Edit',
            child: Icon(Icons.edit),
          ),
        ), // T

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
      title: Text('View Messages'),
    ),
  ];
}
