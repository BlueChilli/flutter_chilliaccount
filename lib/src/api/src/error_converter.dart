import 'package:chopper/chopper.dart';
import 'package:flutter_account/chilli_account.dart';

class ErrorConverter extends Converter {
  @override
  Future decodeEntity<T>(entity) async => ErrorInfo.fromJson(entity);

  @override
  encodeEntity<T>(T entity) async => entity;
}
