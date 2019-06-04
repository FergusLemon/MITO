import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> signUp(String email, String password);
}

class Auth implements BaseAuth {
  Future<String> signUp(String email, String password) async {
    final FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }
}
