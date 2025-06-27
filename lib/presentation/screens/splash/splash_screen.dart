import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_blocs/presentation/blocs/auth/auth_bloc.dart';
import 'package:test_blocs/core/constants/transition_type.dart';
import 'package:test_blocs/router/router.dart';
import 'package:test_blocs/core/utils/router_helpers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<AuthBloc>();
    _checkAuth();
  }

  void _checkAuth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final state = bloc.state;

      if (state is AuthAuthenticated) {
        goWithTransition(context, AppRoute.home.path, TransitionType.fade);
      } else {
        goWithTransition(context, AppRoute.login.path, TransitionType.fade);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(child: const CircularProgressIndicator()),
      ),
    );
  }
}
