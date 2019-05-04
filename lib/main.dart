import 'package:flutter/material.dart';

void main() => runApp(MainScreen());

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  List<String> _recipes = ['French Onion Soup'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("recipedient"),
          ), // AppBar
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                child: RaisedButton(
                  child: Text("Add recipe"),
                  onPressed: () {},
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    Image.asset('resources/logo2.png'),
                    Text("recipedient"),
                  ], // Widget []
                ), // Column
              ), // Card
            ], // []
          ) // Card
          ), // Scaffold
    ); // MaterialApp
  }
}
