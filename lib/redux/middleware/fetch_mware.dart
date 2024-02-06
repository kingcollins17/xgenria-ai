// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:redux/redux.dart';
import 'package:xgenria/api/dash_board.dart';
import 'package:xgenria/models/access_token.dart';
import 'package:xgenria/redux/actions/data_actions.dart';
import 'package:dio/dio.dart';

dynamic fetchDashboardMW(Store store, action, NextDispatcher next) {
  if (action is DataStateAction) {
    switch (action.type) {
      case DataActionType.fetchDashboard:
        if (action.payload is FetchDashboardPayload) {
          final pd = action.payload as FetchDashboardPayload;
          store.dispatch(DataStateAction(
              type: DataActionType.notify, payload: 'Fetching data'));
          DashboardAPI.dashboard(pd.dio, pd.token).then((value) {
            if (value.status) {
              store.dispatch(
                DataStateAction(
                  type: DataActionType.updateDashboardData,
                  payload: (value.data, value.message),
                ),
              );
              if (pd.onDone != null)
                Future.delayed(
                  Duration(seconds: 2),
                  () => pd.onDone!(value),
                );
            } else {
              store.dispatch(
                DataStateAction(
                    type: DataActionType.notify, payload: value.message),
              );

              if (pd.onError != null)
                Future.delayed(
                  Duration(seconds: 3),
                  () => pd.onError!(value),
                );
            }
          });
        }

        break;
      default:
    }
  }
  next(action);
}
