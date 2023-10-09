import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectora_interview_code_flutter/challenge1/providers/viewmodel_providers.dart';

class HeavyOperationView extends HookConsumerWidget {
  const HeavyOperationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ViewModelProviders.heavyOperationViewModel);

    // NOTE: This is just a hook so we can call the init method only once and not
    // every time the widget is rebuilt.
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel.init();
      });
      return;
    }, [viewModel]);

    final value = ref.watch(viewModel.valueProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '$value',
                key: const ValueKey('random-generated-number-text'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
