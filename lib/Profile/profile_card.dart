import 'package:flutter/material.dart';
import 'package:pro/Colors/color.dart';
// import 'package:via_vita_mobile_app/CommonScreens/colors.dart';


class ProfileInfoCard extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Color iconColor;

  const ProfileInfoCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.task_list_color, // Light red background
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.profile_card_iconcolor,
            child: Image.asset(icon,scale: 4.5)
          ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: AppColors.task_text_color,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                value,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}