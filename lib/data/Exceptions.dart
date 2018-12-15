class NoConnectionException implements Exception {
  static const _NO_CONNECTION_MESSAGE = "Please, check internet connectivity";

  @override
  String toString() {
    return _NO_CONNECTION_MESSAGE;
  }
}

class ServiceUnavailableException implements Exception {
  static const _SERVICE_UNAVAILABLE_MESSAGE = "Sorry, service is unavailable.";

  @override
  String toString() {
    return _SERVICE_UNAVAILABLE_MESSAGE;
  }
}
