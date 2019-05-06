import 'dart:async';
import 'recipeapiprovider.dart';
import 'package:recipedient/model/recipe.dart';

class Repository {
  final recipeApiProvider = RecipeApiProvider();

  Future<Recipe> fetchMatchingRecipes() =>
      recipeApiProvider.fetchMatchingRecipes();
}
