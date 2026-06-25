import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/pages/calendar.dart';

void main() {
  testWidgets('shows the synced events section on the calendar page', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AppCalendar()));
    await tester.pump();

    expect(find.byType(CalendarDatePicker), findsOneWidget);
    expect(find.text('Events from your calendars'), findsOneWidget);
    expect(find.text('Refresh events'), findsOneWidget);
  });
}
