import 'package:flutter/material.dart';
import 'package:recipedient/controller/edamamApi.dart';

import 'package:recipedient/widgets/recipe_card.dart';
import 'package:recipedient/model/recipe.dart';

class RecipeList extends StatelessWidget {
  final String query;

  RecipeList(this.query);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: getMatchingRecipes(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (BuildContext _context, int index) {
                return buildRecipeCard(snapshot.data[index]);
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
