import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:marketplace/bloc/base.dart';
import 'package:marketplace/entities/item.dart';

class CatalogBloc extends BaseBloc {
  List<Item> items = [];

  StreamController<int> _itemStreamController = StreamController<int>();

  Stream itemStream;
  Random random = Random();

  CatalogBloc() {
    itemStream = _itemStreamController.stream.asBroadcastStream();
    items.addAll(List.generate(12, (i) {
      return createItem(i);
    }));
  }

  createItem(i) {
    return Item(
      title: "Item ${i+1}",
      price: random.nextDouble() * 15000,
      discount: random.nextBool() ? random.nextDouble() * 70 : 0,
    );
  }

  @override
  void dispose() {
    _itemStreamController.close();
  }

  @override
  void register(BuildContext context) {
    super.register(context);
  }

  void loadMore() {
    items.addAll(List.generate(6, (i) => createItem(i + items.length)));
    _itemStreamController.add(items.length);
  }
}
