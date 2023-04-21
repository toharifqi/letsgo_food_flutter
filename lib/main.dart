import 'package:flutter/material.dart';
import 'package:letsgo_food/model/restaurant.dart';
import 'package:letsgo_food/pages/detail_page.dart';
import 'package:letsgo_food/pages/list_page.dart';
import 'package:letsgo_food/theme/style.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: secondaryColor,
        ),
      ),
      initialRoute: ListPage.routeName,
      routes: {
        ListPage.routeName: (context) => const ListPage(),
        DetailPage.routeName: (context) => DetailPage(
          restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
        )
      },
    );
  }
}
