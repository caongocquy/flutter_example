import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:test_blocs/domain/services/token_manager.dart';
import 'package:test_blocs/core/utils/api_service.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio() => Dio(); // optional

  @lazySingleton
  ApiService provideApiService(TokenManager tokenManager) =>
      ApiService(tokenManager: tokenManager);
}
