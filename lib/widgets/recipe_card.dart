import 'package:flutter/material.dart';
import 'package:recipedient/model/recipe.dart';

/// Returns a card that displays the [recipe]
///
Widget buildRecipeCard(Recipe recipe) {
  // TODO: Fix card text overflow
  const double _IMAGE_SIZE = 100;

  return InkWell(
    onTap: () {},
    child: Card(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image(
              image: NetworkImage(recipe.image),
              height: _IMAGE_SIZE,
            ),
            Flexible(
              child: Text(
                recipe.label,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Flexible(
              child: Text(
                recipe.source,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            // TODO: Remove or keep ingredients on the search screen?
            // _buildIngredientLines(recipe.ingredientLines),
          ],
        ),
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
        // TODO: Use something else besides chips - they don't look great
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
