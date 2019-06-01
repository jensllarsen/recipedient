import "package:flutter/material.dart";
import 'package:recipedient/model/recipe.dart';
import 'package:recipedient/widgets/color_palette.dart';
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
        backgroundColor: defaultPrimaryColor,
        title: Text(recipe.label),
      ),
      body: Center(
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
                child: ListView.builder(
                  itemCount: recipe.ingredientLines.length,
                  itemBuilder: (context, position) {
                    return Text("• ${recipe.ingredientLines[position]}");
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: MaterialButton(
                  child: Text("Open recipe on ${recipe.source}"),
                  color: accentColor,
                  onPressed: () async {
                    if (await canLaunch(recipe.url)) {
                      await launch(recipe.url);
                    } else {
                      throw 'Could not launch $recipe.url';
                    }
                  },
                ),
              ),
              MaterialButton(
                color: accentColor,
                onPressed: () {},
                child: Text("Save Recipe"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
