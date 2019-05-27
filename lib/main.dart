import 'package:flutter/material.dart';
import 'package:recipedient/view/about.dart';
import 'package:recipedient/view/saved.dart';

/// Import navigation screens
import 'package:recipedient/view/search.dart';
import 'package:recipedient/view/shopping.dart';

const int _NUM_TABS = 3;

void main() => runApp(MainScreen());

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: _NUM_TABS,
        child: Scaffold(
          backgroundColor: Colors.deepOrange,
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                  // TODO: Fix this about screen navigation
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutScreen(),
                    ),
                  );
                },
              )
            ],
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
