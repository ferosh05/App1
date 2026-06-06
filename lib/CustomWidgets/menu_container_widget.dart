import 'package:flutter/material.dart';
import 'package:pro/Colors/color.dart';
// import 'package:via_vita_mobile_app/CommonScreens/colors.dart';


class MenuContainerWidgets extends StatelessWidget {
  final String icondata;
  final String title;
  final Function() onTap;

  const MenuContainerWidgets({
    super.key,
    required this.icondata,
    required this.title,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.container_color
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.container_circle_color,
                    child: Image.asset(icondata, scale: 5),
                  ),
                  SizedBox(width: mediaquery.width * 0.05),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
      
             Icon(Icons.arrow_forward_ios,size: 15,)
            ],
          ),
        ),
      ),
    );
  }
}
