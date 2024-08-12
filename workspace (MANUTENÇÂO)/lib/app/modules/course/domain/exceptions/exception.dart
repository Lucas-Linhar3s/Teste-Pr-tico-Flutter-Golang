class CourseException implements Exception {
  final String message;

  final StackTrace? stackTrace;

  CourseException(this.message, this.stackTrace);
}
