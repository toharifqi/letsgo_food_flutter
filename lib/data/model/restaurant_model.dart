import 'dart:convert';

class Restaurant {
  String id;
  String name;
  String? description;
  String city;
  String? address;
  String pictureId;
  List<Category> categories;
  Menus? menus;
  double rating;
  List<CustomerReview> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    this.address,
    required this.pictureId,
    required this.categories,
    this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory Restaurant.fromRawJson(String str) =>
      Restaurant.fromJson(json.decode(str));

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category._fromJson(x))),
        menus: json["menus"] == null ? null : Menus._fromJson(json["menus"]),
        rating: json["rating"]?.toDouble(),
        customerReviews: json["customerReviews"] == null
            ? []
            : List<CustomerReview>.from(json["customerReviews"]!
                .map((x) => CustomerReview._fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "pictureId": pictureId,
        "rating": rating,
      };
}

class Category {
  String name;

  Category({
    required this.name,
  });

  factory Category._fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );
}

class CustomerReview {
  String name;
  String review;
  String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview._fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );
}

class Menus {
  List<Category> foods;
  List<Category> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus._fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Category>.from(
            json["foods"].map((x) => Category._fromJson(x))),
        drinks: List<Category>.from(
            json["drinks"].map((x) => Category._fromJson(x))),
      );
}
