import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable()
class ProjectData {
  @JsonKey(name: 'project_id')
  final int projectId;

  @JsonKey(name: 'user_id')
  final int userId;

  final String name, color;

  final DateTime? datetime;

  @JsonKey(name: 'last_datetime')
  final DateTime? lastDatetime;

  ProjectData(
      {required this.projectId,
      required this.userId,
      required this.name,
      required this.color,
      required this.datetime,
      required this.lastDatetime});

  factory ProjectData.fromJson(Map<String, dynamic> json) =>
      _$ProjectDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDataToJson(this);

  @override
  String toString() => 'ProjectData${toJson()}';
}
