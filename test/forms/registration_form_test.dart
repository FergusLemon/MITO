import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mito/pages/home_page.dart';
import 'package:mito/pages/landing_page.dart';
import 'package:mito/forms/registration_form.dart';
import 'package:mito/inherited_user_services.dart';
import 'package:mito/services/user_status.dart';
import 'package:mito/helpers/validation_warnings.dart';

import '../helpers/form_validation_helpers.dart';
import '../mocks/auth_mock.dart';
import '../mocks/user_status_mock.dart';
import '../mocks/firebase_user_mock.dart';
import '../mocks/firestore_mock.dart';
import '../mocks/collection_reference_mock.dart';
import '../mocks/document_reference_mock.dart';

void main() {
  final authMock = AuthMock();
  final firebaseUserMock = FirebaseUserMock();
  final userStatusMock = UserStatusMock();
  final firestoreMock = FirestoreMock();
  final collectionReferenceMock = CollectionReferenceMock();
  final documentReferenceMock = DocumentReferenceMock();
  Widget app = InheritedUserServices(
      auth: authMock,
      userStatus: userStatusMock,
      firestore: firestoreMock,
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
              child: RegistrationForm(),
          ),
        ),
      ),
    );

  final Finder firstName = find.byKey(RegistrationForm.firstNameKey);
  final Finder lastName = find.byKey(RegistrationForm.lastNameKey);
  final Finder email = find.byKey(RegistrationForm.emailKey);
  final Finder password = find.byKey(RegistrationForm.passwordKey);
  final Finder confirmPassword = find.byKey(RegistrationForm.passwordConfirmKey);
  final Finder signUp = find.byKey(RegistrationForm.signUpKey);

  void fillInFormAndSubmit(WidgetTester tester) async {
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

      expect(find.text(missingEmailWarning), findsOneWidget);
    });

    testWidgets('User needs to enter a well formed email address', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(email, invalidEmail);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(missingEmailWarning), findsNothing);
      expect(find.text(invalidEmailWarning), findsOneWidget);
    });

    testWidgets('User needs to enter a password', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(missingPasswordWarning), findsOneWidget);
    });

    testWidgets('User needs to enter a valid password', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(password, invalidPassword);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(invalidPasswordWarning), findsOneWidget);
    });

    testWidgets('User needs to enter a valid password - 24 or less chars', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(password, invalidLongPassword);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(invalidPasswordWarning), findsOneWidget);
    });

    testWidgets('User needs to confirm their password', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(email, validEmail);
      await tester.enterText(password, validPassword);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(missingPasswordConfirmWarning), findsOneWidget);
    });

    testWidgets('User needs to confirm their password - must be the same password', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(email, validEmail);
      await tester.enterText(password, validPassword);
      await tester.enterText(confirmPassword, invalidPassword);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(notSamePasswordWarning), findsOneWidget);
    });

    testWidgets('User must enter their first name', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(missingFirstNameWarning), findsOneWidget);
    });

    testWidgets('User must enter their last name', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(missingLastNameWarning), findsOneWidget);
    });

    testWidgets('Warning message stays on screen after first invalid attempt from user until the password meets the validity criteria', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(password, invalidPassword);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(invalidPasswordWarning), findsOneWidget);

      await tester.pump();

      expect(find.text(invalidPasswordWarning), findsOneWidget);

      await tester.enterText(password, validPassword);
      await tester.pump();

      expect(find.text(invalidPasswordWarning), findsNothing);
    });
  });

  group('Valid user entries', () {
    testWidgets('User does not see the warning message when they enter a valid email address', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(email, validEmail);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(missingEmailWarning), findsNothing);
      expect(find.text(invalidEmailWarning), findsNothing);
    });

    testWidgets('User does not see the warning message when they enter a valid password', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(password, validPassword);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(missingPasswordWarning), findsNothing);
      expect(find.text(invalidPasswordWarning), findsNothing);
    });

    testWidgets('User does not see the warning message if they correctly confirm their password', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(email, validEmail);
      await tester.enterText(password, validPassword);
      await tester.enterText(confirmPassword, validPassword);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(missingPasswordConfirmWarning), findsNothing);
      expect(find.text(notSamePasswordWarning), findsNothing);
    });

    testWidgets('User does not see the warning message if they enter their first name', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(firstName, name);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(missingFirstNameWarning), findsNothing);
    });

    testWidgets('User does not see the warning message if they enter their last name', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(lastName, surname);
      await tester.tap(signUp);
      await tester.pump();

      expect(find.text(missingLastNameWarning), findsNothing);
    });
  });

  group('Invalid sign ups', () {
    testWidgets('Does not call signUp if the registration form is empty and the button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.tap(signUp);

      verifyNever(authMock.signUp(validEmail, validPassword));
      verifyNever(userStatusMock.signInUser());
    });

    testWidgets('Does not call signUp if there were form validation error when the button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.enterText(password, validPassword);
      await tester.enterText(confirmPassword, invalidPassword);
      await tester.tap(signUp);

      verifyNever(authMock.signUp(validEmail, validPassword));
      verifyNever(userStatusMock.signInUser());
    });

    testWidgets('Does not sign a user in if an error was thrown from calling into Firebase', (WidgetTester tester) async {
      when(authMock.signUp(validEmail, validPassword))
          .thenThrow(StateError('User not authenticated.'));
      await fillInFormAndSubmit(tester);

      verify(authMock.signUp(validEmail, validPassword)).called(1);
      verifyNever(userStatusMock.signInUser());
    });

    testWidgets('Does not sign a user up if a user already exists with the same email', (WidgetTester tester) async {
      when(authMock.signUp(validEmail, validPassword))
          .thenThrow(StateError(firebaseAuthErrorExistingEmail));
      await fillInFormAndSubmit(tester);
      await tester.pump();

      verify(authMock.signUp(validEmail, validPassword)).called(1);
      verifyNever(userStatusMock.signInUser());
      expect(find.text(registeredEmailWarning), findsOneWidget);
    });
  });

  group('Valid sign ups', () {
    var mockData;
    setUp(() {
      when(authMock.signUp(validEmail, validPassword))
          .thenAnswer((_) => Future<String>.value(firebaseUserMock.uid));
      mockData = { 'email': validEmail, 'firstName': name, 'lastName': surname };
      when(firestoreMock.collection('users'))
          .thenReturn(collectionReferenceMock);
      when(collectionReferenceMock.document(firebaseUserMock.uid))
          .thenReturn(documentReferenceMock);
      when(documentReferenceMock.setData(mockData))
          .thenAnswer((_) => Future<void>.value(true));
    });

    testWidgets('Calls signUp when valid details entered and button tapped', (WidgetTester tester) async {
      await fillInFormAndSubmit(tester);

      verify(authMock.signUp(validEmail, validPassword)).called(1);
      verify(userStatusMock.signInUser()).called(1);
      verify(documentReferenceMock.setData(mockData)).called(1);
    });

    testWidgets('On valid sign up navigates away from the registration page', (WidgetTester tester) async {
      await fillInFormAndSubmit(tester);

      verify(authMock.signUp(validEmail, validPassword)).called(1);
      verify(userStatusMock.signInUser()).called(1);
      verify(documentReferenceMock.setData(mockData)).called(1);
      expect(find.text('Registration'), findsNothing);
    });

    testWidgets('On valid sign up navigates user to the Home Page', (WidgetTester tester) async {
      Widget testApp = InheritedUserServices(
          auth: authMock,
          userStatus: userStatusMock,
          firestore: firestoreMock,
          child: MaterialApp(
            home: LandingPage(),
          )
      );
      when(userStatusMock.isSignedIn()).thenReturn(false);

      await tester.pumpWidget(testApp);
      await tester.tap(find.byKey(LandingPage.navigateToRegistrationButtonKey));
      await tester.pumpAndSettle();

      await tester.enterText(firstName, name);
      await tester.enterText(lastName, surname);
      await tester.enterText(email, validEmail);
      await tester.enterText(password, validPassword);
      await tester.enterText(confirmPassword, validPassword);
      await tester.tap(signUp);
      when(userStatusMock.isSignedIn()).thenReturn(true);
      await tester.pumpAndSettle();

      expect(find.text('Registration'), findsNothing);
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
