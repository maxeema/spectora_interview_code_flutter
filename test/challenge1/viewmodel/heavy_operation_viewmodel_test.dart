// ignore_for_file: depend_on_referenced_packages

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

      // This pump() uses to make Timer.periodic() callbacks workable in tests.
      await tester.pump(HeavyOperationViewModel.timerInterval);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      final textFinder = find.byKey(HeavyOperationView.numberTextKey);
      expect(textFinder, findsOneWidget);

      // Wait until the first number text populated
      await untilTrue(() {
        final text = tester.widget<Text>(textFinder).data;
        return text != '';
      });

      // Ensure that text is not empty
      final text = tester.widget<Text>(textFinder).data;
      expect(text, isNotNull);

      // Ensure that text is number and positive
      final number = int.tryParse(text!);
      expect(number, isA<int>());
      expect(number, isPositive);
    });
  });
}
