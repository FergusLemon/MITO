import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mito/pages/landing_page.dart';
import 'package:mito/inherited_user_services.dart';
import 'package:mito/services/auth.dart';
import 'package:mito/services/user_status.dart';

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
    return InheritedUserServices(
        auth: Auth(),
        userStatus: UserStatus(),
        firestore: Firestore.instance,
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
