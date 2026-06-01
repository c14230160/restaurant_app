import 'package:flutter/material.dart';
import '../api/api_service.dart';

sealed class RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<dynamic> restaurants;

  RestaurantLoaded(this.restaurants);
}

class RestaurantError extends RestaurantState {
  final String message;

  RestaurantError(this.message);
}

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider(this.apiService);

  RestaurantState state = RestaurantLoading();

  Future<void> fetchRestaurants() async {
    try {
      state = RestaurantLoading();
      notifyListeners();

      final result = await apiService.getRestaurantList();

      state = RestaurantLoaded(result);

      notifyListeners();
    } catch (e) {
      state = RestaurantError(e.toString());

      notifyListeners();
    }
  }
}
