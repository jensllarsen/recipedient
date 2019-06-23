import "package:flutter/material.dart";
import 'package:recipedient/widgets/color_palette.dart';

/// Displays the about screen including Edamam attribution
///
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ACCENT_COLOR,
        title: Text('Recipedient'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Recipedient was written by Jens Larsen."),
            Text("Software Development Capstone - C868"),
            Text("WGU Student ID #000656147"),
            Text("July 2019"),
            Container(
              height: 20,
            ),
            Container(
              height: 20,
            ),
            Text("Recipe search provided by"),
            Image.asset('resources/edamam.png'),
          ],
        ),
      ),
    );
  }
}
