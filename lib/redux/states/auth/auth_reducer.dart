import '../../actions/auth_action.dart';
import '../../actions/base.dart';
import 'auth_state.dart';
import 'payloads.dart';

AuthState authReducer(AuthState state, XgenriaStateAction action) {
  if (action is AuthStateAction) {
    var newState = state;
    switch (action.type) {
      //
      case AuthActionType.login:
      case AuthActionType.logout:
        newState.isLoading = true;
        break;

      case AuthActionType.updateLogin:
        if (action.payload is UpdateLoginPayload) {
          final payload = action.payload as UpdateLoginPayload;
          newState
            ..accessToken = payload.token
            ..notification = payload.notification
            ..isLoading = false;
        }
        break;

      case AuthActionType.updateLogout:
        if (action.payload is UpdateLogoutPayload) {
          final pd = action.payload as UpdateLogoutPayload;
          newState
            ..accessToken = pd.status ? null : newState.accessToken
            ..notification = pd.notification
            ..isLoading = false;
        }
        break;
      case AuthActionType.clear:
        newState.notification = null;
      default:
    }
    return newState;
  }
  return state;
}

// ### - payloads for different action types

