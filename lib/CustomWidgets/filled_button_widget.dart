import 'package:flutter/material.dart';
import 'package:pro/Colors/color.dart';
// import 'package:via_vita_mobile_app/CommonScreens/colors.dart';
// import 'package:via_vita_mobile_app/Customer/Screens/Detail/detail_screen.dart';
// import 'package:via_vita_mobile_app/Worker/WokerBottom/worker_bottom_screen.dart';



class FilledButtonWidget extends StatelessWidget {
  final String buttontext;
  final double buttonwidth;
  final double buttonheight;
  final Function()? onTap;
  
  const FilledButtonWidget({
    super.key,
    required this.buttontext,
    required this.buttonwidth,
    required this.buttonheight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
      child: Container(
        width: double.infinity,
        height: buttonheight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.color1,AppColors.color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      
        child: Center(
          child: Text(
            buttontext,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}