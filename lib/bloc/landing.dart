import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marketplace/bloc/base.dart';
import 'package:marketplace/components/snackbar.dart';
import 'package:marketplace/pages/home.dart';
class LandingBloc extends BaseBloc {
  int _page = 0;
  int get page => _page;

  StreamController<int> _pageStreamController = StreamController<int>();

  Stream pageStream;

  LandingBloc(){
    pageStream = _pageStreamController.stream.asBroadcastStream();
  }

  @override
  void dispose() {
    _pageStreamController.close();
  }

  @override
  void register(BuildContext context) {
    super.register(context);
  }

  void onViewChart() {
    makeSnackbar(context: context, text: "View Chart", type: SnackbarType.info);
  }

  void setPage(int value) {
    _page = value;

    _pageStreamController.sink.add(value);
  }

  Widget getPage(){
    switch(_page){
      case 0:
        return HomePage();
      default:
        return Center(
          child: Text("Page $_page"),
        );
    }
  }
}
