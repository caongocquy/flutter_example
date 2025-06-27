import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_blocs/core/constants/transition_type.dart';

void goWithTransition(BuildContext context, String path, TransitionType type) {
  context.go(path, extra: type);
}

void pushWithTransition(
  BuildContext context,
  String path,
  TransitionType type,
) {
  context.push(path, extra: type);
}
