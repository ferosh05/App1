import 'package:flutter/material.dart';
import 'package:pro/Colors/color.dart';
import 'package:pro/Image/images&icons.dart';
import 'package:pro/Signin/signinscreen.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: Image.asset(Images.applogo,scale: 2)),const SizedBox(height: 40),
              Center(
                child: const Text(
                  'Sign up your account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _buildAccountOption(
                context,
                image: AppIcons.customer_icon,
                label: 'Customer Login',
                color: AppColors.color2,
                onTap: (){
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CustomerLoginScreen()));

                }
              ),  const SizedBox(height: 16),
              _buildAccountOption(
                context,
                image: AppIcons.worker_icon,
                label: 'Worker Access',
                color:AppColors.color2,
                onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkerLoginScreen()));
                }
              ),
              const SizedBox(height: 16),
              _buildAccountOption(
                context,
                image: AppIcons.shop_icon,
                label: 'Shop Owner',
                color: AppColors.color2,
                onTap: (){
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShopkeeperLoginScreen()));


                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountOption(BuildContext context, {required String image, required String label, required Color color,required Function() onTap}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap:onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Row(
              children: <Widget>[
                Image.asset(image,scale: 4,),
                const SizedBox(width: 20),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}