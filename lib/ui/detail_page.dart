import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/api/api_service.dart';
import '../data/provider/detail_provider.dart';
import '../data/provider/favorite_provider.dart';

class DetailPage extends StatelessWidget {
  final dynamic restaurant;

  const DetailPage({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          DetailProvider(ApiService())..fetchDetail(restaurant['id']),
      child: Scaffold(
        appBar: AppBar(
          title: Text(restaurant['name']),
          centerTitle: true,
        ),
        body: Consumer<DetailProvider>(
          builder: (context, provider, child) {
            final state = provider.state;

            return switch (state) {
              DetailLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),

              DetailLoaded() => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                        child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/large/${state.restaurant['pictureId']}',
                          width: double.infinity,
                          height: 300,
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
                              height: 300,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },

                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return Container(
                              width: double.infinity,
                              height: 300,
                              color: Colors.grey,
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 60,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    state.restaurant['name'],
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                Consumer<FavoriteProvider>(
                                  builder: (
                                    context,
                                    favoriteProvider,
                                    child,
                                  ) {
                                    final isFavorite =
                                        favoriteProvider.favorites.any(
                                      (item) =>
                                          item['id'] ==
                                          state.restaurant['id'],
                                    );

                                    return IconButton(
                                      icon: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      onPressed: () async {
                                        if (isFavorite) {
                                          await favoriteProvider
                                              .removeFavorite(
                                            state.restaurant['id'],
                                          );

                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Removed from Favorite',
                                                ),
                                              ),
                                            );
                                          }
                                        } else {
                                          await favoriteProvider.addFavorite(
                                            state.restaurant,
                                          );

                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Added to Favorite',
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

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
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    state.restaurant['address'],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            Row(
                              children: [
                                Icon(
                                  Icons.location_city,
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.blue,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  state.restaurant['city'],
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  state.restaurant['rating']
                                      .toString(),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            const Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              state.restaurant['description'],
                              textAlign: TextAlign.justify,
                            ),

                            const SizedBox(height: 24),

                            const Text(
                              'Foods',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children:
                                  state.restaurant['menus']['foods']
                                      .map<Widget>(
                                        (food) => Chip(
                                          label: Text(
                                            food['name'],
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),

                            const SizedBox(height: 24),

                            const Text(
                              'Drinks',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children:
                                  state.restaurant['menus']['drinks']
                                      .map<Widget>(
                                        (drink) => Chip(
                                          label: Text(
                                            drink['name'],
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              DetailError() => const Center(
                  child: Text(
                    'Failed to load restaurant data',
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
}