import 'package:equatable/equatable.dart';
import 'package:flutter_account/models/model.dart';
import 'package:meta/meta.dart';

class Session extends Equatable {
  final String userKey;
  final UserData userData;

  Session({
    @required this.userKey,
    @required this.userData,
  }) : super([
          userKey,
        ]);
}
