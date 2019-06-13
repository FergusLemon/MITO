import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './services/auth.dart';
import './services/user_status.dart';

class InheritedUserServices extends InheritedWidget {
  const InheritedUserServices({Key key, Widget child, this.auth, this.userStatus, this.firestore}) : super(key: key, child: child);
  final BaseAuth auth;
  final UserStatus userStatus;
  final Firestore firestore;

  @override

  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static InheritedUserServices of (BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritedUserServices);
  }

}
