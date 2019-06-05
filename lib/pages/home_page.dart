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
        title: Text('Welcome to MITO'),
      ),
      body: Text('Hello User'),
      );
  }

}
