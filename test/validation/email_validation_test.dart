import 'package:test/test.dart';
import '../helpers/form_validation_helpers.dart';
import 'package:mito/helpers/email_validator.dart';

void main() {
  group('Valid email addresses', () {
    test('returns true for ".com" addresses', () {
      expect(validateEmail(caseCom), true);
    });
    test('returns true for ".co.uk" addresses', () {
      expect(validateEmail(caseCoUK), true);
    });
    test('returns true for ".org" addresses', () {
      expect(validateEmail(caseOrg), true);
    });
    test('returns true for ".net" addresses', () {
      expect(validateEmail(caseNet), true);
    });
    test('returns true for addresses with punctuation before the "@"', () {
      expect(validateEmail(casePunctuation), true);
    });
  });

  group('Invalid email addresses', () {
    test('returns false for addresses without an "@" symbol', () {
      expect(validateEmail(caseMissingAt), false);
    });
    test('returns false for addresses without an "." prefixing the TLD', () {
      expect(validateEmail(caseComma), false);
    });
    test('returns false for missing prefix', () {
      expect(validateEmail(caseMissingPrefix), false);
    });
  });
}
