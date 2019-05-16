import 'package:http/http.dart' as http;

// Import Edamam API keys
import 'package:recipedient/controller/secrets.dart';

import 'package:recipedient/model/recipe.dart';

final String endpoint = "https://api.edamam.com/search";

// Queries the Edamam API with [query] and returns a List of Recipe objects
//
Future<List<Recipe>> getMatchingRecipes(String query) async {
  http.Response response;

  if (query.isEmpty) {
    return createEmptyRecipeList();
  }

  // Otherwise get the query and convert to Recipes.
  String request = '$endpoint?q=$query&app_id=$app_id&app_key=$app_key';
  try {
    response = await http.get(request);
  } on Exception catch (e) {
    print("Exception trying to query recipes: ${e.toString()}");
    return createEmptyRecipeList();
  }
  return getRecipesFromJson(response.body);
}