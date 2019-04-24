import 'package:mito/forms/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MaterialApp app = MaterialApp(
      home: Scaffold(
          body: SingleChildScrollView(
              child: LoginForm(),
          ),
      ),
  );

  testWidgets('Renders', (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(RaisedButton), findsOneWidget);
  });
}
