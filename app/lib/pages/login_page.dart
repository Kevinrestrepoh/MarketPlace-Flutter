import 'package:app/components/button.dart';
import 'package:app/components/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 25,),
              Text('Marketplace', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 30),),
              SizedBox(height: 25,),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  children: [
                    MyTextField(hintText: 'email', obscureText: false,),
                    SizedBox(height: 15,),
                    MyTextField(hintText: 'password', obscureText: true, icon: Icon(Icons.lock_outline_rounded),),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Forgot Password?')
                      ],
                    ),
                    SizedBox(height: 15,),
                    MyButton(onTap: (){},),
                    SizedBox(height: 50,),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Or continue with'),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email, size: 80,),
                        SizedBox(width: 50,),
                        Icon(Icons.apple, size: 80,)
                      ],
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Not a member?'),
                        const SizedBox(width: 5,),
                        Text('Register now', style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}