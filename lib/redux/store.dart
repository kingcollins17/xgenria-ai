import 'package:redux/redux.dart';
import 'middleware/auth_mware.dart';
import 'middleware/fetch_mware.dart';
import 'xgenria_state.dart';

///create the redux store
Store<XgenriaState> createStore() => Store(
      xgenriaReducer,
      initialState: XgenriaState.init(),
      middleware: [
        authMiddleware,
        fetchDashboardMW,
      ],
    );
