// To parse this JSON data, do
//
//     final recipe = recipeFromJson(jsonString);

import 'dart:convert';

import 'ingredient.dart';

Recipe recipeFromJson(String str) => Recipe.fromMap(json.decode(str));

String recipeToJson(Recipe data) => json.encode(data.toMap());

class Recipe {
  RecipeClass recipe;

  Recipe({
    this.recipe,
  });

  factory Recipe.fromMap(Map<String, dynamic> json) => new Recipe(
        recipe: RecipeClass.fromMap(json["recipe"]),
      );

  Map<String, dynamic> toMap() => {
        "recipe": recipe.toMap(),
      };
}

class RecipeClass {
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
  List<Ingredient> ingredients;

  RecipeClass({
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
    this.ingredients,
  });

  factory RecipeClass.fromMap(Map<String, dynamic> json) => new RecipeClass(
        uri: json["uri"],
        label: json["label"],
        image: json["image"],
        source: json["source"],
        url: json["url"],
        shareAs: json["shareAs"],
        recipeYield: json["yield"],
        dietLabels: new List<String>.from(json["dietLabels"].map((x) => x)),
        healthLabels: new List<String>.from(json["healthLabels"].map((x) => x)),
        cautions: new List<dynamic>.from(json["cautions"].map((x) => x)),
        ingredientLines:
            new List<String>.from(json["ingredientLines"].map((x) => x)),
        ingredients: new List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "uri": uri,
        "label": label,
        "image": image,
        "source": source,
        "url": url,
        "shareAs": shareAs,
        "yield": recipeYield,
        "dietLabels": new List<dynamic>.from(dietLabels.map((x) => x)),
        "healthLabels": new List<dynamic>.from(healthLabels.map((x) => x)),
        "cautions": new List<dynamic>.from(cautions.map((x) => x)),
        "ingredientLines":
            new List<dynamic>.from(ingredientLines.map((x) => x)),
        "ingredients":
            new List<dynamic>.from(ingredients.map((x) => x.toMap())),
      };
}