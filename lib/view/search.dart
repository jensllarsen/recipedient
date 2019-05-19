import 'package:flutter/material.dart';

import 'package:recipedient/widgets/recipe_list.dart';

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
          RaisedButton(
            child: Text("Search"),
            onPressed: (){},
          ),
          RecipeList(),
        ],
      ),
    );
  }
}
