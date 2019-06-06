import 'package:flutter/material.dart';
import 'package:mito/pages/landing_page.dart';
import 'package:mito/inherited_auth.dart';
import 'package:mito/services/auth.dart';
import 'package:mito/services/user_state.dart';

class MitoRootWidget extends StatefulWidget {
  @override
  MitoRootWidgetState createState() => MitoRootWidgetState();
}

class MitoRootWidgetState extends State<MitoRootWidget> {
  ThemeData get _themeData => ThemeData(
      primaryColor: Colors.red,
      accentColor: Colors.orangeAccent[400],
      scaffoldBackgroundColor: Colors.grey[600],
      brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return InheritedAuth(
        auth: Auth(),
        userState: UserState(),
        child: MaterialApp(
          title: 'MITO',
          theme: _themeData,
          routes: {
            '/': (BuildContext context) => LandingPage(),
          },
        ),
      );
  }
}
