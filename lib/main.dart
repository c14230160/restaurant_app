import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/api/api_service.dart';
import 'data/db/database_helper.dart';
import 'data/provider/favorite_provider.dart';
import 'data/provider/restaurant_provider.dart';
import 'data/provider/theme_provider.dart';
import 'data/provider/reminder_provider.dart';

import 'style/app_theme.dart';
import 'ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(ApiService())..fetchRestaurants(),
        ),

        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(DatabaseHelper())..loadFavorites(),
        ),

        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        ChangeNotifierProvider(create: (_) => ReminderProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: AppTheme.lightTheme,

            darkTheme: AppTheme.darkTheme,

            themeMode: themeProvider.themeMode,

            home: const HomePage(),
          );
        },
      ),
    );
  }
}
