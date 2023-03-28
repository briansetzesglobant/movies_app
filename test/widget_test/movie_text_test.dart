import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/presentation/widget/movie_text.dart';

void main() {
  testWidgets('MovieText() should display the movie text',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MovieText(
          text: 'text',
        ),
      ),
    );
    expect(
      find.descendant(
        of: find.byType(Center),
        matching: find.byType(Padding),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(Padding),
        matching: find.byType(Text),
      ),
      findsOneWidget,
    );
    expect(find.text('text'), findsOneWidget);
  });
}
