import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doc.g.dart';

@JsonSerializable()
class DocumentData {
  @JsonKey(name: 'current_page')
  final int currentPage;

  @JsonKey(name: 'data')
  final List<Document> documents;

  @JsonKey(name: 'first_page_url')
  final String? firstPageUrl;

  final dynamic from;

  final List<DocLink> links;

  @JsonKey(name: 'last_page')
  final int lastPage;

  DocumentData({
    required this.currentPage,
    required this.documents,
    required this.firstPageUrl,
    required this.from,
    required this.links,
    required this.lastPage,
  });

  factory DocumentData.fromJson(Map<String, dynamic> json) =>
      _$DocumentDataFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentDataToJson(this);

  @override
  String toString() => 'DocData${toJson()}';
}

@JsonSerializable()
class Document {
  @JsonKey(name: 'document_id')
  final int id;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'project_id')
  final int? projectId;

  @JsonKey(name: 'template_id')
  final int? templateId;

  @JsonKey(name: 'template_category_id')
  final int? templateCategoryId;

  final String name;
  final dynamic input;
  final String content;

  final String? type, model;

  final DateTime? datetime;

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  Document(
      {required this.id,
      required this.userId,
      required this.projectId,
      required this.templateId,
      required this.templateCategoryId,
      required this.name,
      required this.input,
      required this.content,
      required this.datetime,
      required this.model,
      required this.type});
  Map<String, dynamic> toJson() => _$DocumentToJson(this);

  @override
  String toString() => 'Document{id: $id, name: $name}';
}

@JsonSerializable()
class DocLink {
  final String? url;
  final dynamic label;
  final bool active;

  DocLink({required this.url, required this.label, required this.active});

  factory DocLink.fromJson(Map<String, dynamic> json) =>
      _$DocLinkFromJson(json);

  Map<String, dynamic> toJson() => _$DocLinkToJson(this);

  @override
  String toString() => 'DocLink${toJson()}';
}
