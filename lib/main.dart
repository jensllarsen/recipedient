import 'package:flutter/material.dart';
import 'package:recipedient/view/about.dart';
import 'package:recipedient/view/saved.dart';
import 'package:recipedient/view/search.dart';
import 'package:recipedient/view/shopping.dart';
import 'package:recipedient/widgets/color_palette.dart';

const int _NUM_TABS = 3;

void main() => runApp(MainScreen());

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreenDisplay(),
    );
  }
}

class HomeScreenDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: _NUM_TABS,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.info,
                color: lightPrimaryColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutScreen(),
                  ),
                );
              },
            )
          ],
          backgroundColor: defaultPrimaryColor,
          title: Text('Recipedient'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Search', icon: Icon(Icons.search)),
              Tab(text: 'Saved', icon: Icon(Icons.save)),
              Tab(text: 'Shopping', icon: Icon(Icons.shopping_cart)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SearchScreen(),
            SavedScreen(),
            ShoppingScreen(),
          ],
        ),
      ),
    );
  }
}
