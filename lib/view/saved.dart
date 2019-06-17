import "package:flutter/material.dart";
import 'package:recipedient/controller/database_helper.dart';
import 'package:recipedient/model/recipe.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Recipe>>(
          future: databaseHelper.getRecipesList(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return buildRecipeCard(snapshot.data[index], context);
              },
            );
          },
        ),
      ),
    );
  }
}
