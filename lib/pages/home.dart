import 'package:flutter/material.dart';
import 'package:marketplace/bloc/home.dart';
import 'package:marketplace/entities/item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  HomeBloc get bloc => Provider.of<HomeBloc>(context);

  ScrollController controller = ScrollController();

  @override
  void initState() {
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent)
        bloc.loadMore();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc.register(context);
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            buildSection("Discover"),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  Container buildSection(String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: bloc.theme.textTheme.subhead
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.transparent,
            height: 8,
          ),
          buildListing()
        ],
      ),
    );
  }

  Widget buildListing() {
    return StreamBuilder(
        stream: bloc.itemStream,
        builder: (context, snapshot) {
          return Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    children: List.generate((bloc.items.length / 2).ceil(),
                        (i) => buildItemCard(i * 2)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: List.generate((bloc.items.length / 2).floor(),
                        (i) => buildItemCard(i * 2 + 1)),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget buildItemCard(i) {
    Item item = bloc.items[i];
    return InkWell(
      onTap: ()=>bloc.view(item),
      child: Card(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 120,
                decoration: BoxDecoration(color: Colors.white),
                child: Image.network(item.image),
                alignment: Alignment.center,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item.title),
                      Container(
                        height: 12,
                      ),
                      Text(
                        "RM ${(item.price * (1.0 - (item.discount / 100))).toStringAsFixed(2)}",
                        style: bloc.theme.textTheme.subtitle
                            .copyWith(color: bloc.primaryColor),
                      ),
                      item.hasDiscount
                          ? Text("RM ${item.price.toStringAsFixed(2)}",
                              style: bloc.theme.textTheme.caption.copyWith(
                                  decoration: TextDecoration.lineThrough))
                          : Container()
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
