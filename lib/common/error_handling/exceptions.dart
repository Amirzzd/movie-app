import 'dart:convert';

import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;
  Response? response;

  AppException({required this.message, this.response});

  String getMessage() {
    return message;
  }
}

class ServerException extends AppException {
  ServerException({String? message})
      : super(message: message ?? "server has problem to connect");
}

class BadRequestException extends AppException {
  BadRequestException({String? message, Response? response})
      : super(message: _extractMessage(response) ?? "bad request exception.");
}

class DataParsingException extends AppException {
  DataParsingException({String? message})
      : super(message: message ?? "Data has Corrupted");
}

class FetchDataException extends AppException {
  FetchDataException({String? message})
      : super(message: message ?? "please check your connection...");
}

class UnauthorisedException extends AppException {
  UnauthorisedException({String? message, Response? response})
      : super(message: _extractMessage(response) ?? "token has been expired.");
}

String? _extractMessage(Response? response) {
  if (response != null && response.data != null) {
    try {
      Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

      return responseData['message'] ?? "bad request exception.";
    } catch (e) {
      return "bad request exception.";
    }
  }
}
