import 'package:flutter/material.dart';
import 'package:pro/Colors/color.dart';
import 'package:pro/Image/images&icons.dart';
import 'package:pro/Profile/profile_card.dart';
import 'package:pro/Profile/worker_edit_profile_screen.dart';
import 'package:pro/Profile/worker_profile_provider.dart';
import 'package:pro/Select_Screen/select_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerProfileScreen extends StatefulWidget {
  
  const WorkerProfileScreen({super.key});

  @override
  State<WorkerProfileScreen> createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> {

  @override
  void initState() {
    super.initState();
    loadWorkerProfileData();
  }

  void loadWorkerProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final workerId = prefs.getString("id");

    if (workerId != null) {
      Provider.of<WorkerProfileProvider>(context, listen: false)
          .fetchWorkerProfile(workerId);
    }
  }
  void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    // Prevents closing by tapping outside
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        // Set the custom rounded shape for the dialog box
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // Removes default padding/margins around the content
        contentPadding: const EdgeInsets.all(30.0),
        
        // Custom content: Title and prompt text
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Logout',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Are you sure you want to Logout?',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            // The row for the buttons
            Row(
              children: <Widget>[
                // 1. "No" Button (Outlined with Red Text)
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.color1)
                      ),
                      height: 50,
                      width: double.infinity,
                      child: Center(child: Text('No',style: TextStyle(color: AppColors.color1),)),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                // 2. "Yes" Button (Gradient)
                Expanded(
                  child:  InkWell(
                    onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectScreen()));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                         gradient: LinearGradient(colors: [
                          AppColors.color1,AppColors.color2
                        ])),  child: Center(child: Text('Yes',style: TextStyle(color: AppColors.bgcolor),)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    final displaysize=MediaQuery.of(context).size;
    final profile = Provider.of<WorkerProfileProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: displaysize.height * .25,
                  width: displaysize.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                    gradient: LinearGradient(colors: [AppColors.color1,AppColors.color2])
                  ),
                
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: displaysize.width * .04),
                    child: Column(
                      children: [
                        Center(child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 16,)
                              ),
                              Text('Profile',style: TextStyle(color: Colors.white),),
                              InkWell(
                                onTap: () {
                                  showLogoutDialog(context);
                                },
                                child: Icon(Icons.logout,color: Colors.white,size: 17,)
                              ),
                            ],
                          ),
                        ))
                      ]
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -displaysize.height * .08,
                  
                  child: CircleAvatar(
                    radius:displaysize.height * .08,
                    backgroundImage: NetworkImage( profile.profile?.avatar?? ""),
                  ),
                ), 
              ],
            ),
            SizedBox(height: displaysize.height * .09),  
          
            Text(
              profile.profile?.name ?? "",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Text(
              'Subscription Expiry : ${profile.profile?.subscriptionExpiry ?? ""}',
              style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Colors.grey),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child:GestureDetector(
                    onTap: () async {
                      // 1. Use 'await' to wait until the user comes back from EditProfileScreen
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WokereditProfileScreen(
                            customerId: profile.profile?.userId.toString() ?? "",
                            currentName: profile.profile?.name ?? "",
                            currentEmail: profile.profile?.email ?? "",
                            currentGender: profile.profile?.gender ?? "",
                            currentPhone: profile.profile?.phoneNumber ?? "",
                            currentAddress: profile.profile?.address ?? "",
                            currentImage: profile.profile?.avatar??"",
                          ),
                        ),
                      );
                      // 2. Once they return, call this function to fetch the latest data from API
                      loadWorkerProfileData();
                    },
                    child: Image.asset(
                      AppIcons.edit,
                      scale: 5,
                    ),
                  ),
                ),
                SizedBox(height: displaysize.height * .06),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: displaysize.width * .05),
              child: Column(
                children: [
                  ProfileInfoCard(
                    icon: AppIcons.gender,
                    label: 'Gender',
                    value: profile.profile?.gender?? "",
                    iconColor: Colors.red[300]!,
                  ),
                  SizedBox(height: 16),
                  ProfileInfoCard(
                    icon: AppIcons.call,
                    label: 'Phone Number',
                    value: profile.profile?.phoneNumber ?? "",
                    iconColor: Colors.red[300]!,
                  ),
                  SizedBox(height: 16),
                  ProfileInfoCard(
                    icon: AppIcons.email,
                    label: 'Email ID',
                    value: profile.profile?.email?? "",
                    iconColor: Colors.red[300]!,
                  ),
                  SizedBox(height: 16),
                  ProfileInfoCard(
                    icon: AppIcons.loc,
                    label: 'Address',
                    value: profile.profile?.address ?? "",
                    iconColor: Colors.red[300]!,
                  ), 
                ],
              ),
            ) 
          ],
        )
      )
    );
  }
}
