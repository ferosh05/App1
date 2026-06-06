import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro/Model/accepted_task_model.dart';
import 'package:pro/URL/url.dart';
// import 'package:via_vita_mobile_app/DataModels/accepted_task_model.dart';

class CompleteTaskProvider with ChangeNotifier {
  List<AcceptedTaskModel> _tasks = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<AcceptedTaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchCompletedTasks(String workerId) async {
    final url = '${URL.url}/worker_completed_tasks.php?worker_id=$workerId';
    
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url));
      print("Response: ${response.body}"); // Debug check

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        if (data['success'] == true) {
          final List<dynamic> taskList = data['tasks'];
          _tasks = taskList.map((json) => AcceptedTaskModel.fromJson(json)).toList();
        } else {
          _tasks = [];
          _errorMessage = data['message'] ?? 'No tasks found';
        }
      } else {
        _errorMessage = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Connection error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}