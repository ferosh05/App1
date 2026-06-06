import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro/Signin/signinmodel.dart';
import 'package:pro/URL/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerLoginProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  WorkerLoginModel? user;

  Future<String?> loginWorker({
    required String email,
    required String password,
    required String deviceToken,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      var uri = Uri.parse("${URL.url}/login.php");
      var request = http.MultipartRequest("POST", uri);

      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['device_token'] = deviceToken;

      var response = await request.send();
      var resBody = await response.stream.bytesToString();

      print("Raw Response: $resBody");

      final jsonData = json.decode(resBody);

      if (jsonData["success"] == true) {
        List userList = jsonData["userDetails"];
        
        if (userList.isNotEmpty) {
          user = WorkerLoginModel.fromJson(userList[0]);
          SharedPreferences prefs = await SharedPreferences.getInstance();

          // 1. Save the common User ID
          await prefs.setString("user_id", user?.id ?? "");

          // 2. Save the Role (Essential for checking later)
          String userRole = user?.role ?? "worker"; // Default to customer if null
          await prefs.setString("role", userRole);

          // 3. (Optional) Save specific IDs if your app uses "customer_id" vs "shop_id"
          if (userRole == "worker") {
            await prefs.setString("id", user?.id ?? "");
          } else if (userRole == "customer") {
            await prefs.setString("customer_id", user?.id ?? "");
          } else if (userRole == "worker") {
            await prefs.setString("worker_id", user?.id ?? "");
          }

          _isLoading = false;
          notifyListeners();
          
          // Return the role so the UI knows where to navigate
          return userRole; 
        }
      }
      
      _isLoading = false;
      notifyListeners();
      return null; // Login failed

    } catch (e) {
      print("Error: $e");
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }
}