import 'package:flutter/material.dart';
import 'package:letsgo_food/provider/database_provider.dart';
import 'package:letsgo_food/provider/restaurant_detail_provider.dart';
import 'package:letsgo_food/theme/style.dart';
import 'package:letsgo_food/ui/list_page.dart';
import 'package:letsgo_food/widget/menu_item.dart';
import 'package:letsgo_food/widget/review_item.dart';
import 'package:provider/provider.dart';

import '../common/navigation.dart';
import '../data/model/restaurant_model.dart';
import '../provider/result_state.dart';

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
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<RestaurantDetailProvider>()
        .getDetailRestaurant(widget.restaurant.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, detailProvider, _) {
          switch (detailProvider.state) {
            case ResultState.loading:
              return const Center(
                  child: CircularProgressIndicator(
                    color: secondaryColor,
                  )
              );

            case ResultState.error:
            case ResultState.noData:
              return Center(
                child: Material(
                  child: Text(
                    detailProvider.message,
                    style: const TextStyle(
                        fontSize: 18
                    ),
                  ),
                ),
              );

            case ResultState.hasData:
              return _buildContent(detailProvider.result);
          }
        },
      ),
      floatingActionButton: Consumer<DatabaseProvider>(
        builder: (context, dbProvider, _) {
          return FutureBuilder(
            future: dbProvider.isRestaurantFavorite(widget.restaurant.id),
            builder: (context, snapshot) {
              var isFavorite = snapshot.data ?? false;
              return isFavorite
                  ? removeFavoriteButton(widget.restaurant.id)
                  : addFavoriteButton(widget.restaurant);
            },
          );
        },
      ),
    );
  }

  FloatingActionButton addFavoriteButton(Restaurant restaurant) {
    return FloatingActionButton(
        onPressed: () {
          context
              .read<DatabaseProvider>()
              .addFavorite(restaurant);
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.favorite_border)
    );
  }

  FloatingActionButton removeFavoriteButton(String id) {
    return FloatingActionButton(
        onPressed: () {
          context
              .read<DatabaseProvider>()
              .removeFavorite(id);
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.favorite)
    );
  }

  Widget _buildContent(Restaurant restaurant) {
    final menus = restaurant.menus;
    final reviews = restaurant.customerReviews;
    final categories = restaurant.categories;

    return NestedScrollView(
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
        physics: const BouncingScrollPhysics(),
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
                    color: accentColor,
                    size: 24,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "${restaurant.city}, ${restaurant.address}",
                      style: const TextStyle(
                          fontSize: 18
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.fastfood_rounded,
                    color: accentColor,
                    size: 24,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      categories.map((category) => category.name).join(", "),
                      style: const TextStyle(
                          fontSize: 18
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                restaurant.description ?? "",
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

              if (menus != null)
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: menus.drinks.length,
                      itemBuilder: (context, index) => MenuItem(
                          name: menus.drinks[index].name)
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

              if (menus != null)
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: menus.foods.length,
                      itemBuilder: (context, index) => MenuItem(
                          name: menus.foods[index].name)
                  ),
                ),

              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 12),
                child: Divider(color: Colors.black45),
              ),
              const Text(
                "Reviews",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              if (reviews.isNotEmpty)
                Column(
                  children: reviews.map(
                          (review) => ReviewItem(reviewData: review)
                  ).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  final _imageBaseUrl = "https://restaurant-api.dicoding.dev/images/medium/";

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
                                "$_imageBaseUrl${restaurant.pictureId}",
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
