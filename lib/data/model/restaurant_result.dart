import 'dart:convert';
import 'restaurant_model.dart';

class RestaurantsResult {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  RestaurantsResult({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantsResult.fromRawJson(String str) => RestaurantsResult._fromJson(json.decode(str));

  factory RestaurantsResult._fromJson(Map<String, dynamic> json) => RestaurantsResult(
    error: json["error"],
    message: json["message"],
    count: json["count"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );
}

class RestaurantDetailResult {
  bool error;
  String message;
  Restaurant restaurant;

  RestaurantDetailResult({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResult.fromRawJson(String str) => RestaurantDetailResult._fromJson(json.decode(str));

  factory RestaurantDetailResult._fromJson(Map<String, dynamic> json) => RestaurantDetailResult(
    error: json["error"],
    message: json["message"],
    restaurant: Restaurant.fromJson(json["restaurant"]),
  );
}

class FoundedRestaurantResult {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  FoundedRestaurantResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory FoundedRestaurantResult.fromRawJson(String str) => FoundedRestaurantResult._fromJson(json.decode(str));

  factory FoundedRestaurantResult._fromJson(Map<String, dynamic> json) => FoundedRestaurantResult(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );
}
