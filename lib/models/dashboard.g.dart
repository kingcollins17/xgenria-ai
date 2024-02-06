// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    DashboardData(
      documents: json['documents'] as List<dynamic>,
      totalDocuments: json['total_documents'] as int,
      wordsCurrentMonth: json['words_current_month'] as int,
      availableWords: json['available_words'] as int,
      images: json['images'] as List<dynamic>,
      imagesCurrentMonth: json['images_current_month'] as int,
      availableImages: json['available_images'] as int,
      transcriptions: json['transcriptions'] as List<dynamic>,
      totalTranscriptions: json['total_transcriptions'] as int,
      transcriptionsCurrentMonth: json['transcriptions_current_month'] as int,
      availableTranscriptions: json['available_transcriptions'] as int,
      templates: (json['templates'] as List<dynamic>)
          .map((e) => Template.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['templates_categories'] as List<dynamic>)
          .map((e) => TemplateCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardDataToJson(DashboardData instance) =>
    <String, dynamic>{
      'documents': instance.documents,
      'total_documents': instance.totalDocuments,
      'words_current_month': instance.wordsCurrentMonth,
      'available_words': instance.availableWords,
      'images': instance.images,
      'images_current_month': instance.imagesCurrentMonth,
      'available_images': instance.availableImages,
      'transcriptions': instance.transcriptions,
      'total_transcriptions': instance.totalTranscriptions,
      'transcriptions_current_month': instance.transcriptionsCurrentMonth,
      'available_transcriptions': instance.availableTranscriptions,
      'templates': instance.templates,
      'templates_categories': instance.categories,
    };
