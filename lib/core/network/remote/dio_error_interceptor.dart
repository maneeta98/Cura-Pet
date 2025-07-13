import 'package:dio/dio.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    DioException modifiedError;

    if (err.response != null) {
      final statusCode = err.response?.statusCode ?? 0;
      final serverMessage =
          err.response?.data?['message'] ?? err.response?.statusMessage;

      if (statusCode >= 500) {
        modifiedError = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: serverMessage ?? "Server error",
          type: err.type,
        );
      } else {
        modifiedError = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: serverMessage ?? "Unexpected error",
          type: err.type,
        );
      }
    } else {
      // Handle network issues or no response
      modifiedError = DioException(
        requestOptions: err.requestOptions,
        error: "No internet connection or request timeout.",
        type: DioExceptionType.unknown,
      );
    }

    // Log for debugging (optional)
    print("Dio Interceptor Caught: ${modifiedError.error}");

    return handler.next(modifiedError);
  }
}
