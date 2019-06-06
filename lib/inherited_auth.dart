import 'package:flutter/material.dart';
import './services/auth.dart';
import './services/user_state.dart';

class InheritedAuth extends InheritedWidget {
  const InheritedAuth({Key key, Widget child, this.auth, this.userState}) : super(key: key, child: child);
  final BaseAuth auth;
  final UserState userState;

  @override

  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static InheritedAuth of (BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritedAuth);
  }

}
