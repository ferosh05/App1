import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro/URL/url.dart';
import 'package:toastification/toastification.dart';
// import 'package:via_vita_mobile_app/CommonScreens/colors.dart';
// import 'package:via_vita_mobile_app/CommonScreens/toastwidget.dart';

class WorkerEditProfileProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> updateWorkerProfile({
    required BuildContext context,
    required String workerId,
    required String name,
    required String gender,
    required String phoneNumber,
    required String emailId,
    required String address,
    required String subscriptionExpiry, // Added this parameter
    File? avatarImage, 
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      var uri = Uri.parse("${URL.url}/edit_profile_worker.php");
      
      var request = http.MultipartRequest('POST', uri);

      // Add Text Fields
      request.fields['id'] = workerId;
      request.fields['name'] = name;
      request.fields['gender'] = gender;
      request.fields['phone_number'] = phoneNumber;
      request.fields['email'] = emailId;
      request.fields['address'] = address;
      
      // Add Subscription Expiry field
      if (subscriptionExpiry != null) {
        request.fields['subscription_expiry'] = subscriptionExpiry;
      }

      // Add Image File (Only if the user selected a new one)
      if (avatarImage != null) {
        var stream = http.ByteStream(avatarImage.openRead());
        var length = await avatarImage.length();
        
        var multipartFile = http.MultipartFile(
          'avatar',
          stream,
          length,
          filename: avatarImage.path.split('/').last,
        );
        request.files.add(multipartFile);
      }

      // Send Request
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);

      if (response.statusCode == 200) {
        if (jsonResponse['success'] == true || jsonResponse['status'] == true) { 
          toastification.show(context:context, title:Text("Profile Updated Successfully!"),type: ToastificationType.success );
         
          Navigator.pop(context); // Go back after success
        } else {
              toastification.show(context:context, title:jsonResponse['message'] ?? "Update failed",type: ToastificationType.error );
        }
      } else {
        toastification.show(context:context, title:Text("Server error occurred"),type: ToastificationType.info );
      
      }
    } catch (e) {
      print("Error updating profile: $e");
      toastification.show(context:context, title:Text("Something went wrong. Please try again."),type: ToastificationType.info );
   
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}