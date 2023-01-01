import 'package:flutter/material.dart';
import 'package:vida/home/login.dart';
import 'package:vida/theme.dart';
//import 'package:vida/widgets/checkbox.dart';

//import 'package:vida/widgets/primary_button.dart';
//import 'package:vida/widgets/signup_form.dart';

//import '../features/auth/screens/auth_screen.dart';
import '../features/auth/services/auth_service.dart';
import '../widgets/login_form.dart';

class SignUpScreen extends StatefulWidget {
  //static const String routeName = '/login';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signupformKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _nameController = TextEditingController();
  //final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    //_lnameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
  }

  void sigupUser() {
    authService.signupUser(
      context: context,
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
      address: _addressController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 70,
      ),
      Padding(
        padding: kDefaultPadding,
        child: Text(
          'Create Account',
          style: titleText,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Padding(
        padding: kDefaultPadding,
        child: Row(
          children: [
            Text(
              'Already a member?',
              style: subTitle,
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInScreen()));
              },
              child: Text(
                'Log In',
                style: textButton.copyWith(
                  decoration: TextDecoration.underline,
                  decorationThickness: 1,
                ),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: kDefaultPadding,
        child: Form(
          key: _signupformKey,
          child: Column(
            children: [
              LogInForm(
                hintText: 'Name',
                controller: _nameController,
              ),
              /*LogInForm(
                        hintText: 'LastName',
                        controller: _emailController,
                      ),*/
              
              LogInForm(
                hintText: 'Email',
                controller: _emailController,
              ),
              LogInForm(
                hintText: 'Phone',
                controller: _phoneController,
              ),
              LogInForm(
                hintText: 'Password',
                controller: _passwordController,
              ),
              LogInForm(
                hintText: 'Address',
                controller: _addressController,
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: kDefaultPadding,
        child: GestureDetector(
          onTap: () {
            if (_signupformKey.currentState!.validate()) {
              sigupUser();
            }
            //Navigator.pushNamed(context, AuthScreen.routeName);
            //Navigator.of(context).pushNamed('/appointment');
          },
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.08,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: kPrimaryColor),
            child: Text(
              'Sign Up',
              style: textButton.copyWith(color: kWhiteColor),
            ),
          ),
        ),
      ),
    ])));
  }
}

/*class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ild: S
            ),
            SizedBox(
              height: 20,
            ),
            
            
            Padding(
              padding: kDefaultPadding,
              child: PrimaryButton(buttonText: 'Sign Up'),
            ),
            SizedBox(
              height: 20,
            ),
            
            
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}*/
