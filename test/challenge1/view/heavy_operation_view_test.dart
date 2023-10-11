import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:spectora_interview_code_flutter/challenge1/view/heavy_operation_view.dart';
import 'package:spectora_interview_code_flutter/challenge1/viewmodel/heavy_operation_viewmodel.dart';

import '../../test_helpers.dart';

void main() {
  group('HeavyOperationView', () {
    testWidgets(
        'Ensure UI elements presented and the first generated number appears',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HeavyOperationView(),
          ),
        ),
      );

      final textFinder = find.byKey(HeavyOperationView.numberTextKey);
      expect(textFinder, findsOneWidget);

      // Ensure that text is empty by default
      expect(tester.widget<Text>(textFinder).data, (text) => text == '');

      // Wait for the first generated number.
      // This pump() uses to make Timer.periodic() callbacks workable in tests.
      await tester.pump(HeavyOperationViewModel.timerInterval);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait until the first number populated
      await untilTrue(() {
        final text = tester.widget<Text>(textFinder).data;
        return text != '';
      });

      // Ensure that text now is not empty
      final text = tester.widget<Text>(textFinder).data;
      expect(text, isNotNull);

      // Ensure that text is number and positive
      final number = int.tryParse(text!);
      expect(number, isA<int>());
      expect(number, isPositive);
    });
  });
}
