import 'package:flutter/material.dart';
import 'package:letsgo_food/common/navigation.dart';
import 'package:letsgo_food/theme/style.dart';

import '../data/model/restaurant_model.dart';
import '../ui/detail_page.dart';

class RestaurantItem extends StatelessWidget {
  final BuildContext context;
  final Restaurant restaurant;
  final _imageBaseUrl = "https://restaurant-api.dicoding.dev/images/small/";

  const RestaurantItem({super.key, required this.restaurant, required this.context});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation.intentWithData(
          DetailPage.routeName,
          restaurant
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Card(
          color: grayBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Hero(
                    tag: restaurant.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "$_imageBaseUrl${restaurant.pictureId}",
                        height: 80,
                        width: 100,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, _) => const Center(
                          child: Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: primaryColor
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: secondaryColor,
                            size: 16,
                          ),
                          Expanded(
                            child: Text(
                              restaurant.city,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.star,
                            color: accentColor,
                            size: 16,
                          ),
                          Text(
                            restaurant.rating.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}
