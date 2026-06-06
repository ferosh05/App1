import 'package:flutter/material.dart';
// import 'package:via_vita_mobile_app/CommonScreens/colors.dart';



class CountContainerWidgets extends StatelessWidget {
  final Color bgColor;
  final String text;
  final String count;

  const CountContainerWidgets({
    super.key,
    required this.bgColor,
    required this.text,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      width: mediaQuery.width * 0.45,
      height: 70,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
       //border: Border.all(color: colors.app_color_2, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color:Colors.black
              ),
            ),
            Text(
              count,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color:Colors.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}
