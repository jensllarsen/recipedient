import 'package:flutter/material.dart';
import 'package:recipedient/model/recipe.dart';
import 'package:recipedient/view/recipe_detail.dart';

/// Returns a card that displays the [recipe]
///
Widget buildRecipeCard(Recipe recipe, BuildContext context) {
  return ListTile(
    title: Text(recipe.label),
    subtitle: Text(recipe.source),
    trailing: Icon(Icons.keyboard_arrow_right),
    leading: CircleAvatar(
      backgroundImage: NetworkImage(recipe.image),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeDetail(recipe),
        ),
      );
    },
  );
}
