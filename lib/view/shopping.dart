import "package:flutter/material.dart";
import 'package:recipedient/controller/database_helper.dart';
import 'package:recipedient/model/ingredient.dart';
import 'package:recipedient/widgets/color_palette.dart';
import 'package:recipedient/widgets/dialog_box.dart';
import 'package:share/share.dart';

class ShoppingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShoppingScreenState();
  }
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Ingredient>>(
          future: databaseHelper.getShoppingList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: <Widget>[
                  RaisedButton(
                    color: accentColor,
                    child: Text(
                      'Share shopping list',
                      style: TextStyle(color: textPrimaryColor),
                    ),
                    onPressed: () async {
                      String shoppingList =
                          await databaseHelper.getShoppingListAsStrings();
                      Share.share(shoppingList);
                    },
                  ),
                  Flexible(
                    // TODO: fix list not updating when item is deleted
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        padding: EdgeInsets.all(16),
                        itemBuilder: (BuildContext _context, int index) {
                          return ListTile(
                            trailing: Icon(Icons.delete),
                            onTap: () {
                              removeFromShoppingListDialogBox(
                                  context, snapshot.data[index].id);
                            },
                            title: Text(snapshot.data[index].item),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("Error in FutureBuilder!");
            } else {
              return Container(
                padding: EdgeInsets.all(15),
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
