import 'package:flutter/material.dart';
import 'package:letsgo_food/data/api/api_service.dart';
import 'package:letsgo_food/data/db/database_helper.dart';
import 'package:letsgo_food/data/model/restaurant_model.dart';
import 'package:letsgo_food/data/preferences/preference_helper.dart';
import 'package:letsgo_food/provider/database_provider.dart';
import 'package:letsgo_food/provider/preferences_provider.dart';
import 'package:letsgo_food/provider/restaurant_detail_provider.dart';
import 'package:letsgo_food/provider/restaurant_list_provider.dart';
import 'package:letsgo_food/theme/style.dart';
import 'package:letsgo_food/ui/favorite_page.dart';
import 'package:letsgo_food/ui/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/navigation.dart';
import 'ui/detail_page.dart';
import 'ui/list_page.dart';

import 'package:provider/provider.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RestaurantListProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => RestaurantDetailProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
        ChangeNotifierProvider(create: (_) => PreferencesProvider(
          preferencesHelper: PreferencesHelper(
            sharedPreferences: SharedPreferences.getInstance()
          )
        ))
      ],
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
          ListPage.routeName: (context) => const ListPage(),
          DetailPage.routeName: (context) => DetailPage(
            restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
          ),
          FavoritePage.routeName: (context) => const FavoritePage(),
          SettingPage.routeName: (context) => const SettingPage(),
        },
      ),
    );
  }
}
