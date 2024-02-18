import 'package:json_annotation/json_annotation.dart';

part 'transcription.g.dart';

@JsonSerializable()
class TranscriptionData {
  @JsonKey(name: 'transcription_id')
  final int id;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'project_id')
  final int? projectId;

  final String name;
  final String? input;

  final String content;

  factory TranscriptionData.fromJson(Map<String, dynamic> json) =>
      _$TranscriptionDataFromJson(json);

  TranscriptionData(
      {required this.id,
      required this.userId,
      required this.projectId,
      required this.name,
      required this.input,
      required this.content});
  Map<String, dynamic> toJson() => _$TranscriptionDataToJson(this);

  @override
  String toString() =>
      'TranscriptionData{id: $id, name: $name, content: $content}';
}
