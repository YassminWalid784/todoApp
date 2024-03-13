import 'package:flutter/material.dart';
import 'package:todo_app/feature/settings/page/settings_view.dart';
import 'package:todo_app/feature/task/page/task_view.dart';


class SettingsProvider extends ChangeNotifier {

  List<Widget> screens = [
     const TasksView(),
     SettingsView(),
  ];
  String currlanguage = 'en';
  int currentIndex = 0;
  DateTime selectedDate = DateTime.now();
  selectDateTime(BuildContext context) async {
    var currentSelectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: selectedDate,
      currentDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      locale: Locale(currlanguage),
    );
    if (currentSelectedDate == null) return;
    selectedDate = currentSelectedDate;
    notifyListeners();
  }



  changeIndex(int index) {

    currentIndex = index;
    notifyListeners();

  }
  String currentlanguage = 'en';
  changeLanguage(String newLanguage) {
    if (currentlanguage == newLanguage) return;
    currentlanguage = newLanguage;
    notifyListeners();
  }



  ThemeMode currentThemeMode = ThemeMode.light;

  changeTheme(ThemeMode newThemeMode) {
    if (currentThemeMode == newThemeMode) return;
    currentThemeMode = newThemeMode;
    notifyListeners();

  }
  bool isDark() {
    return currentThemeMode == ThemeMode.dark;
  }
}