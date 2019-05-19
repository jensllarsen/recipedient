import 'package:flutter/material.dart';

import 'package:recipedient/widgets/recipe_card.dart';
import 'package:recipedient/model/recipe.dart';
import 'package:recipedient/model/dummy_data.dart';

class RecipeList extends StatelessWidget {
  RecipeList() : super();

  final List<Recipe> recipes = getRecipes();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int index) {
          if (index < recipes.length) {
            return buildRecipeCard(recipes[index]);
          }
        },
      ),
    );
  }
}
