import 'package:chopper/chopper.dart';
import 'package:flutter_account/models/error_info.dart';

class ErrorConverter extends Converter {
  @override
  Future decodeEntity<T>(entity) async => ErrorInfo.fromJson(entity);

  @override
  encodeEntity<T>(T entity) async => entity;
}
