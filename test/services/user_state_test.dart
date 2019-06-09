import 'package:flutter_test/flutter_test.dart';
import 'package:mito/services/user_state.dart';

void main() {
  group('Test user auth status', () {
    test('A user is signed out before they are signed in', () {
      final user = UserState();
      expect(user.isSignedIn(), false);
    });
    test('A user is signed in once they sign in', () {
      final user = UserState();
      user.signInUser();
      expect(user.isSignedIn(), true);
    });
  });
}
