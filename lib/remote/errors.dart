import 'dart:io';

class FailedResponseException extends IOException {
  final String? message;

  FailedResponseException(this.message);
}

class CallSyncedFailedException extends IOException {}

class NetworkNotAvailableException implements IOException {
  final String? message;

  NetworkNotAvailableException({required this.message});
}
