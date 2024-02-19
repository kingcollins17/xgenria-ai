// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentData _$DocumentDataFromJson(Map<String, dynamic> json) => DocumentData(
      currentPage: json['current_page'] as int,
      documents: (json['data'] as List<dynamic>)
          .map((e) => Document.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['first_page_url'] as String?,
      from: json['from'],
      links: (json['links'] as List<dynamic>)
          .map((e) => DocLink.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastPage: json['last_page'] as int,
    );

Map<String, dynamic> _$DocumentDataToJson(DocumentData instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.documents,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'links': instance.links,
      'last_page': instance.lastPage,
    };

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      id: json['document_id'] as int,
      userId: json['user_id'] as int,
      projectId: json['project_id'] as int?,
      templateId: json['template_id'] as int?,
      templateCategoryId: json['template_category_id'] as int?,
      name: json['name'] as String,
      input: json['input'],
      content: json['content'] as String,
      datetime: json['datetime'] == null
          ? null
          : DateTime.parse(json['datetime'] as String),
      model: json['model'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'document_id': instance.id,
      'user_id': instance.userId,
      'project_id': instance.projectId,
      'template_id': instance.templateId,
      'template_category_id': instance.templateCategoryId,
      'name': instance.name,
      'input': instance.input,
      'content': instance.content,
      'type': instance.type,
      'model': instance.model,
      'datetime': instance.datetime?.toIso8601String(),
    };

DocLink _$DocLinkFromJson(Map<String, dynamic> json) => DocLink(
      url: json['url'] as String?,
      label: json['label'],
      active: json['active'] as bool,
    );

Map<String, dynamic> _$DocLinkToJson(DocLink instance) => <String, dynamic>{
      'url': instance.url,
      'label': instance.label,
      'active': instance.active,
    };
