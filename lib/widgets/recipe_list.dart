import 'package:flutter/material.dart';
import 'package:recipedient/controller/edamamApi.dart';
import 'package:recipedient/model/recipe.dart';
import 'package:recipedient/widgets/recipe_card.dart';

class RecipeList extends StatelessWidget {
  final String _query;

  RecipeList(this._query);

  @override
  Widget build(BuildContext context) {
    // if the query is empty don't try to draw a card
    if (_query.isEmpty) {
      return Container();
    }
    return FutureBuilder<List<Recipe>>(
      future: getMatchingRecipes(_query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Flexible(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (BuildContext _context, int index) {
                return buildRecipeCard(snapshot.data[index], context);
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error in FutureBuilder!");
        } else {
          return Container(
            padding: EdgeInsets.all(15),
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
