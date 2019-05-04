import 'package:flutter/material.dart';

import 'package:recipedient/search.dart';
import 'package:recipedient/saved.dart';
import 'package:recipedient/shopping.dart';

void main() => runApp(MainScreen());

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  title: Text('recipedent'),
                  bottom: TabBar(
                    tabs: [
                      Tab(text: 'Search', icon: Icon(Icons.search)),
                      Tab(text: 'Saved', icon: Icon(Icons.save)),
                      Tab(text: 'Shopping', icon: Icon(Icons.shopping_cart)),
                    ],
                  ),
                ),
                body: TabBarView(children: [
                  SearchScreen(),
                  SavedScreen(),
                  ShoppingScreen(),
                ]))));
  }
}
