import 'package:dio/dio.dart';
import '../models/access_token.dart';
import '../models/project.dart';

import '_config.dart' as cfg;

class ProjectAPI {
  static Future<dynamic> projects(Dio dio, AccessToken token) async {
    try {
      final response = await dio.get(
        Uri.https(cfg.domain, '/projects').toString(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // return ProjectData.fromJson(response.data);
      return (response.data as List<dynamic>)
          .map((e) => ProjectData.fromJson(e))
          .toList();
    } on TypeError catch (e) {
      return e.stackTrace;
    }
  }

  static Future<dynamic> createProject(Dio dio, AccessToken token,
      {String name = 'Test project', String color = '#760934'}) async {
    try {
      final response = await dio.post(
        Uri.https(cfg.domain, '/project/create').toString(),
        data: {'name': name, 'color': color},
        options: Options(headers: {'Authorization': 'Bearer $token-0'}),
      );

      return response.statusCode;
    } catch (e) {
      return e;
    }
  }
}
