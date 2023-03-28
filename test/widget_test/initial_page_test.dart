import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/presentation/view/initial_page.dart';

void main() {
  testWidgets('InitialPage() should display the initial page',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: InitialPage(
          title: 'title',
        ),
      ),
    );
    expect(
      find.descendant(
        of: find.byType(Scaffold),
        matching: find.byType(AppBar),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(SafeArea),
        matching: find.byType(Center),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(Column),
        matching: find.byType(ElevatedButton),
      ),
      findsNWidgets(3),
    );
    expect(find.text('title'), findsOneWidget);
    expect(find.text('All movies'), findsOneWidget);
    expect(find.text('The most popular movies'), findsOneWidget);
    expect(
        find.text(
            'Movies will be shown ascending by title\n"Click to change to descending"'),
        findsOneWidget);
    final key1 = find.byKey(const Key('elevated-button-1'));
    await tester.tap(key1);
    await tester.pumpAndSettle();
    expect(
        find.text(
            'Movies will be shown descending by title\n"Click to change to ascending"'),
        findsOneWidget);
  });
}
