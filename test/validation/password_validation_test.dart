import 'package:test/test.dart';
import '../helpers/form_validation_helpers.dart';
import 'package:mito/helpers/password_validator.dart';

void main() {
  group('Valid passwords', () {
    test('returns true for short valid password', () {
      expect(validatePassword(caseShort), true);
    });
    test('returns true for long valid password', () {
      expect(validatePassword(caseLong), true);
    });
  });

  group('Invalid password', () {
    test('returns false for a password that is too short', () {
      expect(validatePassword(caseTooShort), false);
    });
    test('returns false for a password that is too long', () {
      expect(validatePassword(caseTooLong), false);
    });
    test('returns false for a password with no uppercase character', () {
      expect(validatePassword(caseNoUppercase), false);
    });
    test('returns false for a password with no lowercase character', () {
      expect(validatePassword(caseNoLowercase), false);
    });
    test('returns false for a password with no number', () {
      expect(validatePassword(caseNoNumber), false);
    });
    test('returns false for a password with no special character', () {
      expect(validatePassword(caseNoSpecialChar), false);
    });
  });
}
