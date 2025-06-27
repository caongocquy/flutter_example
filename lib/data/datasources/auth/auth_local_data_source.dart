import 'package:injectable/injectable.dart';
import 'package:test_blocs/domain/services/token_manager.dart';
import 'package:test_blocs/injection/injection.dart';

@injectable
class AuthLocalDataSource {
  final tokenManager = getIt<TokenManager>();
  Future<String?> getAccessToken() => tokenManager.getAccessToken();

  Future<String?> getRefreshToken() => tokenManager.getRefreshToken();

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) {
    return tokenManager.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Future<void> clearTokens() => tokenManager.clearTokens();
}
