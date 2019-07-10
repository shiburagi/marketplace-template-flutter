import 'package:flutter/material.dart';
import 'package:marketplace/bloc/landing.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  LandingPage({
    Key key,
  }) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  LandingBloc get bloc => Provider.of<LandingBloc>(context);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: bloc.pageStream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                margin: EdgeInsets.only(left: 8, right: 48, top: 4),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).padding.top,
                    ),
                    buildSearchField(),
                  ],
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: bloc.onViewChart,
                )
              ],
            ),
            body: Builder(
              builder: (context) {
                bloc.register(context);
                return bloc.getPage();
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 8,
              currentIndex: snapshot.data ?? 0,
              type: BottomNavigationBarType.fixed,
              onTap: bloc.setPage,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), title: Text("Home")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat), title: Text("Message")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), title: Text("Cart")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), title: Text("Profile")),
              ],
            ),
          );
        });
  }

  TextFormField buildSearchField() {
    OutlineInputBorder border =
        OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent));
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(16, 12, 16, 12),
        filled: true,
        fillColor: Colors.white,
        hintText: "IPhone X",
        border: border,
        focusedBorder: border,
        enabledBorder: border,
        disabledBorder: border,
      ),
    );
  }
}
