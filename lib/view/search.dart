import 'package:flutter/material.dart';
import 'package:recipedient/widgets/color_palette.dart';
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
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            cursorColor: accentColor,
            decoration: InputDecoration(hintText: 'Ingredients'),
            controller: searchController,
          ),
        ),
        RaisedButton(
          color: accentColor,
          child: Text(
            "Search",
            style: TextStyle(color: textPrimaryColor),
          ),
          onPressed: () {
            print("Search: ${searchController.text.toString()}");
            setState(() {});
          },
        ),
        RecipeList(searchController.text.toString()),
      ],
    );
  }
}
