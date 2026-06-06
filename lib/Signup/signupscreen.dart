import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro/Colors/color.dart';
import 'package:pro/Image/images&icons.dart';
import 'package:pro/Signin/signinscreen.dart';
import 'package:pro/Signup/signupapi.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class WorkerRegisterscreen extends StatefulWidget {

  const WorkerRegisterscreen({super.key, });

  @override
  _WorkerRegisterscreenState createState() => _WorkerRegisterscreenState();
}

class _WorkerRegisterscreenState extends State<WorkerRegisterscreen> {
  
  String? _selectedGender;
  bool _isPasswordVisible = false;

//controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _agecontroller = TextEditingController();
  final TextEditingController _phoneController=TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  final TextEditingController _districtController =TextEditingController();
  final TextEditingController idProofCtrl = TextEditingController();

  File? avatarFile;
  File? idProofFile;

  final picker = ImagePicker();

  Future pickAvatar() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => avatarFile = File(picked.path));
    }
  }

  Future pickIdProof() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        idProofFile = File(picked.path);
        idProofCtrl.text = picked.name;  
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkerRegisterProvider>(context);
    return Scaffold(
     backgroundColor: AppColors.bgcolor,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 70),
            Center(
              child: const Text(
                'Create a new account',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                 CircleAvatar(
                  radius: 60,
                  backgroundImage: avatarFile != null
                      ? FileImage(avatarFile!)
                      : AssetImage(Images.profileimage) as ImageProvider,
                 ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () =>pickAvatar(),
                    child: Text(
                      '+ Add Image',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
           _buildInputField('Name', 'Name', Icons.person_outline,_nameController),
            const SizedBox(height: 20),
             Row(
              children: <Widget>[
                Expanded(
                  child: RadioListTile<String>(
                    activeColor: AppColors.color1,
                    title: const Text('Male'),
                    value: 'Male',
                    groupValue: _selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                       activeColor: AppColors.color1,
                    title: const Text('Female'),
                    value: 'Female',
                    groupValue: _selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                       activeColor: AppColors.color1,
                    title: const Text('Other'),
                    value: 'Other',
                    groupValue: _selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ),
              ],
            ),
               const SizedBox(height: 20),
              _buildInputField('Age', 'Age', Icons.phone_outlined,_agecontroller),
           
            const SizedBox(height: 20),
            _buildInputField('Phone Number', 'Phone Number', Icons.phone_outlined,_phoneController),
            const SizedBox(height: 20),
            _buildInputField('Email ID', 'Email ID', Icons.email_outlined,_emailController),
            const SizedBox(height: 20),
             _buildInputField('State', 'State', Icons.location_on_outlined,_stateController),
            const SizedBox(height: 20),
              _buildInputField('District', 'District', Icons.location_on_outlined,_districtController),
            const SizedBox(height: 20),
            
               _buildInputField('Address', 'Address', Icons.location_on_outlined,_addressController),
            const SizedBox(height: 20),
            Text('ID Proof',style: TextStyle(fontWeight: FontWeight.w500),),  const SizedBox(height: 10),

            TextFormField(
              readOnly: true,
              controller: idProofCtrl,
              decoration: InputDecoration(
                hintText: 'ID Proof',
                suffixIcon: InkWell(
                  onTap: () => pickIdProof(),
                  child: Image.asset(AppIcons.upload,scale: 4.5,)),
                hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              
                fillColor: Colors.grey[100],
                filled: true
              ),
              style: const TextStyle(color: Colors.black87),
            ),
            SizedBox(height: 20),
            _buildPasswordField('Password', 'Password', Icons.lock_outline, _isPasswordVisible, (bool value) {
              setState(() {
                _isPasswordVisible = value;
              });
            },_passwordController),
            const SizedBox(height: 20),
         
            const SizedBox(height: 30),
   
            Center(
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.color1,AppColors.color2
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: MaterialButton(
                  onPressed: ()async {
                    if (_nameController.text.isEmpty ||
                          _selectedGender == null ||
                          _agecontroller.text.isEmpty ||
                          _phoneController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _stateController.text.isEmpty ||
                          _districtController.text.isEmpty ||
                          _addressController.text.isEmpty ||
                          avatarFile==null||
                          idProofFile==null||
                          _passwordController.text.isEmpty) {
                             toastification.show(context:context, title: Text('Please fill all fields'),type: ToastificationType.info);
                        
                        return;
                      }
                  

                      try {
                        await provider.registerWorker(
                          name: _nameController.text,
                          gender:   _selectedGender !,
                          age: _agecontroller.text,
                          phoneNumber:    _phoneController.text,
                          email:  _emailController.text,
                          state:   _stateController.text,
                          district:   _districtController.text,
                          address:   _addressController.text,
                          password:  _passwordController.text,
                          avatar: avatarFile,
                          idProof: idProofFile,
                        );
                         toastification.show(context:context, title: Text('Worker Registered Successfully!'),type: ToastificationType.success);

                      
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkerLoginScreen()));

                      } catch (e) {
                         toastification.show(context:context, title:Text(e.toString()),type: ToastificationType.error);
                        
                      }
                    
                    // Handle sign up logic
                    print('Sign up button pressed');
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.zero,
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 Text(
                    "Already have an account ? ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500

                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>WorkerLoginScreen()));
                      // Handle navigation to the sign-up screen
                      debugPrint('Sign Up Pressed');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,decoration: TextDecoration.underline,
                        color: Colors.black87,
                        
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
   
  Widget _buildInputField(String label, String hintText, IconData icon,TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            
            fillColor: Colors.grey[100],
            filled: true
           
          ),
          style: const TextStyle(color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildPasswordField(String label, String hintText, IconData icon, bool isVisible, Function(bool) onVisibilityChanged,TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: !isVisible,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            fillColor: AppColors.form_field_color,
            filled: true,
            suffixIcon: GestureDetector(
              onTap: () {
                onVisibilityChanged(!isVisible);
              },
              child: isVisible?Image.asset(AppIcons.eye,scale: 4.5,):Image.asset(AppIcons.in_eye,scale: 4.5,),
            )
          ),
          style: const TextStyle(color: Colors.black87),
        ),
      ],
    );
  }
  
}