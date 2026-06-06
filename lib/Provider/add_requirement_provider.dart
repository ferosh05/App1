import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro/URL/url.dart';
import 'dart:convert';

import 'package:toastification/toastification.dart';
// import 'package:via_vita_mobile_app/CommonScreens/toastwidget.dart';



class AddRequirementProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
   String? errorMessage; 

  Future<void> addRequirement(String taskId, String workerId, String requirements, BuildContext context, ) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('${URL.url}/add_requirements_worker.php');
    
    try {
      final response = await http.post(
        url,
        body: {
          "task_id": taskId,
          "worker_id": workerId,
          "requirements": requirements // Field name updated to plural 's'
        },
      );

      print("Response: ${response.body}");
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        // Show Success Toast
        toastification.show(context: context, 
          title: data['message'] ?? "Requirements added successfully!", 
          type: ToastificationType.success
        );
        
        // Navigate to Bottom Screen
        
     
      } else {
        toastification.show(context: context, 
          title: data['message'] ?? "Failed to add requirements", 
          type: ToastificationType.error
        );
      }
    } catch (e) {
       errorMessage = e.toString();
      print("Error: $e");
      toastification.show(context: context, 
        title: Text("Error: Could not connect to server"), 
        type: ToastificationType.info
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}