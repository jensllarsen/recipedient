import 'package:flutter/material.dart';
import 'package:recipedient/widgets/color_palette.dart';

void displaySnackBar(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(
    backgroundColor: PRIMARY_COLOR_DARK,
    duration: Duration(seconds: 3),
    content: Text(message),
  );
  Scaffold.of(context).showSnackBar(snackBar);
}
