import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';

import 'package:test_blocs/presentation/blocs/auth/auth_bloc.dart';
import 'package:test_blocs/presentation/blocs/locale/locale_bloc.dart';
import 'package:test_blocs/presentation/blocs/math/math_bloc.dart';
import 'package:test_blocs/presentation/blocs/ui_message/ui_message_bloc.dart';
import 'package:test_blocs/core/utils/api_service.dart';
import 'package:test_blocs/domain/repositories/auth_repository.dart';
import 'package:test_blocs/domain/repositories/locale_repository.dart';
import 'package:test_blocs/domain/repositories/math_repository.dart';
import 'package:test_blocs/injection/injection.dart';

import 'package:test_blocs/router/app_router.dart';
import 'package:test_blocs/presentation/widgets/ui_message_listener.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();
  final localeRepository = getIt<LocaleRepository>();
  final mathRepository = getIt<MathRepository>();
  final authRepository = getIt<AuthRepository>();
  final uiMessageBloc = UiMessageBloc();
  final localeBloc = getIt<LocaleBloc>()..add(LoadSavedLocale());
  final mathBloc = getIt<MathBloc>();
  final authBloc = getIt<AuthBloc>()..add(AuthStarted());
  getIt<ApiService>().onUnauthorized = () => authBloc.add(AuthLoggedOut());
  final appRouter = createAppRouter(authBloc);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: const Locale('vi'),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<LocaleRepository>(create: (_) => localeRepository),
          RepositoryProvider<AuthRepository>(create: (_) => authRepository),
          RepositoryProvider<MathRepository>(create: (_) => mathRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<UiMessageBloc>.value(value: uiMessageBloc),
            BlocProvider<LocaleBloc>.value(value: localeBloc),
            BlocProvider<AuthBloc>.value(value: authBloc),
            BlocProvider<MathBloc>.value(value: mathBloc),
          ],
          child: MyApp(router: appRouter),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: UiMessageListener(
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          routerConfig: router,
        ),
      ),
    );
  }
}
