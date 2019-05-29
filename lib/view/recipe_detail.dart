import "package:flutter/material.dart";
import 'package:recipedient/model/recipe.dart';

/// Display the details of the [recipe] on a new screen
///
class RecipeDetail extends StatelessWidget {
  final Recipe recipe;

  RecipeDetail(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${recipe.label}"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.network(recipe.url),
            Text("${recipe.source}"),
            Text("${recipe.recipeYield}"),
            Text("${recipe.ingredientLines}"),
            Text("${recipe.url}"),
          ],
        ),
      ),
    );
  }
}
