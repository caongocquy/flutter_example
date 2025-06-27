import 'package:dio/dio.dart';
import 'package:test_blocs/core/utils/api_config.dart';
import 'package:test_blocs/domain/services/token_manager.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() =>
      'ApiException(statusCode: $statusCode, message: $message)';
}

class ApiService {
  final Dio _dio;
  final TokenManager tokenManager;
  void Function()? onUnauthorized; // 👈 gán sau

  ApiService({required this.tokenManager})
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await tokenManager.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            final refreshed = await _refreshToken();
            if (refreshed) {
              final retryToken = await tokenManager.getAccessToken();
              final request = e.requestOptions;
              request.headers['Authorization'] = 'Bearer $retryToken';
              final cloned = await _dio.fetch(request);
              return handler.resolve(cloned);
            } else {
              await tokenManager.clearTokens();
              onUnauthorized?.call(); // 👈 callback
            }
          }
          handler.next(e);
        },
      ),
    );
  }

  Future<bool> _refreshToken() async {
    final refreshToken = await tokenManager.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      final res = await _dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      if (res.statusCode == 200 && res.data['accessToken'] != null) {
        await tokenManager.saveTokens(
          accessToken: res.data['accessToken'],
          refreshToken: res.data['refreshToken'],
        );
        return true;
      }
    } catch (_) {}
    return false;
  }

  // Request helper methods
  Future<Map<String, dynamic>> request(
    String method,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method, headers: headers),
      );

      if (response.statusCode! < 500) {
        if (response.data is Map<String, dynamic>) {
          return response.data;
        } else {
          throw ApiException('Response data không đúng định dạng');
        }
      } else {
        throw ApiException(
          'Lỗi server: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw ApiException(
          e.response?.data['message'] ??
              'Lỗi server: ${e.response?.statusCode}',
          statusCode: e.response?.statusCode,
        );
      } else {
        throw ApiException('Lỗi kết nối hoặc timeout: ${e.message}');
      }
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) =>
      request('GET', path, queryParameters: queryParameters, headers: headers);

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) => request('POST', path, data: data, headers: headers);

  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) => request('PUT', path, data: data, headers: headers);

  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) => request('DELETE', path, data: data, headers: headers);
}
