import 'package:flutter/foundation.dart';
import 'package:letsgo_food/data/db/database_helper.dart';

import '../data/model/restaurant_model.dart';
import 'result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getAllFavorites();
  }

  late List<Restaurant> _restaurants;
  List<Restaurant> get result => _restaurants;

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  String _message = "";
  String get message => _message;

  void _getAllFavorites() async {
    _restaurants = await databaseHelper.getAllFavorites();

    if (_restaurants.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = "You don't have any favorite restaurant yet.";
    }

    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getAllFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = "Error: $e";
      notifyListeners();
    }
  }

  Future<bool> isRestaurantFavorite(String id) async {
    final result = await databaseHelper.getFavoriteById(id);
    return (result != null);
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.deleteFavorite(id);
      _getAllFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = "Error: $e";
      notifyListeners();
    }
  }
}
