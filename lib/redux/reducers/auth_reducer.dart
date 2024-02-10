// import 'package:xgenria/providers/auth_provider.dart';
import '../actions/auth_actions.dart';
import '../actions/base.dart';
import '../state/auth.dart';

AuthState authReducer(AuthState state, XgenriaAction action) {
  if (action is AuthAction) {
    switch (action.type) {
      case AuthActionType.login:
        break;
      default:
        break;
    }
  }
  return state;
}
