// API key is stored in two variables in secrets.dart:
//
// final String app_id
// final String app_key
//
// See https://developer.edamam.com/edamam-docs-recipe-api for more info

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:recipedient/model/recipe.dart';

import 'secrets.dart'; // API keys stored here

class RecipeApiProvider {
  Client client = Client();
  final String _endpoint = "https://api.edamam.com/search";
  final String _query = "chicken";

  Future<Recipe> fetchMatchingRecipes() async {
    final response = await client
        .get("$_endpoint?q=$_query&app_id=$app_id&app_key=$app_key");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return Recipe.fromMap(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception(
          'Failed to load recipes in RecipeApiProvider: $response.statusCode');
    }
  }
}
