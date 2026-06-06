// import 'package:flutter/material.dart';
// import 'package:pro/Home/home.dart';
// import 'package:pro/MyTasks/mytasks.dart';
// import 'package:pro/Profile/profile.dart';
// import 'package:pro/Tasks/tasks.dart';
// import 'package:pro/Image/images&icons.dart';

// class Bottom extends StatefulWidget {
//   const Bottom({super.key});

//   @override
//   State<Bottom> createState() => _BottomState();
// }

// class _BottomState extends State<Bottom> {
//   int selectedIndex = 0;

//   final List<Widget> pages = [Home(),Tasks(),Mytasks(),Profile()];

//   void ontapped(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[selectedIndex],

//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 8,
//         child: SizedBox(
//           height: 70,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               GestureDetector(
//                 onTap: () => ontapped(0),
//                 child: bottomwidgets(
//                   image: AppIcons.home,
//                   name: 'Home',
//                   index: 0,
//                 ),
//               ),

//               GestureDetector(
//                 onTap: () => ontapped(1),
//                 child: bottomwidgets(
//                   image: AppIcons.tasks,
//                   name: 'Task',
//                   index: 1,
//                 ),
//               ),

//               const SizedBox(width: 40),

//               GestureDetector(
//                 onTap: () => ontapped(2),
//                 child: bottomwidgets(
//                   image: AppIcons.mytask,
//                   name: 'Booking',
//                   index: 2,
//                 ),
//               ),

//               GestureDetector(
//                 onTap: () => ontapped(3),
//                 child: bottomwidgets(
//                   image: AppIcons.profile,
//                   name: 'Profile',
//                   index: 3,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget bottomwidgets({
//     required String image,
//     required String name,
//     required int index,
//   }) {
//     bool isSelected = selectedIndex == index;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Image.asset(
//           image,
//           scale: 5,
//           color: isSelected ? Colors.red : Colors.grey,
//         ),
//         const SizedBox(height: 4),
//         Text(
//           name,
//           style: TextStyle(color: isSelected ? Colors.red : Colors.grey),
//         ),
//       ],
//     );
//   }
// }