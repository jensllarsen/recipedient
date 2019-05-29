import "package:flutter/material.dart";

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Recipedient'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Recipedient was written by Jens Larsen."),
            Image.asset('resources/edamam.png'),
          ],
        ),
      ),
    );
  }
}
