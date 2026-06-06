import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro/Signup/signupmodel.dart';
import 'package:pro/URL/url.dart';

class WorkerRegisterProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  WorkerRegisterModel? _workerData;
  WorkerRegisterModel? get workerData => _workerData;

  Future<void> registerWorker({
    required String name,
    required String gender,
    required String age,
    required String phoneNumber,
    required String email,
    required String state,
    required String district,
    required String address,
    required String password,
    File? avatar,
    File? idProof,
  }) async {
    _isLoading = true;
    notifyListeners();

    final String url =
        "${URL.url}/worker_reg.php";

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Normal fields
      request.fields['name'] = name;
      request.fields['gender'] = gender;
      request.fields['age'] = age;
      request.fields['phone_number'] = phoneNumber;
      request.fields['email'] = email;
      request.fields['state'] = state;
      request.fields['district'] = district;
      request.fields['address'] = address;
      request.fields['password'] = password;

      // Avatar file (optional)
      if (avatar != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'avatar',
            avatar.path,
            filename: avatar.path
          ),
        );
      }

      // ID Proof file (optional)
      if (idProof != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'id_proof',
            idProof.path,
            filename: idProof.path
          ),
        );
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      print("Response: $responseData");

      var jsonData = json.decode(responseData);

      if (jsonData['success'] == true) {
        _workerData = WorkerRegisterModel.fromJson(jsonData['userDetails'][0]);
      } else {
        throw jsonData['message'] ?? "Registration failed";
      }
    } catch (e) {
      debugPrint("Register Error: $e");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
