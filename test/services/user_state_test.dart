import 'package:flutter_test/flutter_test.dart';
import 'package:mito/services/user_status.dart';

void main() {
  group('Test user auth status', () {
    test('Auth status is set to notSignedIn by default', () {
      final authStatus = UserStatus().authStatus;
      expect(authStatus, AuthStatus.notSignedIn);
    });
    test('A user is signed in once they sign in', () {
      final userStatus = UserStatus();
      userStatus.signInUser();
      expect(userStatus.authStatus, AuthStatus.isSignedIn);
    });
  });
}
