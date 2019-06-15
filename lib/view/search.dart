import 'package:flutter/material.dart';
import 'package:recipedient/widgets/color_palette.dart';
import 'package:recipedient/widgets/display_snack_bar.dart';
import 'package:recipedient/widgets/recipe_list.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  String query = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                cursorColor: accentColor,
                decoration: InputDecoration(hintText: 'Ingredients'),
                controller: searchController,
                onSubmitted: (String value) {
                  setState(() {
                    query = searchController.text.toString();
                  });
                  return searchController.text.toString();
                },
              ),
            ),
            RaisedButton(
              color: accentColor,
              child: Text(
                "Search",
                style: TextStyle(color: textPrimaryColor),
              ),
              onPressed: () {
                displaySnackBar(
                    context, "Searching: ${searchController.text.toString()}");
                setState(() {
                  query = searchController.text.toString();
                });
              },
            ),
            RecipeList(query),
          ],
        );
      },
    );
  }
}
