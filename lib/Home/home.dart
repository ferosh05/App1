import 'package:flutter/material.dart';
import 'package:pro/Colors/color.dart';
import 'package:pro/CustomWidgets/count_container_widget.dart';
import 'package:pro/CustomWidgets/home_app_bar_widget.dart';
import 'package:pro/CustomWidgets/menu_container_widget.dart';
import 'package:pro/Image/images&icons.dart';
import 'package:pro/MyTasks/worker_my_task_screen.dart';
import 'package:pro/Profile/worker_profile_provider.dart';
import 'package:pro/Provider/task_provider.dart';
import 'package:pro/Provider/worker_task_count_provider.dart';
import 'package:pro/Shop/shop_screen.dart';
import 'package:pro/Subscription/Subscriptionscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerHomeScreen extends StatefulWidget {
  const WorkerHomeScreen({super.key});

  @override
  State<WorkerHomeScreen> createState() => _WorkerHomeScreenState();
}

class _WorkerHomeScreenState extends State<WorkerHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadProfileData();
      // You can keep this for the list data if needed
      Provider.of<TaskProvider>(context, listen: false).fetchNewTasks();
    });
  }

  void loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final workerId = prefs.getString("id");

    if (workerId != null && mounted) {
      // Fetch Profile
      Provider.of<WorkerProfileProvider>(context, listen: false)
          .fetchWorkerProfile(workerId);
          
      // ADD THIS: Fetch Task Counts
      Provider.of<WorkerTaskCountProvider>(context, listen: false)
          .fetchTaskCount(workerId);
          
    } else {
      print("Error: Worker ID not found in SharedPreferences");
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<WorkerProfileProvider>(context);
    final taskProvider = Provider.of<WorkerTaskCountProvider>(context); // Listen to TaskProvider
    final mediaquery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 50.0),
        child: Column(
          children: [
            HomeAppBarWidget(
                name: profile.profile?.name ?? "",
                imgUrl: profile.profile?.avatar ?? ""),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: mediaquery.height * 0.03),
                   // SearchBarWidget(),
                    SizedBox(height: mediaquery.height * 0.03),
                    
                    // UPDATED ROW: Using data from taskProvider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CountContainerWidgets(
                          bgColor: AppColors.worker_card1_color,
                          text: 'New Task',
                          // Show '0' if data is loading or null
                          count: taskProvider.taskData?['new_tasks']?.toString() ?? '0',
                        ),
                        CountContainerWidgets(
                          bgColor: AppColors.worker_card2_color,
                          text: 'Accepted',
                          // Show '0' if data is loading or null
                          count: taskProvider.taskData?['accepted_tasks']?.toString() ?? '0',
                        ),
                      ],
                    ),
                    
                    SizedBox(height: mediaquery.height * 0.03),
                    Column(
                      children: [
                        MenuContainerWidgets(
                          icondata: AppIcons.viewall_task,
                          title: 'View all Tasks',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WorkerMyTaskScreen()));
                          },
                        ),
                        SizedBox(height: mediaquery.height * 0.008),
                        MenuContainerWidgets(
                          icondata: AppIcons.manage_sub_icon,
                          title: 'Manage Subscription',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubscriptionScreen()));
                          },
                        ),
                        SizedBox(height: mediaquery.height * 0.008),
                        MenuContainerWidgets(
                          icondata: AppIcons.visit_shop_icon,
                          title: 'Visit Shop',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShopScreen()));
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: mediaquery.height * 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}