import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'recipe.g.dart';

/// Plain class to store Recipe data.
///
/// Utilizes json_serializable to create to and from JSON methods in
/// recipe.g.dart.
///
@JsonSerializable()
class Recipe {
  String uri;
  String label;
  String image;
  String source;
  String url;
  String shareAs;
  double recipeYield;
  List<String> dietLabels;
  List<String> healthLabels;
  List<String> cautions;
  List<String> ingredientLines;

  Recipe(
    this.uri,
    this.label,
    this.image,
    this.source,
    this.url,
    this.shareAs,
    this.recipeYield,
    this.dietLabels,
    this.healthLabels,
    this.cautions,
    this.ingredientLines,
  );

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}

/// Converts a JSON string, [jsonString], returned from the Edamam API to a
/// list of Recipe objects.
///
List<Recipe> getRecipesFromJson(String jsonString) {
  var resultsMap = jsonDecode(jsonString);
  List<Recipe> recipes = new List<Recipe>();

  // Pull out the interesting data from the response contained in the hits list
  var recipeMap = resultsMap['hits'];

  // Loop through all the recipes, convert to objects, and add them to the list
  for (var hit in recipeMap) {
    var recipe = hit['recipe'];
    Recipe tempRecipe = _$RecipeFromJson(recipe);
    recipes.add(tempRecipe);
  }
  return recipes;
}

/// Return a [List<Recipe>] with one empty recipe
///
/// Used to handle empty queries and errors.
/// There's probably a better way handle these cases??
///
List<Recipe> createEmptyRecipeList() {
  var recipes = new List<Recipe>();
  recipes.add(
    new Recipe(
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      List<String>(),
      List(),
      List(),
      List(),
    ),
  );
  return recipes;
}
