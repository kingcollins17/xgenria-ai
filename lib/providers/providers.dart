import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'package:xgenria/api/api.dart';
import 'package:xgenria/models/access_token.dart';
import 'package:xgenria/api/dash_board.dart';
import 'package:xgenria/models/models.dart';

part 'providers.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final sx = [301, 200, 400, 401, 403, 422, 404];
  return Dio(BaseOptions(validateStatus: (status) => true));
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

@Riverpod(keepAlive: true)
Future<({UserData? data, String message, bool status})> user(
        UserRef ref, AccessToken token) async =>
    AuthAPI.user(ref.read(dioProvider), token);
