import 'package:flutter/material.dart';

import 'package:recipedient/model/recipe.dart';

/// Returns a card that displays the [recipe]
/// 
Widget buildRecipeCard(Recipe recipe) {
  return Card(
    child: Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            recipe.label,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            recipe.source,
            style: TextStyle(fontSize: 18),
          ),
          _buildIngredientLines(recipe.ingredientLines),
        ],
      ),
    ),
  );
}

/// Builds a list of chips to display ingredients
///
Widget _buildIngredientLines(List<String> ingredients) {
  // TODO: Fix overflow or redesign this?
  List<Widget> chips = [];
  print("Ingredients: ${ingredients}");

  for (var index = 0; index < ingredients.length; index++) {
    var chip = Container(
      padding: EdgeInsets.only(right: 10),
      child: Chip(
        label: Text(ingredients[index]),
        backgroundColor: Colors.lightBlue,
      ),
    );
    chips.add(chip);
  }
  return Row(
    children: chips,
  );
}
