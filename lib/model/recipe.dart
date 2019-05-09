import 'dart:convert';

import 'package:recipedient/model/ingredient.dart';

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
  List<Ingredient> ingredients;

  Recipe(this.uri,
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
      this.ingredients,);


  Recipe.fromJson(Map<String, dynamic> json)
      :
        uri=json['url'],
        label=json['label'],
        image=json['image'],
        source=json['source'],
        url=json['url'],
        shareAs=json['shareAs'],
        recipeYield=json['recipeYield'],
        dietLabels=json['dietLabels'],
        healthLabels=json['healthLabels'],
        cautions=json['cautions'],
        ingredientLines=json['ingredientsLines'],
        ingredients=json['ingredients'];


  Map<String, dynamic> toJson() =>
      {
        'uri': uri,
        'label': label,
        'image': image,
        'source': source,
        'url': url,
        'shareAs': shareAs,
        'recipeYield': recipeYield,
        'dietLabels': dietLabels,
        'healthLabels': healthLabels,
        'cautions': cautions,
        'ingredientsLines': ingredientLines,
        'ingredients': ingredients,
      };
}

Recipe recipeFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return Recipe.fromJson(jsonData);
}

String recipeToJson(Recipe recipe) {
  final data = recipe.toJson();
  return json.encode(data);
}

List<Recipe> getRecipesFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return new List<Recipe>.from(jsonData.map((x) => Recipe.fromJson(x)));
}

String getJsonFromRecipes(List<Recipe> recipes) {
  final data = new List<dynamic>.from(recipes.map((x) => x.toJson()));
  return json.encode(data);
}