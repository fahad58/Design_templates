// This is a basic Flutter widget test for the document scanner.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:imagepickerdemoflutter/main.dart';

void main() {
  testWidgets('Document scanner screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the document scanner screen loads correctly
    expect(find.text('Document Scanner'), findsOneWidget);
    expect(find.text('Scan Document'), findsOneWidget);
    expect(find.text('No text scanned yet'), findsOneWidget);

    // Verify button is clickable
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
