import 'package:flutter/material.dart';
import 'package:flutterappflorafy/plant_profile.dart';

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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
                      image: NetworkImage(
                          'https://cdnus.melaleuca.com/Images/florify/bottle-2020.png'),
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
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Florafy Password',
                      ),
                    ),
                  ),
                  Text('Forgot Password?',
                      style: TextStyle(color: Colors.teal)),
                  Text('Create a new Account',
                      style: TextStyle(color: Colors.teal))
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
                    /*...*/
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
//            Expanded(
//                flex: 4,
//                child: Column(
//                  children: <Widget>[
//                    FlatButton(
//                      color: Colors.teal,
//                      textColor: Colors.white,
//                      disabledColor: Colors.grey,
//                      disabledTextColor: Colors.black,
//                      padding: EdgeInsets.all(8.0),
//                      splashColor: Colors.blueAccent,
//                      onPressed: () {
//                        /*...*/
//                      },
//                      child: Text(
//                        "Create a new account",
//                        style: TextStyle(fontSize: 20.0),
//                      ),
//                    ),
//                  ],
//                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlantProfilePage()),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
