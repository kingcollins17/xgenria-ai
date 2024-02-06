// ignore_for_file: unnecessary_this

import 'package:json_annotation/json_annotation.dart';

part 'template.g.dart';

@JsonSerializable()
class Template {
  @JsonKey(name: 'template_id')
  final int id;

  @JsonKey(name: 'template_category_id')
  final int categoryId;

  final String name, icon;
  final String? prompt, emoji, color, background;
  final int order;

  @JsonKey(name: 'total_usage')
  final int? totalUsage;

  final dynamic settings;

  @JsonKey(name: 'is_enabled')
  final bool isEnabled;

  final DateTime datetime;

  @JsonKey(name: 'last_datetime')
  final DateTime? lastDatetime;

  Template(
      {required this.id,
      required this.categoryId,
      required this.name,
      required this.icon,
      required this.settings,
      this.prompt,
      this.emoji,
      this.color,
      this.background,
      required this.order,
      this.totalUsage,
      int? isEnabled,
      required this.datetime,
      this.lastDatetime})
      : this.isEnabled = isEnabled == 1;

  factory Template.fromJson(Map<String, dynamic> json) =>
      _$TemplateFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class TemplateCategory {
  @JsonKey(name: 'template_category_id')
  final int id;
  final String name, icon, emoji, color, background;
  final int order;

  @JsonKey(name: 'is_enabled')
  final bool isEnabled;

  final dynamic settings;
  final DateTime datetime;

  @JsonKey(name: 'last_datetime')
  final DateTime? lastDatetime;

  TemplateCategory(
      {required this.id,
      required this.name,
      required this.icon,
      required this.emoji,
      required this.color,
      required this.background,
      required this.order,
      required int isEnabled,
      required this.settings,
      required this.datetime,
      required this.lastDatetime})
      : this.isEnabled = isEnabled == 1;

  factory TemplateCategory.fromJson(Map<String, dynamic> json) =>
      _$TemplateCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateCategoryToJson(this);

  @override
  String toString() => toJson().toString();
}
