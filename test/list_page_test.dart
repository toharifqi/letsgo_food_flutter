import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:letsgo_food/data/api/api_service.dart';
import 'package:letsgo_food/provider/restaurant_list_provider.dart';
import 'package:letsgo_food/ui/list_page.dart';
import 'package:provider/provider.dart';

Widget createListPage() => ChangeNotifierProvider<RestaurantListProvider>(
      create: (context) => RestaurantListProvider(apiService: ApiService()),
      child: const MaterialApp(
        home: ListPage(),
      ),
    );

void main() {
  group("List Page Test", () {
    testWidgets("when open list page, should show search hint on search bar",
        (WidgetTester tester) async {
      await tester.pumpWidget(createListPage());
      expect(find.textContaining("Search restaurant..."), findsOneWidget);
    });
  });
}
