import '../../../models/dashboard.dart';
import '../../actions/base.dart';
import '../../actions/data_actions.dart';

class DataState {
  DashboardData? dashboard;
  bool isLoading;
  String? notification;
  DataState({
    this.dashboard,
    this.isLoading = false,
    this.notification,
  });
}

DataState dataReducer(DataState state, XgenriaStateAction action) {
  if (action is DataStateAction) {
    switch (action.type) {
      case DataActionType.load:
      case DataActionType.fetchDashboard:
        state.isLoading = true;
        break;

      case DataActionType.updateDashboardData:
        final pd = action.payload as (DashboardData, String);
        state
          ..dashboard = pd.$1
          ..isLoading = false
          ..notification = pd.$2;

      case DataActionType.notify:
        state.notification = action.payload.toString();
      default:
    }
  }
  return state;
}
