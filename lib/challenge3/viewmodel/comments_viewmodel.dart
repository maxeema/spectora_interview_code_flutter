import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectora_interview_code_flutter/challenge3/models/comment.dart';
import 'package:spectora_interview_code_flutter/challenge3/providers/viewmodel_providers.dart';

import 'comments_notifier.dart';

class CommentsViewModel {
  static const timerInterval = Duration(milliseconds: 1000);

  final Ref ref;

  final valueProvider = StateNotifierProvider<CommentsNotifier, List<Comment>>(
      (ref) => CommentsNotifier());

  CommentsViewModel(this.ref);

  late final repository =
      ref.read(ViewModelProviders.commentsRepositoryProvider);

  init() {
    repository.init();
  }

  Future<Comment?> loadRandom() async {
    final comment = await repository.getRandom();
    if (comment != null) {
      ref.read(valueProvider.notifier).add(comment);
    }
    return comment;
  }

  void dispose() {
    //
  }
}
