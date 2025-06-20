import 'package:dio/dio.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      // If status code is 500 or above, use server error message if available
      if (err.response!.statusCode != null &&
          err.response!.statusCode! >= 500) {
        err = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error:
              err.response!.data?['message'] ??
              err.response!.statusMessage ??
              "Server error",
          type: err.type,
        );
      } else {
        // For other errors with response (like 4xx), keep original or customize here
        err = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error:
              err.response!.data?['message'] ??
              err.response!.statusMessage ??
              "Error occurred",
          type: err.type,
        );
      }
    } else {
      // Handle no response, usually network or connection errors
      err = DioException(
        requestOptions: err.requestOptions,
        error: "Connection error. Please check your internet connection.",
        type: err.type,
      );
    }

    // Pass the modified error to the next handler
    super.onError(err, handler);
  }
}
