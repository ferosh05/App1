import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:pro/Reset_Password/reset_pass.dart';
import 'package:pro/URL/url.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {

  TextEditingController emailcontroller=TextEditingController();

  Future<void>registerApp()async{

    final url='${URL.url}/customer_reg.php';

    final body={
      'email': emailcontroller.text,

    };
    try{
      final response =await https.post(Uri.parse(url),body: body);
    final jsondata=json.decode(response.body);

    if(response.statusCode==200){
      if(jsondata['success']==true){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${jsondata['message']}')));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPass()));
      }
      else{
        jsondata['success']==false;
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${jsondata['message']}')));
      }
      
    }

    }
    catch(e){
      e.toString();

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("Forgot Password?",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),)
            ),
            SizedBox(height: 15,),
            
            Center(
              child: Column(
                children: [
                  Text("Enter your E-mail below to receive your",style: TextStyle(fontSize: 19),),
                  SizedBox(height: 5,),
                  Text("password reset instruction",style: TextStyle(fontSize: 19),),
                ],
              )
            ),
            SizedBox(height: 20,),
        
            Text("Email",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

            TextFormField(
              controller: emailcontroller,
              validator: (value) {
                if (value==null||value.isEmpty) {
                  return "Please enter your email";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey,),

                ),
                hintText: "Email ID"
              ),
            ),
            SizedBox(height: 50,),

            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPass()));
              },
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [const Color.fromRGBO(153, 32, 21, 1),Color.fromRGBO(234,90,29,1)]),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                  child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 20),)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}