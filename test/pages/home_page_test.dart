import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mito/inherited_user_services.dart';
import 'package:mito/pages/home_page.dart';
import '../mocks/auth_mock.dart';
import '../mocks/user_status_mock.dart';

void main() {
  final authMock = AuthMock();
  final userStatusMock = UserStatusMock();
  when(userStatusMock.isSignedIn()).thenReturn(true);

  Future<Null> _buildHomePage(WidgetTester tester) async {
    Widget app = InheritedUserServices(
        auth: authMock,
        userStatus: userStatusMock,
        child: MaterialApp(
          home: HomePage(),
          ),
      );
    await tester.pumpWidget(app);
  }

  testWidgets("Renders content", (WidgetTester tester) async {
    await _buildHomePage(tester);
    expect(find.text('Home'), findsOneWidget);
    expect(find.byType(IconButton),findsNWidgets(3));
  });
}
