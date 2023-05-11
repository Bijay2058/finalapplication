import 'package:flutter/material.dart';
import 'package:untitled2/screens/home.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:untitled2/screens/news_screen.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() =>
      _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(17, 26, 41, 0.9),
      // backgroundColor: bottomNavigationBarColor,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.newspaper),
          activeIcon: Icon(LucideIcons.newspaper),
          label: 'News',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.compass),
          activeIcon: Icon(LucideIcons.compass),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.calendar),
          activeIcon: Icon(LucideIcons.calendar),
          label: 'Calender',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.user),
          activeIcon: Icon(LucideIcons.user),
          label: 'Profile',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _index,
      selectedItemColor: Colors.lightBlueAccent,
      unselectedItemColor: Colors.grey,
      onTap: (value) {
        switch (value) {
          case 0:
            Navigator.pushNamed(context, HomeScreen.id);

            break;
          case 1:
            Navigator.pushNamed(context, NewsScreen.id);
            break;
          default:
        }
        setState(() {
          _index = value;
        });
      },
    );
  }
}