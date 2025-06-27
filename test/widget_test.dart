import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:test_blocs/domain/repositories/auth_repository.dart';
import 'package:test_blocs/domain/repositories/locale_repository.dart';
import 'package:test_blocs/domain/repositories/math_repository.dart';
import 'package:test_blocs/injection/injection.dart';

import 'package:test_blocs/main.dart';
import 'package:test_blocs/presentation/blocs/ui_message/ui_message_bloc.dart';
import 'package:test_blocs/presentation/blocs/locale/locale_bloc.dart';
import 'package:test_blocs/presentation/blocs/auth/auth_bloc.dart';
import 'package:test_blocs/presentation/blocs/math/math_bloc.dart';

import 'package:test_blocs/core/utils/api_service.dart';
import 'package:test_blocs/router/app_router.dart';

import 'test_injection.dart' as test_di;

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Setup injectable container
    await test_di.configureTestInjection();

    final authBloc = getIt<AuthBloc>();
    final uiMessageBloc = getIt<UiMessageBloc>();
    final localeRepo = getIt<LocaleRepository>();
    final mathRepo = getIt<MathRepository>();
    final localeBloc = getIt<LocaleBloc>()..add(LoadSavedLocale());
    final router = createAppRouter(authBloc);

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('vi')],
        path: 'assets/translations',
        fallbackLocale: const Locale('vi'),
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(value: getIt<ApiService>()),
            RepositoryProvider.value(value: getIt<AuthRepository>()),
            RepositoryProvider.value(value: localeRepo),
            RepositoryProvider.value(value: mathRepo),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: authBloc),
              BlocProvider.value(value: uiMessageBloc),
              BlocProvider(create: (_) => localeBloc),
              BlocProvider(create: (_) => MathBloc(mathRepository: mathRepo)),
            ],
            child: MyApp(router: router),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });
}
