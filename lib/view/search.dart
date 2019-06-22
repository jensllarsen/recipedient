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
  final TextEditingController _searchController = TextEditingController();

  String _query = "";

  @override
  void dispose() {
    _searchController.dispose();
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
                cursorColor: ACCENT_COLOR,
                decoration: InputDecoration(hintText: 'Ingredients'),
                controller: _searchController,
                onSubmitted: (String value) {
                  setState(() {
                    _query = _searchController.text.toString();
                  });
                  return _searchController.text.toString();
                },
              ),
            ),
            RaisedButton(
              color: ACCENT_COLOR,
              child: Text(
                "Search",
                style: TextStyle(color: PRIMARY_COLOR_TEXT),
              ),
              onPressed: () {
                displaySnackBar(
                    context, "Searching: ${_searchController.text.toString()}");
                setState(() {
                  _query = _searchController.text.toString();
                });
              },
            ),
            RecipeList(_query),
          ],
        );
      },
    );
  }
}
