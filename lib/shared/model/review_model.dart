// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReviewModel {
  final String user;
  final String review;
  final double rating;
  ReviewModel({
    required this.user,
    required this.review,
    required this.rating,
  });

  ReviewModel copyWith({
    String? user,
    String? review,
    double? rating,
  }) {
    return ReviewModel(
      user: user ?? this.user,
      review: review ?? this.review,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'review': review,
      'rating': rating,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      user: map['user'] as String,
      review: map['review'] as String,
      rating: map['rating'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) => ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ReviewModel(user: $user, review: $review, rating: $rating)';

  @override
  bool operator ==(covariant ReviewModel other) {
    if (identical(this, other)) return true;

    return other.user == user && other.review == review && other.rating == rating;
  }

  @override
  int get hashCode => user.hashCode ^ review.hashCode ^ rating.hashCode;
}
