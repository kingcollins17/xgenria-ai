// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:redux/redux.dart';
import 'package:xgenria/api/auth.dart';
import 'package:xgenria/redux/actions/auth_actions.dart';

import '../actions/base.dart';

dynamic authMiddleware(Store store, action, NextDispatcher next) {
  if (action is AuthAction) {
    switch (action.type) {
      case AuthActionType.login:
        if (action.payload is LoginPayload) {
          final pd = action.payload as LoginPayload;
          AuthAPI.login(pd.client,
                  email: pd.email,
                  password: pd.password,
                  rememberMe: pd.rememberMe)
              .then(
            (value) {
              store.dispatch(AuthAction(
                type: AuthActionType.updateLogin,
                payload: UpdatePayload(value),
              ));
              if (value.token != null && pd.onDone != null) {
                pd.onDone!(value);
              } else if (pd.onError != null) pd.onError!(value);
            },
          );
        }
      default:
        break;
    }
  }
  next(action);
}
