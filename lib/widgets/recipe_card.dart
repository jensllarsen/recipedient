import 'package:flutter/material.dart';
import 'package:recipedient/model/recipe.dart';
import 'package:recipedient/view/recipe_detail.dart';
import 'package:recipedient/widgets/color_palette.dart';

/// Returns a card that displays the [recipe]
///
Widget buildRecipeCard(Recipe recipe, context) {
  // TODO: Fix card text overflow
  const double _IMAGE_SIZE = 100;

  return Container(
    height: 400,
    child: Card(
      elevation: 3,
      child: InkWell(
        splashColor: accentColor,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetail(recipe),
            ),
          );
        },
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
                    color: primaryTextColor,
                    fontSize: 16,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  recipe.source,
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
