// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GenreModel {
  final int id;
  final String name;
  final String? image;
  GenreModel({
    required this.id,
    required this.name,
    this.image,
  });

  GenreModel copyWith({
    int? id,
    String? name,
    String? image,
  }) {
    return GenreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory GenreModel.fromMap(Map<String, dynamic> map) {
    return GenreModel(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GenreModel.fromJson(String source) => GenreModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GenreModel(id: $id, name: $name, image: $image)';

  @override
  bool operator ==(covariant GenreModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;
}
