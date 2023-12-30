import 'package:flutter/material.dart';
import 'package:manageit_school/globalWidgets/divider_with_text.dart';
import 'package:manageit_school/globalWidgets/individual_button.dart';
import 'package:manageit_school/globalWidgets/social_auth.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const YMargin(height: 20),
                    const Text(
                      'Sign up using your social account or email to get started with us',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const YMargin(height: 20),
                    SocialAuth(
                      onGoogleSignInComplete: () {},
                    ),
                    const YMargin(height: 20),
                    const DividerWithText(text: 'OR'),
                    const YMargin(height: 20),
                    Form(
                      key: _registerFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Username',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const YMargin(),
                          TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              final RegExp userNameRegExp =
                                  RegExp(r'^[a-zA-Z][a-zA-Z0-9_-]{2,19}$');

                              if (value == null ||
                                  value.isEmpty ||
                                  !userNameRegExp.hasMatch(value)) {
                                return 'Enter a valid user name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.contact_page_outlined),
                              hintText: "hello@example.com",
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 50,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const YMargin(height: 20),
                          const Text(
                            'Email Address',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const YMargin(),
                          TextFormField(
                            controller: _userNameController,
                            validator: (value) {
                              final RegExp userNameRegExp =
                                  RegExp(r'^[a-zA-Z][a-zA-Z0-9_-]{2,19}$');

                              if (value == null ||
                                  value.isEmpty ||
                                  !userNameRegExp.hasMatch(value)) {
                                return 'Enter a valid user name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.contact_page_outlined),
                              hintText: "hello@example.com",
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 50,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const YMargin(height: 20),
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const YMargin(),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !isPasswordVisible,
                            autocorrect: false,
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.lock_outline_rounded),
                              hintText: "********",
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              suffixIcon: IconButton(
                                icon: !isPasswordVisible
                                    ? const Icon(Icons.visibility_outlined)
                                    : const Icon(Icons.visibility_off_outlined),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 50,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            validator: (value) {
                              final RegExp passwordRegExp = RegExp(
                                r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-]).{8,}$',
                              );
                              if (value == null ||
                                  value.isEmpty ||
                                  !passwordRegExp.hasMatch(value)) {
                                return 'Password must be of at least 8 characters and must contain digits, special characters, and uppercase and lowercase letters';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const YMargin(height: 20),
                    IndividualButton(
                      buttonFunction: () {
                        // Perform registration logic
                      },
                      buttonText: 'Register',
                      backgroundColor: const Color.fromRGBO(47, 78, 255, 0.8),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to the Login screen
                  Navigator.pop(context);
                },
                child: const Text('Already have an account? Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
