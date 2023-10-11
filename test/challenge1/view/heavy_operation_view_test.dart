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

      final numberFinder = find.byKey(HeavyOperationView.numberTextKey);
      expect(numberFinder, findsOneWidget);

      // Ensure that the number text is empty by default
      expect(tester.widget<Text>(numberFinder).data, (text) => text == '');

      // Wait for the first generated number.
      // This pump() uses to make Timer.periodic() callbacks workable in tests.
      await tester.pump(HeavyOperationViewModel.timerInterval);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait until the first number populated
      await untilTrue(() {
        final number = tester.widget<Text>(numberFinder).data;
        return number!.isNotEmpty;
      });

      // Ensure that the number text is not empty anymore
      final number = tester.widget<Text>(numberFinder).data;
      expect(number, isNotNull);

      // Ensure that text is number and positive
      final intValue = int.tryParse(number!);
      expect(intValue, isA<int>());
      expect(intValue, isPositive);
    });
  });
}
