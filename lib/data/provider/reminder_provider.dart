import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/notification_service.dart';

class ReminderProvider extends ChangeNotifier {
  bool _isReminderActive = false;

  bool get isReminderActive => _isReminderActive;

  final NotificationService _notificationService =
      NotificationService();

  ReminderProvider() {
    loadReminder();
  }

  Future<void> loadReminder() async {
    final prefs = await SharedPreferences.getInstance();

    _isReminderActive =
        prefs.getBool('reminder') ?? false;

    notifyListeners();
  }

  Future<void> setReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('reminder', value);

    _isReminderActive = value;

    if (value) {
      await _notificationService.scheduleDailyReminder();
    } else {
      await _notificationService.cancelReminder();
    }

    notifyListeners();
  }
}import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/notification_service.dart';

class ReminderProvider extends ChangeNotifier {
  bool _isReminderActive = false;

  bool get isReminderActive => _isReminderActive;

  final NotificationService _notificationService =
      NotificationService();

  ReminderProvider() {
    loadReminder();
  }

  Future<void> loadReminder() async {
    final prefs = await SharedPreferences.getInstance();

    _isReminderActive =
        prefs.getBool('reminder') ?? false;

    notifyListeners();
  }

  Future<void> setReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('reminder', value);

    _isReminderActive = value;

    if (value) {
      await _notificationService.scheduleDailyReminder();
    } else {
      await _notificationService.cancelReminder();
    }

    notifyListeners();
  }
}