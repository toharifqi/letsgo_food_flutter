import 'dart:io';

import 'package:flutter/foundation.dart';
import '../data/api/api_service.dart';
import '../data/model/restaurant_model.dart';
import 'result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    fetchAllRestaurants();
  }

  late List<Restaurant> _restaurants;
  List<Restaurant> get result => _restaurants;

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  String _message = "";
  String get message => _message;

  Future<dynamic> fetchAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantsResult = await apiService.getAllRestaurants();

      if (restaurantsResult.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Nothing to show.";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurants = restaurantsResult.restaurants;
      }
    } on SocketException catch (_) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No internet connection.";
    } catch (_) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Failed to load restaurants.";
    }
  }

  Future<dynamic> searchRestaurants(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final foundedRestaurantResult = await apiService.searchRestaurants(query);

      if (foundedRestaurantResult.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Can't find this restaurant: $query";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurants = foundedRestaurantResult.restaurants;
      }
    } on SocketException catch (_) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No internet connection.";
    } catch (_) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Failed to search restaurant.";
    }
  }

}
