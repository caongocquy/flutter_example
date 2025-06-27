// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:test_blocs/core/utils/api_service.dart' as _i305;
import 'package:test_blocs/data/datasources/auth/auth_local_data_source.dart'
    as _i243;
import 'package:test_blocs/data/datasources/auth/auth_remote_data_source.dart'
    as _i653;
import 'package:test_blocs/data/datasources/locale/locale_local_data_source.dart'
    as _i481;
import 'package:test_blocs/data/datasources/locale/shared_prefs_locale_data_source.dart'
    as _i379;
import 'package:test_blocs/data/repositories/auth_repository.dart' as _i28;
import 'package:test_blocs/data/repositories/locale_repository.dart' as _i558;
import 'package:test_blocs/data/repositories/math_repository.dart' as _i624;
import 'package:test_blocs/data/services/secure_token_manager.dart' as _i769;
import 'package:test_blocs/domain/repositories/auth_repository.dart' as _i731;
import 'package:test_blocs/domain/repositories/locale_repository.dart' as _i648;
import 'package:test_blocs/domain/repositories/math_repository.dart' as _i120;
import 'package:test_blocs/domain/services/token_manager.dart' as _i1004;
import 'package:test_blocs/domain/usecases/auth/auth_usecases.dart' as _i953;
import 'package:test_blocs/domain/usecases/auth/clear_tokens.dart' as _i1065;
import 'package:test_blocs/domain/usecases/auth/fetch_user.dart' as _i274;
import 'package:test_blocs/domain/usecases/auth/get_valid_access_token.dart'
    as _i1071;
import 'package:test_blocs/domain/usecases/auth/login_with_email_and_password.dart'
    as _i610;
import 'package:test_blocs/domain/usecases/auth/save_tokens.dart' as _i1013;
import 'package:test_blocs/domain/usecases/locale/load_locale.dart' as _i605;
import 'package:test_blocs/domain/usecases/locale/save_locale.dart' as _i525;
import 'package:test_blocs/injection/network_module.dart' as _i79;
import 'package:test_blocs/injection/storage_module.dart' as _i331;
import 'package:test_blocs/presentation/blocs/auth/auth_bloc.dart' as _i217;
import 'package:test_blocs/presentation/blocs/locale/locale_bloc.dart' as _i912;
import 'package:test_blocs/presentation/blocs/math/math_bloc.dart' as _i565;
import 'package:test_blocs/presentation/blocs/ui_message/ui_message_bloc.dart'
    as _i848;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final storageModule = _$StorageModule();
    final registerModule = _$RegisterModule();
    gh.factory<_i243.AuthLocalDataSource>(() => _i243.AuthLocalDataSource());
    gh.factory<_i848.UiMessageBloc>(() => _i848.UiMessageBloc());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.provideSecureStorage(),
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i481.LocaleLocalDataSource>(
      () => _i379.SharedPrefsLocaleDataSource(),
    );
    gh.lazySingleton<_i648.LocaleRepository>(
      () => _i558.LocaleRepositoryImpl(gh<_i481.LocaleLocalDataSource>()),
    );
    gh.lazySingleton<_i120.MathRepository>(() => _i624.MathRepositoryImpl());
    gh.factory<_i565.MathBloc>(
      () => _i565.MathBloc(mathRepository: gh<_i120.MathRepository>()),
    );
    gh.lazySingleton<_i1004.TokenManager>(
      () => _i769.SecureTokenManager(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i1013.SaveTokens>(
      () => _i1013.SaveTokens(gh<_i1004.TokenManager>()),
    );
    gh.lazySingleton<_i305.ApiService>(
      () => registerModule.provideApiService(gh<_i1004.TokenManager>()),
    );
    gh.factory<_i605.LoadLocale>(
      () => _i605.LoadLocale(gh<_i648.LocaleRepository>()),
    );
    gh.factory<_i525.SaveLocale>(
      () => _i525.SaveLocale(gh<_i648.LocaleRepository>()),
    );
    gh.factory<_i912.LocaleBloc>(
      () => _i912.LocaleBloc(
        loadLocale: gh<_i605.LoadLocale>(),
        saveLocale: gh<_i525.SaveLocale>(),
      ),
    );
    gh.factory<_i653.AuthRemoteDataSource>(
      () => _i653.AuthRemoteDataSource(apiService: gh<_i305.ApiService>()),
    );
    gh.lazySingleton<_i731.AuthRepository>(
      () => _i28.AuthRepositoryImpl(
        remote: gh<_i653.AuthRemoteDataSource>(),
        local: gh<_i243.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i1065.ClearTokens>(
      () => _i1065.ClearTokens(gh<_i731.AuthRepository>()),
    );
    gh.factory<_i274.FetchUser>(
      () => _i274.FetchUser(gh<_i731.AuthRepository>()),
    );
    gh.factory<_i610.LoginWithEmailAndPassword>(
      () => _i610.LoginWithEmailAndPassword(gh<_i731.AuthRepository>()),
    );
    gh.factory<_i1071.GetValidAccessToken>(
      () => _i1071.GetValidAccessToken(gh<_i731.AuthRepository>()),
    );
    gh.factory<_i953.AuthUseCases>(
      () => _i953.AuthUseCases(
        getValidAccessToken: gh<_i1071.GetValidAccessToken>(),
        loginWithEmailAndPassword: gh<_i610.LoginWithEmailAndPassword>(),
        clearTokens: gh<_i1065.ClearTokens>(),
        fetchUser: gh<_i274.FetchUser>(),
        saveTokens: gh<_i1013.SaveTokens>(),
      ),
    );
    gh.factory<_i217.AuthBloc>(
      () => _i217.AuthBloc(
        uiMessageBloc: gh<_i848.UiMessageBloc>(),
        authUseCases: gh<_i953.AuthUseCases>(),
      ),
    );
    return this;
  }
}

class _$StorageModule extends _i331.StorageModule {}

class _$RegisterModule extends _i79.RegisterModule {}
