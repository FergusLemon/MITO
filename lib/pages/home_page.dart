import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override

  const HomePage({Key key}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
              icon: Icon(choices[0].icon),
              onPressed: () => {},
          ),
          IconButton(
              icon: Icon(choices[1].icon),
              onPressed: () => {},
          ),
          PopupMenuButton<Choice>(
              //onSelected: () => {},
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                      value: choice,
                      child: Text(choice.title),
                  );
                }).toList();
              }
          ),
        ],
      ),
      body: Text('Hello User'),
      );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Profile', icon: Icons.account_circle),
  const Choice(title: 'Map', icon: Icons.map),
  const Choice(title: 'Sign Out', icon: Icons.exit_to_app),
];
