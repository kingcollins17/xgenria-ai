import 'package:json_annotation/json_annotation.dart';

part 'doc.g.dart';

@JsonSerializable()
class DocumentData {
  @JsonKey(name: 'current_page')
  final int currentPage;

  final List<dynamic> data;

  @JsonKey(name: 'first_page_url')
  final String? firstPageUrl;

  final dynamic from;

  final List<DocLink> links;

  @JsonKey(name: 'last_page')
  final int lastPage;

  DocumentData({
    required this.currentPage,
    required this.data,
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
