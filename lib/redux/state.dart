import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:xgenria/models/access_token.dart';

import 'package:xgenria/redux/actions/base.dart';
import 'package:xgenria/redux/mware/data_mware.dart';
import 'reducers/auth_reducer.dart';
import 'reducers/data_reducer.dart';
import 'package:hive_flutter/hive_flutter.dart' as hv;

import 'mware/auth_mware.dart';

class XgenriaState {
  AuthState auth;
  DataState data;
  XgenriaState()
      : auth = AuthState(),
        data = DataState();

  XgenriaState.fromTokenMap(Map<dynamic, dynamic> tokenMap)
      : auth = AuthState(
          token: AccessToken(
            type: tokenMap['type'],
            value: tokenMap['value'],
            expiration: const Duration(minutes: 30),
          ),
        ),
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

// final store = createStore();

Store<XgenriaState> createStore() {
  final settings = hv.Hive.box('settings');
  final token = settings.get('token');
  debugPrint(token.toString());
  debugPrint(token.runtimeType.toString());
  XgenriaState state;

  if (token != null && token is Map<dynamic, dynamic>) {
    state = XgenriaState.fromTokenMap(token);
  } else {
    state = XgenriaState();
  }
  return Store<XgenriaState>(
    reducer,
    initialState: state,
    middleware: [authMiddleware, imageMiddleware],
  );
}
