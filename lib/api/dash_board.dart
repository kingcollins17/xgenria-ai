import 'package:dio/dio.dart';
import 'package:xgenria/models/access_token.dart';
import 'package:xgenria/models/dashboard.dart';
import 'package:xgenria/models/template.dart';

import '_config.dart' as cfg;

abstract class DashboardAPI {
  static Future<DashboardResponse> dashboard(Dio dio, AccessToken token) async {
    try {
      final response = await dio.get(
          Uri.https(cfg.domain, '/dashboard').toString(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return (
        data: response.statusCode == 200
            ? DashboardData.fromJson(response.data)
            : null,
        message: response.statusCode == 200
            ? 'Dashboard data fetched'
            : response.data['message'].toString(),
        status: response.statusCode == 200
      );
    } catch (e) {
      return (data: null, message: e.toString(), status: false);
    }
  }

  static Future<TemplateResponse> templates(Dio dio, AccessToken token) async {
    try {
      final response = await dio.get(
          Uri.https(cfg.domain, '/templates').toString(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return (
        templates: response.statusCode == 200
            ? List.generate(response.data['templates'].length,
                (index) => Template.fromJson(response.data['templates'][index]))
            : null,
        categories: response.statusCode == 200
            ? List.generate(
                response.data['templates_categories'].length,
                (index) => TemplateCategory.fromJson(
                    response.data['templates_categories'][index]))
            : null,
        status: response.statusCode == 200,
        message: response.statusCode == 200
            ? "Templates data fetched"
            : response.data['message'].toString()
      );
    } catch (e) {
      return (
        templates: <Template>[],
        categories: <TemplateCategory>[],
        status: false,
        message: e.toString()
      );
    }
  }
}

typedef DashboardResponse = ({
  DashboardData? data,
  String message,
  bool status
});

typedef TemplateResponse = ({
  List<Template>? templates,
  List<TemplateCategory>? categories,
  bool status,
  String message
});
