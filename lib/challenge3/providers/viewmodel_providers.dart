import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectora_interview_code_flutter/challenge3/repositories/comments_repository.dart';
import 'package:spectora_interview_code_flutter/challenge3/viewmodel/comments_viewmodel.dart';

class ViewModelProviders {
  static final commentsViewModel =
      AutoDisposeProvider((ref) => CommentsViewModel(ref));

  static final commentsRepositoryProvider =
      Provider((ref) => CommentsRepository());
}
