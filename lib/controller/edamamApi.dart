import 'package:http/http.dart' as http;

import 'package:recipedient/controller/secrets.dart';
import 'package:recipedient/model/recipe.dart';

final String endpoint = "https://api.edamam.com/search";
final String request = '$endpoint?q=chickn&app_id=$app_id&app_key=$app_key';


Future<List<Recipe>> getMatchingRecipes() async {
  final response = await http.get(request);
  return getRecipesFromJson(response.body);
}

