import 'package:injectable/injectable.dart';
import 'package:test_blocs/domain/services/token_manager.dart';

@injectable
class SaveTokens {
  final TokenManager tokenManager;

  SaveTokens(this.tokenManager);

  Future<void> call({
    required String accessToken,
    required String refreshToken,
  }) {
    return tokenManager.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
