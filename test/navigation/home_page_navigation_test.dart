import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mito/pages/home_page.dart';
import 'package:mito/pages/registration_page.dart';
import 'package:mito/pages/login_page.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('Home Page navigation tests', () {
    NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    Future<Null> _buildHomePage(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HomePage(),
        navigatorObservers: [mockObserver],
      ));
      verify(mockObserver.didPush(any, any));
    }

    Future<Null> _navigateToRegistrationPage(WidgetTester tester) async {
      await tester.tap(find.byKey(HomePage.navigateToRegistrationButtonKey));
      await tester.pumpAndSettle();
    }

    Future<Null> _navigateToLoginPage(WidgetTester tester) async {
      await tester.tap(find.byKey(HomePage.navigateToLoginButtonKey));
      await tester.pumpAndSettle();
    }

    testWidgets(
        '''when the "navigate to Sign Up" button is tapped, should navigate to
        the registration page''', (WidgetTester tester) async {
          await _buildHomePage(tester);
          await _navigateToRegistrationPage(tester);

          verify(mockObserver.didPush(any, any));
          expect(find.byType(RegistrationPage), findsOneWidget);
          expect(find.text('Registration'), findsOneWidget);
    });

    testWidgets(
        '''when the "navigate to Login" button is tapped, should navigate to
        the login page''', (WidgetTester tester) async {
          await _buildHomePage(tester);
          await _navigateToLoginPage(tester);

          verify(mockObserver.didPush(any, any));
          expect(find.byType(LoginPage), findsOneWidget);
          expect(find.text('Login'), findsOneWidget);
    });
  });
}
