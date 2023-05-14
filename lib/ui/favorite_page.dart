import 'package:flutter/material.dart';
import 'package:letsgo_food/provider/database_provider.dart';
import 'package:letsgo_food/provider/result_state.dart';
import 'package:letsgo_food/theme/style.dart';
import 'package:provider/provider.dart';

import '../common/navigation.dart';
import '../widget/list_item.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = "/favorite_page";

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DatabaseProvider>(
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
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: dbProvider.result.length,
                itemBuilder: (context, index) => RestaurantItem(
                    restaurant: dbProvider.result[index],
                    context: context
                ),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigation.back(),
        label: const Text("Home"),
        icon: const Icon(Icons.home_rounded),
        backgroundColor: secondaryColor,
      ),
    );
  }

}
