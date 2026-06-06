import 'package:flutter/material.dart';
import 'package:pro/Colors/color.dart';
import 'package:pro/Detail/wokerdetailscreen.dart';
import 'package:pro/Provider/task_provider.dart';
import 'package:provider/provider.dart';

class WorkerTaskScreen extends StatefulWidget {
  const WorkerTaskScreen({super.key});

  @override
  State<WorkerTaskScreen> createState() => _WorkerTaskScreenState();
}

class _WorkerTaskScreenState extends State<WorkerTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).fetchNewTasks();
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
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tasks',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // SEARCH BAR
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                onChanged: (value) {
                  // Update search query in provider as user types
                  Provider.of<TaskProvider>(context, listen: false).setSearchQuery(value);
                },
                style: const TextStyle(color: Colors.grey, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Search by category...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: Colors.black87),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            Expanded(
              child: Consumer<TaskProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(
                        provider.errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  // Use filteredTasks instead of tasks
                  final displayedTasks = provider.filteredTasks;

                  if (displayedTasks.isEmpty) {
                    return const Center(child: Text("No tasks found matching category"));
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(Duration(seconds: 1));
                    },
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: displayedTasks.length,
                      itemBuilder: (context, index) {
                        final task = displayedTasks[index];
                        return TaskWidget(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Wokerdetailscreen(task: task.taskId),
                            ));
                          },
                          title: task.categoryname ?? '',
                          price: '₹${task.budget ?? '0'}/-',
                          location: task.location ?? 'No Location',
                          description: task.description ?? 'No Description',
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskWidget extends StatelessWidget {
  final String title;
  final String price;
  final String location;
  final String description;
  final Function() onTap;

  const TaskWidget({
    super.key,
    required this.title,
    required this.price,
    required this.location,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color textMain = Color(0xFF5A6175);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.container_color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textMain,
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: textMain,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: const TextStyle(color: textMain, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Color(0xFFE0E0E0), thickness: 1),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: textMain,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.chevron_right, color: textMain),
              ],
            ),
          ],
        ),
      ),
    );
  }
}