// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageData _$ImageDataFromJson(Map<String, dynamic> json) => ImageData(
      imageId: json['image_id'] as int,
      userId: json['user_id'] as int?,
      projectId: json['project_id'] as int?,
      name: json['name'] as String,
      input: json['input'] as String,
      image: json['image'] as String,
      style: json['style'] as String?,
      size: json['size'] as String?,
      artist: json['artist'] as String?,
      lighting: json['lighting'] as String?,
      mood: json['mood'] as String?,
      datetime: json['datetime'] == null
          ? null
          : DateTime.parse(json['datetime'] as String),
      lastDatetime: json['last_datetime'] == null
          ? null
          : DateTime.parse(json['last_datetime'] as String),
    );

Map<String, dynamic> _$ImageDataToJson(ImageData instance) => <String, dynamic>{
      'image_id': instance.imageId,
      'user_id': instance.userId,
      'project_id': instance.projectId,
      'name': instance.name,
      'input': instance.input,
      'image': instance.image,
      'style': instance.style,
      'size': instance.size,
      'artist': instance.artist,
      'lighting': instance.lighting,
      'mood': instance.mood,
      'datetime': instance.datetime?.toIso8601String(),
      'last_datetime': instance.lastDatetime?.toIso8601String(),
    };
