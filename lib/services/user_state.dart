import 'package:flutter/material.dart';

class UserState {
  static var _userSignedIn = false;

  void signInUser() {
    _userSignedIn = true;
  }

  bool isSignedIn() {
    return _userSignedIn;
  }
}
