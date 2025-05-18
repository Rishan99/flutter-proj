class NoInternetException implements Exception {}

class LocationServiceDisabled implements Exception {
  final String? message;
  LocationServiceDisabled(this.message);

  @override
  String toString() {
    return '$message';
  }
}

class LocationPermissionDenied implements Exception {
  final String? message;
  LocationPermissionDenied(this.message);

  @override
  String toString() {
    return '$message';
  }
}

class PhoneNumberNotVerified implements Exception {
  final String? message;
  PhoneNumberNotVerified(this.message);

  @override
  String toString() {
    return '$message';
  }
}

class ValidationException implements Exception {
  final String? message;
  ValidationException(this.message);

  @override
  String toString() {
    return '$message';
  }
}

class WrongOtpException implements Exception {
  final String? message;
  WrongOtpException(this.message);

  @override
  String toString() {
    return '$message';
  }
}

class ApiException implements Exception {}

class SessionExpiredException implements Exception {}
