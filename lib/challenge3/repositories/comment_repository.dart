import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:spectora_interview_code_flutter/challenge3/models/comment.dart';

class CommentRepository {
  late final List<Comment> _comments;

  init() async {
    String data = await rootBundle.loadString("assets/data/comments.json");
    final jsonResult = List<Map<String, dynamic>>.from(json.decode(data));

    _comments = List.from(jsonResult.map((e) => Comment.fromJson(e)));
  }

  Future<Comment> getRandom() async {
    final randomIndex = Random().nextInt(_comments.length);
    return _comments[randomIndex];
  }
}
