import 'package:mito/forms/registration_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../helpers/form_validation_helpers.dart';

void main() {
  const MaterialApp app = MaterialApp(
      home: Scaffold(
          body: SingleChildScrollView(
              child: RegistrationForm(),
          ),
      ),
  );

  final Finder email = find.widgetWithText(TextFormField, 'Email');
  final Finder password = find.widgetWithText(TextFormField, 'Password');
  final Finder signUp = find.widgetWithText(RaisedButton, 'SIGN UP');

  testWidgets('Renders', (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.text('SIGN UP'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(RaisedButton), findsOneWidget);
  });

  testWidgets('User needs to enter an email address', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    await tester.tap(signUp);
    await tester.pump();

    expect(find.text(noEmailMessage), findsOneWidget);
  });

  testWidgets('User needs to enter a well formed email address', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final invalidEmail = 'invalid@comma,com';
    await tester.enterText(email, invalidEmail);
    await tester.tap(signUp);
    await tester.pump();

    expect(find.text(noEmailMessage), findsNothing);
    expect(find.text(invalidEmailMessage), findsOneWidget);
  });

  testWidgets('User sees no warning message when they enter a valid email address', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final validEmail = 'valid@gmail.com';
    await tester.enterText(email, validEmail);
    await tester.tap(signUp);
    await tester.pump();

    expect(find.text(noEmailMessage), findsNothing);
    expect(find.text(invalidEmailMessage), findsNothing);
  });

  testWidgets('User needs to enter a password', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    await tester.tap(signUp);
    await tester.pump();

    expect(find.text(noPasswordMessage), findsOneWidget);
  });

  testWidgets('User needs to enter a valid password', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final invalidPassword = '1234';
    await tester.enterText(password, invalidPassword);
    await tester.tap(signUp);
    await tester.pump();

    expect(find.text(invalidPasswordMessage), findsOneWidget);
  });

  testWidgets('User sees no warning message when they enter a valid password', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final validPassword = 'B@tman99';
    await tester.enterText(password, validPassword);
    await tester.tap(signUp);
    await tester.pump();

    expect(find.text(noPasswordMessage), findsNothing);
    expect(find.text(invalidPasswordMessage), findsNothing);
  });
}
