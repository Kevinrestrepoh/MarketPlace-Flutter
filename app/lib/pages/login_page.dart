import 'package:app/api/api.dart';
import 'package:app/components/button.dart';
import 'package:app/components/text_field.dart';
import 'package:app/pages/app_page.dart';
import 'package:app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Api api = Api();

  bool _emailValid = true;
  bool _passwordValid = true;

  Future _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    setState(() {
      _emailValid = email.isNotEmpty;
      _passwordValid = password.isNotEmpty;
    });

    if (!_emailValid || !_passwordValid){
      _triggerErrorAnimation();
      return;
    }

    try {
      final user = await api.login(email, password);
      if(mounted){
        context.read<UserProvider>().setUser(user: user);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AppPage()));
      }
    } catch (e) {
      setState(() {
        _emailValid = false;
        _passwordValid = false;
      });
      _triggerErrorAnimation();
    }
  }

  BoxDecoration inputError = BoxDecoration();

  void _triggerErrorAnimation() {
    setState(() {
      inputError = BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.red,
          width: 1
        )
      );
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        inputError = BoxDecoration(borderRadius: BorderRadius.circular(15));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
                  MyTextField(controller: _emailController, hintText: 'email', anim: !_emailValid ? inputError : null),
                  SizedBox(height: 15,),
                  MyTextField(controller: _passwordController, hintText: 'password', obscureText: true, icon: Icon(Icons.lock_outline_rounded), anim: !_passwordValid ? inputError : null),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forgot Password?')
                    ],
                  ),
                  SizedBox(height: 15,),
                  MyButton(onTap: _login, text: 'Sign In',),
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
    );
  }
}