import 'package:flutter/material.dart';
import 'package:flutterappflorafy/home_page.dart';
import 'package:flutterappflorafy/plant_profile.dart';
import 'package:flutterappflorafy/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Florafy Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.uid}) : super(key: key);

  final String title;
  final FirebaseUser uid;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  var currentUser = "Unknown";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 40,
                child: Container(
//                    width: 100,
//                    height: 100,
                    margin: EdgeInsets.all(10),
                    child: Image(
                      //image: NetworkImage('https://cdnus.melaleuca.com/Images/florify/bottle-2020.png'),
                      image: AssetImage('assets/florafyLogo.png'),
                      fit: BoxFit.cover,
                    ))),
            Expanded(
              flex: 50,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      'Florafy Login',
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 35, right: 35, bottom: 10, top: 10),
                    child: TextField(
                      controller: emailEditingController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Florafy User/Email',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 35, right: 35, bottom: 10, top: 10),
                    child: TextField(
                      controller: passwordEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Florafy Password',
                      ),
                    ),
                  ),
                  Text('Forgot Password?',
                      style: TextStyle(color: Colors.teal)),
                  InkWell(
                    child: Text('Create a new Account',
                        style: TextStyle(color: Colors.teal)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                  )
                ]),
              ),
            ),
            Expanded(
              flex: 20,
              child: Container(
                margin: EdgeInsets.only(top: 40, bottom: 40),
                width: 150,
                child: FlatButton(
                  color: Colors.teal,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    _auth
                        .signInWithEmailAndPassword(
                            email: emailEditingController.text.toString(),
                            password: passwordEditingController.text.toString())
                        .then((value) {
                      print("Successfully login! " + value.user.uid);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage()),

                        //MaterialPageRoute(builder: (context) => PlantProfilePage(uid: value.user.uid)),
                      );
                    }).catchError((e) {
                      print("Failed to login! " + e.toString());
                    });
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
