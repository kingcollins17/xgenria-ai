import 'package:dio/dio.dart';
import '../models/access_token.dart';
import '../models/project.dart';

import '_config.dart' as cfg;

typedef FetchProjectResponse = ({
  List<ProjectData>? data,
  bool status,
  String message
});

typedef CreateProjectResponse = ({int? data, String message, bool status});
typedef DeleteProjectResponse = ({String message, bool status});

class ProjectAPI {
  static Future<FetchProjectResponse> projects(
      Dio dio, AccessToken token) async {
    try {
      final response = await dio.get(
        Uri.https(cfg.domain, '/projects').toString(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return (
        status: response.statusCode == 200,
        message: response.statusCode == 200
            ? 'Projects fetched successfully'
            : response.data['message'].toString(),
        data: response.statusCode == 200
            ? (response.data as List<dynamic>)
                .map((e) => ProjectData.fromJson(e))
                .toList()
            : null
      );
    } on DioException catch (_) {
      return (status: false, data: null, message: cfg.connectErrorMessage);
    } on TypeError catch (e) {
      return (status: false, data: null, message: e.toString());
    }
  }

  static Future<CreateProjectResponse> createProject(Dio dio, AccessToken token,
      {String name = 'My Test AI Project', String color = '#760934'}) async {
    try {
      final response = await dio.post(
        Uri.https(cfg.domain, '/project/create').toString(),
        data: {'name': name, 'color': color},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return (
        status: response.statusCode == 200,
        data: response.statusCode == 200
            ? response.data['data']['id'] as int?
            : null,
        message: response.statusCode == 200
            ? 'Project $name created successfully'
            : response.data['message'].toString()
      );
    } on DioException catch (_) {
      return (status: false, message: cfg.connectErrorMessage, data: null);
    } catch (e) {
      return (status: false, data: null, message: e.toString());
    }
  }

  static Future<DeleteProjectResponse> deleteProject(Dio dio, AccessToken token,
      {required int projectId}) async {
    try {
      final response = await dio.delete(
        Uri.https(cfg.domain, '/project/$projectId/delete').toString(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return (
        status: response.statusCode == 200,
        message: response.data['message'].toString(),
      );
    } on DioException catch (_) {
      return (status: false, message: cfg.connectErrorMessage);
    } catch (e) {
      return (status: false, message: e.toString());
    }
  }
}
