import 'package:redux/redux.dart';
import 'package:xgenria/redux/actions/auth_actions.dart';

dynamic authMiddleware(Store store, action, NextDispatcher next) {
  if (action is AuthAction) {
    switch (action.type) {
      default:
        break;
    }
  }
  next(action);
}
