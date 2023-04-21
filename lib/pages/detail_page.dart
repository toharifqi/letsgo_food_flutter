import 'package:flutter/material.dart';
import 'package:letsgo_food/model/restaurant.dart';
import 'package:letsgo_food/theme/style.dart';
import 'package:letsgo_food/widget/menu_item.dart';

class DetailPage extends StatefulWidget {
  static const routeName = "/detail_page";

  final Restaurant restaurant;

  const DetailPage({super.key, required this.restaurant});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    Restaurant restaurant = widget.restaurant;
    Menus menus = restaurant.menus;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18)
                )
              ),
              flexibleSpace: _buildCustomAppBar(restaurant),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 32
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: secondaryColor,
                      size: 18,
                    ),
                    Expanded(
                      child: Text(
                        restaurant.city,
                        style: const TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Text(
                  restaurant.description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 18
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  "Foods",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 42,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: restaurant.menus.foods
                        .map((food) => MenuItem(name: food.name))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Drinks",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 42,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: restaurant.menus.drinks
                        .map((food) => MenuItem(name: food.name))
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  LayoutBuilder _buildCustomAppBar(Restaurant restaurant) {
    return LayoutBuilder(
              builder: (context, constraints) {
                top = constraints.biggest.height;
                return FlexibleSpaceBar(
                  background: Hero(
                    tag: widget.restaurant.id,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18)
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(
                                  restaurant.pictureId
                              ),
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.dstATop
                              ),
                            )
                        ),
                      ),
                    ),
                  ),
                  title: (top > 80.0)
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 18),
                      const Icon(
                        Icons.star,
                        color: accentColor,
                        size: 32,
                      ),
                      Expanded(
                        child: Text(
                          restaurant.rating.toString(),
                          style: const TextStyle(
                              fontSize: 32
                          ),
                        ),
                      ),
                    ],
                  )
                  : Text(
                    restaurant.name
                  ),
                  centerTitle: true,
                );
              },
            );
  }

}
