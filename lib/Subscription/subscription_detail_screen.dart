import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro/Bottom%20Nav/worker_bottom_screen.dart';
import 'package:pro/Profile/worker_profile_provider.dart';
import 'package:pro/Subscription/Subscriptionapi.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class SubscriptionDetailScreen extends StatefulWidget {
  const SubscriptionDetailScreen({super.key});

  @override
  State<SubscriptionDetailScreen> createState() => _SubscriptionDetailScreenState();
}

class _SubscriptionDetailScreenState extends State<SubscriptionDetailScreen> {
  String? _selectedPlan;
  File? _selectedImage;
  final TextEditingController _transactionController = TextEditingController();
  final List<String> _plans = ['monthly', 'yearly'];

  // Pick image from gallery
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  // Handle Form Submission
  void _handleSubmit() async {
    final subProvider = Provider.of<SubscriptionProvider>(context, listen: false);
    final profileProvider = Provider.of<WorkerProfileProvider>(context, listen: false);

    // Get worker ID from profile provider
    final String workerId = profileProvider.profile?.workerId?.toString() ?? "";

    // 1. Validation
    if (workerId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Worker Profile not found.")),
      );
      return;
    }

    if (_selectedPlan == null || _selectedImage == null || _transactionController.text.isEmpty) {
      toastification.show(context:context, title: Text("Please fill all fields and upload a screenshot"),type: ToastificationType.info);
     
      return;
    }

    // 2. Call API
    await subProvider.subscribePlan(
      workerId: workerId,
      planType: _selectedPlan!,
      transactionId: _transactionController.text,
      imageFile: _selectedImage!,
    );

    // 3. Response Handling
    if (!mounted) return;

    if (subProvider.isSuccess) {
      toastification.show(context: context, title: Text(subProvider.resMessage),type: ToastificationType.success);
     
      Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkerBottomscreen()));
    } else {
      toastification.show(context: context, title: Text(subProvider.resMessage),type: ToastificationType.error);
     
    }
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Subscription',
          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Yearly/Monthly", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            
            // Plan Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: const Color(0xFFF8F9FB), borderRadius: BorderRadius.circular(10)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedPlan,
                  hint: const Text("Select Type",style: TextStyle(fontSize: 13),),
                  isExpanded: true,
                  items: _plans.map((plan) => DropdownMenuItem(value: plan, child: Text(plan,style: TextStyle(fontSize: 13),))).toList(),
                  onChanged: (val) => setState(() => _selectedPlan = val),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text("Transaction ID", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            
            // Transaction Field
            TextField(
              controller: _transactionController,
              decoration: InputDecoration(
                hintText: "Enter Transaction ID",
                hintStyle: TextStyle(fontSize: 13),
                filled: true,
                fillColor: const Color(0xFFF8F9FB),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),

            const SizedBox(height: 20),
            const Text("Payment Screenshot Upload", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),

            // Image Picker Trigger
            GestureDetector(
              onTap: _pickImage,
              child: _buildCustomInput(
                text: _selectedImage == null ? "No File Chosen" : "File: ${_selectedImage!.path.split('/').last}",
                icon: _selectedImage == null ? Icons.file_upload_outlined : Icons.check_circle,
                iconColor: _selectedImage == null ? Colors.grey : Colors.green,
              ),
            ),

            const SizedBox(height: 40),
            
            // Submit Button with Loading State
            Consumer<SubscriptionProvider>(
              builder: (context, provider, child) {
                return provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _buildSubmitButton();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomInput({required String text, required IconData icon, Color iconColor = const Color(0xFF6E7C87)}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(color: const Color(0xFFF8F9FB), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(text, style: const TextStyle(color: Color(0xFF6E7C87), fontSize: 13), overflow: TextOverflow.ellipsis)),
          Icon(icon, color: iconColor, size: 22),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return InkWell(
      onTap: _handleSubmit,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xFF9A1F0D), Color(0xFFE85A26)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Submit",
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}