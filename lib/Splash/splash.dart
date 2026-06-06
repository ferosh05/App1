import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pro/Image/images&icons.dart';
import 'package:pro/Signin/signinscreen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    splashsc();
    super.initState();
  }
  
  splashsc()async
  {
    await Future.delayed(Duration(milliseconds: 1500));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkerLoginScreen()));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeIn(
        duration: Duration(seconds: 4),
        child: Column(
          children: [
            SizedBox(height: 150,),
            Center(
              child: Container(
                height: 450,
                width: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Images.splashimage),fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        )
      ),
    );

  }
}