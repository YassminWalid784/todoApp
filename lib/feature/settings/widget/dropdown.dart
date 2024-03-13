import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../settings_provider.dart';

class CustomDrop extends StatelessWidget {
  const CustomDrop({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    final List<String> themeList = [];
    final List<String> customList=[];

    return CustomDropdown<String>(
      items: customList,
      initialItem: vm.isDark() ? "Dark" : "Light",
      decoration: CustomDropdownDecoration(
        expandedSuffixIcon: Icon(
          Icons.keyboard_arrow_up_rounded,
          color: vm.isDark() ? const Color(0xFF5D9CEC) : Colors.black,
        ),
        closedSuffixIcon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: vm.isDark() ? const Color(0xFF5D9CEC) : Colors.black,
        ),
        closedFillColor: vm.isDark() ? const Color(0xFF141922) : Colors.white,
        expandedFillColor: vm.isDark() ? const Color(0xFF141922) : Colors.white,
      ),
      onChanged: (value) {
        if (value == "Dark") {
          vm.changeTheme(ThemeMode.dark);
        } else if (value == "Light") {
          vm.changeTheme(ThemeMode.light);
        }
      },
    );
  }
}
