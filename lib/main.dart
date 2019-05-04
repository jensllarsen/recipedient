import 'package:flutter/material.dart';

main() {
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("recipedient"),
        ),
      ),
    );
  }
}
