import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';


typedef ImageResultData = ({
  Map<String, dynamic>? data,
  String message,
  bool status
});

@JsonSerializable()
class ImageData {
  @JsonKey(name: 'image_id')
  final int imageId;

  @JsonKey(name: 'user_id')
  final int? userId;

  @JsonKey(name: 'project_id')
  final int? projectId;

  final String name, input, image;
  final String? style, size, artist, lighting, mood;

  final DateTime? datetime;

  @JsonKey(name: 'last_datetime')
  final DateTime? lastDatetime;

  factory ImageData.fromJson(Map<String, dynamic> json) =>
      _$ImageDataFromJson(json);

  ImageData(
      {required this.imageId,
      required this.userId,
      required this.projectId,
      required this.name,
      required this.input,
      required this.image,
      required this.style,
      required this.size,
      required this.artist,
      required this.lighting,
      required this.mood,
      required this.datetime,
      required this.lastDatetime});
  Map<String, dynamic> toJson() => _$ImageDataToJson(this);

  @override
  String toString() =>
      'ImageData{id; $imageId, name: $name, image: $image, project: $projectId, '
      'size: $size, input: $input'
      'user: $userId, artist: $artist, style: $style, lighting: '
      '$lighting, mood: $mood, }';
}
