import 'package:flutter/material.dart';
import 'package:pro/Model/accepted_task_model.dart';
import 'package:pro/Provider/task_status_change_provider.dart';
import 'package:provider/provider.dart';

class InprogresstaskDetailScreen extends StatefulWidget {
  final AcceptedTaskModel task; // Using dynamic to support different models if they share same properties

  const InprogresstaskDetailScreen({super.key, required this.task});

  @override
  State<InprogresstaskDetailScreen> createState() => _InprogresstaskDetailScreenState();
}

class _InprogresstaskDetailScreenState extends State<InprogresstaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final statusprovider=Provider.of<TaskActionProvider>(context);
    const Color primaryOrange = Color(0xFFF15A24);
    const Color lightGrey = Color(0xFF757575);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                
                  const Text("View Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.task.categoryName ?? "Task Name",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF455A64)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      widget.task.jobCategory ?? "General",
                      style: const TextStyle(color: Color(0xFFD32F2F), fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              _buildInfoRow(Icons.account_balance_wallet_outlined, "Budget - ₹ ${widget.task.budget}/-", lightGrey),
              const SizedBox(height: 12),
              _buildInfoRow(Icons.location_on_outlined, "Location - ${widget.task.location}", lightGrey),
              const SizedBox(height: 12),
              _buildInfoRow(Icons.calendar_today_outlined, "Expected Deadline - ${widget.task.deadlineDate ?? 'N/A'}", lightGrey),
              
              const SizedBox(height: 30),

              // Progress Stepper
              _buildTimelineStep(icon: Icons.check_circle, color: primaryOrange, label: "Started", showLine: true, lineColor: primaryOrange),
              _buildTimelineStep(icon: Icons.check_circle, color: primaryOrange, label: "In Progress", showLine: true, lineColor: Colors.grey.shade300),
              
              Row(
                children: [
                  Container(width: 24, height: 24, decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle)),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      statusprovider.completeTask(widget.task.taskId, context,
                      
                        
                      );
                      
                     
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryOrange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text("Completed", style: TextStyle(color: Colors.white,fontSize: 12)),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              const Text("Description", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(widget.task.taskDescription ?? "No description", style: const TextStyle(fontSize: 14, color: lightGrey, height: 1.5)),

              const SizedBox(height: 25),
              const Text("Requirements", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(widget.task.requirements ?? "No requirements listed", style: const TextStyle(fontSize: 14, color: lightGrey, height: 1.5)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildTimelineStep({required IconData icon, required Color color, required String label, required bool showLine, required Color lineColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(width: 20),
            Text(label, style: TextStyle(fontSize: 12, color: Colors.blueGrey.shade700, fontWeight: FontWeight.w500)),
          ],
        ),
        if (showLine)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Container(width: 2, height: 30, color: lineColor),
          ),
      ],
    );
  }
}