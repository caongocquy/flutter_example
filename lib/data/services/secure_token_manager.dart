import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:test_blocs/domain/services/token_manager.dart';

@LazySingleton(as: TokenManager)
class SecureTokenManager implements TokenManager {
  final FlutterSecureStorage _storage;

  SecureTokenManager(this._storage);

  @override
  Future<String?> getAccessToken() => _storage.read(key: 'accessToken');

  @override
  Future<String?> getRefreshToken() => _storage.read(key: 'refreshToken');

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  @override
  Future<void> clearTokens() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
  }
}
