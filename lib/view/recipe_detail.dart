import "package:flutter/material.dart";
import 'package:recipedient/model/recipe.dart';

/// Display the details of the [recipe] on a new screen
///
class RecipeDetail extends StatelessWidget {
  final Recipe recipe;

  RecipeDetail(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("${recipe.label}"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 20,
                child: Image.network(recipe.image),
              ),
              Container(
                height: 20,
              ),
              Text(
                "${recipe.source}",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              Container(
                height: 20,
              ),
              Text("${recipe.ingredientLines}"),
              Text("${recipe.url}"),
              MaterialButton(
                color: Colors.green,
                onPressed: () {},
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
