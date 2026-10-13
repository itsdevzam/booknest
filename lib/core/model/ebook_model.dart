import 'dart:convert';
import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EbookModel {
  int id;
  String ebookName;
  String ebookAuthor;
  List<String> ebookCatList;
  String ebookDesc;
  String ebookUrl;
  String ebookImage;
  EbookModel({
    required this.id,
    required this.ebookName,
    required this.ebookAuthor,
    required this.ebookCatList,
    required this.ebookDesc,
    required this.ebookUrl,
    required this.ebookImage,
  });

  EbookModel copyWith({
    int? id,
    String? ebookName,
    String? ebookAuthor,
    List<String>? ebookCatList,
    String? ebookDesc,
    String? ebookUrl,
    String? ebookImage,
  }) {
    return EbookModel(
      id: id ?? this.id,
      ebookName: ebookName ?? this.ebookName,
      ebookAuthor: ebookAuthor ?? this.ebookAuthor,
      ebookCatList: ebookCatList ?? this.ebookCatList,
      ebookDesc: ebookDesc ?? this.ebookDesc,
      ebookUrl: ebookUrl ?? this.ebookUrl,
      ebookImage: ebookImage ?? this.ebookImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ebookName': ebookName,
      'ebookAuthor': ebookAuthor,
      'ebookCatList': ebookCatList,
      'ebookDesc': ebookDesc,
      'ebookUrl': ebookUrl,
      'ebookImage': ebookImage,
    };
  }

  factory EbookModel.fromMap(Map<String, dynamic> map) {
    return EbookModel(
      id: map['id'] as int,
      ebookName: map['ebookName'] as String,
      ebookAuthor: map['ebookAuthor'] as String,
      ebookCatList: List<String>.from((map['ebookCatList'] as List<String>)),
      ebookDesc: map['ebookDesc'] as String,
      ebookUrl: map['ebookUrl'] as String,
      ebookImage: map['ebookImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EbookModel.fromJson(String source) =>
      EbookModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EbookModel(id: $id, ebookName: $ebookName, ebookAuthor: $ebookAuthor, ebookCatList: $ebookCatList, ebookDesc: $ebookDesc, ebookUrl: $ebookUrl, ebookImage: $ebookImage)';
  }

  @override
  bool operator ==(covariant EbookModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.ebookName == ebookName &&
        other.ebookAuthor == ebookAuthor &&
        listEquals(other.ebookCatList, ebookCatList) &&
        other.ebookDesc == ebookDesc &&
        other.ebookUrl == ebookUrl &&
        other.ebookImage == ebookImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ebookName.hashCode ^
        ebookAuthor.hashCode ^
        ebookCatList.hashCode ^
        ebookDesc.hashCode ^
        ebookUrl.hashCode ^
        ebookImage.hashCode;
  }
}
