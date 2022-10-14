import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:midowe_app/screens/welcome_screen.dart';

Widget createWelcomeView() => WelcomeScreen();

void main() {
  group('Welcome view tests', () {
    testWidgets('Test if hero image shows up', (tester) async {
      await tester.pumpWidget(createWelcomeView());
    });
  });
}
