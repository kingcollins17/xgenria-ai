// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentData _$DocumentDataFromJson(Map<String, dynamic> json) => DocumentData(
      currentPage: json['current_page'] as int,
      data: json['data'] as List<dynamic>,
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
      'data': instance.data,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'links': instance.links,
      'last_page': instance.lastPage,
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
