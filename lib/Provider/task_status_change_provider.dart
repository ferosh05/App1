import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro/Bottom%20Nav/worker_bottom_screen.dart';
import 'package:pro/URL/url.dart';
import 'package:toastification/toastification.dart';
// import 'package:via_vita_mobile_app/CommonScreens/toastwidget.dart';
// import 'package:via_vita_mobile_app/Worker/WokerBottom/worker_bottom_screen.dart';

class TaskActionProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final String baseUrl = URL.url;

  /// Start Task API
  Future<void> startTask(String taskId, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/worker_start_task.php'),
        // FIX: Removed jsonEncode. 
        // Passing a Map directly sends data as 'application/x-www-form-urlencoded'
        // which PHP needs to populate the $_POST variable.
        body: {
          "task_id": taskId,
        },
      );

      print("Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        toastification.show(context:context, title: Text('Task started successfully'),type: ToastificationType.success);
         Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkerBottomscreen()));
        
      
      } else {
         toastification.show(context: context, title:data['message'] ?? "Failed to start task",type: ToastificationType.error);
       
      }
    } catch (e) {
      print("Provider Error: $e");
         toastification.show(context: context, title:Text("Connection error: $e"),type: ToastificationType.info);
      
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Complete Task API
  Future<void> completeTask(String taskId, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/worker_complete_task.php'),
        // FIX: Removed jsonEncode to support PHP $_POST
        body: {
          "task_id": taskId,
        },
      );

      final data = jsonDecode(response.body);

      if (data['success'] == true) {
           toastification.show(context: context, title: Text('Task completed successfully'),type: ToastificationType.success);
       
        Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkerBottomscreen()));
      } else {
         toastification.show(context: context, title: data['message'] ?? "Failed to complete task",type: ToastificationType.error);
       
      }
    } catch (e) {
         toastification.show(context: context, title:Text("Connection error: $e"),type: ToastificationType.info);
     
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}