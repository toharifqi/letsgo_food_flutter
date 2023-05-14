import 'package:flutter_test/flutter_test.dart';
import 'package:letsgo_food/data/model/restaurant_model.dart';

void main() {
  test("fromRawJson, when given with string json, should return Restaurant with matched values", () {
    const id = "rqdv5juczeskfw1e867";
    const name = "Melting";
    const description = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...";
    const pictureId = "14";
    const city = "Medan";
    const rating = 4.2;

    const rawJson = """
      {
          "id": "$id",
          "name": "$name",
          "description": "$description",
          "pictureId": "$pictureId",
          "city": "$city",
          "rating": $rating
      }
    """;

    final result = Restaurant.fromRawJson(rawJson);

    expect(result.id, id);
    expect(result.name, name);
    expect(result.description, description);
    expect(result.pictureId, pictureId);
    expect(result.city, city);
    expect(result.rating, rating);
  });

  test("fromJson, when given with json in map, should return Restaurant with matched values", () {
    const id = "rqdv5juczeskfw1e867";
    const name = "Melting";
    const description = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...";
    const pictureId = "14";
    const city = "Medan";
    const rating = 4.2;

    final json = {
      "id": id,
      "name": name,
      "description": description,
      "city": city,
      "pictureId": pictureId,
      "rating": rating,
    };

    final result = Restaurant.fromJson(json);

    expect(result.id, id);
    expect(result.name, name);
    expect(result.description, description);
    expect(result.pictureId, pictureId);
    expect(result.city, city);
    expect(result.rating, rating);
  });

  test("toJson, when given with Restaurant, should return json with matched values", () {
    const id = "rqdv5juczeskfw1e867";
    const name = "Melting";
    const pictureId = "14";
    const city = "Medan";
    const rating = 4.2;

    final restaurant = Restaurant(
        id: id,
        name: name,
        description: null,
        city: city,
        pictureId: pictureId,
        categories: List.empty(),
        rating: rating,
        customerReviews: List.empty()
    );

    final result = restaurant.toJson();

    expect(result["id"], id);
    expect(result["name"], name);
    expect(result["pictureId"], pictureId);
    expect(result["city"], city);
    expect(result["rating"], rating);
  });
}
