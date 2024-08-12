class StudentException implements Exception {
  final String message;

  final StackTrace? stackTrace;

  StudentException(this.message, this.stackTrace);
}
