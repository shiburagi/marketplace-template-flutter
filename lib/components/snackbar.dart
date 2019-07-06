import 'package:flutter/material.dart';

makeSnackbar(
        {@required BuildContext context,
        String text,
        SnackbarType type = SnackbarType.success}) =>
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: snackbarBackgroundColor(context)[type],
    ));

enum SnackbarType {
  success,
  info,
  error,
  warning,
}

Map<SnackbarType, Color> snackbarBackgroundColor(BuildContext context) => {
      SnackbarType.success: Colors.green,
      SnackbarType.info: Theme.of(context).accentColor,
      SnackbarType.error: Theme.of(context).errorColor,
      SnackbarType.warning: Colors.yellow,
    };
