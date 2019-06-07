import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mito/inherited_auth.dart';
import 'package:mito/pages/home_page.dart';
import '../mocks/auth_mock.dart';
import '../mocks/user_state_mock.dart';

void main() {
  final authMock = AuthMock();
  final userStateMock = UserStateMock();
  when(userStateMock.isSignedIn()).thenReturn(true);

  Future<Null> _buildHomePage(WidgetTester tester) async {
    Widget app = InheritedAuth(
        auth: authMock,
        userState: userStateMock,
        child: MaterialApp(
          home: HomePage(),
          ),
      );
    await tester.pumpWidget(app);
  }

  testWidgets("Renders content", (WidgetTester tester) async {
    await _buildHomePage(tester);
    expect(find.text('Home'), findsOneWidget);
  });
}
