import 'package:test_blocs/presentation/blocs/auth/auth_bloc.dart';
import 'package:test_blocs/router/router.dart';

String? authGuard(String location, AuthState state) {
  final isLoggingIn = location == AppRoute.login.path;

  if (state is AuthUnauthenticated && !isLoggingIn) {
    return AppRoute.login.path;
  }

  if (state is AuthAuthenticated && isLoggingIn) {
    return AppRoute.home.path;
  }

  return null;
}
