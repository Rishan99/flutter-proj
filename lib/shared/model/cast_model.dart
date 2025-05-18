// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CastModel {
  final String name;
  final String type;
  CastModel({
    required this.name,
    required this.type,
  });

  CastModel copyWith({
    String? name,
    String? type,
  }) {
    return CastModel(
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
    };
  }

  factory CastModel.fromMap(Map<String, dynamic> map) {
    return CastModel(
      name: map['name'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CastModel.fromJson(String source) => CastModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CastModel(name: $name, type: $type)';

  @override
  bool operator ==(covariant CastModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.type == type;
  }

  @override
  int get hashCode => name.hashCode ^ type.hashCode;
}
