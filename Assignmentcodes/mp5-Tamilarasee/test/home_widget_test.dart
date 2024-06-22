import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/views/home.dart';

Widget createHomeScreen() => const MaterialApp(
      home: Home(),
    );

void main() {
  group('Home Page Widget Tests', () {

    testWidgets('Test - Search icon', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byIcon(Icons.search), findsWidgets);
    });

      testWidgets('Test - Refresh icon', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byIcon(Icons.refresh), findsWidgets);
    });

  });
}
