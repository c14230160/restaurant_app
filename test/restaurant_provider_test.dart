import 'package:flutter_test/flutter_test.dart';

import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/provider/restaurant_provider.dart';

class FakeApiSuccess extends ApiService {
  @override
  Future<List<dynamic>> getRestaurantList() async {
    return [
      {'id': '1', 'name': 'Test Restaurant'},
    ];
  }
}

class FakeApiFailed extends ApiService {
  @override
  Future<List<dynamic>> getRestaurantList() async {
    throw Exception('Network Error');
  }
}

void main() {
  group('RestaurantProvider Test', () {
    test('Initial state should be RestaurantLoading', () {
      final provider = RestaurantProvider(FakeApiSuccess());

      expect(provider.state, isA<RestaurantLoading>());
    });

    test('Should return RestaurantLoaded when API succeeds', () async {
      final provider = RestaurantProvider(FakeApiSuccess());

      await provider.fetchRestaurants();

      expect(provider.state, isA<RestaurantLoaded>());

      final state = provider.state as RestaurantLoaded;

      expect(state.restaurants.length, 1);
    });

    test('Should return RestaurantError when API fails', () async {
      final provider = RestaurantProvider(FakeApiFailed());

      await provider.fetchRestaurants();

      expect(provider.state, isA<RestaurantError>());
    });
  });
}
