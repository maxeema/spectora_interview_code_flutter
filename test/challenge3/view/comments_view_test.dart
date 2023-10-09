import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectora_interview_code_flutter/challenge3/view/comments_view.dart';

import '../../test_helpers.dart';

void main() {
  group('CommentsView', () {
    testWidgets('When tap on FAB it adds a new comment to the ListView',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CommentsView(),
          ),
        ),
      );

      expect(find.byType(ListView), findsOneWidget);

      expect(find.byType(FloatingActionButton), findsOneWidget);

      final listViewFind = find.byType(ListView);
      var childrenDelegate = tester
          .widget<ListView>(listViewFind)
          .childrenDelegate as SliverChildBuilderDelegate;

      expect(childrenDelegate.childCount, 0);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      childrenDelegate = tester.widget<ListView>(listViewFind).childrenDelegate
          as SliverChildBuilderDelegate;

      expect(childrenDelegate.childCount, 1);

      // final textFinder = find.byKey(HeavyOperationView.numberTextKey);
      // expect(textFinder, findsOneWidget);

      // // Wait until the first number text populated
      // await untilTrue(() {
      //   final text = tester.widget<Text>(textFinder).data;
      //   return text != '';
      // });

      // // Ensure that text is not empty
      // final text = tester.widget<Text>(textFinder).data;
      // expect(text, isNotNull);

      // // Ensure that text is number and positive
      // final number = int.tryParse(text!);
      // expect(number, isA<int>());
      // expect(number, isPositive);
    });
  });
}
