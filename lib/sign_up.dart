import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();

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
            FlatButton(
              child: Text("Sign Up"),
              onPressed: () {
                print(emailEditingController.text.toString());
                print(passwordEditingController.text.toString());

                _auth.createUserWithEmailAndPassword(
                    email: emailEditingController.text.toString(),
                    password: passwordEditingController.text.toString())
                .then((value){
                    print("Successfully signed up! " + value.user.uid);
                }).catchError((e){
                  print("Failed to sign up! " + e.toString());
                });

              },
            )
          ],
        ));
  }
}
