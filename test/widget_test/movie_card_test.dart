import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/presentation/widget/movie_card.dart';

void main() {
  testWidgets('MovieCard() should display the movie card',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MovieCard(
          title: 'title',
          image:
              'https://image.tmdb.org/t/p/w185/8LpnMIqpRiwxpbGR33ALCmVl7gj.jpg',
        ),
      ),
    );
    expect(
      find.descendant(
        of: find.byType(Column),
        matching: find.byType(Text),
      ),
      findsOneWidget,
    );
    expect(find.text('title'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(Column),
        matching: find.byType(Expanded),
      ),
      findsOneWidget,
    );
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });
}
