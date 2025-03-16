import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoapp/home/home_screen.dart';
import 'package:todoapp/services/auth_services.dart';
import 'package:todoapp/theme/appcolor.dart';
import 'package:todoapp/pages/loginpage.dart';

class RegisterPage extends StatelessWidget {

  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController name = TextEditingController();

  RegisterPage({super.key});
  Future<void> signup(BuildContext context, String email, pass, name) async {
    final AuthServices auth = AuthServices();

    if(email!='' && pass!='' && name!='' ){
      try{
        await auth.signup(email, pass, name);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }
      catch(e){
        print(e);
      }
    }
    else{
      print('Error!!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 53),
                  Text("Username", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 5),
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      hintText: "Enter your Username",
                      hintStyle: TextStyle(color: Colors.white60),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text("Email", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 5),
                  TextField(
                    controller: email,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      hintText: 'Enter your Email',
                      hintStyle: TextStyle(color: Colors.white60),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text("Password", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 5),
                  TextField(
                    controller: pass,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white60),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      signup(context, email.text, pass.text, name.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.primary,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Text("Register",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.white60),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("or", style: TextStyle(color: Colors.white60)),
                      ),
                      Expanded(
                        child: Divider(color: Colors.white60),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: BorderSide(color: Appcolor.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      )
                    ), 
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        SvgPicture.asset('assets/svg/google.svg', height: 24, width: 24,),
                        SizedBox(width: 10,),
                        Text('Login with Google',style: TextStyle(color: Colors.white)),
                      ],),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: BorderSide(color: Appcolor.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      )
                    ), 
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        SvgPicture.asset('assets/svg/apple.svg', height: 24, width: 24,),
                        SizedBox(width: 10,),
                        Text('Login with Apple',style: TextStyle(color: Colors.white)),
                      ],),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white70),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    }, child: Text('Login', style: TextStyle(color: Colors.white),))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
