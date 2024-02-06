import 'package:redux/redux.dart';
import 'package:xgenria/api/auth.dart';
import 'package:xgenria/redux/actions/auth_action.dart';
import 'package:xgenria/redux/states/base.dart';
import 'package:xgenria/redux/notification/state_notification.dart';
import 'package:xgenria/redux/states/auth/auth_reducer.dart';
import 'package:xgenria/redux/states/auth/payloads.dart';

dynamic authMiddleware(Store store, action, NextDispatcher next) {
  //if action is of type [AuthStateAction]
  if (action is AuthStateAction) {
    switch (action.type) {
      //
      case AuthActionType.login:
        if (action.payload is LoginPayload) {
          final payload = action.payload as LoginPayload;
          //login and update state
          AuthAPI.login(
            payload.client,
            email: payload.email,
            password: payload.password,
            rememberMe: payload.rememberMe,
          ).then((response) {
            store.dispatch(AuthStateAction(
              type: AuthActionType.updateLogin,
              payload: (
                token: response.token,
                notification: StateNotification(message: response.message)
              ),
            ));
            if (response.token != null && (payload.onDone != null)) {
              payload.onDone!();
            } else if (payload.onError != null) {
              payload.onError!(response.message);
            }
          });
        }
        break;

      case AuthActionType.logout:
        if (action.payload is XgenriaNetworkPayload) {
          final pd = action.payload as XgenriaNetworkPayload;
          AuthAPI.logout(pd.dio, pd.token).then((response) {
            store.dispatch(
              AuthStateAction(
                type: AuthActionType.updateLogout,
                payload: UpdateLogoutPayload(
                  status: response.status,
                  notification: StateNotification(message: response.message),
                ),
              ),
            );
          });
        }

        break;
      default:
    }
    //
  }
  next(action);
}
