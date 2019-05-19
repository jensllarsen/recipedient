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
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
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
  List<Widget> chips = [];

  for (var index = 0; index < ingredients.length; index++) {
    var chip = Flexible(
      child: Container(
        padding: EdgeInsets.only(right: 1),
        child: Chip(
          label: Text(ingredients[index]),
          backgroundColor: Colors.blue[600],
          labelStyle: TextStyle(
            fontSize: 10,
          ),
        ),
      ),
    );
    chips.add(chip);
  }
  return Row(
    children: chips,
  );
}
