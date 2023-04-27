import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarBest extends StatelessWidget {
  final int rate;

  RatingBarBest({required this.rate});

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      itemSize: 18,
      initialRating: rate.toDouble(),
      direction: Axis.horizontal,
      itemCount: 5,
      ratingWidget: RatingWidget(
        full: const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        half: const Icon(Icons.star_border, color: Colors.amber),
        empty: const Icon(Icons.star_border, color: Colors.amber),
      ),
      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}