import 'package:redux/redux.dart';
import 'package:xgenria/redux/middleware/auth_mware.dart';
import 'package:xgenria/redux/middleware/fetch_mware.dart';
import 'package:xgenria/redux/xgenria_state.dart';

///create the redux store
Store<XgenriaState> createStore() => Store(
      xgenriaReducer,
      initialState: XgenriaState.init(),
      middleware: [
        authMiddleware,
        fetchDashboardMW,
      ],
    );
