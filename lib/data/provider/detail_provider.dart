import 'package:flutter/material.dart';

import '../api/api_service.dart';

sealed class DetailState {}

class DetailLoading extends DetailState {}

class DetailLoaded extends DetailState {
  final dynamic restaurant;

  DetailLoaded(this.restaurant);
}

class DetailError extends DetailState {
  final String message;

  DetailError(this.message);
}

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailProvider(this.apiService);

  DetailState state = DetailLoading();

  Future<void> fetchDetail(String id) async {
    try {
      state = DetailLoading();
      notifyListeners();

      final result = await apiService.getRestaurantDetail(id);

      state = DetailLoaded(result);

      notifyListeners();
    } catch (e) {
      state = DetailError('Failed to load restaurant data');

      notifyListeners();
    }
  }
}
