enum AuthStatus {
  isSignedIn,
  notSignedIn
}

class UserStatus {
  AuthStatus authStatus = AuthStatus.notSignedIn;
  void signInUser() => authStatus = AuthStatus.isSignedIn;
  bool isSignedIn() => authStatus == AuthStatus.isSignedIn;
}
