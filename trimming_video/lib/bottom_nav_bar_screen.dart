import 'package:flutter/material.dart';
import 'package:trimming_video/core/theme/app_pallete.dart';
import 'package:trimming_video/features/tasks_task/presentation/pages/tasks_page.dart';
import 'package:trimming_video/features/trimming_videos/presentation/pages/home_page.dart';

class BottomNavBarScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => BottomNavBarScreen(),
      );
  String? outputPath;
  BottomNavBarScreen({super.key, this.outputPath});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int selectedTabIndex = 0;

  void _onItemTapped(int index, BuildContext context) async {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedTabIndex,
        children: [
          widget.outputPath != null
              ? HomePage(outputPath: widget.outputPath)
              : HomePage(),
          const TasksPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Color(0xffF0F0F0),
            ),
          ),
          color: Colors.white,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          iconSize: 26,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.video_collection_outlined,
              ),
              label: 'Обрезка видео',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.book,
              ),
              label: 'Задачи',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 13.0,
          unselectedFontSize: 13.0,
          currentIndex: selectedTabIndex,
          onTap: (index) => _onItemTapped(index, context),
          selectedItemColor: AppPallete.backgroundColor,
          unselectedItemColor: AppPallete.greyColor,
        ),
      ),
    );
  }
}
