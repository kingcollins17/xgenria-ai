import 'package:redux/redux.dart';

import 'package:xgenria/redux/actions/base.dart';
import 'package:xgenria/redux/mware/data_mware.dart';
import 'reducers/auth_reducer.dart';
import 'reducers/data_reducer.dart';

import 'mware/auth_mware.dart';

class XgenriaState {
  AuthState auth;
  DataState data;
  XgenriaState()
      : auth = AuthState(),
        data = DataState();
}

XgenriaState reducer(XgenriaState state, action) {
  if (action is XgenriaAction) {
    state
      ..auth = authReducer(state.auth, action)
      ..data = dataReducer(state.data, action);
  }
  return state;
}

final store = Store<XgenriaState>(
  reducer,
  initialState: XgenriaState(),
  middleware: [
    authMiddleware,
    imageMiddleware,
    // chatMiddleware,
  ],
);
