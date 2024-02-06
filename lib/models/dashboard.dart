import 'package:json_annotation/json_annotation.dart';
import 'template.dart';

part 'dashboard.g.dart';

@JsonSerializable()
class DashboardData {
  final List<dynamic> documents;

  @JsonKey(name: 'total_documents')
  final int totalDocuments;

  @JsonKey(name: 'words_current_month')
  final int wordsCurrentMonth;

  @JsonKey(name: 'available_words')
  final int availableWords;

  final List<dynamic> images;

  @JsonKey(name: 'images_current_month')
  final int imagesCurrentMonth;

  @JsonKey(name: 'available_images')
  final int availableImages;

  final List<dynamic> transcriptions;

  @JsonKey(name: 'total_transcriptions')
  final int totalTranscriptions;

  @JsonKey(name: 'transcriptions_current_month')
  final int transcriptionsCurrentMonth;

  @JsonKey(name: 'available_transcriptions')
  final int availableTranscriptions;

  final List<Template> templates;

  @JsonKey(name: 'templates_categories')
  final List<TemplateCategory> categories;

  DashboardData(
      {required this.documents,
      required this.totalDocuments,
      required this.wordsCurrentMonth,
      required this.availableWords,
      required this.images,
      required this.imagesCurrentMonth,
      required this.availableImages,
      required this.transcriptions,
      required this.totalTranscriptions,
      required this.transcriptionsCurrentMonth,
      required this.availableTranscriptions,
      required this.templates,
      required this.categories});

  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataToJson(this);

  @override
  String toString() => 'DashboardData${toJson()}';
}
