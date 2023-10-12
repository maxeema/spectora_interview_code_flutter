import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:spectora_interview_code_flutter/challenge1/view/heavy_operation_view.dart';

import '../../test_helpers.dart';

void main() {
  final numberFinder = find.byKey(HeavyOperationView.numberTextKey);
  final progressFinder = find.byType(CircularProgressIndicator);

  group('HeavyOperationView', () {
    testWidgets('ensure the first generated number appears',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HeavyOperationView(),
          ),
        ),
      );

      expect(progressFinder, findsOneWidget);
      expect(numberFinder, findsOneWidget);

      expect(tester.widget<Text>(numberFinder).data, (text) => text == '');

      await tester.untilTrue(
        () => tester.widget<Text>(numberFinder).data != '',
      );

      final number = tester.widget<Text>(numberFinder).data;
      expect(number, isNotNull);

      final intValue = int.tryParse(number!);
      expect(intValue, isA<int>());
      expect(intValue, isPositive);
    });
  });
}
