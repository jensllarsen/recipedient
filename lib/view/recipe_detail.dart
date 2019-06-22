import "package:flutter/material.dart";
import 'package:recipedient/controller/database_helper.dart';
import 'package:recipedient/model/recipe.dart';
import 'package:recipedient/widgets/color_palette.dart';
import 'package:recipedient/widgets/dialog_boxes.dart';
import 'package:recipedient/widgets/display_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

/// Display the details of the [recipe] on a new screen
///
class RecipeDetail extends StatelessWidget {
  final Recipe recipe;

  RecipeDetail(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR_DEFAULT,
        title: Text(recipe.label),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      elevation: 20,
                      child: Image.network(recipe.image),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Container(
                    height: 20,
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: recipe.ingredientLines.length,
                        itemBuilder: (context, position) {
                          return ListTile(
                            title: Text("${recipe.ingredientLines[position]}"),
                            trailing: Icon(Icons.shopping_basket),
                            dense: true,
                            onTap: () {
                              addIngredientDialogBox(
                                  context,
                                  'Alert',
                                  'Add ingredient to shopping list?',
                                  recipe.ingredientLines[position]);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: MaterialButton(
                      child: Text(
                        "Open recipe on ${recipe.source}",
                        style: TextStyle(color: PRIMARY_COLOR_TEXT),
                      ),
                      color: ACCENT_COLOR,
                      onPressed: () async {
                        if (await canLaunch(recipe.url)) {
                          await launch(recipe.url);
                        } else {
                          displaySnackBar(
                              context, 'Could not launch $recipe.url');
                        }
                      },
                    ),
                  ),
                  MaterialButton(
                    color: ACCENT_COLOR,
                    onPressed: () async {
                      _saveRecipeToDatabase(recipe);
                      displaySnackBar(context, 'Adding recipe');
                    },
                    child: Text(
                      "Save Recipe",
                      style: TextStyle(color: PRIMARY_COLOR_TEXT),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<int> _saveRecipeToDatabase(Recipe recipe) async {
    DatabaseHelper databaseHelper = new DatabaseHelper();
    int recipeId = await databaseHelper.insertRecipe(recipe);
    return recipeId;
  }
}
