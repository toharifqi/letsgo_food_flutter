import 'dart:io';

import 'package:flutter/foundation.dart';

import '../data/api/api_service.dart';
import '../data/model/restaurant_model.dart';
import 'result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailProvider({required this.apiService});

  late Restaurant _restaurant;
  Restaurant get result => _restaurant;

  late ResultState _state;
  ResultState get state => _state;

  String _message = "";
  String get message => _message;

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
