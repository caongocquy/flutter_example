import 'package:test_blocs/domain/entities/auth/user_entity.dart';

abstract class AuthRepository {
  Future<String?> getValidAccessToken();
  Future<String?> refreshAccessToken();
  Future<void> clearTokens();
  Future<Map<String, dynamic>> login(String username, String password);
  Future<UserEntity> fetchUser();
}
