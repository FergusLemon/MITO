import 'package:mito/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MaterialApp app = MaterialApp(
      home: RegistrationPage(),
  );

  testWidgets("Renders content", (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.text('Registration'), findsOneWidget);
  });
}
