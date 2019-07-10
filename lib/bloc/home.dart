import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:marketplace/bloc/base.dart';
import 'package:marketplace/entities/item.dart';

class HomeBloc extends BaseBloc {
  List<Item> items = [];

  StreamController<int> _itemStreamController = StreamController<int>();

  Stream itemStream;
  Random random = Random();

  HomeBloc() {
    itemStream = _itemStreamController.stream.asBroadcastStream();
    items.addAll(List.generate(12, (i) {
      return createItem(i);
    }));
  }

  createItem(i) {
    return Item(
        title: "Item ${i + 1}",
        price: random.nextDouble() * 15000,
        discount: random.nextBool() ? random.nextDouble() * 70 : 0,
        image:
            "https://d3dqioy2sca31t.cloudfront.net/Projects/store/production/products/1173/product/bv-civo91455c4cd67667bd15f960304f4f891b.jpg",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ac dapibus lacus. Aenean rutrum dictum efficitur. Phasellus pharetra, nibh eu pellentesque lacinia, dolor purus volutpat risus, sit amet congue turpis nunc at lorem. Maecenas quis justo risus. Nulla fringilla, lectus mattis elementum tempus, orci tellus pretium nibh, nec ultricies odio lectus sit amet quam. Sed consectetur, lacus eu euismod rhoncus, elit felis malesuada nibh, semper congue massa diam et purus. Morbi lacinia risus eu dapibus congue. Etiam viverra, turpis ac imperdiet gravida, massa urna sollicitudin felis, quis aliquet lorem libero at sem. Maecenas ultricies sagittis mauris, eget cursus risus suscipit elementum.\n\n" +
            "Suspendisse potenti. Etiam lobortis turpis bibendum mauris aliquet, vel porta nisi sollicitudin. Duis sit amet suscipit felis, ut luctus ipsum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Ut interdum eu nunc at lacinia. Aenean tincidunt magna tortor, sit amet porta ligula tristique eget. Etiam in tempor purus.\n\n" +
            "Cras volutpat sapien non maximus fermentum. Aenean maximus lacus non augue euismod, a blandit lorem consequat. Nulla laoreet efficitur efficitur. Praesent eget ipsum sed tellus rhoncus rhoncus. Morbi vel mattis sapien. Cras quis tellus tristique, ultricies ligula at, facilisis justo. In placerat scelerisque ornare. Mauris enim purus, lobortis in gravida eget, tristique sed ante. Phasellus consequat vitae urna in pharetra. Nullam laoreet tellus at orci dignissim rhoncus. Vivamus aliquam felis eget blandit imperdiet.\n\n" +
            "Sed dui mi, tempus eu scelerisque pharetra, efficitur ut purus. Etiam tristique arcu in libero pulvinar, bibendum sollicitudin massa pulvinar. Donec in fermentum odio, eu tincidunt tortor. Donec eget pretium risus. Cras at est in turpis volutpat elementum nec ut ipsum. Pellentesque tristique, est non dapibus convallis, est mi rhoncus mauris, ac scelerisque lorem ipsum sit amet erat. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.\n\n" +
            "Suspendisse vitae dui id purus eleifend convallis. Nulla sit amet nibh porta, mollis purus et, auctor lacus. Quisque vel turpis eu metus aliquet rutrum. Proin id aliquet turpis, varius porta ligula. Proin rutrum tortor ut elementum volutpat. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam consectetur quis dolor in volutpat. Aenean eget lacinia nunc. Nulla aliquam massa eget odio tempus, nec lacinia ipsum volutpat. Morbi at rhoncus augue, sit amet tincidunt dui. Curabitur fermentum eget risus non euismod. Nulla in condimentum mi, id fringilla est. Aliquam id mi massa. Nam vitae neque pellentesque, pretium velit ac, laoreet nulla. Suspendisse quis feugiat libero.\n\n");
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

  view(Item item) {
    Navigator.of(context).pushNamed("/item/view", arguments: item);
  }
}
