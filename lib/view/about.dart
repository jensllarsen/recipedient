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
        children: <Widget>[
          Text("Recipedient was written by Jens Larsen."),
          Image.asset('resource/edamam.png'),
          MaterialButton(
            child: Text("Return to app"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      )),
    );
  }
}
