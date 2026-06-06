
import 'package:flutter/material.dart';
import 'package:pro/Bottom%20Nav/demo%20bot_nav.dart';
import 'package:pro/Bottom%20Nav/worker_bottom_screen.dart';
import 'package:pro/Colors/color.dart';
import 'package:pro/Forgot/forgot_pass.dart';
import 'package:pro/Image/images&icons.dart';
import 'package:pro/Signin/signinapi.dart';
import 'package:pro/Signup/demosignup.dart';
import 'package:pro/Signup/signupscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class WorkerLoginScreen extends StatefulWidget {
  const WorkerLoginScreen({super.key});

  @override
  State<WorkerLoginScreen> createState() => _WorkerLoginScreenState();
}

class _WorkerLoginScreenState extends State<WorkerLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; 
  
  // ADD THIS VARIABLE TO HANDLE PASSWORD VISIBILITY
  bool _isObscure = true; 
    Future<void> handleLogin(BuildContext context, String assignedRole) async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userRole', assignedRole); // Store: 'customer', 'worker', or 'shopkeeper'

    if (context.mounted) {
      if (assignedRole == 'customer') {
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CustomerBottomScreen()));
      } else if (assignedRole == 'worker') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WorkerBottomscreen()));
      } else {
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShopBottomNavigationSCreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<WorkerLoginProvider>(context);
    final displaysize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                ),
                Center(
                  child: const Text(
                    'Sign in your account',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 48.0),
                const Text(
                  'Email ID',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                _buildTextInputField(
                  isPassword: false,
                  hintText: 'Email ID',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                _buildTextInputField(
                  hintText: 'Password',
                  controller: passwordcontroller,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 3) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgot()));
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      
                      // 1. Start Loading
                      setState(() {
                        _isLoading = true;
                      });

                      // 2. Call API (Must return the role string, e.g., "customer", "shopkeeper")
                      String? role = await login.loginWorker(
                        email: emailController.text,
                        password: passwordcontroller.text,
                        deviceToken: '1234',
                      );

                      // 3. Stop Loading
                      if (mounted) {
                        setState(() {
                          _isLoading = false;
                        });
                      }

                      // 4. CHECK THE RESULT
                      if (role != null) {
                        
                        // --- SCENARIO A: IT IS A CUSTOMER ---
                        if (role == 'worker') {
                          if (!mounted) return;
                          toastification.show(context:context, title: const Text('Login Successful!'),type: ToastificationType.success);
                                    await handleLogin(context, 'worker'); 
                          // Navigate to Customer Page
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => WorkerBottomscreen())
                          );
                        } 
                        
                        // --- SCENARIO B: IT IS A SHOPKEEPER OR WORKER (BLOCK THEM) ---
                        else {
                          if (!mounted) return;
                          toastification.show(context:context, title: Text('Access Denied: You are registered as a $role.\nPlease use the $role app/login.'),type: ToastificationType.info);
                          // Show error message specifically for non-customers
                        
                          
                          // DO NOT NAVIGATE
                        }

                      } else {
                        // --- SCENARIO C: INVALID PASSWORD OR EMAIL ---
                        if (!mounted) return;
                        toastification.show(context:context, title: Text('Invalid Email or Password'),type: ToastificationType.error);
                        
                      }
                    }
                  },
                  child: Container(
                    height: 55,
                    width: 390,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [AppColors.color1,AppColors.color2]),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Sign in',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account ? ",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                   WorkerRegisterscreen()));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ]
            ),
          ),
        ),
      )
    );  
  }

  Widget _buildTextInputField({
    required String hintText,
    required TextEditingController controller,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?)? validator,
  }) 
  {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      // If it is a password field, use the state variable. If not, don't obscure.
      obscureText: isPassword ? _isObscure : false,
      style: const TextStyle(color: Colors.black87,fontSize: 13),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14),
        filled: true,
        // fillColor: colors.form_field_color,
        
        // LOGIC: Only show icon if isPassword is true. Otherwise null.
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure; // Toggle the state
                  });
                },
                icon: _isObscure
                    ? Image.asset(
                        AppIcons.in_eye, // Icon when hidden
                        scale: 4,
                      )
                    : Image.asset(
                        AppIcons.eye, // Icon when visible
                        scale: 4,
                      ),
              )
            : null, // No icon for Email
            
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: AppColors.color1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: AppColors.color1,      
          ),
        ),
      ),
    );
  }
}