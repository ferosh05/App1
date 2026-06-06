class ShopModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String state;
  final String district;

  ShopModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.state,
    required this.district,
  });

  // Factory constructor to create a ShopModel object from a JSON map
  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      // Note: mapping 'phone_number' from JSON to 'phoneNumber' variable
      phoneNumber: json['phone_number'] ?? '', 
      state: json['state'] ?? '',
      district: json['district'] ?? '',
    );
  }
}