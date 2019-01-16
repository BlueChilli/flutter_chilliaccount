import 'dart:convert';
import 'package:flutter_account/models/error_info.dart';
import 'package:flutter_account/models/service_exception.dart';
import 'package:flutter_account/models/service_result.dart';
import 'package:chopper/chopper.dart';
import 'package:logging/logging.dart';

mixin ServiceBase {
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

  ServiceResult<T> logAndGetErrorInfo<T>(
      String message, Exception ex, StackTrace stacktrace, Logger logger) {
    logger?.severe(message, ex, stacktrace);
  }
}
