import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterappflorafy/chat_page.dart';
import 'package:flutterappflorafy/plant_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'user_profile.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final FirebaseAuth _auth = FirebaseAuth.instance;



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
//      print("Failed to load the data!");
      print(error);
    });

//    FirebaseAuth.instance.currentUser().then((value) {
//      print(value);
//      var uid = value.uid;
//
//    }).catchError((error) {
//      print("failed to update the user");
//    });

  }

  @override
  Widget build(BuildContext context) {
//    theme: ThemeData();
//    darkTheme: ThemeData.dark();

    var db = FirebaseDatabase.instance.reference().child("user");
    db.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
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
                    margin: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
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
                          margin: EdgeInsets.only(left: 145),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: 282,
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
                              color: Colors.black38,
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
                            mainAxisAlignment: MainAxisAlignment.end,

                            children: <Widget>[

                            ExpandText('Plant Details'),
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
      title: Text('View Messages'),
    ),
  ];
}
class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plant Details"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child:
          Text('Go back!'),
        ),
      ),
    );
  }
}