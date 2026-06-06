// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as https;
// import 'package:pro/Image/images.dart';
// import 'package:pro/Forgot/forgot_pass.dart';
// import 'package:pro/Signup/signup.dart';
// import 'package:pro/Subscription/subsc.dart';

// class Signin extends StatefulWidget {
//   const Signin({super.key});

//   @override
//   State<Signin> createState() => _SigninState();
// }

// class _SigninState extends State<Signin> {
//   bool isshow=true;
//   void show()
//   {
//     setState(() {
//       isshow=!isshow;
//     });
//   }
//   TextEditingController emailcontroller=TextEditingController();
//   TextEditingController passwordcontroller=TextEditingController();

//   FocusNode emailFocus=FocusNode();
//   FocusNode passwordFocus=FocusNode();

//   final formkey=GlobalKey<FormState>();

//   Future<void>registerApp()async{

//     const url='https://srishticampus.tech/bloodconnect/viavita_api/customer_reg.php';

//     final body={
//       'email': emailcontroller.text,
//       'password': passwordcontroller.text,

//     };
//     try{
//       final response =await https.post(Uri.parse(url),body: body);
//     final jsondata=json.decode(response.body);

//     if(response.statusCode==200){
//       if(jsondata['success']==true){
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${jsondata['message']}')));
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>Subscription()));
//       }
//       else{
//         jsondata['success']==false;
//          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${jsondata['message']}')));
//       }
      
//     }

//     }
//     catch(e){
//       e.toString();

//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 150,),
//               Center(child: Text("Sign in your account",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30),)),
          
//               SizedBox(height: 30,),
//               Text("Email ID",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
        
//               TextFormField(
//                 controller: emailcontroller,
//                 focusNode: emailFocus,
//                 validator: (value) {
//                   if (value==null||value.isEmpty) {
//                     return "Please enter Your Email";
//                   } else {
//                     return null;
//                   }
//                 },
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey,)
//                   ),
//                   fillColor: Colors.grey,
//                   hintText: "Email ID",
                  
//                 ),
//               ),
        
//               SizedBox(height: 30,),
//               Text("Password",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
//               TextFormField(
//                 controller: passwordcontroller,
//                 focusNode: passwordFocus,
//                 validator: (value) {
//                   if (value==null||value.isEmpty) {
//                     return "Please enter Your Password";
//                   } else {
//                     return null;
//                   }
//                 },
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey,)
//                   ),
//                   fillColor: Colors.grey,
//                   hintText: "Password",
//                   suffixIcon: GestureDetector(
//                     onTap: () {
//                       show();
//                     },
//                     child: Image.asset(isshow?Images.eye:Images.in_eye,scale: 4,)
//                   )
                  
//                 ),
//               ),
//               SizedBox(height: 18,),
        
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                      onPressed: () { 
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgot()));
//                       }, child: Text("Forgot Password?",style: TextStyle(fontSize: 20,color: Colors.black),)
//                   )
//                 ],
//               ),
//               SizedBox(height: 25,),
        
//               Container(
//                 height: 55,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: [const Color.fromRGBO(153, 32, 21, 1),Color.fromRGBO(234,90,29,1)]),
//                   borderRadius: BorderRadius.circular(15)
//                 ),
//                 child: Center(
//                   child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 20),)
//                 ),
//               ),
//               SizedBox(height: 50,),
        
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Don't have an account?",style: TextStyle(fontSize: 18),),
//                   TextButton(
//                     onPressed:() {
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
//                     } , child: Text("Signup",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 19,color: Colors.black),))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }