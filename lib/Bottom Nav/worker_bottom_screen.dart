import 'package:flutter/material.dart';
import 'package:pro/Colors/color.dart';
import 'package:pro/Home/home.dart';
import 'package:pro/Image/images&icons.dart';
import 'package:pro/MyTasks/worker_my_task_screen.dart';
import 'package:pro/Profile/worker_profile_screen.dart';
import 'package:pro/Tasks/worker_task_screen.dart';

class WorkerBottomscreen extends StatefulWidget {
  const WorkerBottomscreen({super.key});

  @override
  State<WorkerBottomscreen> createState() => _WorkerBottomscreenState();
}

class _WorkerBottomscreenState extends State<WorkerBottomscreen> {
  int selectedIndex = 0;

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> pages = [
    WorkerHomeScreen(),
    WorkerTaskScreen(),
    WorkerMyTaskScreen(),
    WorkerProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: pages[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              bottomFields(
                image: AppIcons.home,
                index: 0,
                name: 'Home',
                onTap: () => onTapped(0),
              ),
              bottomFields(
                image: AppIcons.tasks,
                index: 1,
                name: 'Tasks',
                onTap: () => onTapped(1),
              ),
              bottomFields(
                image: AppIcons.mytask,
                index: 2,
                name: 'My Tasks',
                onTap: () => onTapped(2),
              ),
              bottomFields(
                image: AppIcons.profile,
                index: 3,
                name: 'Profile',
                onTap: () => onTapped(3),
              ),
            ],
          ),
      ),
    
      
    );
  }

  Widget bottomFields({
    required String image,
    required String name,
    required int index,
    required Function() onTap,
  }) {
    final bool isSelected = selectedIndex == index;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      splashColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            image,
            scale: 5,
            color: isSelected ? AppColors.color1 : Colors.grey,
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? AppColors.color1 : Colors.grey,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
