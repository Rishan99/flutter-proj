// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WishlistIcon extends StatelessWidget {
  final int movieId;
  const WishlistIcon({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isInWishlist = movieId % 2 == 0; // Replace with your logic to check if the movie is in the wishlist
    return Icon(
      Icons.favorite,
      color: isInWishlist ? Colors.red : Colors.grey,
      size: 24.0,
    );
  }
}
