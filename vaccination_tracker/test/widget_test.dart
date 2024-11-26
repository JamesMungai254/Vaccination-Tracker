import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vaccination_tracker/main.dart'; // Make sure this points to the correct path

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VaccinationTrackerApp());

    // Verify that our counter starts at 0.
    expect(find.text('Counter: 0'), findsOneWidget); // Adjusted to match the counter label
    expect(find.text('Counter: 1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add)); // Tap the icon button
    await tester.pump(); // Rebuild the widget after the state change

    // Verify that our counter has incremented.
    expect(find.text('Counter: 0'), findsNothing); // No longer finds '0'
    expect(find.text('Counter: 1'), findsOneWidget); // Finds '1'
  });
}
