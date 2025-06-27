import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:test_blocs/data/datasources/auth/auth_local_data_source.dart';
import 'package:test_blocs/data/datasources/auth/auth_remote_data_source.dart';
import 'package:test_blocs/domain/entities/auth/user_entity.dart';
import 'package:test_blocs/models/user_model.dart';
import 'package:test_blocs/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImpl({required this.remote, required this.local});

  @override
  Future<String?> getValidAccessToken() async {
    String? accessToken = await local.getAccessToken();

    if (accessToken != null && JwtDecoder.isExpired(accessToken)) {
      accessToken = await refreshAccessToken();
    }

    if (accessToken != null && !JwtDecoder.isExpired(accessToken)) {
      return accessToken;
    }

    return null;
  }

  @override
  Future<String?> refreshAccessToken() async {
    final refreshToken = await local.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return null;

    try {
      final response = await remote.refreshToken(refreshToken);
      final accessToken = response['accessToken'];
      final newRefreshToken = response['refreshToken'];

      if (accessToken != null && newRefreshToken != null) {
        await local.saveTokens(
          accessToken: accessToken,
          refreshToken: newRefreshToken,
        );
        return accessToken;
      }
    } catch (_) {}

    return null;
  }

  @override
  Future<void> clearTokens() => local.clearTokens();

  @override
  Future<Map<String, dynamic>> login(String username, String password) {
    return remote.login(username, password);
  }

  @override
  Future<UserEntity> fetchUser() async {
    final response = await remote.getProfile();
    return UserModel.fromJson(response);
  }
}
