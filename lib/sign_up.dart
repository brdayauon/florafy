import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'plant_profile.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  var nameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sign Up Page')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailEditingController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordEditingController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            TextField(
              controller: nameEditingController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),

            FlatButton(
              child: Text("Sign Up"),
              onPressed: () {
                print(emailEditingController.text.toString());
                print(passwordEditingController.text.toString());

                _auth
                    .createUserWithEmailAndPassword(
                        email: emailEditingController.text.toString(),
                        password: passwordEditingController.text.toString())
                    .then((authResult) {
                  print("Successfully signed up! " +
                      authResult.user.uid.toString());

                  var userProfile = {
                    'uid': authResult.user.uid,
                    'email': emailEditingController.text,
                    'name': nameEditingController.text,
                  };

                  FirebaseDatabase.instance
                      .reference()
                      .child("user/" + authResult.user.uid)
                      .set(userProfile)
                      .then((value) {
                    print(("Successfullly created the profile information"));

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PlantProfilePage()),
                    );

                  }).catchError((error) {
                    print("Failed to create the profile info.");
                  });
                }).catchError((e) {
                  print("Failed to sign up! " + e.toString());
                });
              },
            )
          ],
        ));
  }
}
