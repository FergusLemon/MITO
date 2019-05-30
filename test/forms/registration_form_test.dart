import 'package:mito/forms/registration_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MaterialApp app = MaterialApp(
      home: Scaffold(
          body: SingleChildScrollView(
              child: RegistrationForm(),
          ),
      ),
  );

  testWidgets('Renders', (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.text('SIGN UP'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(RaisedButton), findsOneWidget);
  });

  testWidgets('User needs to provide an email address', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final Finder signUp = find.widgetWithText(RaisedButton, 'SIGN UP');
    await tester.tap(signUp);
    await tester.pump();

    expect(find.text('Please enter an email address.'), findsOneWidget);
  });

  testWidgets('User needs to provide a well formed email address', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final Finder email = find.widgetWithText(TextFormField, 'Email');
    final Finder signUp = find.widgetWithText(RaisedButton, 'SIGN UP');
    final invalidEmail = 'invalid@comma,com';
    await tester.enterText(email, invalidEmail);
    await tester.tap(signUp);
    await tester.pump();

    expect(find.text('Please enter an email address.'), findsNothing);
    expect(find.text('Please enter a valid email address.'), findsOneWidget);
  });

  testWidgets('User sees no warning message when they enter a valid email address', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final Finder email = find.widgetWithText(TextFormField, 'Email');
    final Finder signUp = find.widgetWithText(RaisedButton, 'SIGN UP');
    final validEmail = 'valid@gmail.com';
    await tester.enterText(email, validEmail);
    await tester.tap(signUp);
    await tester.pump();

    expect(find.text('Please enter an email address.'), findsNothing);
    expect(find.text('Please enter a valid email address.'), findsNothing);
  });
}
