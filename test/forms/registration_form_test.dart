import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mito/pages/home_page.dart';
import 'package:mito/forms/registration_form.dart';
import 'package:mito/inherited_auth.dart';

import '../helpers/form_validation_helpers.dart';
import '../mocks/auth_mock.dart';
import '../mocks/firebase_user_mock.dart';

void main() {
  final authMock = AuthMock();
  final firebaseUserMock = FirebaseUserMock();
  bool didSignIn;
  Widget app = InheritedAuth(
      auth: authMock,
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
              child: RegistrationForm(onSignedIn: () => didSignIn = true),
          ),
        ),
      ),
    );

  final Finder firstName = find.widgetWithText(TextFormField, 'First Name');
  final Finder lastName = find.widgetWithText(TextFormField, 'Last Name');
  final Finder email = find.widgetWithText(TextFormField, 'Email');
  final Finder password = find.widgetWithText(TextFormField, 'Password');
  final Finder confirmPassword = find.widgetWithText(TextFormField, 'Confirm Password');
  final Finder signUp = find.widgetWithText(RaisedButton, 'SIGN UP');

  void completeValidSignUp(WidgetTester tester) async {
    await tester.pumpWidget(app);
    await tester.enterText(firstName, name);
    await tester.enterText(lastName, surname);
    await tester.enterText(email, validEmail);
    await tester.enterText(password, validPassword);
    await tester.enterText(confirmPassword, validPassword);
    await tester.tap(signUp);
  }

  testWidgets('Renders', (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.text('SIGN UP'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(5));
    expect(find.byType(RaisedButton), findsOneWidget);
  });

  group('Invalid user entries', () {
    testWidgets('User needs to enter an email address', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(noEmailMessage), findsOneWidget);
    });

    testWidgets('User needs to enter a well formed email address', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(email, invalidEmail);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(noEmailMessage), findsNothing);
      expect(find.text(invalidEmailMessage), findsOneWidget);
    });

    testWidgets('User needs to enter a password', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(noPasswordMessage), findsOneWidget);
    });

    testWidgets('User needs to enter a valid password', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(password, invalidPassword);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(invalidPasswordMessage), findsOneWidget);
    });

    testWidgets('User needs to enter a valid password - 24 or less chars', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(password, invalidLongPassword);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(invalidPasswordMessage), findsOneWidget);
    });

    testWidgets('User needs to confirm their password', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(email, validEmail);
      await tester.enterText(password, validPassword);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(noPasswordConfirmMessage), findsOneWidget);
    });

    testWidgets('User needs to confirm their password - must be the same password', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(email, validEmail);
      await tester.enterText(password, validPassword);
      await tester.enterText(confirmPassword, invalidPassword);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(notSamePasswordMessage), findsOneWidget);
    });

    testWidgets('User must enter their first name', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(noFirstNameMessage), findsOneWidget);
    });

    testWidgets('User must enter their last name', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(noLastNameMessage), findsOneWidget);
    });

    testWidgets('Error message stays on screen after first invalid attempt from user until the password meets the validity criteria', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(password, invalidPassword);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(invalidPasswordMessage), findsOneWidget);

      await tester.pump();

      expect(find.text(invalidPasswordMessage), findsOneWidget);

      await tester.enterText(password, validPassword);
      await tester.pump();

      expect(find.text(invalidPasswordMessage), findsNothing);
    });
  });

  group('Valid user entries', () {
    testWidgets('User does not see the error message when they enter a valid email address', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(email, validEmail);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(noEmailMessage), findsNothing);
      expect(find.text(invalidEmailMessage), findsNothing);
    });

    testWidgets('User does not see the error message when they enter a valid password', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(password, validPassword);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(noPasswordMessage), findsNothing);
      expect(find.text(invalidPasswordMessage), findsNothing);
    });

    testWidgets('User does not see the error message if they correctly confirm their password', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(email, validEmail);
      await tester.enterText(password, validPassword);
      await tester.enterText(confirmPassword, validPassword);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(noPasswordConfirmMessage), findsNothing);
      expect(find.text(notSamePasswordMessage), findsNothing);
    });

    testWidgets('User does not see the error message if they enter their first name', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(firstName, name);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(noFirstNameMessage), findsNothing);
    });

    testWidgets('User does not see the error message if they enter their last name', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(lastName, surname);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(noLastNameMessage), findsNothing);
    });
  });

  group('Auth status', () {
    setUp(() => didSignIn = false);

    testWidgets('Calls signUp when valid details entered and button tapped', (WidgetTester tester) async {
      when(authMock.signUp(validEmail, validPassword))
          .thenAnswer((_) => Future<String>.value(firebaseUserMock.uid));
      await completeValidSignUp(tester);

      verify(authMock.signUp(validEmail, validPassword)).called(1);
      expect(didSignIn, true);
    });

    testWidgets('Does not call signUp if the registration form is empty and the button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.tap(signUp);

      verifyNever(authMock.signUp(validEmail, validPassword));
      expect(didSignIn, false);
    });

    testWidgets('Does not call signUp if there were form validation error when the button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(password, validPassword);
      await tester.enterText(confirmPassword, invalidPassword);
      await tester.tap(signUp);

      verifyNever(authMock.signUp(validEmail, validPassword));
      expect(didSignIn, false);
    });

    testWidgets('Does not sign a user in if an error was thrown from calling into Firebase', (WidgetTester tester) async {
      when(authMock.signUp(validEmail, validPassword))
          .thenThrow(StateError('User not authenticated.'));
      await completeValidSignUp(tester);

      verify(authMock.signUp(validEmail, validPassword)).called(1);
      expect(didSignIn, false);
    });

    testWidgets('On valid sign up navigates away from the registration page', (WidgetTester tester) async {
      when(authMock.signUp(validEmail, validPassword))
          .thenAnswer((_) => Future<String>.value(firebaseUserMock.uid));
      await completeValidSignUp(tester);

      expect(didSignIn, true);
      expect(find.text('Registration'), findsNothing);
    });
  });
}
