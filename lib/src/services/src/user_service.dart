import 'dart:async';

import 'package:flutter_account/chilli_account.dart';
import 'package:meta/meta.dart';
import 'package:chopper/chopper.dart';
import 'package:logging/logging.dart';

abstract class UserService {}

class UserServiceImpl with ServiceMixin implements UserService {
  final UsersApi api;
  final Logger logger;

  UserServiceImpl({
    @required this.api,
    this.logger,
  });
}
