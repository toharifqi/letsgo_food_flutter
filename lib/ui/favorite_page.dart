import 'package:flutter/material.dart';
import 'package:letsgo_food/provider/database_provider.dart';
import 'package:letsgo_food/provider/result_state.dart';
import 'package:letsgo_food/theme/style.dart';
import 'package:letsgo_food/widget/home_button.dart';
import 'package:provider/provider.dart';

import '../widget/list_item.dart';
import '../widget/setting_button.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = "/favorite_page";

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              backgroundColor: Colors.transparent,
              expandedHeight: 20,
              flexibleSpace: _buildCustomAppBar(),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(20.0),
                child: Text(""),
              ),
            )
          ];
        },
        body: _buildList(),
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.end,
        spacing: 8.0,
        children: const [
          HomeButton(),
          SettingButton(),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Card(
          color: Colors.pink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Favorite",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, dbProvider, _) {
        switch (dbProvider.state) {
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
                  dbProvider.message,
                  style: const TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
            );

          case ResultState.hasData:
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: dbProvider.result.length,
                itemBuilder: (context, index) => RestaurantItem(
                    restaurant: dbProvider.result[index],
                    context: context
                ),
              ),
            );;
        }
      },
    );
  }

}
