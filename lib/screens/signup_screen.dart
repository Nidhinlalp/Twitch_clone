import 'package:flutter/material.dart';
import 'package:twithc_clone/resources/auth_methods.dart';
import 'package:twithc_clone/responsive/responsive.dart';
import 'package:twithc_clone/utils/size.dart';
import 'package:twithc_clone/widgets/custom_button.dart';
import 'package:twithc_clone/widgets/custom_textfield.dart';
import 'package:twithc_clone/widgets/loding_indicator.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    bool res = await _authMethods.signUpUser(
      context,
      _emailController.text,
      _userNameController.text,
      _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (res && context.mounted) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: _isLoading
          ? const LoadingIndicator()
          : Responsive(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.1),
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomTextField(
                          controller: _emailController,
                        ),
                      ),
                      kHight20,
                      const Text(
                        'Username',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: CustomTextField(
                          controller: _userNameController,
                        ),
                      ),
                      kHight20,
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: CustomTextField(
                          controller: _passwordController,
                        ),
                      ),
                      kHight20,
                      CustomButton(
                        text: 'Sign Up',
                        onTap: signUpUser,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
