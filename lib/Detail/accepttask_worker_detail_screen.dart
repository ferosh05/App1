import 'package:flutter/material.dart';
import 'package:pro/CustomWidgets/filled_button_widget.dart';
import 'package:pro/Detail/add_requirement_screen.dart';
import 'package:pro/Model/accepted_task_model.dart';
import 'package:pro/Profile/worker_profile_provider.dart';
import 'package:pro/Provider/task_status_change_provider.dart';
import 'package:provider/provider.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final AcceptedTaskModel task;

  const ProjectDetailsScreen({super.key, required this.task});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final worker = Provider.of<WorkerProfileProvider>(context);
    
    // Logic to check if requirements exist
    bool hasRequirements = widget.task.requirements != null && 
                           widget.task.requirements!.trim().isNotEmpty;

    // Logic for status (0: Not Started, 1: In Progress, 2: Completed)
    int status = int.tryParse(widget.task.status.toString()) ?? 0;
    final statusprovider=Provider.of<TaskActionProvider>(context);

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
          "View Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Name and Category Tag
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.task.categoryName ?? "Suresh Kumar", // Using name from image as fallback
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF455A64)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBE9E7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.task.jobCategory ?? "Painting",
                    style: const TextStyle(color: Color(0xFFD32F2F), fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Basic Info Rows
            _buildInfoRow(Icons.account_balance_wallet_outlined, "Budget - ₹ ${widget.task.budget ?? '15,000'}/-"),
            const SizedBox(height: 15),
            _buildInfoRow(Icons.location_on_outlined, "Location - ${widget.task.location ?? 'Coimbatore'}"),
            const SizedBox(height: 15),
            _buildInfoRow(Icons.calendar_today_outlined, "Expected Dead line - ${widget.task.deadlineDate ?? '20 September, 2025'}"),
            
            const SizedBox(height: 35),

            // --- STATUS TIMELINE SECTION ---
            if (hasRequirements) ...[
              _buildTimelineRow(
                child: _buildActionButton("Start the work", status == 0,() {
                  print("Attempting to start task with ID: ${widget.task.taskId}");

  if (widget.task.taskId == null || widget.task.taskId.toString().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Error: Task ID is missing from data")),
    );
    return;
  }

  // 2. Call provider (Ensure you convert to string if the API expects it)
  statusprovider.startTask(widget.task.taskId.toString(), context);
                },),
                isFirst: true,
                isLast: false,
              ),
              _buildTimelineRow(
                child: Text("In Progress", style: TextStyle(color: Colors.blueGrey[400], fontWeight: FontWeight.w500,fontSize: 12)),
                isFirst: false,
                isLast: false,
              ),
              _buildTimelineRow(
                child: Text("Completed", style: TextStyle(color: Colors.blueGrey[400], fontWeight: FontWeight.w500,fontSize: 12)),
                isFirst: false,
                isLast: true,
              ),
              
              const SizedBox(height: 30),
              
              // Description
              const Text("Description", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF37474F))),
              const SizedBox(height: 8),
              Text(
                widget.task.taskDescription ?? "We need a skilled carpenter to build and install a custom wooden wardrobe and kitchen shelves...",
                style: TextStyle(fontSize: 13, color: Colors.blueGrey[600], height: 1.5),
              ),

              const SizedBox(height: 25),

              // Requirements
              const Text("Requirements", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF37474F))),
              const SizedBox(height: 8),
              Text(
                widget.task.requirements!,
                style: TextStyle(fontSize: 13, color: Colors.blueGrey[600], height: 1.5),
              ),
            ] else ...[
              // IF NO REQUIREMENTS: Show Add Button
              const SizedBox(height: 20),
              FilledButtonWidget(
                buttontext: 'Add Requirements',
                buttonwidth: double.infinity,
                buttonheight: 52,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddRequirementsScreen(
                        taskId: widget.task.taskId.toString(),
                        workerId: worker.profile?.workerId ?? "",
                      ),
                    ),
                  ).then((value) => setState(() {}));
                },
              ),
            ],
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[500]),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(fontSize: 12.5, color: Colors.blueGrey[300], fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // Helper for the Timeline vertical line and circles
  Widget _buildTimelineRow({required Widget child, bool isFirst = false, bool isLast = false}) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: Color(0xFFCCCCCC),
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1,
                    color: Colors.grey[300],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                child,
                const SizedBox(height: 25), // Space between timeline items
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, bool isActive,Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFE65100), // Match the orange from image
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13),
        ),
      ),
    );
  }
}
         