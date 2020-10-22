import 'package:ee_calcy/table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'table.dart';

// text style
var appStyle =
    TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400);
var titleStyle =
    TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400);
var descStyle =
    TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w300);

class home extends StatelessWidget {
  static const String id = 'home.dart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            showSearch(context: context, delegate: calcSearch());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Search Calculator',
                style: appStyle,
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 83,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //  Spacer(flex: 1),
                Image.asset(
                  'images/diag/${cards[index]}-min.png',
                  width: 130,
                ),
                //  Spacer(flex: 1),
                Container(
                    margin: EdgeInsets.all(8),
                    width: 150,
                    child: RichText(
                        text: TextSpan(style: titleStyle, children: [
                      TextSpan(text: cards[index], style: titleStyle),
                      TextSpan(text:  cards[index], style: descStyle),
                    ]))),
              ],
            ),
          );
        },
      ),
    );
  }
}

class calcSearch extends SearchDelegate<String> {

  final recentSearch = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //  leading icon on left
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.arrow_menu,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show selected search
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // suggestions for the search
    final suggestionList = query.isEmpty
        ? recentSearch
        : cards.values.where((p) => p.contains(query.toLowerCase())).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //  Spacer(flex: 1),
                Image.asset(
                  'images/diag/${cards}-min.png',
                  width: 130,
                ),
                //  Spacer(flex: 1),
                Container(
                    margin: EdgeInsets.all(8),
                    width: 150,
                    child: RichText(
                        text: TextSpan(style: titleStyle, children: [
                      TextSpan(text: cards[index], style: titleStyle),
                      TextSpan(text: suggestionList[index], style: descStyle),
                    ]))),
              ],
            ),
          );
        });
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(primaryColor: Colors.deepOrangeAccent);
  }

}

