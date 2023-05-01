import 'package:flutter/material.dart';
import 'package:letsgo_food/theme/style.dart';

import '../data/model/restaurant_model.dart';

class ReviewItem extends StatelessWidget {
  final CustomerReview reviewData;


  const ReviewItem({super.key, required this.reviewData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: (randomUserColor..shuffle()).first,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                reviewData.name[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reviewData.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  reviewData.date,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  reviewData.review,
                  style: const TextStyle(
                      fontSize: 18
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}
