import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'package:xgenria/models/access_token.dart';
import 'package:xgenria/api/dash_board.dart';

part 'providers.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final sx = [301, 200, 400, 401, 403, 422, 404];
  return Dio(BaseOptions(validateStatus: (status) => sx.contains(status)));
}

@Riverpod(keepAlive: true)
Future<TemplateResponse> templates(TemplatesRef ref, AccessToken token) async {
  final dioClient = ref.read(dioProvider);
  return DashboardAPI.templates(dioClient, token);
}

@Riverpod(keepAlive: true)
Future<DashboardResponse> dashboard(DashboardRef ref, AccessToken token) async {
  final dioClient = ref.read(dioProvider);
  return DashboardAPI.dashboard(dioClient, token);
}





