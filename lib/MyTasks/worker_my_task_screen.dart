
import 'package:flutter/material.dart';
import 'package:pro/Colors/color.dart';
import 'package:pro/Detail/accepttask_worker_detail_screen.dart';
import 'package:pro/Detail/completed_task_detailscreen.dart';
import 'package:pro/Detail/inprogresstask_detail_screen.dart';
import 'package:pro/Image/images&icons.dart';
import 'package:pro/Profile/worker_profile_provider.dart';
import 'package:pro/Provider/accepted_task_provider.dart';
import 'package:pro/Provider/complete_task_provider.dart';
import 'package:pro/Provider/in_progress_task_provider.dart';
import 'package:provider/provider.dart';

class WorkerMyTaskScreen extends StatefulWidget {
  @override
  _WorkerMyTaskScreenState createState() => _WorkerMyTaskScreenState();
}

class _WorkerMyTaskScreenState extends State<WorkerMyTaskScreen> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final workerId = Provider.of<WorkerProfileProvider>(context, listen: false).profile?.workerId ?? "";
      
      // Fetch data for all three categories
      Provider.of<AcceptedTaskProvider>(context, listen: false).fetchAcceptedTasks(workerId);
      Provider.of<InProgressTaskProvider>(context, listen: false).fetchInProgressTasks(workerId);
      Provider.of<CompleteTaskProvider>(context, listen: false).fetchCompletedTasks(workerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tasks',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // --- Custom Tabs Section ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabItem(0, "Accepted Task"),
                _buildTabItem(1, "In Progress"),
                _buildTabItem(2, "Completed"),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // --- Task List Section ---
          Expanded(
            child: _buildTaskListByTab(),
          ),
        ],
      ),
    );
  }

  // Logic to switch between Providers based on Tab Index
  Widget _buildTaskListByTab() {
    if (_selectedTabIndex == 0) {
      return Consumer<AcceptedTaskProvider>(
        builder: (context, provider, _) => _buildList(provider.isLoading, provider.tasks, "No accepted tasks"),
      );
    } else if (_selectedTabIndex == 1) {
      return Consumer<InProgressTaskProvider>(
        builder: (context, provider, _) => _buildList(provider.isLoading, provider.tasks, "No tasks in progress"),
      );
    } else {
      return Consumer<CompleteTaskProvider>(
        builder: (context, provider, _) => _buildList(provider.isLoading, provider.tasks, "No completed tasks"),
      );
    }
  }

  // Generic List Builder
  Widget _buildList(bool isLoading, List tasks, String emptyMessage) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFFA13C2B)));
    }
    if (tasks.isEmpty) {
      return Center(child: Text(emptyMessage));
    }
    return RefreshIndicator(
     onRefresh:   () async {
 
    await Future.delayed(Duration(seconds: 1));},
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tasks.length,
        itemBuilder: (context, index) => _buildTaskCard(tasks[index]),
      ),
    );
  }

  // Tab Button Widget
  Widget _buildTabItem(int index, String title) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF1F0) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFFA13C2B) : Colors.grey,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // Generic Task Card (Works with different models as long as property names match)
    Widget _buildTaskCard(dynamic task) {
    return GestureDetector(
      onTap: () {
        // Navigate based on the selected tab index
        if (_selectedTabIndex == 0) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ProjectDetailsScreen(task: task)));
        } else if (_selectedTabIndex == 1) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => InprogresstaskDetailScreen(task: task)));
        } else {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => CompletedTaskDetailscreen(task: task)));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.container_color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.categoryName ?? "Category",
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF535E73)),
                ),
                Text(
                  "₹${task.budget}/-",
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF535E73)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Image.asset(AppIcons.loc, scale: 5, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    task.location ?? "No Location",
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Divider(color: Color(0xFFF0F0F0), thickness: 1.5),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.taskDescription ?? "No description available",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Color(0xFF7D8797), fontSize: 13, height: 1.4),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF535E73)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}