import 'package:flutter/material.dart';
import 'package:letsgo_food/model/restaurant.dart';
import 'package:letsgo_food/theme/style.dart';
import 'package:letsgo_food/widget/list_item.dart';

class ListPage extends StatelessWidget {
  static const routeName = "/list_page";

  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              backgroundColor: Colors.transparent,
              expandedHeight: 160,
              flexibleSpace: _buildCustomAppBar(),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(60.0),
                child: Text(""),
              ),
            )
          ];
        },
        body: _buildList(context),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return SafeArea(
      child: Padding(
        padding:  const EdgeInsets.all(12),
        child: Card(
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Let's go Food",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Recommendation restaurant for you!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: secondaryColor
                        ),
                        child: Image.asset(
                            "assets/icon_no_text.png"
                        ),
                      )
                  )
                ],
              ),
            )
        ),
      ),
    );
  }

  FutureBuilder<String> _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString("assets/local_restaurant.json"),
      builder: (context, snapshot) {
        final List<Restaurant> restaurants = Restaurant.fromRawJson(snapshot.data);

        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) => RestaurantItem(
                      restaurant: restaurants[index],
                      context: context),
                )
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      },
    );
  }

}
