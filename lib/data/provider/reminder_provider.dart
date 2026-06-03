import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/notification_service.dart';

class ReminderProvider extends ChangeNotifier {
  bool _isReminderActive = false;

  bool get isReminderActive => _isReminderActive;

  ReminderProvider() {
    loadReminder();
  }

  Future<void> loadReminder() async {
    final prefs = await SharedPreferences.getInstance();

    _isReminderActive = prefs.getBool('reminder') ?? false;

    notifyListeners();
  }

  Future<void> setReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('reminder', value);

    _isReminderActive = value;

    if (value) {
      await NotificationService().scheduleDailyReminder();
    } else {
      await NotificationService().cancelReminder();
    }

    notifyListeners();
  }
}