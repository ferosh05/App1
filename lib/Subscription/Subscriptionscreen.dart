import 'package:flutter/material.dart';
import 'package:pro/Bottom%20Nav/worker_bottom_screen.dart';
import 'package:pro/Colors/color.dart';
import 'package:pro/CustomWidgets/app_bar_widget.dart';
import 'package:pro/CustomWidgets/plan_widget.dart';
import 'package:pro/Subscription/subscription_detail_screen.dart';


class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
        child: Column(
          children: [
            SizedBox(height: mediaquery.height * 0.02),
            AppBarWidget(title: 'Subscription'),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PlansWidget(
                      planName: 'Free Plan',
                      content:
                          'Unlock exclusive features and enjoy an ad-free experience. ',
                      price: '0',
                      cycle: '3+ Months',
                      buttonText: 'Free',
                      showButton: true,
                      containerwidth: 390,
                      containerheight: 226,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkerBottomscreen()));
                        
                      },
                    ),
                    SizedBox(height: mediaquery.height * 0.01),
                    PlansWidget(
                      planName: '3+ Months Plan',
                      content:
                          'Unlock exclusive features and enjoy an ad-free experience. ',
                      price: '₹600',
                      cycle: 'Monthly',
                      buttonText: 'pay ₹600/Month',
                      showButton: true,
                      containerwidth: 390,
                      containerheight: 226,
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionDetailScreen()));
                        
                      },
                    ),
                    SizedBox(height: mediaquery.height * 0.01),

                    PlansWidget(
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionDetailScreen()));
                        
                      },
                      planName: 'Yearly Plan',
                      content:
                          'Unlock exclusive features and enjoy an ad-free experience. ',
                      price: '₹500/Month',
                      cycle: 'Yearly',
                      buttonText: 'pay ₹3,000/Year',
                      showButton: true,
                      containerwidth: 390,
                      containerheight: 226,
                    ),
                    SizedBox(height: mediaquery.height * 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
