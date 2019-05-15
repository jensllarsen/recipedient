import 'package:http/http.dart' as http;

import 'package:recipedient/controller/secrets.dart';
import 'package:recipedient/model/recipe.dart';

final String endpoint = "https://api.edamam.com/search";

Future<List<Recipe>> getMatchingRecipes(String query) async {
  final String request = '$endpoint?q=$query&app_id=$app_id&app_key=$app_key';
  final response = await http.get(request);
  return getRecipesFromJson(response.body);
}