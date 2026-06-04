import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/provider/favorite_provider.dart';
import 'detail_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Restaurants'),
        centerTitle: true,
      ),
      body: provider.favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorite restaurants yet',
              ),
            )
          : ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                final restaurant = provider.favorites[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/small/${restaurant['pictureId']}',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,

                        loadingBuilder: (
                          context,
                          child,
                          loadingProgress,
                        ) {
                          if (loadingProgress == null) {
                            return child;
                          }

                          return const SizedBox(
                            width: 60,
                            height: 60,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },

                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.broken_image,
                              size: 30,
                            ),
                          );
                        },
                      ),
                    ),
                    title: Text(
                      restaurant['name'],
                    ),
                    subtitle: Text(
                      restaurant['city'],
                    ),
                    trailing: Text(
                      '⭐ ${restaurant['rating']}',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPage(
                            restaurant: restaurant,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}