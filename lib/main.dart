import 'package:flutter/material.dart';

void main() => runApp(MainScreen());

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("recipedient"),
        ), // AppBar
        body: Card(
          child: Column(
            children: <Widget>[
              Image.asset('resources/logo2.png'),
              Text("recipedient"),
            ],
          ), // Column
        ), // Card
      ), // Scaffold
    ); // MaterialApp
  }
}
