import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:vida/features/auth/screens/auth_screen.dart';
import 'package:vida/features/auth/services/auth_service.dart';
import 'package:vida/home/reset_password.dart';
import 'package:vida/home/signup.dart';
import 'package:vida/theme.dart';
import 'package:vida/widgets/login_form.dart';



class LogInScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  //  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void logIn(){
    authService.logIn(
      context: context,
      
      email: _emailController.text,
      
      password: _passwordController.text,
      
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
              ),
              Text(
                'Welcome Back',
                style: titleText,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'New to this app?',
                    style: subTitle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    LogInForm(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    LogInForm(
                      hintText: 'Password',
                      controller: _passwordController,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              /*GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen()));
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: kZambeziColor,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1,
                  ),
                ),
              ),*/
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
              logIn();
            }
                  //Navigator.pushNamed(context, AuthScreen.routeName);
                  //Navigator.of(context).pushNamed('/appointment');
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: kPrimaryColor),
                  child: Text(
                    'Log In',
                    style: textButton.copyWith(color: kWhiteColor),
                  ),
                ),
              ),

              /*PrimaryButton(
                buttonText: 'Log In',
              ),*/
              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 20,
              ),
              //LoginOption(),
            ],
          ),
        ),
      ),
    );
  }
}

/*class LogInScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
  }
}*/
