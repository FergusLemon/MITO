import 'package:test/test.dart';
import '../helpers/form_validation_helpers.dart';
import 'package:mito/helpers/email_validator.dart';

void main() {
  group('Valid email addresses', () {
    test('returns true for ".com" addresses', () {
      expect(EmailValidator.validate(caseCom), true);
    });
    test('returns true for ".co.uk" addresses', () {
      expect(EmailValidator.validate(caseCoUK), true);
    });
    test('returns true for ".org" addresses', () {
      expect(EmailValidator.validate(caseOrg), true);
    });
    test('returns true for ".net" addresses', () {
      expect(EmailValidator.validate(caseNet), true);
    });
    test('returns true for addresses with punctuation before the "@"', () {
      expect(EmailValidator.validate(casePunctuation), true);
    });
  });

  group('Invalid email addresses', () {
    test('returns false for addresses without an "@" symbol', () {
      expect(EmailValidator.validate(caseMissingAt), false);
    });
    test('returns false for addresses without an "." prefixing the TLD', () {
      expect(EmailValidator.validate(caseComma), false);
    });
    test('returns false for missing prefix', () {
      expect(EmailValidator.validate(caseMissingPrefix), false);
    });
  });
}
