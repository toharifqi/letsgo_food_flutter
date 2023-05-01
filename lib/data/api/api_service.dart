import 'package:http/http.dart' as http;

import '../model/restaurant_result.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";

  Future<RestaurantsResult> getAllRestaurants() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));

    if (response.statusCode == 200) {
      return RestaurantsResult.fromRawJson(response.body);
    } else {
      throw Exception("Failed to load restaurants");
    }
  }

  Future<RestaurantDetailResult> getRestaurantDetail(
      String restaurantId
  ) async {
    final response =
        await http.get(Uri.parse("${_baseUrl}/detail/$restaurantId"));

    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromRawJson(response.body);
    } else {
      throw Exception("Failed to load restaurants");
    }
  }

  Future<FoundedRestaurantResult> searchRestaurants(
      String query
  ) async {
    final response =
    await http.get(Uri.parse("${_baseUrl}/search?q=$query"));

    if (response.statusCode == 200) {
      return FoundedRestaurantResult.fromRawJson(response.body);
    } else {
      throw Exception("Failed to load restaurants");
    }
  }
}
