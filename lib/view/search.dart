import 'package:flutter/material.dart';

import 'package:recipedient/model/recipe.dart';
import 'package:recipedient/controller/edamamApi.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(hintText: 'Ingredents'),
              controller: searchController,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      getMatchingRecipes(searchController.text);
                      print("Search ${searchController.text}!");
                    },
                    child: Text('Search'),
                  ),
                ),
                FutureBuilder<List<Recipe>>(
                  future: getMatchingRecipes(searchController.text),
                  builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        return CircularProgressIndicator();
                      case ConnectionState.done:
                        if(snapshot.hasError){
                          print("Error in FutureBuilder: ${snapshot.error}");
                          return Text("Error: ${snapshot.error}");
                        }
                        return Text(
                            'Title from Recipe JSON : ${snapshot.data[0].label}');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
