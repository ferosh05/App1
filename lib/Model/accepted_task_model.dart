class AcceptedTaskModel {
  final String taskId;
  final String jobCategory;
  final String? categoryName;
  final String taskDescription;
  final String location;
  final String budget;
  final String deadlineDate;
  final String status;
  final String customerId;
  final String createdDate;
  final String requirements;

  AcceptedTaskModel({
    required this.taskId,
    required this.jobCategory,
    required this.categoryName,
    required this.taskDescription,
    required this.location,
    required this.budget,
    required this.deadlineDate,
    required this.status,
    required this.customerId,
    required this.createdDate,
    required this.requirements,
  });

  factory AcceptedTaskModel.fromJson(Map<String, dynamic> json) {
    return AcceptedTaskModel(
      taskId: json['task_id'].toString() ?? "",
      jobCategory: json['job_category'].toString() ?? "",
      categoryName: json['category_name']?.toString(),
      taskDescription: json['task_description'].toString() ?? "",
      location: json['location'].toString() ?? "",
      budget: json['budget'].toString() ?? "",
      deadlineDate: json['deadline_date'].toString() ?? "",
      status: json['status'].toString()?? "",
      customerId: json['customer_id'].toString() ?? "",
      createdDate: json['created_date'].toString() ?? "",
      requirements: json['requirements'].toString() ?? "", 
    );
  }
}