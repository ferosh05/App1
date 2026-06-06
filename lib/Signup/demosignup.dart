// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:pro/Image/images&icons.dart';
// import 'package:pro/Signin/demosignin.dart';
// import 'package:pro/Signin/signinscreen.dart';
// import 'package:pro/Subscription/subsc.dart';

// class Signup extends StatefulWidget {
//   const Signup({super.key});

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   TextEditingController nameController=TextEditingController();
//   TextEditingController ageController=TextEditingController();
//   TextEditingController phoneController=TextEditingController();
//   TextEditingController emailController=TextEditingController();
//   TextEditingController addressController=TextEditingController();
//   TextEditingController idController=TextEditingController();
//   TextEditingController passwordController=TextEditingController();
//   TextEditingController confirmController=TextEditingController();

//   FocusNode namefocus =FocusNode();
//   FocusNode agefocus =FocusNode();
//   FocusNode phonefocus =FocusNode();
//   FocusNode emailfocus =FocusNode();
//   FocusNode addressfocus =FocusNode();
//   FocusNode idfocus =FocusNode();
//   FocusNode passwordfocus =FocusNode();
//   FocusNode confirmfocus =FocusNode();

//   final formkey =GlobalKey<FormState>();
//   bool isshow=false;
//   String? _selectedvalue;
//   String? selectedState;
//   String? selectedDistrict;

//   // FilePickerResult? result = await FilePicker.platform.pickFiles();

//   void show()
//   {
//     setState(() {
//       isshow =!isshow;
//     });
//   }

//   List<String> states = ["Tamil Nadu", "Kerala", "Karnataka"];
//   List<String> districts = ["Kanya Kumari","Chennai", "Madurai", "Coimbatore"];
//   @override
//   Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Colors.white,
//     appBar: AppBar(
//       backgroundColor: Colors.white,
//     ),
//     body: SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Text("Create a new account",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),)
//             ),
//             SizedBox(
//               height: 15,
//             ),
        
//             Center(
//               child: CircleAvatar(
//                 radius: 70,
//                 backgroundColor: Colors.grey.shade400,
//                 child: Icon(Icons.person_add_alt_1,size: 80,color: Colors.grey.shade100,),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
        
//             Center(
//               child: Text("+ Add Image",style: TextStyle(fontSize: 18),)
//             ),
//             SizedBox(
//               height: 15,
//             ),
        
//             Text("Name",style: TextStyle(fontSize: 18),),
//             customtextformfield(
//               text: "Name",
//               control: nameController,
//               focusnode: namefocus,
//               validator: (value)
//               {
//                 if (value==null || value.isEmpty) {
//                   return "Please enter name";
//                 } else {
//                   return null;
//                 }
//               }
//             ),
//             SizedBox(height: 15,),
      
//             Text("Gender",style: TextStyle(fontSize: 18),),
      
//             Row(
//               children: [
//                 radio(text: "Male"),
//                 Text("Male",style: TextStyle(fontSize: 20,color: Colors.grey.shade700),),
      
//                 radio(text: "Female"),
//                 Text("Female",style: TextStyle(fontSize: 20,color: Colors.grey.shade700),),
      
//                 radio(text: "Other"),
//                 Text("Other",style: TextStyle(fontSize: 20,color: Colors.grey.shade700),),
//               ],
//             ),
//             SizedBox(
//               height: 15,
//             ),
        
//             Text("Age",style: TextStyle(fontSize: 18),),
//             customtextformfield(
//               text: "Age",
//               control: ageController,
//               focusnode: agefocus,
//               validator: (value)
//               {
//                 if (value==null || value.isEmpty) {
//                   return "Please enter age";
//                 } else {
//                   return null;
//                 }
//               }
//             ),
//             SizedBox(
//               height: 15,
//             ),
        
//             Text("Phone Number",style: TextStyle(fontSize: 18),),
//             customtextformfield(
//               text: "Phone Number",
//               control: phoneController,
//               focusnode: phonefocus,
//               validator: (value)
//               {
//                 if (value==null || value.isEmpty) {
//                   return "Please enter Phone Number";
//                 } else {
//                   return null;
//                 }
//               }
//             ),
//             SizedBox(
//               height: 15,
//             ),
        
//             Text("Email",style: TextStyle(fontSize: 18),),
//             customtextformfield(
//               text: "Email",
//               control: emailController,
//               focusnode: emailfocus,
//               validator: (value)
//               {
//                 if (value==null || value.isEmpty) {
//                   return "Please enter email ID";
//                 } else {
//                   return null;
//                 }
//               }
//             ),
//             SizedBox(
//               height: 15,
//             ),

