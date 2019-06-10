import 'package:flutter_test/flutter_test.dart';
import 'package:mito/services/user_state.dart';

void main() {
  group('Test user auth status', () {
    test('Auth status is set to notSignedIn by default', () {
      final authStatus = UserState().authStatus;
      expect(authStatus, AuthStatus.notSignedIn);
    });
    test('A user is signed in once they sign in', () {
      final userState = UserState();
      userState.signInUser();
      expect(userState.authStatus, AuthStatus.isSignedIn);
    });
  });
}
