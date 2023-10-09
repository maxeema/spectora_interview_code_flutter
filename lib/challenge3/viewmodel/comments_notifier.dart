import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectora_interview_code_flutter/challenge3/models/comment.dart';

class CommentsNotifier extends StateNotifier<List<Comment>> {
  CommentsNotifier() : super([]);

  void set(List<Comment> data) {
    state = data;
  }

  void add(Comment comment) {
    state = [...state, comment];
  }
}
