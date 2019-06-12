import 'package:flutter/material.dart';
import 'package:recipedient/model/recipe.dart';
import 'package:recipedient/view/recipe_detail.dart';
import 'package:recipedient/widgets/color_palette.dart';

/// Returns a card that displays the [recipe]
///
Widget buildRecipeCard(Recipe recipe, context) {
  // TODO: Fix card text overflow
  const double _IMAGE_SIZE = 100;

  return ListTile(
    title: Text(recipe.label),
    subtitle: Text(recipe.source),
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
