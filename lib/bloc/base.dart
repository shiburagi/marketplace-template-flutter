import 'package:flutter/material.dart';

abstract class BaseBloc {
  BuildContext _context;
  BuildContext get context => _context;

  ThemeData get theme => Theme.of(context);

  Color get primaryColor => Theme.of(context).primaryColor;
  Color get accentColor => Theme.of(context).accentColor;
  
  Size get screenSize => MediaQuery.of(context).size;
  EdgeInsets get screenPadding => MediaQuery.of(context).padding;

  void register(BuildContext context) {
    this._context = context;
  }

  void dispose();
}
