import 'package:xgenria/redux/actions/base.dart';
import 'package:xgenria/redux/states/auth/auth_reducer.dart';
import 'package:xgenria/redux/states/auth/auth_state.dart';
import 'package:xgenria/redux/states/data/data_state.dart';

class XgenriaState {
  final AuthState authState;
  final DataState dataState;

  XgenriaState({required this.authState, required this.dataState});

  XgenriaState.init()
      : authState = AuthState.init(),
        dataState = DataState();
}

XgenriaState xgenriaReducer(XgenriaState state, action) {
  if (action is XgenriaStateAction) {
    return XgenriaState(
      authState: authReducer(state.authState, action),
      dataState: dataReducer(state.dataState, action),
    );
  }
  return state;
}
