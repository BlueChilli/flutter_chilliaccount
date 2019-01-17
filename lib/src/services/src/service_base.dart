import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:flutter_account/chilli_account.dart';
import 'package:logging/logging.dart';

mixin ServiceMixin {
  ServiceResult<T> getErrorInfo<T>(Response error, Logger logger) {
    logger?.info((error.body as ErrorInfo)?.errorMessages);
    if ((error.body as ErrorInfo) != null) {
      logger?.warning(
          ServiceException((error.body as ErrorInfo)?.errorMessages),
          StackTrace.fromString(
              json.encode((error.body as ErrorInfo).toJson())));
    }

    return ServiceResult<T>.failure(
        errorMessage: (error.body as ErrorInfo)?.errorMessages,
        statusCode: error.statusCode);
  }

  ServiceResult<T> logErrorInfo<T>(
      String message, Exception ex, StackTrace stacktrace, Logger logger) {
    logger?.severe(message, ex, stacktrace);
    return ServiceResult<T>.failure(ex: ex, statusCode: 500);
  }
}
