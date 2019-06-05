import 'package:test/test.dart';
import '../helpers/form_validation_helpers.dart';
import 'package:mito/helpers/password_validator.dart';

void main() {
  group('Valid passwords', () {
    test('returns true for short valid password', () {
      expect(PasswordValidator.validate(caseShort), true);
    });
    test('returns true for long valid password', () {
      expect(PasswordValidator.validate(caseLong), true);
    });
  });

  group('Invalid password', () {
    test('returns false for a password that is too short', () {
      expect(PasswordValidator.validate(caseTooShort), false);
    });
    test('returns false for a password that is too long', () {
      expect(PasswordValidator.validate(caseTooLong), false);
    });
    test('returns false for a password with no uppercase character', () {
      expect(PasswordValidator.validate(caseNoUppercase), false);
    });
    test('returns false for a password with no lowercase character', () {
      expect(PasswordValidator.validate(caseNoLowercase), false);
    });
    test('returns false for a password with no number', () {
      expect(PasswordValidator.validate(caseNoNumber), false);
    });
    test('returns false for a password with no special character', () {
      expect(PasswordValidator.validate(caseNoSpecialChar), false);
    });
  });
}
