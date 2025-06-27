import 'package:injectable/injectable.dart';
import 'package:test_blocs/core/utils/api_service.dart';

@injectable
class AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSource({required this.apiService});

  Future<Map<String, dynamic>> login(String username, String password) {
    return apiService.post(
      'auth/login',
      data: {'username': username, 'password': password},
    );
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) {
    return apiService.post(
      'auth/refresh',
      data: {'refreshToken': refreshToken},
    );
  }

  Future<Map<String, dynamic>> getProfile() {
    return apiService.get('auth/me');
  }
}
