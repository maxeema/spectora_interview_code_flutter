import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:spectora_interview_code_flutter/challenge3/models/comment.dart';
import 'package:spectora_interview_code_flutter/challenge3/providers/viewmodel_providers.dart';
import 'package:spectora_interview_code_flutter/challenge3/repositories/comments_repository.dart';
import 'package:spectora_interview_code_flutter/challenge3/view/comments_view.dart';

import '../../test_helpers.dart';

void main() {
  group('CommentsView', () {
    late ProviderContainer providerContainer;

    setUpAll(() {
      providerContainer = ProviderContainer();
    });

    tearDownAll(() {
      providerContainer.dispose();
    });

    final listFinder = find.byType(ListView);
    final fabFinder = find.byType(FloatingActionButton);

    testWidgets('when tap FAB a new comment added to the ListView',
        (WidgetTester tester) async {
      const mockComment = Comment(
          id: '000',
          value: 0.12345,
          name: 'Mock Comment 1',
          description: 'Mock Desc. 1');

      final mockRepository = MockCommentsRepository();
      when(() => mockRepository.getRandom())
          .thenAnswer((_) => Future.value(mockComment));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ViewModelProviders.commentsRepositoryProvider
                .overrideWithValue(mockRepository)
          ],
          child: const MaterialApp(
            home: CommentsView(),
          ),
        ),
      );

      expect(fabFinder, findsOneWidget);

      expect(listFinder, findsNothing);

      // Tap on Floating Action Button to add mock comment to ListView
      await tester.tap(fabFinder);

      await tester.waitFor(listFinder);

      // Ensures auto-scrolling to the new comment animation completed.
      await tester.pumpAndSettle();

      // Ensures mock comment added to the ListView
      final childrenDelegate = tester
          .widget<ListView>(listFinder)
          .childrenDelegate as SliverChildBuilderDelegate;

      expect(childrenDelegate.childCount, 1);
      expect(find.text(mockComment.value.toString()), findsOneWidget);
      expect(find.text(mockComment.name), findsOneWidget);
      expect(find.text(mockComment.description), findsOneWidget);
    });
  });
}

class MockCommentsRepository extends Mock implements CommentsRepository {}
