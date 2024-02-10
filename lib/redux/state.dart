import 'package:redux/redux.dart';
// import 'package:xgenria/providers/auth_provider.dart';
import 'package:xgenria/redux/actions/base.dart';
import 'package:xgenria/redux/reducers/auth_reducer.dart';

import 'mware/auth.dart';
import 'state/auth.dart';

class XgenriaState {
  AuthState auth;
  XgenriaState() : auth = AuthState();
}

XgenriaState reducer(XgenriaState state, action) {
  if (action is XgenriaAction) {
    state.auth = authReducer(state.auth, action);
  }
  return state;
}

final store = Store<XgenriaState>(
  reducer,
  initialState: XgenriaState(),
  middleware: [
    authMiddleware,
  ],
);
