// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectData _$ProjectDataFromJson(Map<String, dynamic> json) => ProjectData(
      projectId: json['project_id'] as int,
      userId: json['user_id'] as int,
      name: json['name'] as String,
      color: json['color'] as String,
      datetime: json['datetime'] == null
          ? null
          : DateTime.parse(json['datetime'] as String),
      lastDatetime: json['last_datetime'] == null
          ? null
          : DateTime.parse(json['last_datetime'] as String),
    );

Map<String, dynamic> _$ProjectDataToJson(ProjectData instance) =>
    <String, dynamic>{
      'project_id': instance.projectId,
      'user_id': instance.userId,
      'name': instance.name,
      'color': instance.color,
      'datetime': instance.datetime?.toIso8601String(),
      'last_datetime': instance.lastDatetime?.toIso8601String(),
    };
