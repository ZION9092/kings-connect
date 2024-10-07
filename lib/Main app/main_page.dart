// home_page.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kings_connect/Main%20app/favorites_page.dart';
import 'package:kings_connect/Main%20app/home_page.dart';
import 'package:kings_connect/Main%20app/Profile%20Pages/profile_page.dart';
import 'package:kings_connect/constants/colors.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:kings_connect/constants/font_sizes.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Controller for managing PageView navigation
  final PageController _pageController = PageController();
  // Index for snake navigation bar
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children:  const [
          HomeScreen(), // The Home screen UI you provided
          FavoritesPage(), // Placeholder for Favorites
          ProfilePage(), // Placeholder for Profile
        ],
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.indicator,
        padding: const EdgeInsets.all(12),
        backgroundColor: AppColors.white,
        snakeViewColor: AppColors.primary,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(letterSpacing: -1,fontWeight: FontSizes.bold),
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            _pageController.jumpToPage(index); // Navigate to the selected page
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Iconsax.heart), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),
    );
  }
}
