import "package:flutter/material.dart";
import 'package:recipedient/controller/database_helper.dart';

class ShoppingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShoppingScreenState();
  }
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

  List<String> shopping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<String>>(
          future: databaseHelper.getShoppingList(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
