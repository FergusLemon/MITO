import 'package:mito/main.dart';
import 'package:mito/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Renders content", (WidgetTester tester) async {
    await tester.pumpWidget(MitoRootWidget());

    expect(find.text('Welcome to MITO'), findsOneWidget);
    expect(find.text('Help Those Around You'), findsOneWidget);
    expect(find.byType(RaisedButton), findsNWidgets(2));
  });
}
