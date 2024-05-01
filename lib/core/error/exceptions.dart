sealed class AppException implements Exception {
  final String message;

  const AppException(this.message);
}

final class InternetException extends AppException {
  const InternetException(super.message);
}

final class ServerException extends AppException {
  const ServerException(super.message);
}
