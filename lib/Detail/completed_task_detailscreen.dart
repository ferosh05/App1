import 'package:flutter/material.dart';

class CompletedTaskDetailscreen extends StatefulWidget {
  // Add this line to accept the task data
  final dynamic task; 

  const CompletedTaskDetailscreen({super.key, required this.task});

  @override
  State<CompletedTaskDetailscreen> createState() => _CompletedTaskDetailscreenState();
}

class _CompletedTaskDetailscreenState extends State<CompletedTaskDetailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'View Details',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name and Category Tag
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.task.categoryName ?? 'No Title', // Dynamic Data
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF455A64),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Completed',
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500, fontSize: 11),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Info Rows - Dynamic Data
            _buildInfoRow(Icons.account_balance_wallet_outlined, 'Budget - ₹ ${widget.task.budget ?? "0"}/-'),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.location_on_outlined, 'Location - ${widget.task.location ?? "Not specified"}'),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.calendar_today_outlined, 'Expected Dead line - ${widget.task.deadlineDate ?? "N/A"}'),
            
            const SizedBox(height: 30),

            _buildSectionTitle('Description'),
            const SizedBox(height: 8),
            _buildSectionBody(widget.task.taskDescription ?? "No description available."),

            const SizedBox(height: 25),

            _buildSectionTitle('Requirements'),
            const SizedBox(height: 8),
            _buildSectionBody(widget.task.requirements ?? "No requirements provided."),

            const SizedBox(height: 25),

            _buildSectionTitle('Estimate by shop owner'),
            const SizedBox(height: 8),
          //  _buildSectionBody(widget.task.estimateSummary ?? "No estimate provided."),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 13, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF263238)));
  }

  Widget _buildSectionBody(String body) {
    return Text(body, style: TextStyle(fontSize: 13, color: Colors.grey.shade700, height: 1.5));
  }
}