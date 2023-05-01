import 'package:flutter/material.dart';
import 'package:letsgo_food/provider/restaurant_detail_provider.dart';
import 'package:letsgo_food/theme/style.dart';
import 'package:letsgo_food/widget/menu_item.dart';
import 'package:provider/provider.dart';

import '../data/model/restaurant_model.dart';
import '../provider/result_state.dart';

class DetailPage extends StatefulWidget {
  static const routeName = "/detail_page";

  final String restaurantId;

  const DetailPage({super.key, required this.restaurantId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var top = 0.0;


  @override
  void initState() {
    super.initState();
    context.read<RestaurantDetailProvider>()
        .getDetailRestaurant(widget.restaurantId);
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
                  child: Text(detailProvider.message),
                ),
              );

            case ResultState.hasData:
              return _buildContent(detailProvider.result);
          }
        },
      ),
    );
  }

  Widget _buildContent(Restaurant restaurant) {
    final menus = restaurant.menus;
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
                      "${restaurant.city}, ${restaurant.address}",
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

              if (menus != null)
                SizedBox(
                  height: 40,
                  child: ListView.builder(
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
                      scrollDirection: Axis.horizontal,
                      itemCount: menus.foods.length,
                      itemBuilder: (context, index) => MenuItem(
                          name: menus.foods[index].name)
                  ),
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
                    tag: widget.restaurantId,
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
