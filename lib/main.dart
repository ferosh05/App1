import 'package:flutter/material.dart';
import 'package:pro/Profile/worker_profile_provider.dart';
import 'package:pro/Provider/accepted_task_provider.dart';
import 'package:pro/Provider/add_requirement_provider.dart';
import 'package:pro/Provider/complete_task_provider.dart';
import 'package:pro/Provider/in_progress_task_provider.dart';
import 'package:pro/Provider/shop_provider.dart';
import 'package:pro/Provider/task_provider.dart';
import 'package:pro/Provider/task_status_change_provider.dart';
import 'package:pro/Provider/worker_edit_profile_provider.dart';
import 'package:pro/Provider/worker_task_count_provider.dart';
import 'package:pro/Signin/signinapi.dart';
import 'package:pro/Signup/signupapi.dart';
import 'package:pro/Splash/splash.dart';
import 'package:pro/Subscription/Subscriptionapi.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Worker());
}

class Worker extends StatelessWidget {
  const Worker({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> WorkerProfileProvider()),
        ChangeNotifierProvider(create: (context)=>AcceptedTaskProvider()),
        ChangeNotifierProvider(create: (context)=>AddRequirementProvider()),
        ChangeNotifierProvider(create: (context)=>CompleteTaskProvider()),
        ChangeNotifierProvider(create: (context)=>InProgressTaskProvider()),
        ChangeNotifierProvider(create: (context)=>ShopProvider()),
        ChangeNotifierProvider(create: (context)=>TaskProvider()),
        ChangeNotifierProvider(create: (context)=>TaskActionProvider()),
        ChangeNotifierProvider(create: (context)=>WorkerEditProfileProvider()),
        ChangeNotifierProvider(create: (context)=>WorkerTaskCountProvider()),
        ChangeNotifierProvider(create: (context)=>WorkerLoginProvider()),
        ChangeNotifierProvider(create: (context)=>WorkerRegisterProvider()),
        ChangeNotifierProvider(create: (context)=>SubscriptionProvider()),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false,home: Splash(),));
  }
}