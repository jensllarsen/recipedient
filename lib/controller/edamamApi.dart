import 'package:http/http.dart' as http;
import 'package:recipedient/controller/secrets.dart';
import 'package:recipedient/model/recipe.dart';

/// Queries the Edamam API with [query] and returns a List of Recipe objects
///
Future<List<Recipe>> getMatchingRecipes(String query) async {
  final String edamamEndpoint = "https://api.edamam.com/search";

  http.Response response;

  if (query.isEmpty) {
    return createEmptyRecipeList();
  }

  // Otherwise get the query
  String request = '$edamamEndpoint?q=$query&app_id=$APP_ID&app_key=$APP_KEY';
  try {
    response = await http.get(request);
    // check the status code
    if (response.statusCode == 200) {
      return getRecipesFromJson(response.body);
    } else {
      throw Exception(
          "Falied to retrive recipes! Status: ${response.statusCode}");
    }
  } on Exception catch (e) {
    print("Exception trying to query recipes: ${e.toString()}");
    return createEmptyRecipeList();
  }
}
