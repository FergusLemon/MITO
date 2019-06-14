import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> signUp(String email, String password);
  Future<String> signIn(String email, String password);
}

class Auth implements BaseAuth {
  final auth = FirebaseAuth.instance;

  Future<String> signUp(String email, String password) async {
    final FirebaseUser user = await auth.createUserWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }
  Future<String> signIn(String email, String password) async {
    final FirebaseUser user = await auth.signInWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }
}
