import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro/URL/url.dart';

class WorkerTaskCountProvider with ChangeNotifier {
 
  Map<String, dynamic>? _taskData;
  bool _isLoading = false;

  Map<String, dynamic>? get taskData => _taskData;
  bool get isLoading => _isLoading;

  Future<void> fetchTaskCount(String workerId) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        '${URL.url}/worker_task_count.php?worker_id=$workerId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Decode directly into the map
        _taskData = json.decode(response.body);
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}