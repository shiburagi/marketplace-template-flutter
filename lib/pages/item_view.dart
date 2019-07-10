import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marketplace/bloc/item_view.dart';
import 'package:marketplace/entities/item.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ItemView extends StatefulWidget {
  @override
  _ItemViewState createState() {
    return _ItemViewState();
  }
}

class _ItemViewState extends State<ItemView> {
  ItemViewBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = ItemViewBloc();
  }

  @override
  Widget build(BuildContext context) {
    Item item = ModalRoute.of(context).settings.arguments;
    bloc.register(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: bloc.screenSize.width,
                      height: 300,
                      color: Colors.grey.shade700,
                      child: Image.network(item.image),
                    ),
                    Divider(
                      height: 1,
                    ),
                    buildBasicInfoCard(item),
                    Container(
                      height: 16,
                    ),
                    buildProductDetail(item),
                     Container(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
          buildBottomBar()
        ],
      ),
    );
  }

  Card buildProductDetail(Item item) {
    return Card(
      margin: EdgeInsets.all(0),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: Column(
            children: <Widget>[
              Text(
                "Description",
                style: bloc.theme.textTheme.subhead
                    .copyWith(color: bloc.theme.hintColor),
              ),
              Divider(
                height: 24,
              ),
              Text(
                item.description ?? "",
                style: bloc.theme.textTheme.caption.copyWith(color: Colors.black),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start),
      ),
    );
  }

  Card buildBasicInfoCard(Item item) {
    return Card(
      margin: EdgeInsets.all(0),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
                children: <Widget>[
                  Text(
                    "RM ${item.priceAfterDiscount.toStringAsFixed(2)}",
                    style: bloc.theme.textTheme.headline.copyWith(
                        color: bloc.primaryColor, fontWeight: FontWeight.bold),
                  ),
                  item.hasDiscount
                      ? Text(
                          "RM ${item.price.toStringAsFixed(2)}",
                          style: bloc.theme.textTheme.subhead.copyWith(
                              color: bloc.theme.disabledColor,
                              decoration: TextDecoration.lineThrough),
                        )
                      : Container(),
                  Container(
                    height: 24,
                  ),
                  Text(
                    item.title,
                    style: bloc.theme.textTheme.subhead.copyWith(),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(6, 0, 4, 16),
            child: FlutterRatingBar(
              initialRating: 0,
              itemCount: 5,
              itemSize: 16,
              onRatingUpdate: (w) {},
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  Card buildBottomBar() {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(0),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(32, 8, 32, 0),
              child: Column(
                children: [
                  Icon(
                    Icons.chat,
                    color: Colors.black54,
                  ),
                  Text(
                    "Chat",
                    style: bloc.theme.textTheme.caption,
                  )
                ],
              ),
            ),
            buildBottomButton("Buy Now", Colors.orange, () {}),
            buildBottomButton("Add to Cart", Colors.deepOrange, () {}),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      ),
    );
  }

  Expanded buildBottomButton(text, color, onPress) {
    return Expanded(
      child: ButtonTheme(
        // height: 32 + bloc.screenPadding.bottom,
        padding: EdgeInsets.fromLTRB(16, 16, 16, bloc.screenPadding.bottom),
        child: FlatButton(
          onPressed: onPress,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0))),
          child: Text(text),
          color: color,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
