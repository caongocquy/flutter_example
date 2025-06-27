import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_blocs/presentation/blocs/auth/auth_bloc.dart';
import 'package:test_blocs/core/constants/transition_type.dart';
import 'package:test_blocs/router/router.dart';
import 'package:test_blocs/presentation/screens/auth/login_screen.dart';
import 'package:test_blocs/presentation/screens/home/home_screen.dart';
import 'package:test_blocs/presentation/screens/splash/splash_screen.dart';
import 'package:test_blocs/core/utils/navigation_helper.dart';

import 'auth_guard.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

GoRouter createAppRouter(AuthBloc authBloc) {
  return GoRouter(
    initialLocation: AppRoute.splashScreen.path,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) =>
        authGuard(state.fullPath ?? '', authBloc.state),
    routes: [
      GoRoute(
        path: AppRoute.splashScreen.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoute.login.path,
        pageBuilder: (context, state) {
          final extra = state.extra;
          final type = extra is TransitionType ? extra : TransitionType.fade;

          return transitionPage(
            child: const LoginScreen(),
            state: state,
            type: type,
          );
        },
      ),
      GoRoute(
        path: AppRoute.home.path,
        pageBuilder: (context, state) {
          final extra = state.extra;
          final type = extra is TransitionType ? extra : TransitionType.fade;

          return transitionPage(
            child: const MyHomePage(title: 'Home'),
            state: state,
            type: type,
          );
        },
      ),
    ],
  );
}
