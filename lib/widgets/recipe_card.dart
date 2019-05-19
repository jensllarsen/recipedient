import 'package:flutter/material.dart';

import 'package:recipedient/model/recipe.dart';

Widget buildRecipeCard(Recipe recipe) {
  return Card(
    child: Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            recipe.label,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            recipe.url,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    ),
  );
}
