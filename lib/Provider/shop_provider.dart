import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro/Model/shop_model.dart';
import 'package:pro/URL/url.dart';
// import 'package:via_vita_mobile_app/DataModels/shop_model.dart';


class ShopProvider with ChangeNotifier {
  List<ShopModel> _shops = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<ShopModel> get shops => _shops;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchShops() async {
    final url = '${URL.url}/shop_list.php';
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        if (data['success'] == true) {
          final List<dynamic> shopData = data['shops'];
          _shops = shopData.map((item) => ShopModel.fromJson(item)).toList();
        } else {
          _errorMessage = 'Failed to load shops';
        }
      } else {
        _errorMessage = 'Server error: ${response.statusCode}';
      }
    } catch (error) {
      _errorMessage = 'Connection error: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}