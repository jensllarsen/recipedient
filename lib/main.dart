import 'package:flutter/material.dart';
import 'package:recipedient/view/saved.dart';

/// Import navigation screens
import 'package:recipedient/view/search.dart';
import 'package:recipedient/view/shopping.dart';

const int _NUM_TABS = 3;

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
        length: _NUM_TABS,
        child: Scaffold(
          backgroundColor: Colors.deepOrange,
          appBar: AppBar(
            backgroundColor: Colors.green[600],
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
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
