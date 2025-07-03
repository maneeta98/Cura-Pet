import 'package:cura_pet/app/constant/remote/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dio_error_interceptor.dart'; // Since it's in the same remote folder

class ApiService {
  final Dio _dio;

  Dio get dio => _dio;

  ApiService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      }
      ..interceptors.addAll([
        DioErrorInterceptor(),
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      ]);
  }
}
