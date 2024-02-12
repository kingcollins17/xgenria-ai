// import 'package:xgenria/providers/auth_provider.dart';
import '../../models/models.dart';
import '../actions/auth_actions.dart';
import '../actions/base.dart';

AuthState authReducer(AuthState state, XgenriaAction action) {
  if (action is AuthAction) {
    switch (action.type) {
      case AuthActionType.login:
        state
          ..isLoading = true
          ..message = 'Logging in...';
        break;
      case AuthActionType.register:
        state
          ..isLoading = true
          ..message = 'Registering account ...';
        break;
      case AuthActionType.updateLogin:
        if (action.payload
            is UpdatePayload<({String message, AccessToken? token})>) {
          final pd = action.payload
              as UpdatePayload<({String message, AccessToken? token})>;
          state
            ..isLoading = false
            ..message = pd.data.message
            ..token = pd.data.token;
        }
        break;
      case AuthActionType.notify:
        if (action.payload is NotifyPayload) {
          final pd = action.payload as NotifyPayload;
          state
            ..message = pd.notification
            ..isLoading = false;
        }
        break;
      case AuthActionType.clear:
        state.message = null;
      default:
        break;
    }
  }
  return state;
}

class AuthState {
  AccessToken? token;
  UserData? userData;
  String? message;
  bool isLoading;

  bool get isAuthenticated => token != null;
  AuthState({this.token, this.userData, this.message, this.isLoading = false});

  @override
  String toString() => 'AuthState{token: $token, data: $userData, '
      'message: $message, loading: $isLoading}';
}
