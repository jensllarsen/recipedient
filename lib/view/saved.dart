import "package:flutter/material.dart";
import 'package:recipedient/controller/database_helper.dart';
import 'package:recipedient/model/recipe.dart';
import 'package:recipedient/widgets/color_palette.dart';
import 'package:recipedient/widgets/recipe_card.dart';

class SavedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SavedScreenState();
  }
}

class _SavedScreenState extends State<SavedScreen> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

  List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Recipe>>(
        future: databaseHelper.getRecipesList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return buildRecipeCard(snapshot.data[index], context);
            },
          );
        },
      ),
    );
  }
}
