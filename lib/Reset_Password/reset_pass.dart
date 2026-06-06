import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:pro/Image/images&icons.dart';
import 'package:pro/Signin/demosignin.dart';
import 'package:pro/Signin/signinscreen.dart';
import 'package:pro/URL/url.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  bool isshow=true;
  void show()
  {
    setState(() {
      isshow=!isshow;
    });
  }

  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController resetpasswordcontroller=TextEditingController();

  FocusNode passwordFocus=FocusNode();
  FocusNode resetpasswordFocus=FocusNode();

  Future<void>registerApp()async{

    final url='${URL.url}/customer_reg.php';

    final body={
      'password':passwordcontroller.text,
      'resetpassword':resetpasswordcontroller.text


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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("Reset Password",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500))
            ),
            SizedBox(height: 20,),
        
            Center(
              child: Text("Enter your new password",style: TextStyle(fontSize: 18),)
            ),
        
            Text("Password",style: TextStyle(fontSize: 18),),
            SizedBox(height: 15,),
            TextFormField(
                  controller: passwordcontroller,
                  focusNode: passwordFocus,
                  validator: (value) {
                    if (value==null||value.isEmpty) {
                      return "Please enter Your Password";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,)
                    ),
                    fillColor: Colors.grey,
                    hintText: "Password",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        show();
                      },
                      child: Image.asset(isshow?AppIcons.eye:AppIcons.in_eye,scale: 4,)
                    )
                    
                  ),
                ),
              SizedBox(height: 40,),
              
              Text("Password",style: TextStyle(fontSize: 18),),
              SizedBox(height: 15,),
        
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey,),
                  ),
                  hintText: "Password",
                  suffixIcon: Icon(Icons.remove_red_eye_outlined)
                ),
              ),
              SizedBox(height: 50,),

              GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkerLoginScreen()));
              },
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [const Color.fromRGBO(153, 32, 21, 1),Color.fromRGBO(234,90,29,1)]),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                  child: Text("Confirm",style: TextStyle(color: Colors.white,fontSize: 20),)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}