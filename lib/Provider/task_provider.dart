import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro/Bottom%20Nav/worker_bottom_screen.dart';
import 'package:pro/Model/task_model.dart';
import 'package:pro/URL/url.dart';
import 'package:toastification/toastification.dart';
// import 'package:via_vita_mobile_app/CommonScreens/toastwidget.dart';
// import 'package:via_vita_mobile_app/DataModels/task_model.dart';
// import 'package:via_vita_mobile_app/Worker/WokerBottom/worker_bottom_screen.dart';


class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _searchQuery = ""; 

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
   List<TaskModel> get filteredTasks {
    if (_searchQuery.isEmpty) {
      return _tasks;
    }
    return _tasks.where((task) {
      final name = task.categoryname?.toLowerCase() ?? "";
      return name.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  // Step 3: Method to update search query and notify UI
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> fetchNewTasks() async {
    final url = "${URL.url}/view_new_tasks.php";
    
    _isLoading = true;
    _errorMessage = '';
    // notifyListeners(); // Optional here, depends if you want to show loading immediately

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success'] == true) {
          final List<dynamic> taskList = data['taskDetails'];
          _tasks = taskList.map((item) => TaskModel.fromJson(item)).toList();
        } else {
          _errorMessage = data['message'] ?? "Failed to load tasks";
        }
      } else {
        _errorMessage = "Server error: ${response.statusCode}";
      }
    } catch (error) {
      _errorMessage = "An error occurred: $error";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> searchTasks(int categoryId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final url = Uri.parse(
        'https://srishticampus.tech/bloodconnect/viavita_api/worker_task_search.php?job_category_id=$categoryId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _tasks = data.map((item) => TaskModel.fromJson(item)).toList();
      } else {
        _errorMessage = 'Failed to load tasks. Server error: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> acceptTask(String taskId, String workerId, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://srishticampus.tech/bloodconnect/viavita_api/accept_task_worker.php');

    try {
      final response = await http.post(
        url,
        body: {
          "task_id": taskId,
          "worker_id": workerId
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        toastification.show(context: context, title: data['message'] ?? "Task Accepted", type: ToastificationType.success);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkerBottomscreen()));
     
      } else {
         toastification.show(context: context, title: data['message'] ?? "Failed to accept task", type: ToastificationType.error);
        
      }
    } catch (e) {
       toastification.show(context:context, title: Text("Error: Could not connect to server"), type: ToastificationType.info);
    
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}