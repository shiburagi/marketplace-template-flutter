import 'package:flutter/material.dart';
import 'package:marketplace/bloc/base.dart';
import 'package:marketplace/bloc/home.dart';
import 'package:marketplace/bloc/landing.dart';
import 'package:marketplace/pages/item_view.dart';
import 'package:marketplace/pages/landing.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

Map<String, WidgetBuilder> routes = {
  "/": (context) => LandingPage(),
  "/item/view": (context) => ItemView(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        registerProvider(HomeBloc()),
        registerProvider(LandingBloc()),
      ],
      child: MaterialApp(
        title: 'Marketplace',
        theme: ThemeData(
            primarySwatch: Colors.deepOrange, accentColor: Colors.green),
        routes: routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

/*
 * Method to register bloc, reuseable 
 */
Provider<T> registerProvider<T>(T baseBloc) {
  return Provider<T>(
    builder: (context) => baseBloc,
    dispose: (context, bloc) => (baseBloc as BaseBloc).dispose(),
  );
}
