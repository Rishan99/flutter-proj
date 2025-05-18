import 'dart:convert';

class ValueModel {
  final int id;
  final String name;
  final int? parentId;
  ValueModel({
    required this.id,
    required this.name,
    this.parentId,
  });

  ValueModel copyWith({
    int? id,
    String? name,
    int? parentId,
  }) {
    return ValueModel(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
    };
  }

  factory ValueModel.fromMap(Map<String, dynamic> map) {
    return ValueModel(
      id: (map['id'] ?? map['value'])?.toInt() ?? 0,
      name: map['name'] ?? map['label'] ?? '',
      parentId: map['category_id'],
    );
  }
  factory ValueModel.fromSubCategory(Map<String, dynamic> map) {
    return ValueModel(
      id: (map['id'] ?? map['value'])?.toInt() ?? 0,
      name: map['name'] ?? map['label'] ?? '',
      parentId: map['category_id'],
    );
  }
  factory ValueModel.fromCity(Map<String, dynamic> map) {
    return ValueModel(
      id: (map['id'] ?? map['value'])?.toInt() ?? 0,
      name: map['name'] ?? map['label'] ?? '',
      parentId: map['counttry_id'],
    );
  }
  factory ValueModel.fromNeighbourhood(Map<String, dynamic> map) {
    return ValueModel(
      id: (map['id'] ?? map['value'])?.toInt() ?? 0,
      name: map['name'] ?? map['label'] ?? '',
      parentId: map['city_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ValueModel.fromJson(String source) => ValueModel.fromMap(json.decode(source));

  @override
  String toString() => 'ValueModel(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
