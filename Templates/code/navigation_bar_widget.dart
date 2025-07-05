// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class NavigationBarItem {
  final IconData icon;
  final String label;
  final Color? iconColor;
  final double? iconSize;
  final TextStyle? labelStyle;
  final VoidCallback? onTap;

  NavigationBarItem({
    required this.icon,
    required this.label,
    this.iconColor,
    this.iconSize,
    this.labelStyle,
    this.onTap,
  });
}

typedef OnItemTap = void Function(int index);

class CustomNavigationBar extends StatelessWidget {
  final List<NavigationBarItem> items;
  final int currentIndex;
  final OnItemTap onTap;
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double iconSize;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;

  // Removed defaultNavigationBarItems to make the widget fully customizable by passing items from main.dart

  const CustomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    required this.backgroundColor,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.iconSize,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == currentIndex;
          return Expanded(
            child: InkWell(
              onTap: item.onTap ?? () => onTap(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      size: item.iconSize ?? iconSize,
                      color: item.iconColor ??
                          (isSelected ? selectedItemColor : unselectedItemColor),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: item.labelStyle ??
                          (isSelected
                              ? (selectedLabelStyle ??
                                  TextStyle(
                                      color: selectedItemColor,
                                      fontWeight: FontWeight.bold))
                              : (unselectedLabelStyle ??
                                  TextStyle(color: unselectedItemColor))),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class NavigationBarApp extends StatefulWidget {
  final List<NavigationBarItem> items;
  final List<Widget> pages;

  const NavigationBarApp({super.key, required this.items, required this.pages});

  @override
  _NavigationBarAppState createState() => _NavigationBarAppState();
}

class _NavigationBarAppState extends State<NavigationBarApp> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.items.length == widget.pages.length, 'Items and pages length must be equal');
    return Scaffold(
      body: widget.pages[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        items: widget.items,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        iconSize: 28.0,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}
// // .....................................
// $$$$$$$ Demo usage in main.dart
// import 'package:flutter/material.dart';
// import 'navigation_bar_widget.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Customizable Navigation Bar Demo',
//       debugShowCheckedModeBanner: false,
//       home: NavigationBarApp(
//         items: [
//           NavigationBarItem(
//             icon: Icons.home,
//             label: 'Home',
//             iconColor: Colors.blue,
//             iconSize: 30.0,
//             labelStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//             onTap: () {
//               print('Home tapped');
//             },
//           ),
//           NavigationBarItem(
//             icon: Icons.search,
//             label: 'Search',
//             iconColor: Colors.grey,
//             iconSize: 28.0,
//             labelStyle: const TextStyle(color: Colors.grey),
//             onTap: () {
//               print('Search tapped');
//             },
//           ),
//           NavigationBarItem(
//             icon: Icons.settings,
//             label: 'Settings',
//             iconColor: Colors.grey,
//             iconSize: 28.0,
//             labelStyle: const TextStyle(color: Colors.grey),
//             onTap: () {
//               print('Settings tapped');
//             },
//           ),
//         ],
//         pages: [
//           Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
//           Center(child: Text('Search Page', style: TextStyle(fontSize: 24))),
//           Center(child: Text('Settings Page', style: TextStyle(fontSize: 24))),
//         ],
//       ),
//     );
//   }
// }
