import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

import 'package:mito/pages/home_page.dart';
import 'package:mito/pages/landing_page.dart';
import 'package:mito/forms/login_form.dart';
import 'package:mito/inherited_auth.dart';
import 'package:mito/services/user_state.dart';

import '../helpers/form_validation_helpers.dart';
import '../mocks/auth_mock.dart';
import '../mocks/user_state_mock.dart';
import '../mocks/firebase_user_mock.dart';
import '../mocks/firestore_mock.dart';

void main() {
  final authMock = AuthMock();
  final firebaseUserMock = FirebaseUserMock();
  final userStateMock = UserStateMock();
  final firestoreMock = FirestoreMock();
  Widget app = InheritedAuth(
      auth: authMock,
      userState: userStateMock,
      firestore: firestoreMock,
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
              child: LoginForm(),
          ),
        ),
      ),
    );

  final Finder login = find.byKey(LoginForm.loginKey);
  final Finder email = find.byKey(LoginForm.emailKey);

  testWidgets('Renders', (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(RaisedButton), findsOneWidget);
  });

  group('Validation of user inputs', () {
    group('Invalid inputs', () {
      testWidgets('User is shown a warning if they do not enter an email address', (WidgetTester tester) async {
        await tester.pumpWidget(app);
        await tester.tap(login);
        await tester.pump();

        expect(find.text(missingEmailWarning), findsOneWidget);
      });

      testWidgets('User is shown a warning if enter an invalid email address', (WidgetTester tester) async {
        await tester.pumpWidget(app);
        await tester.enterText(email, invalidEmail);
        await tester.tap(login);
        await tester.pump();

        expect(find.text(invalidEmailWarning), findsOneWidget);
      });
    });
  });
}
