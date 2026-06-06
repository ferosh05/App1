import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro/Profile/worker_profile_model.dart';
import 'package:pro/URL/url.dart';
// import 'package:via_vita_mobile_app/DataModels/worker_profile_model.dart';



class WorkerProfileProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  WorkerProfileModel? profile;

  Future<bool> fetchWorkerProfile(String workerId) async {
    _loading = true;
    notifyListeners();

    final url =
        "${URL.url}/view_profile_worker.php?id=$workerId";

    try {
      final response = await http.get(Uri.parse(url));

      print("Worker Profile RES: ${response.body}");

      final jsonData = json.decode(response.body);

      if (jsonData["success"] == true) {
        profile = WorkerProfileModel.fromJson(jsonData["userDetails"][0]);

        _loading = false;
        notifyListeners();
        return true;
      } else {
        _loading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("PROFILE ERROR: $e");
      _loading = false;
      notifyListeners();
      return false;
    }
  }
  
}
