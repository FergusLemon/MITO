import 'package:mito/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Renders content", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Welcome to MITO'), findsOneWidget);
  });
}
