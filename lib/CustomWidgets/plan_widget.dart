import 'package:flutter/material.dart';
import 'package:pro/CustomWidgets/filled_button_widget.dart';
// import 'package:via_vita_mobile_app/CommonScreens/colors.dart';
// import 'package:via_vita_mobile_app/Worker/CustomWidgts/filled_button_widget.dart';
// import 'package:via_vita_mobile_app/Worker/WokerBottom/worker_bottom_screen.dart';



class PlansWidget extends StatelessWidget {
  final String planName;
  final String content;
  final String price;
  final String cycle;
  final String buttonText;
  final Function() onTap;
    final bool showButton;
      final double containerwidth;
  final double containerheight;

  const PlansWidget({
    super.key,
    required this.planName,
    required this.content,
    required this.price,
    required this.cycle,
    required this.buttonText,
    required this.showButton,
      required this.containerwidth,
  required this.containerheight,
  required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    final datatextstyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black
    );
    final subtitletextstyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.black
    );

    return Container(
      height: containerheight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                planName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
                ),
              ),
            ),
            SizedBox(height: mediaquery.height * 0.03),
            Text(content, style: datatextstyle),
            SizedBox(height: mediaquery.height * 0.01),
            Row(
              children: [
                Text('Price:', style: subtitletextstyle),
                SizedBox(width: mediaquery.width * 0.02),
                Text('$price', style: datatextstyle),
              ],
            ),
            SizedBox(height: 5),

            Row(
              children: [
                Text('Billing:', style: subtitletextstyle),
                SizedBox(width: mediaquery.width * 0.02),

                Text('$cycle', style: datatextstyle),
              ],
            ),
            SizedBox(height: mediaquery.height * 0.02),
             FilledButtonWidget(buttontext: buttonText, buttonwidth: 350, buttonheight: 45,onTap:onTap)
          ],
        ),
      ),
    );
  }
}
