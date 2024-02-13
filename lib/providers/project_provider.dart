import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xgenria/api/project.dart';
import '../models/access_token.dart';
import 'providers.dart';
part 'project_provider.g.dart';

@Riverpod(keepAlive: true)
class ProjectNotifier extends _$ProjectNotifier {
  @override
  Future<FetchProjectResponse> build(AccessToken token) =>
      ProjectAPI.projects(ref.read(dioProvider), token);

  ///
  Future<CreateProjectResponse> create(AccessToken token,
      {required String name, String color = '#FFFFFF'}) async {
    final response =
        await ProjectAPI.createProject(ref.read(dioProvider), token);

    ref.invalidate(projectNotifierProvider);

    return response;
  }
}
