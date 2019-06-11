import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './services/auth.dart';
import './services/user_state.dart';

class InheritedAuth extends InheritedWidget {
  const InheritedAuth({Key key, Widget child, this.auth, this.userState, this.firestore}) : super(key: key, child: child);
  final BaseAuth auth;
  final UserState userState;
  final Firestore firestore;

  @override

  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static InheritedAuth of (BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritedAuth);
  }

}
