import 'package:flutter/material.dart';
import 'package:letsgo_food/data/api/api_service.dart';
import 'package:letsgo_food/provider/restaurant_provider.dart';
import 'package:letsgo_food/theme/style.dart';

import 'common/navigation.dart';
import 'ui/detail_page.dart';
import 'ui/list_page.dart';

import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantProvider(apiService: ApiService()),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: primaryColor,
            onPrimary: Colors.white,
            secondary: secondaryColor,
          ),
        ),
        navigatorKey: navigatorKey,
        initialRoute: ListPage.routeName,
        routes: {
          ListPage.routeName: (context) =>  const ListPage(),
          DetailPage.routeName: (context) => DetailPage(
            restaurantId: ModalRoute.of(context)?.settings.arguments as String,
          ),
        },
      ),
    );
  }
}
