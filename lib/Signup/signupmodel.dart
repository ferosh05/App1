class WorkerRegisterModel {
  final int workerId;
  final String name;
  final String gender;
  final String age;
  final String phoneNumber;
  final String email;
  final String state;
  final String district;
  final String address;
  final String avatar;
  final String idProof;

  WorkerRegisterModel({
    required this.workerId,
    required this.name,
    required this.gender,
    required this.age,
    required this.phoneNumber,
    required this.email,
    required this.state,
    required this.district,
    required this.address,
    required this.avatar,
    required this.idProof,
  });

  factory WorkerRegisterModel.fromJson(Map<String, dynamic> json) {
    return WorkerRegisterModel(
      workerId: json['worker_id'],
      name: json['name'],
      gender: json['gender'],
      age: json['age'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      state: json['state'],
      district: json['district'],
      address: json['address'],
      avatar: json['avatar'] ?? "",
      idProof: json['id_proof'] ?? "",
    );
  }
}
