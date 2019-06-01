import "package:flutter/material.dart";
import 'package:recipedient/widgets/color_palette.dart';

class SavedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SavedScreenState();
  }
}

class _SavedScreenState extends State<SavedScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int item) {
        return Card(
          color: Colors.white,
          elevation: 2,
          child: ListTile(
            onTap: () {
              debugPrint('List Item clicked!');
            },
            title: Text(
              'Dummy title',
              style: titleStyle,
            ),
            subtitle: Text('Dummy data'),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset('resources/bg.png'),
            ),
            trailing: Icon(
              Icons.delete,
              color: accentColor,
            ),
          ),
        );
      },
    );
  }
}
