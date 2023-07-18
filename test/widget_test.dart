import 'package:flutter/material.dart';
import 'package:flutter_intergration_test/home_screen.dart';
import 'package:flutter_intergration_test/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('end-to-end test', () {
    testWidgets('Successful Login Navigates To Home Page',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
      // Enter valid credentials into the login form.
      await tester.enterText(
          find.byKey(const Key('usernameField')), 'valid_username');
      await tester.enterText(
          find.byKey(const Key('passwordField')), 'saja12345a');
      await Future.delayed(const Duration(seconds: 2));
      // Tap the login button.
      await tester.tap(find.byKey(const Key('loginButton')));

      // Rebuild the widget tree.
      await tester.pumpAndSettle();

      // Verify that we have navigated to the home page.
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Failed Login Invalid Password', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
      // Enter valid credentials into the login form.
      final passwordField = find.byKey(const Key('passwordField'));
      await tester.enterText(
          find.byKey(const Key('usernameField')), 'valid_username');
      await tester.enterText(find.byKey(const Key('passwordField')), 'short');

      // Trigger the validation by removing focus from the field.
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // Wait for the app to settle after the validation.
      await tester.pumpAndSettle();

      // Get the TextFormField widget from the finder.
      final formField = tester.widget<TextFormField>(passwordField);

      // Call the validator function directly to get the validation error message.
      final errorMessage = formField.validator!.call('short');
      // Tap the login button.
      await tester.tap(find.byKey(const Key('loginButton')));

      // Verify that the validation error message matches the expected message.
      expect(errorMessage, 'Enter Valid Password,at least 8 characters');
    });

    testWidgets('Failed Login Invalid Username', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      final userNameFinder = find.byKey(const Key('usernameField'));

      await tester.enterText(userNameFinder, '');

      await tester.enterText(
          find.byKey(const Key('passwordField')), 'saja1234S');

      await tester.testTextInput.receiveAction(TextInputAction.done);

      await tester.pumpAndSettle();

      final userNameField = tester.widget<TextFormField>(userNameFinder);

      final errorMessage = userNameField.validator!.call('');

      await tester.tap(find.byKey(const Key('loginButton')));

      expect(errorMessage, 'Please enter your username');
    });
  });
}