//             Text("State",style: TextStyle(fontSize: 18),),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 hintText: "State",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               value: selectedState,
//               items: states.map((state) {
//                 return DropdownMenuItem(
//                   value: state,
//                   child: Text(state),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedState = value;
//                 });
//               },
//             ),
//             SizedBox(
//               height: 15,
//             ),

//             Text("District",style: TextStyle(fontSize: 18),),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 labelText: "District",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               value: selectedDistrict,
//               items: districts.map((district) {
//                 return DropdownMenuItem(
//                   value: district,
//                   child: Text(district),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedDistrict = value;
//                 });
//               },
//             ),
//             SizedBox(
//               height: 15,
//             ),
        
//             Text("Address",style: TextStyle(fontSize: 18),),
//             customtextformfield(
//               text: "Address",
//               control: addressController,
//               focusnode: addressfocus,
//               validator: (value)
//               {
//                 if (value==null || value.isEmpty) {
//                   return "Please enter Address";
//                 } else {
//                   return null;
//                 }
//               }
//             ),
//             SizedBox(
//               height: 15,
//             ),

//             Text("ID proof",style: TextStyle(fontSize: 18),),
//             TextFormField(
//               controller: idController,
//               focusNode: idfocus,
//               validator: (value)
//               {
//                 if (value==null || value.isEmpty) {
//                   return "Please enter an ID proof";
//                 } else {
//                   return null;
//                 }
//               },
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 hintText: "Choose File",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 // suffixIcon: if (result != null) {
//                 //   File file = File(result.files.single.path!);
//                 // } else {
//                 //   // User canceled the picker
//                 // }
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
        
//             Text("Password",style: TextStyle(fontSize: 18),),
//             customtextformfield(
//               text: "Password",
//               control: passwordController,
//               focusnode: passwordfocus,
//               validator: (value)
//               {
//                 if (value==null || value.isEmpty) {
//                   return "Please enter your password";
//                 } else {
//                   return null;
//                 }
//               },
//               ispassword: true,
//             ),
//             SizedBox(
//               height: 15,
//             ),
        
//             Text("Confirm Password",style: TextStyle(fontSize: 18),),
//             customtextformfield(
//               text: "Confirm Password",
//               control: confirmController,
//               focusnode: confirmfocus,
//               validator: (value)
//               {
//                 if (value==null || value.isEmpty) {
//                   return "Please re-enter your password";
//                 } else {
//                   return null;
//                 }
//               },
//               ispassword: true,
//             ),
//             SizedBox(
//               height: 35,
//             ),

//             GestureDetector(
//               onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Subscription())),
//               child: Container(
//                 height: 55,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: [const Color.fromRGBO(153, 32, 21, 1),Color.fromRGBO(234,90,29,1)]),
//                   borderRadius: BorderRadius.circular(15)
//                 ),
//                 child: Center(
//                   child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 20),)
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
            
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Already have an account?",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
//                 TextButton(onPressed: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkerLoginScreen()));
//                 }, child:Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),) )
//               ],
//             )
//           ],
//         ),
//       ),
//     ),
//   );
//   }
//   Widget customtextformfield(
//     {
//       String? text,
//       TextEditingController? control,
//       String? Function(String?)? validator,
//       FocusNode? focusnode,
//       FocusNode? nextfocusnode,
//       bool ispassword= false
//     }
//   )
//   {
//     return TextFormField(
//       controller: control,
//       focusNode: focusnode,
//       validator: validator,
//       obscureText: ispassword? !isshow:false,
//       onFieldSubmitted: (_) {
//         if (nextfocusnode != null) {
//           FocusScope.of(context).requestFocus(nextfocusnode);
//         } else {
//           FocusScope.of(context).unfocus();
//         }
//       },
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.white,
//         hintText: text,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
          
//         ),
//         suffixIcon: ispassword? 
//             GestureDetector(
//               onTap: () => show(),
//               child: Image.asset(
//                 isshow? Images.eye:Images.in_eye,scale: 4,
//               ),
//             ) 
//           :null
//       ),
//     );
//   }

//   Widget radio(
//   {
//     String? text,
//   }
//   )
//   {
//     return Radio(value: text, 
//       groupValue: _selectedvalue, 
//       onChanged: (value) {
//         setState(() {
//           _selectedvalue =value!;
//         });
//       },
//     );
//   }
// }