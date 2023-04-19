import 'dart:convert';

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menus menus;

  static List<Restaurant> fromRawJson(String? json) {
    if (json == null) {
      return [];
    }
    
    final List parsed = jsonDecode(json);
    return parsed.map((json) => Restaurant.fromJson(json)).toList();
  }
  
  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"]?.toDouble(),
    menus: Menus.fromJson(json["menus"]),
  );
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<Drink> foods;
  List<Drink> drinks;

  factory Menus.fromRawJson(String str) => Menus.fromJson(json.decode(str));
  
  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods: List<Drink>.from(json["foods"].map((x) => Drink.fromJson(x))),
    drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
  );
}

class Drink {
  Drink({
    required this.name,
  });

  String name;

  factory Drink.fromRawJson(String str) => Drink.fromJson(json.decode(str));
  
  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
    name: json["name"],
  );
}
