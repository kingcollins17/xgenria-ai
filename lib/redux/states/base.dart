import 'package:dio/dio.dart';
import 'package:xgenria/models/access_token.dart';

class XgenriaNetworkPayload {
  final Dio dio;
  final AccessToken token;

  XgenriaNetworkPayload({required this.dio, required this.token});
}
