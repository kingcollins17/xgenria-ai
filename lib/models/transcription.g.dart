// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranscriptionData _$TranscriptionDataFromJson(Map<String, dynamic> json) =>
    TranscriptionData(
      id: json['transcription_id'] as int,
      userId: json['user_id'] as int,
      projectId: json['project_id'] as int?,
      name: json['name'] as String,
      input: json['input'] as String?,
      content: json['content'] as String,
    );

Map<String, dynamic> _$TranscriptionDataToJson(TranscriptionData instance) =>
    <String, dynamic>{
      'transcription_id': instance.id,
      'user_id': instance.userId,
      'project_id': instance.projectId,
      'name': instance.name,
      'input': instance.input,
      'content': instance.content,
    };
