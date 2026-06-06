import 'package:flutter/material.dart';
import 'package:pro/Bottom%20Nav/worker_bottom_screen.dart';
import 'package:pro/CustomWidgets/filled_button_widget.dart';
import 'package:pro/Provider/add_requirement_provider.dart';
import 'package:provider/provider.dart';

class AddRequirementsScreen extends StatefulWidget {
  final String taskId;
  final String workerId;

  const AddRequirementsScreen({
    super.key,
    required this.taskId,
    required this.workerId,
  });

  @override
  State<AddRequirementsScreen> createState() => _AddRequirementsScreenState();
}

class _AddRequirementsScreenState extends State<AddRequirementsScreen> {
  final TextEditingController _requirementsController = TextEditingController();

  @override
  void dispose() {
    _requirementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddRequirementProvider>(context); 
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
          'Add Requirements',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: 
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _requirementsController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: "Type your requirements here...",
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                    filled: true,
                    fillColor: const Color(0xFFF8F9FA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
                const Spacer(), // Pushes button to bottom
                FilledButtonWidget(
                  buttontext: provider.isLoading ? 'Processing...' : 'Submit',
                  buttonwidth: double.infinity,
                  buttonheight: 54,
                  onTap: provider.isLoading
                      ? null
                      : () async {
                          String reqText = _requirementsController.text.trim();

                          if (reqText.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Please enter requirement details")),
                            );
                            return;
                          }

                          await provider.addRequirement(
                            widget.taskId,
                            widget.workerId,
                            reqText,
                            context,
                          );

                          if (provider.isLoading == false ) {
                          
                            Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => WorkerBottomscreen()),
                            );
                          } else {
                            
                          }
                        },
                ),
                const SizedBox(height: 20),
              ],
            ),
          )
        
      
    );
  }
}