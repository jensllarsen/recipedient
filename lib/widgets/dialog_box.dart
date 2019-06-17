import 'package:flutter/material.dart';
import 'package:recipedient/controller/database_helper.dart';
import 'color_palette.dart';

void closeDialogBox(BuildContext context, String title, String body) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          FlatButton(
            child: Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void addIngredientDialogBox(
    BuildContext context, String title, String body, String ingredientString) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: textPrimaryColor,
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          FlatButton(
            child: Text("Yes"),
            onPressed: () async {
              DatabaseHelper databaseHelper = new DatabaseHelper();
              int ingredientId =
                  await databaseHelper.insertIngredientString(ingredientString);
              databaseHelper.addIngredientToShoppingList(ingredientId);
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void removeFromShoppingListDialogBox(BuildContext context, int ingredientId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: textPrimaryColor,
        title: Text('Alert'),
        content: Text('Remove from shopping list?'),
        actions: <Widget>[
          FlatButton(
            child: Text("Yes"),
            onPressed: () async {
              // TODO: remove ingredient from the shopping list
              DatabaseHelper databaseHelper = new DatabaseHelper();
              databaseHelper.removeIngredientToShoppingList(ingredientId);
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
