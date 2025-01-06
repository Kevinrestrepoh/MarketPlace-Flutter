import 'package:app/pages/login_page.dart';
import 'package:app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return userProvider.user == null
                    ? Text("No user logged in.")
                    : Text("Welcome, ${userProvider.user!.name}");
              },
            ),
            ElevatedButton(
              onPressed: (){
                context.read<UserProvider>().setUser(user: null);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              }, 
              child: Text('Log Out')
            )
          ],
        ),
      ),
    );
  }
}