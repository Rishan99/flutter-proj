// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:moviehub/shared/model/cast_model.dart';
import 'package:moviehub/shared/model/review_model.dart';

class MovieModel {
  final int id;
  final int genreId;
  final String genre;
  final String? movieLink;
  final String? trailerLink;
  final int runtime;
  final String releaseDate;
  final double averageRating;
  final String coverImage;
  final String title;
  final String movieType;
  final String? description;
  final List<CastModel> cast;
  final List<ReviewModel> ratings;
  MovieModel({
    required this.id,
    required this.genreId,
    required this.genre,
    this.movieLink,
    this.trailerLink,
    required this.runtime,
    required this.releaseDate,
    required this.averageRating,
    required this.coverImage,
    required this.title,
    required this.movieType,
    this.description,
    required this.cast,
    required this.ratings,
  });

  MovieModel copyWith({
    int? id,
    int? genreId,
    String? genre,
    String? movieLink,
    String? trailerLink,
    int? runtime,
    String? releaseDate,
    double? averageRating,
    String? coverImage,
    String? title,
    String? movieType,
    String? description,
    List<CastModel>? cast,
    List<ReviewModel>? ratings,
  }) {
    return MovieModel(
      id: id ?? this.id,
      genreId: genreId ?? this.genreId,
      genre: genre ?? this.genre,
      movieLink: movieLink ?? this.movieLink,
      trailerLink: trailerLink ?? this.trailerLink,
      runtime: runtime ?? this.runtime,
      releaseDate: releaseDate ?? this.releaseDate,
      averageRating: averageRating ?? this.averageRating,
      coverImage: coverImage ?? this.coverImage,
      title: title ?? this.title,
      movieType: movieType ?? this.movieType,
      description: description ?? this.description,
      cast: cast ?? this.cast,
      ratings: ratings ?? this.ratings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'genreId': genreId,
      'genre': genre,
      'movieLink': movieLink,
      'trailerLink': trailerLink,
      'runtime': runtime,
      'releaseDate': releaseDate,
      'averageRating': averageRating,
      'coverImage': coverImage,
      'title': title,
      'movieType': movieType,
      'description': description,
      'cast': cast.map((x) => x.toMap()).toList(),
      'ratings': ratings.map((x) => x.toMap()).toList(),
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] as int,
      genreId: map['genreId'] as int,
      genre: map['genre'] as String,
      movieLink: map['movieLink'] != null ? map['movieLink'] as String : null,
      trailerLink: map['trailerLink'] != null ? map['trailerLink'] as String : null,
      runtime: map['runtime'] as int,
      releaseDate: map['releaseDate'] as String,
      averageRating: map['averageRating'] as double,
      coverImage: map['coverImage'] as String,
      title: map['title'] as String,
      movieType: map['movieType'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      cast: List<CastModel>.from(
        (map['cast'] as List<int>).map<CastModel>(
          (x) => CastModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      ratings: List<ReviewModel>.from(
        (map['ratings'] as List<int>).map<ReviewModel>(
          (x) => ReviewModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) => MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MovieModel(id: $id, genreId: $genreId, genre: $genre, movieLink: $movieLink, trailerLink: $trailerLink, runtime: $runtime, releaseDate: $releaseDate, averageRating: $averageRating, coverImage: $coverImage, title: $title, movieType: $movieType, description: $description, cast: $cast, ratings: $ratings)';
  }

  @override
  bool operator ==(covariant MovieModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.genreId == genreId &&
        other.genre == genre &&
        other.movieLink == movieLink &&
        other.trailerLink == trailerLink &&
        other.runtime == runtime &&
        other.releaseDate == releaseDate &&
        other.averageRating == averageRating &&
        other.coverImage == coverImage &&
        other.title == title &&
        other.movieType == movieType &&
        other.description == description &&
        listEquals(other.cast, cast) &&
        listEquals(other.ratings, ratings);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        genreId.hashCode ^
        genre.hashCode ^
        movieLink.hashCode ^
        trailerLink.hashCode ^
        runtime.hashCode ^
        releaseDate.hashCode ^
        averageRating.hashCode ^
        coverImage.hashCode ^
        title.hashCode ^
        movieType.hashCode ^
        description.hashCode ^
        cast.hashCode ^
        ratings.hashCode;
  }
}
