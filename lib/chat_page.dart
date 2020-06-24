import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterappflorafy/user_profile.dart';

class ChatPage extends StatefulWidget {
  var uid;

  ChatPage(this.uid);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var firebaseMessageRoot;
  var messageController = TextEditingController();
  var scrollController = ScrollController();

  var messageList = [];

  @override
  void initState(){
    if (widget.uid == 'group') {
      firebaseMessageRoot = 'group';
    } else {
      if (UserProfile.currentUser['uid'].compareTo(widget.uid.toString()) >=
          0) {
        firebaseMessageRoot =
            UserProfile.currentUser['uid'] + '-' + widget.uid.toString();
      } else {
        firebaseMessageRoot =
            widget.uid.toString() + '-' + UserProfile.currentUser['uid'];
      }
    }
    _refreshMessageList();
    FirebaseDatabase.instance
        .reference()
        .child("message/" + firebaseMessageRoot)
        .onChildAdded
        .listen((event) {
      _refreshMessageList();
    });

    print("Current uid: " + UserProfile.currentUser['uid']);
  }

  _ChatPageState() {

  }

  void _refreshMessageList() {
    FirebaseDatabase.instance
        .reference()
        .child("message/" + firebaseMessageRoot)
        .once()
        .then((ds) {
      print(ds.value);
      var tmpList = [];
      ds.value.forEach((k, v) {
        v['image'] =
            'https://firebasestorage.googleapis.com/v0/b/florafy-7dacd.appspot.com/o/profile%2FflorafyLogo.png?alt=media&token=2db644bf-c717-4340-94bc-397a2b81b378';
        tmpList.add(v);
      });

      tmpList.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));
      messageList = tmpList;
      setState(() {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    }).catchError((error) {
      print("Failed to get load all the message!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              controller: scrollController,
              itemCount: messageList.length,
              itemBuilder: (BuildContext context, int index) {
                return messageList[index]['uid'] ==
                        UserProfile.currentUser['uid']
                    ? Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                    // width: 250,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(bottom: 3),
                                    decoration: new BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: Text(messageList[index]['text'])),
                                Text(
                                  'Sent At ' +
                                      DateTime.fromMillisecondsSinceEpoch(
                                              messageList[index]['timestamp'])
                                          .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                                //  Text(DateTime.fromMillisecondsSinceEpoch(messageList[index]['timestamp'].toIso8601String())
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    '${messageList[index]['image']}'),
                              ),
                            ),
                          ],
                        ))
                    : Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    '${messageList[index]['image']}'),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    // width: 250,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(bottom: 3),
                                    decoration: new BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: Text(messageList[index]['text'])),
                                Text(
                                  'Sent At ' +
                                      DateTime.fromMillisecondsSinceEpoch(
                                              messageList[index]['timestamp'])
                                          .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                                //  Text(DateTime.fromMillisecondsSinceEpoch(messageList[index]['timestamp'].toIso8601String())
                              ],
                            ),
                          ],
                        ));
              }),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Type your message here',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                var timestamp = DateTime.now().millisecondsSinceEpoch;
                var messageRecord = {
                  "text": messageController.text,
                  "timestamp": timestamp,
                  "uid": UserProfile.currentUser['uid'],
                };
                FirebaseDatabase.instance
                    .reference()
                    .child(("message/" +
                        firebaseMessageRoot +
                        "/" +
                        timestamp.toString()))
                    .set(messageRecord)
                    .then((value) {
                  print("Added the message!");
                  messageController.text = "";
                }).catchError((error) {
                  print("Failed to add the message");
                  messageController.text = "";
                });
              },
            )
          ],
        )
      ],
    ));
  }
}
