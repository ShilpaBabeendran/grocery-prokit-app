import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_app/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const GroceryApp());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}