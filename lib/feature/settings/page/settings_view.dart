import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/feature/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  List<String> languageList = ["English", "عربي"];
  List<String> themeList = ["Dark", "Light"];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    var local = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: mediaQuery.width,
          height: mediaQuery.height * 0.22,
          color: theme.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Text(
            local.settings,
            style: theme.textTheme.titleLarge,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                local.language,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: vm.isDark()? Colors.white :Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: const Color(0xFF5D9CEC),
                  ),
                ),
                child: CustomDropdown<String>(
                  decoration: CustomDropdownDecoration(
                    expandedSuffixIcon: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: vm.isDark() ? const Color(0xFF5D9CEC) : Colors.black,
                    ),
                    closedSuffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: vm.isDark() ? const Color(0xFF5D9CEC) : Colors.black,
                    ),
                    closedFillColor:
                        vm.isDark() ? const Color(0xFF141922) : Colors.white,
                    expandedFillColor: vm.isDark() ? const Color(0xFF141922) : Colors.white,
                  ),
                  items: languageList,
                  initialItem: vm.currentlanguage == "en" ? "English" : "عربي",
                  onChanged: (value) {
                    if (value == "English") {
                      vm.changeLanguage("en");
                    } else if (value == "عربي") {
                      vm.changeLanguage("ar");
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                local.theme,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: vm.isDark()? Colors.white :Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF5D9CEC),
                  ),
                  //borderRadius: BorderRadius.circular(8.0),
                ),
                child: CustomDropdown<String>(
                  items: themeList,
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
                    closedFillColor:
                        vm.isDark() ? const Color(0xFF141922) : Colors.white,
                    expandedFillColor:
                        vm.isDark() ? const Color(0xFF141922) : Colors.white,
                  ),
                  onChanged: (value) {
                    if (value == "Dark") {
                      vm.changeTheme(ThemeMode.dark);
                    } else if (value == "Light") {
                      vm.changeTheme(ThemeMode.light);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
