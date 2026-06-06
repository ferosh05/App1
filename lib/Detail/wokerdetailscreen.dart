import 'package:flutter/material.dart';
import 'package:pro/Colors/color.dart';
import 'package:pro/Profile/worker_profile_provider.dart';
import 'package:pro/Provider/task_provider.dart';
import 'package:provider/provider.dart';


class Wokerdetailscreen extends StatefulWidget {
  final String task; // 1. Add the task variable

  // 2. Update constructor to require the task
  const Wokerdetailscreen({super.key, required this.task});

  @override
  State<Wokerdetailscreen> createState() => _WokerdetailscreenState();
}

class _WokerdetailscreenState extends State<Wokerdetailscreen> {
  
  // Helper to convert category ID to a Name (Since API returns "1", "2" etc)
 

  // Helper to map Status ID to Text
  String getStatusText(String statusId) {
    return statusId == '0' ? 'Pending' : 'In Progress';
  }

  @override
  Widget build(BuildContext context) {
      final task = Provider.of<TaskProvider>(context);
      final worker =Provider.of<WorkerProfileProvider>(context);
      final tasktData =
        Provider.of<TaskProvider>(context).tasks.firstWhere((element) => element.taskId == widget.task);

    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      appBar: AppBar(
         backgroundColor: AppColors.bgcolor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 17),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('View Details', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 3. Dynamic Title (Category)
                Text(
                  tasktData.categoryname,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.task_progress_color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // 4. Dynamic Status
                  child: Text(
                    getStatusText(tasktData.status),
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.progress_pending_txtcolor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // 5. Dynamic Details
            _buildDetailRow(
              icon: Icons.account_balance_wallet,
              label: 'Budget',
              value: '₹ ${tasktData.budget}/-',
            ),
            _buildDetailRow(
              icon: Icons.location_on,
              label: 'Location',
              value: tasktData.location,
            ),
            _buildDetailRow(
              icon: Icons.calendar_today,
              label: 'Expected Deadline',
              value: tasktData.deadlineDate,
            ),
            
            // Added Customer Name to show full API usage
            // _buildDetailRow(
            //   icon: Icons.person,
            //   label: 'Customer',
            //   value: task.customerDetails?.name ?? 'Unknown',
            // ),

            const SizedBox(height: 30),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black
              ),
            ),
            const SizedBox(height: 10),
            // 6. Dynamic Description
            Text(
              tasktData.description,
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: AppColors.task_text_color
              ),
            ),
            const SizedBox(height: 40),
           
             Row(
                children: [
                  
                
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        task.acceptTask(tasktData.taskId.toString(), worker.profile?.workerId??"",context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC62828),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Accept",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade700, size: 20),
          const SizedBox(width: 10),
          Text(
            '$label - ',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.task_text_color, fontWeight: FontWeight.w500
            ),
          ),
          Expanded( // Added Expanded to prevent overflow if text is long
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.task_text_color
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}