import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MITO',
      theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Colors.orangeAccent[400],
          brightness: Brightness.dark,
      ),// ThemeData
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to MITO'),
        ),// AppBar
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 200.0),
                        child: Text(
                          'Help Those Around You',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36.0,
                          ),
                        ),
                      ),
                  ),
                  ButtonTheme(
                      minWidth: 200.0,
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                            'LOGIN',
                            style: TextStyle(
                                fontSize: 18.0,
                            ),
                          ),
                        color: Colors.red,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius:
                            BorderRadius.circular(30.0)),
                      ),
                    ),
                  SizedBox(height: 5.0),
                  ButtonTheme(
                      minWidth: 200.0,
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                            'SIGN UP',
                            style: TextStyle(
                                fontSize: 18.0,
                            ),
                          ),
                        color: Colors.white,
                        textColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius:
                            BorderRadius.circular(30.0)),
                      ),
                  ),
                ],
            ),// Column
          ),// Center
      ),// Scaffold
    );// Material App
  }
}
