enum NetworkExceptionType {
  connectTimeout,

  sendTimeout,

  receiveTimeout,

  response,

  cancel,

  other,
}

class NetworkException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  final int statusCode;
  final NetworkExceptionType type;
  final dynamic data;

  NetworkException(
    this.message,
    this.data, {
    this.stackTrace,
    required this.statusCode,
    this.type = NetworkExceptionType.other,
  });
}
