import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets('Find column widget', (WidgetTester tester) async {
    final columnFinder = find.byType(Column);

    await tester.pumpWidget(_makeTestableWidget(AboutPage()));

    expect(columnFinder, findsOneWidget);
  });
}
