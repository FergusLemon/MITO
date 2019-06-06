import 'package:flutter/material.dart';
import './services/auth.dart';

class InheritedAuth extends InheritedWidget {
  const InheritedAuth({Key key, Widget child, this.auth}) : super(key: key, child: child);
  final BaseAuth auth;

  @override

  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static InheritedAuth of (BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritedAuth);
  }
}
