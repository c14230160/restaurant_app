import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/provider/theme_provider.dart';
import '../data/provider/reminder_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return SwitchListTile(
                title: const Text('Dark Theme'),
                subtitle: const Text('Enable dark mode'),
                value: themeProvider.isDarkTheme,
                onChanged: (value) {
                  themeProvider.setTheme(value);
                },
              );
            },
          ),

          Consumer<ReminderProvider>(
            builder: (context, reminderProvider, child) {
              return SwitchListTile(
                title: const Text('Daily Reminder'),
                subtitle: const Text('Enable lunch reminder notification'),
                value: reminderProvider.isReminderActive,
                onChanged: (value) {
                  reminderProvider.setReminder(value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
