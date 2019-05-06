import 'package:rxdart/rxdart.dart';

import 'package:recipedient/controller/reciperepository.dart';
import 'package:recipedient/model/recipe.dart';

class RecipesBloc {
  final _repository = RecipeRepository();
  final _recipesFetcher = PublishSubject<Recipe>();

  Observable<Recipe> get matchingRecipes => _recipesFetcher.stream;

  fetchMatchingRecipes() async {
    Recipe recipe = await _repository.fetchMatchingRecipes();
    _recipesFetcher.sink.add(recipe);
  }

  dispose() {
    _recipesFetcher.close();
  }
}

final bloc = RecipesBloc();
