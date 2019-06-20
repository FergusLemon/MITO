import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';

import 'package:mito/pages/home_page.dart';
import 'package:mito/pages/landing_page.dart';
import 'package:mito/forms/login_form.dart';
import 'package:mito/inherited_user_services.dart';
import 'package:mito/services/user_status.dart';
import 'package:mito/helpers/form_helpers.dart';

import '../helpers/form_validation_helpers.dart';
import '../mocks/auth_mock.dart';
import '../mocks/user_status_mock.dart';
import '../mocks/firebase_auth_mock.dart';
import '../mocks/firebase_user_mock.dart';
import '../mocks/firestore_mock.dart';
import '../mocks/google_sign_in_mock.dart';
import '../mocks/google_sign_in_account_mock.dart';
import '../mocks/google_sign_in_auth_mock.dart';
import '../mocks/auth_credential_mock.dart';

void main() {
  final authMock = AuthMock();
  final firebaseAuthMock = FirebaseAuthMock();
  final firebaseUserMock = FirebaseUserMock();
  final userStatusMock = UserStatusMock();
  final firestoreMock = FirestoreMock();
  final googleSignInMock = GoogleSignInMock();
  final googleSignInAccountMock = GoogleSignInAccountMock();
  final googleSignInAuthMock = GoogleSignInAuthMock();
  final authCredentialMock = AuthCredentialMock();
  Widget app = InheritedUserServices(
    auth: authMock,
    userStatus: userStatusMock,
    firestore: firestoreMock,
    child: MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: LoginForm(),
        ),
      ),
    ),
  );
  Widget landingPageApp = InheritedUserServices(
    auth: authMock,
    userStatus: userStatusMock,
    firestore: firestoreMock,
    child: MaterialApp(
      home: LandingPage(),
    )
  );

  final Finder login = find.byKey(LoginForm.loginKey);
  final Finder email = find.byKey(LoginForm.emailKey);
  final Finder password = find.byKey(LoginForm.passwordKey);
  final Finder signInWithGoogle = find.byKey(LoginForm.googleSignInKey);

  void fillInFormAndSubmit(WidgetTester tester) async {
    await tester.pumpWidget(app);
    await tester.enterText(email, validEmail);
    await tester.enterText(password, validPassword);
    await tester.tap(login);
    await tester.pump();
  };

  testWidgets('Renders', (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.text('Sign in with Email'), findsOneWidget);
    expect(find.text('Sign in with Google'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(RaisedButton), findsNWidgets(2));
  });

  group('Sign in with email and password', () {
    group('Validation of user inputs', () {
      group('Invalid inputs', () {
        testWidgets('User is shown a warning if they do not enter anything', (WidgetTester tester) async {
          await tester.pumpWidget(app);
          await tester.tap(login);
          await tester.pump();

          expect(find.text(missingEmailWarning), findsOneWidget);
          expect(find.text(missingPasswordWarning), findsOneWidget);
        });

        testWidgets('User is shown a warning if they do not enter an email address', (WidgetTester tester) async {
          await tester.pumpWidget(app);
          await tester.enterText(password, validPassword);
          await tester.tap(login);
          await tester.pump();

          expect(find.text(missingEmailWarning), findsOneWidget);
        });

        testWidgets('User is shown a warning if enter an invalid email address', (WidgetTester tester) async {
          await tester.pumpWidget(app);
          await tester.enterText(email, invalidEmail);
          await tester.enterText(password, validPassword);
          await tester.tap(login);
          await tester.pump();

          expect(find.text(invalidEmailWarning), findsOneWidget);
        });

        testWidgets('User is shown a warning if they do not enter a password', (WidgetTester tester) async {
          await tester.pumpWidget(app);
          await tester.enterText(email, validEmail);
          await tester.tap(login);
          await tester.pump();

          expect(find.text(missingPasswordWarning), findsOneWidget);
        });

        testWidgets('User is shown a warning if enter an invalid password', (WidgetTester tester) async {
          await tester.pumpWidget(app);
          await tester.enterText(email, validEmail);
          await tester.enterText(password, invalidPassword);
          await tester.tap(login);
          await tester.pump();

          expect(find.text(notAPasswordWarning), findsOneWidget);
        });

        testWidgets('''Warning message stays on screen after first invalid attempt
            from user until the validity criteria are met''', (WidgetTester tester) async {
            await tester.pumpWidget(app);
            await tester.enterText(email, validEmail);
            await tester.enterText(password, invalidPassword);
            await tester.tap(login);
            await tester.pump();

            expect(find.text(notAPasswordWarning), findsOneWidget);

            await tester.pump();

            expect(find.text(notAPasswordWarning), findsOneWidget);

            await tester.enterText(password, validPassword);
            await tester.pumpAndSettle();

            expect(find.text(notAPasswordWarning), findsNothing);
        });
      });

      group('Valid inputs', () {
        setUp(() {
          when(authMock.signIn(validEmail, validPassword))
              .thenAnswer((_) => Future<String>.value(firebaseUserMock.uid));
        });
        tearDown(() {
          clearInteractions(authMock);
          clearInteractions(userStatusMock);
        });

        testWidgets('User is not shown any warnings if they enter valid details', (WidgetTester tester) async {
          await fillInFormAndSubmit(tester);

          expect(find.text(missingEmailWarning), findsNothing);
          expect(find.text(invalidEmailWarning), findsNothing);
          expect(find.text(missingPasswordWarning), findsNothing);
          expect(find.text(notAPasswordWarning), findsNothing);
        });
      });
    });

    group('Valid sign in with email and password', () {
      setUp(() {
        when(authMock.signIn(validEmail, validPassword))
            .thenAnswer((_) => Future<String>.value(firebaseUserMock.uid));
      });
      tearDown(() {
        clearInteractions(authMock);
        clearInteractions(userStatusMock);
      });

      testWidgets('Calls signIn when valid details entered and button tapped', (WidgetTester tester) async {
        await fillInFormAndSubmit(tester);

        verify(authMock.signIn(validEmail, validPassword)).called(1);
        verify(userStatusMock.signInUser()).called(1);
      });

      testWidgets('On valid sign in navigates user to the Home Page', (WidgetTester tester) async {
        when(userStatusMock.isSignedIn()).thenReturn(false);

        await tester.pumpWidget(landingPageApp);
        await tester.tap(find.byKey(LandingPage.navigateToLoginButtonKey));
        await tester.pumpAndSettle();

        await tester.enterText(email, validEmail);
        await tester.enterText(password, validPassword);
        await tester.tap(login);
        when(userStatusMock.isSignedIn()).thenReturn(true);
        await tester.pumpAndSettle();

        expect(find.text('Email'), findsNothing);
        expect(find.text('Password'), findsNothing);
        expect(find.byType(HomePage), findsOneWidget);
      });
    });

    group('Sign in error cases', () {
      tearDown(() {
        clearInteractions(authMock);
        clearInteractions(userStatusMock);
      });

      testWidgets('''User sees a warning message if there is no registered user
          with the email address entered''', (WidgetTester tester) async {
          when(authMock.signIn(validEmail, validPassword))
              .thenThrow(StateError(firebaseUserNotFound));
          await fillInFormAndSubmit(tester);

          verifyNever(userStatusMock.signInUser());
          expect(find.text(userNotFoundWarning), findsOneWidget);
      });

      testWidgets('''User sees a warning message if they enter a password not
          associated with the email address entered''', (WidgetTester tester) async {
          when(authMock.signIn(validEmail, validPassword))
              .thenThrow(StateError(firebaseInvalidPassword));
          await fillInFormAndSubmit(tester);

          verifyNever(userStatusMock.signInUser());
          expect(find.text(incorrectPasswordWarning), findsOneWidget);
      });
    });
  });

  group('Sign in with Google', () {
    tearDown(() {
      clearInteractions(googleSignInMock);
      clearInteractions(googleSignInAccountMock);
      clearInteractions(googleSignInAuthMock);
      clearInteractions(authCredentialMock);
      clearInteractions(firebaseAuthMock);
      clearInteractions(authMock);
      clearInteractions(userStatusMock);
    });

    group('Success cases', () {
      setUp(() {
        when(userStatusMock.isSignedIn()).thenReturn(false);
        when(googleSignInMock.signIn())
            .thenAnswer((_) => Future<GoogleSignInAccountMock>.value(googleSignInAccountMock));
        when(googleSignInAccountMock.authentication)
            .thenAnswer((_) => Future<GoogleSignInAuthMock>.value(googleSignInAuthMock));
        when(firebaseAuthMock.signInWithCredential(authCredentialMock))
            .thenAnswer((_) => Future<FirebaseUserMock>.value(firebaseUserMock));
        when(authMock.signInWithGoogle()).thenAnswer((_) => Future<String>.value(firebaseUserMock.uid));
      });

      testWidgets('signs a user in', (WidgetTester tester) async {
        await tester.pumpWidget(app);
        await tester.tap(signInWithGoogle);
        await tester.pump();

        verify(authMock.signInWithGoogle()).called(1);
        verify(userStatusMock.signInUser()).called(1);
      });

      testWidgets('Navigates the user to the Home Page', (WidgetTester tester) async {
        await tester.pumpWidget(landingPageApp);
        await tester.tap(find.byKey(LandingPage.navigateToLoginButtonKey));
        await tester.pumpAndSettle();

        await tester.tap(signInWithGoogle);
        when(userStatusMock.isSignedIn()).thenReturn(true);
        await tester.pumpAndSettle();

        expect(find.text('Email'), findsNothing);
        expect(find.text('Password'), findsNothing);
        expect(find.byType(HomePage), findsOneWidget);
      });
    });

    group('Error cases', () {
      testWidgets('User is shown a message when Google sign in fails', (WidgetTester tester) async {
          when(userStatusMock.isSignedIn()).thenReturn(false);
          when(googleSignInMock.signIn())
              .thenAnswer((_) => Future<GoogleSignInAccountMock>.value(googleSignInAccountMock));
          when(googleSignInAccountMock.authentication)
              .thenAnswer((_) => Future<GoogleSignInAuthMock>.value(googleSignInAuthMock));
          when(firebaseAuthMock.signInWithCredential(authCredentialMock))
              .thenAnswer((_) => Future<FirebaseUserMock>.value(firebaseUserMock));
          when(authMock.signInWithGoogle()).thenThrow(StateError(googleSignInErrorMessage));

          await tester.pumpWidget(app);
          await tester.tap(signInWithGoogle);
          await tester.pumpAndSettle();

          verifyNever(userStatusMock.signInUser());
          expect(find.text(googleSignInErrorMessage), findsOneWidget);
        });
      });
  });
}
