import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MITO',
      theme: ThemeData(
          primarySwatch: Colors.red,
      ),// ThemeData
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to MITO'),
        ),// AppBar
        body: Center(
            child: Column(
                children: <Widget>[
                  Text(
                    'Help those around you if you can',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  RaisedButton(
                    onPressed: null,
                    child: const Text('LOGIN'),
                  ),
                  RaisedButton(
                    onPressed: null,
                    child: const Text('SIGN UP'),
                  ),
                ],
            ),// Column
          ),// Center
      ),// Scaffold
    );// Material App
  }
}
