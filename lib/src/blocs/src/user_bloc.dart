import 'package:flutter_account/chilli_account.dart';
import 'package:meta/meta.dart';

class UserBloc {
  final UserService userService;
  final SessionTracker sessionTracker;
  AuthValidator _validator;

  UserBloc({
    @required this.userService,
    @required this.sessionTracker,
    AuthValidator validator,
  })  : assert(sessionTracker != null),
        assert(userService != null) {
    this._validator = validator ?? AuthValidatorImpl();
  }
}
