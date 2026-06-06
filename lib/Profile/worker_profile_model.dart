

class WorkerProfileModel {
  final String userId;
  final String username;
  final String phoneNo;
  final String role;
  final String status;
  final String createdDate;
  final String deviceToken;
  final String workerId;
  final String name;
  final String gender;
  final String age;
  final String phoneNumber;
  final String email;
  final String state;
  final String district;
  final String address;
  final String idProof;
  final String avatar;
  final String subscriptionExpiry;

  WorkerProfileModel({
    required this.userId,
    required this.username,
    required this.phoneNo,
    required this.role,
    required this.status,
    required this.createdDate,
    required this.deviceToken,
    required this.workerId,
    required this.name,
    required this.gender,
    required this.age,
    required this.phoneNumber,
    required this.email,
    required this.state,
    required this.district,
    required this.address,
    required this.idProof,
    required this.avatar,
    required this.subscriptionExpiry
  });

factory  WorkerProfileModel.fromJson(Map<String, dynamic> json) {
  return WorkerProfileModel(
     userId :json['user_id'],
    username :json['username'],
    phoneNo :json['phone_no'],
    role :json['role'],
    status :json['status'],
    createdDate :json['created_date'],
    deviceToken :json['device_token'],
    workerId :json['worker_id'],
    name :json['name'],
    gender :json['gender'],
    age :json['age'],
    phoneNumber :json['phone_number'],
    email :json['email'],
    state :json['state'],
    district :json['district'],
    address :json['address'],
    idProof :json['id_proof'],
    avatar :json['avatar'],
    subscriptionExpiry: json['subscription_expiry']
  );
   
  }

}