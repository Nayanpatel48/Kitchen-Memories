import 'package:flutter/material.dart';
import 'package:k/views/home_page.dart';
import 'package:k/views/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;

  final List<Widget> _pages = [const HomePage(), const SearchPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentPageIndex, children: _pages),

      bottomNavigationBar: _buildFloatingNavBar(),
    );
  }

  Widget _buildFloatingNavBar() {
    return SafeArea(
      child: Container(
        height: 70,
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _customNavItem(0, Icons.home_rounded, "Home", Colors.blue),
            _customNavItem(1, Icons.search_rounded, "Search", Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _customNavItem(
    int index,
    IconData icon,
    String label,
    Color activeColor,
  ) {
    bool isSelected = currentPageIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentPageIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 60,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // The Icon
            Icon(
              icon,
              color: isSelected ? activeColor : Colors.grey.shade400,
              size: 45,
            ),

            const Spacer(),

            // The Animated Underline
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: 4,
              // If selected, width is 25, otherwise 0 (invisible)
              width: isSelected ? 25 : 0,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
