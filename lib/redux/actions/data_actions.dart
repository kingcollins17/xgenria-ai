import 'package:dio/dio.dart';
import 'package:xgenria/api/dash_board.dart';
import 'package:xgenria/models/access_token.dart';
import 'package:xgenria/redux/actions/base.dart';

enum DataActionType {
  load,

  ///Payload should FetchDashboardPayload
  fetchDashboard,

  ///Send payload as (DashboardData, String)
  updateDashboardData,

  notify,
}

//payloads
class FetchDashboardPayload {
  final Dio dio;
  final AccessToken token;

  final void Function(DashboardResponse)? onError;
  final void Function(DashboardResponse)? onDone;

  FetchDashboardPayload({
    required this.dio,
    required this.token,
    this.onError,
    this.onDone,
  });
}

base class DataStateAction extends XgenriaStateAction {
  final DataActionType type;
  DataStateAction({required this.type, required super.payload});
}
