import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/feature/settings_provider.dart';
import 'task_bottom_sheet.dart';

class LayoutView extends StatelessWidget {
  static const String routeName = "layout";

  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const TaskBottomSheet(),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      extendBody: true,
      body: vm.screens[vm.currentIndex],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10.0,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: vm.isDark() ? const Color(0xFF141922) : const Color(0xFFFFFFFF),
          currentIndex: vm.currentIndex,
          onTap: vm.changeIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "Tasks",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
