import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe {
  String uri;
  String label;
  String image;
  String source;
  String url;
  String shareAs;
  int recipeYield;
  List<String> dietLabels;
  List<String> healthLabels;
  List<dynamic> cautions;
  List<String> ingredientLines;
  List<dynamic> ingredients;

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
      this.ingredients);

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}

List<Recipe> getRecipesFromJson(String jsonString) {
  var resultsMap = jsonDecode(jsonString);
  var recipeMap = resultsMap['hits'];
  List<Recipe> recipes = new List<Recipe>();

  for (var hit in recipeMap) {
    var recipe = hit['recipe'];
    print(recipe);
    Recipe tempRecipe = _$RecipeFromJson(recipe);
    print(tempRecipe.label);
    recipes.add(tempRecipe);
  }
  return recipes;
}
