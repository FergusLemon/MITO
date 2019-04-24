import 'package:mito/pages/login_page.dart';
import 'package:mito/forms/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MaterialApp app = MaterialApp(
      home: LoginPage(),
  );

  testWidgets("Renders content", (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(LoginForm), findsOneWidget);
  });
}
