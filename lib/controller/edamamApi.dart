import 'package:http/http.dart' as http;

// Import Edamam API keys
import 'package:recipedient/controller/secrets.dart';

import 'package:recipedient/model/recipe.dart';

final String endpoint = "https://api.edamam.com/search";

// Queries the Edamam API with [query] and returns a List of Recipe objects
//
// Currently no error checking
Future<List<Recipe>> getMatchingRecipes(String query) async {
  // TODO: Add data validation and error checking
  final String request = '$endpoint?q=$query&app_id=$app_id&app_key=$app_key';
  try {
    final response = await http.get(request);
    return getRecipesFromJson(response.body);
  } catch (e) {
    print("Error: " + e.toString());
  }
}
