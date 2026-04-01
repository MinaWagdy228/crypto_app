import 'package:crypto_app/core/network/ApiConstants.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static final DioHelper _instance = DioHelper._internal();
  late final Dio _dio;

  factory DioHelper() {
    return _instance;
  }

  DioHelper._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
      ),
    );
  }

  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }
}
