// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Template _$TemplateFromJson(Map<String, dynamic> json) => Template(
      id: json['template_id'] as int,
      categoryId: json['template_category_id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      settings: json['settings'],
      prompt: json['prompt'] as String?,
      emoji: json['emoji'] as String?,
      color: json['color'] as String?,
      background: json['background'] as String?,
      order: json['order'] as int,
      totalUsage: json['total_usage'] as int?,
      isEnabled: json['is_enabled'] as int?,
      datetime: DateTime.parse(json['datetime'] as String),
      lastDatetime: json['last_datetime'] == null
          ? null
          : DateTime.parse(json['last_datetime'] as String),
    );

Map<String, dynamic> _$TemplateToJson(Template instance) => <String, dynamic>{
      'template_id': instance.id,
      'template_category_id': instance.categoryId,
      'name': instance.name,
      'icon': instance.icon,
      'prompt': instance.prompt,
      'emoji': instance.emoji,
      'color': instance.color,
      'background': instance.background,
      'order': instance.order,
      'total_usage': instance.totalUsage,
      'settings': instance.settings,
      'is_enabled': instance.isEnabled,
      'datetime': instance.datetime.toIso8601String(),
      'last_datetime': instance.lastDatetime?.toIso8601String(),
    };

TemplateCategory _$TemplateCategoryFromJson(Map<String, dynamic> json) =>
    TemplateCategory(
      id: json['template_category_id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      emoji: json['emoji'] as String,
      color: json['color'] as String,
      background: json['background'] as String,
      order: json['order'] as int,
      isEnabled: json['is_enabled'] as int,
      settings: json['settings'],
      datetime: DateTime.parse(json['datetime'] as String),
      lastDatetime: json['last_datetime'] == null
          ? null
          : DateTime.parse(json['last_datetime'] as String),
    );

Map<String, dynamic> _$TemplateCategoryToJson(TemplateCategory instance) =>
    <String, dynamic>{
      'template_category_id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'emoji': instance.emoji,
      'color': instance.color,
      'background': instance.background,
      'order': instance.order,
      'is_enabled': instance.isEnabled,
      'settings': instance.settings,
      'datetime': instance.datetime.toIso8601String(),
      'last_datetime': instance.lastDatetime?.toIso8601String(),
    };
