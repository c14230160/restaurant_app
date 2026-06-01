import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/provider/restaurant_provider.dart';
import 'detail_page.dart';
import 'favorite_page.dart';
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RestaurantProvider>(context);
    final state = provider.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),
        ],
      ),

      body: switch (state) {
        RestaurantLoading() => const Center(child: CircularProgressIndicator()),

        RestaurantLoaded() => RefreshIndicator(
          onRefresh: () async {
            await provider.fetchRestaurants();
          },
          child: ListView.builder(
            itemCount: state.restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = state.restaurants[index];

              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(restaurant: restaurant),
                    ),
                  );
                },
                child: Card(
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/medium/${restaurant['pictureId']}',
                          width: double.infinity,
                          height: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant['name'],
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.red,
                                ),
                                const SizedBox(width: 4),
                                Text(restaurant['city']),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.orange),
                                const SizedBox(width: 4),
                                Text(restaurant['rating'].toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        RestaurantError() => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 80, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Failed to load restaurants',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  provider.fetchRestaurants();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      },
    );
  }
}
