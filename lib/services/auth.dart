import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> signUp(String email, String password);
  Future<String> signIn(String email, String password);
  Future<Map> signInWithGoogle();
}

class Auth implements BaseAuth {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signUp(String email, String password) async {
    final FirebaseUser user = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }
  Future<String> signIn(String email, String password) async {
    final FirebaseUser user = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }
  Future<Map> signInWithGoogle() async {
    final GoogleSignInAccount googleAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    final FirebaseUser user = await firebaseAuth.signInWithCredential(credential);
    return { 'uid': user.uid, 'email': user.email };
  }
}
