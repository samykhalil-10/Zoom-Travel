import 'package:flutter/material.dart';
import 'package:zoom_travel/screens/login/Login_Screen.dart';
import 'package:zoom_travel/screens/login/Signup_Screen.dart';

import '../../shared/components/components.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(75.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 90,
              ),
              Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                'Sign in to enjoy with us',
                style: TextStyle(
                  color: Colors.black26,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              defaultButton(
                function: () {
                  navigateTo(context, ZoomLoginScreen());
                },
                text: 'LOGIN',
              ),
              SizedBox(height: 10),
              defaultButton(
                  function: () {
                    navigateTo(context, ZoomRegisterScreen());
                  },
                  text: 'SIGNUP'),
            ],
          ),
        ),
      ),
    );
  }
}
