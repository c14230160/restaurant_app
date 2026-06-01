import 'package:flutter/material.dart';

import '../db/database_helper.dart';

class FavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  FavoriteProvider(this.databaseHelper);

  List<Map<String, dynamic>> favorites = [];

  Future<void> loadFavorites() async {
    favorites = await databaseHelper.getFavorites();
    notifyListeners();
  }

  Future<void> addFavorite(Map<String, dynamic> restaurant) async {
    await databaseHelper.insertFavorite(restaurant);

    await loadFavorites();
  }

  Future<void> removeFavorite(String id) async {
    await databaseHelper.removeFavorite(id);

    await loadFavorites();
  }

  Future<bool> isFavorite(String id) async {
    return databaseHelper.isFavorite(id);
  }
}
