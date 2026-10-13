import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  int id;
  int count;
  String name;
  CategoryModel({required this.id, required this.count, required this.name});

  CategoryModel copyWith({int? id, int? count, String? name}) {
    return CategoryModel(
      id: id ?? this.id,
      count: count ?? this.count,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'count': count, 'name': name};
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      count: map['count'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoryModel(id: $id, count: $count, name: $name)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.count == count && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ count.hashCode ^ name.hashCode;
}
