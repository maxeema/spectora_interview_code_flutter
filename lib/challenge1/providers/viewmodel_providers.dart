import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectora_interview_code_flutter/challenge1/viewmodel/heavy_operation_viewmodel.dart';

class ViewModelProviders {
  static final heavyOperationViewModel =
      AutoDisposeProvider(HeavyOperationViewModel.new);
}
