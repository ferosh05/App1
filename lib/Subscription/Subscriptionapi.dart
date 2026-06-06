import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro/URL/url.dart';

class SubscriptionProvider with ChangeNotifier {
  bool isLoading = false;
  String resMessage = "";
  bool isSuccess = false;

  // Void function as requested
  Future<void> subscribePlan({
    required String workerId,
    required String planType,
    required String transactionId,
    required File imageFile,
  }) async {
    isLoading = true;
    isSuccess = false;
    resMessage = "";
    notifyListeners();

    final url = Uri.parse('${URL.url}/worker_subscribe_plan.php');

    try {
      var request = http.MultipartRequest('POST', url);

      // Adding text fields
      request.fields['worker_id'] = workerId;
      request.fields['plan_type'] = planType;
      request.fields['transaction_id'] = transactionId;

      // Adding file field
      request.files.add(await http.MultipartFile.fromPath(
        'payment_screenshot',
        imageFile.path,
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Direct JSON parsing without a model
        var data = jsonDecode(response.body);
        
        if (data['success'] == true) {
          isSuccess = true;
          resMessage = data['message']; //"Subscription request submitted..."
        } else {
          isSuccess = false;
          resMessage = data['message'] ?? "Failed to submit request";
        }
      } else {
        isSuccess = false;
        resMessage = "Server error: ${response.statusCode}";
      }
    } catch (e) {
      isSuccess = false;
      resMessage = "Connection failed: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}