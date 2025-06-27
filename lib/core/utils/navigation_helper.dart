import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_blocs/core/constants/transition_type.dart';

CustomTransitionPage transitionPage({
  required Widget child,
  required GoRouterState state,
  required TransitionType type,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (type) {
        case TransitionType.fade:
          return FadeTransition(
            opacity: animation.drive(
              Tween(
                begin: 0.0,
                end: 1.0,
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        case TransitionType.slide:
          return SlideTransition(
            position: animation.drive(
              Tween(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        case TransitionType.scale:
          return ScaleTransition(
            scale: animation.drive(
              Tween(
                begin: 0.0,
                end: 1.0,
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        default:
          return child;
      }
    },
  );
}
