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
                  RaisedButton(
                    onPressed: null,
                    child: const Text('Sign In'),
                  ),
                  RaisedButton(
                    onPressed: null,
                    child: const Text('Sign In With Google'),
                  ),
                  RaisedButton(
                    onPressed: null,
                    child: const Text('Sign Up'),
                  ),
                ]
            ),// Row
          ),// Center
      ),// Scaffold
    );// Material App
  }
}
