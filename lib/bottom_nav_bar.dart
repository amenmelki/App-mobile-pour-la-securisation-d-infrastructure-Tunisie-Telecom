import 'package:flutter/material.dart';
import '../../user_account.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int, BuildContext) onTap;
  final List<BottomNavItem> navItems;
  final BuildContext context;
  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
    required this.navItems,
    required this.context,
    required int currentIndex,
    required List<BottomNavigationBarItem> items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: (index) => onTap(index, context), // Pass context to onTap callback
      selectedFontSize: 16,
      unselectedFontSize: 16,
      iconSize: 30,
      items: List.generate(
        navItems.length,
        (index) => BottomNavigationBarItem(
          icon: Icon(navItems[index].icon),
          label: navItems[index].label,
        ),
      ),
    );
  }
}

class BottomNavItem {
  BottomNavItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;
}
