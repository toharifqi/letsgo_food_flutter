import 'dart:io';

import 'package:flutter/foundation.dart';
import '../data/api/api_service.dart';
import '../data/model/restaurant_model.dart';
import 'result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurants();
  }

  late List<Restaurant> _restaurantList;
  List<Restaurant> get resultList => _restaurantList;

  late Restaurant _restaurant;
  Restaurant get resultDetail => _restaurant;

  late ResultState _state;
  ResultState get state => _state;

  String _message = "";
  String get message => _message;

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantsResult = await apiService.getAllRestaurants();

      if (restaurantsResult.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "empty data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantList = restaurantsResult.restaurants;
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

  Future<dynamic> searchRestaurants(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final foundedRestaurantResult = await apiService.searchRestaurants(query);

      if (foundedRestaurantResult.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "empty data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantList = foundedRestaurantResult.restaurants;
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

  Future<dynamic> getDetailRestaurant(String restaurantId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetailResult = await apiService.getRestaurantDetail(restaurantId);

      if (restaurantDetailResult.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Restaurant is not available.";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurant = restaurantDetailResult.restaurant;
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
