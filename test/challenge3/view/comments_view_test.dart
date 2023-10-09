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

    testWidgets('When tap on FAB it adds new comment to the ListView',
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

      expect(find.byType(ListView), findsOneWidget);

      expect(find.byType(FloatingActionButton), findsOneWidget);

      final listViewFind = find.byType(ListView);
      var childrenDelegate = tester
          .widget<ListView>(listViewFind)
          .childrenDelegate as SliverChildBuilderDelegate;

      // Ensures mock that ListView is empty without mock comment
      expect(childrenDelegate.childCount, 0);
      expect(find.text(mockComment.value.toString()), findsNothing);
      expect(find.text(mockComment.name), findsNothing);
      expect(find.text(mockComment.description), findsNothing);

      // Tap on Floating Action Button to add mock comment to ListView
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Ensures mock comment added to the ListView
      childrenDelegate = tester.widget<ListView>(listViewFind).childrenDelegate
          as SliverChildBuilderDelegate;
      expect(childrenDelegate.childCount, 1);
      expect(find.text(mockComment.value.toString()), findsOneWidget);
      expect(find.text(mockComment.name), findsOneWidget);
      expect(find.text(mockComment.description), findsOneWidget);
    });
  });
}

class MockCommentsRepository extends Mock implements CommentsRepository {}
