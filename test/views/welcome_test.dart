import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:midowe_app/views/welcome_view.dart';

Widget createWelcomeView() => WelcomeView();

void main() {
  group('Welcome view tests', () {
    testWidgets('Test if hero image shows up', (tester) async {
      await tester.pumpWidget(createWelcomeView());
    });
  });
}
