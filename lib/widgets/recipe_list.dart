import 'package:flutter/material.dart';
import 'package:recipedient/controller/edamamApi.dart';
import 'package:recipedient/model/recipe.dart';
import 'package:recipedient/widgets/recipe_card.dart';

class RecipeList extends StatelessWidget {
  final String query;

  RecipeList(this.query);

  @override
  Widget build(BuildContext context) {
    // if the query is empty don't try to draw a card
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder<List<Recipe>>(
      future: getMatchingRecipes(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Flexible(
            child: GridView.builder(
              itemCount: snapshot.data.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (BuildContext _context, int index) {
                return buildRecipeCard(snapshot.data[index]);
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
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
