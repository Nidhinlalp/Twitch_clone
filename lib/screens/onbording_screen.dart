import 'package:flutter/material.dart';
import 'package:twithc_clone/responsive/responsive.dart';
import 'package:twithc_clone/screens/login_screen.dart';
import 'package:twithc_clone/screens/signup_screen.dart';
import 'package:twithc_clone/utils/size.dart';
import 'package:twithc_clone/widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const Text(
                'Twitch',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              kHight20,
              CustomButton(
                text: 'Log in',
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
              ),
              kHight10,
              CustomButton(
                text: 'Sign Up',
                onTap: () {
                  Navigator.pushNamed(context, SignUpScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
