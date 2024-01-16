import 'package:flutter/material.dart';
import 'package:manageit_school/controllers/auth_controller.dart';
import 'package:manageit_school/globalWidgets/divider_with_text.dart';
import 'package:manageit_school/globalWidgets/individual_button.dart';
import 'package:manageit_school/globalWidgets/navigator_widget.dart';
import 'package:manageit_school/globalWidgets/social_auth.dart';
import 'package:manageit_school/globalWidgets/y_margin.dart';
import 'package:manageit_school/screens/dashboard.dart';
import 'package:manageit_school/screens/forgot_password.dart';
import 'package:manageit_school/screens/home.dart';
import 'package:manageit_school/screens/register.dart';
import 'package:manageit_school/services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isRememberMeToggled = true;
  bool loading = false;

  void validateLogin(bool saveLoginData) async {
    final Map<String, dynamic>? userData;
    if (_loginFormKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        if (saveLoginData) {
          await AuthController().authenticateUser(
            userNameController.text,
            passwordController.text,
            saveLoginData,
          );
          userData = await AuthController().fetchUserDetailsfromSP();
          print(userData);
          NavigatorWidget().screenPushReplacement(context, const HomeScreen());
        } else {
          final String? userToken = await AuthController().getUserToken(
            userNameController.text,
            passwordController.text,
            saveLoginData,
          );
          if (userToken != null) {
            userData = await ApiService().fetchUserDetails(userToken);
            NavigatorWidget()
                .screenPushReplacement(context, DashBoard(user: userData!));
          } else {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error authenticating the user'),
              ),
            );
          }
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid username or password'),
          ),
        );
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome Back!!',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const YMargin(height: 20),
                    const Text(
                      'Welcome back! Sign in using your social account or email to continue with us',
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
                        key: _loginFormKey,
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
                              controller: userNameController,
                              autocorrect: false,
                              validator: (value) {
                                final RegExp userNameRegExp =
                                    RegExp(r'^[a-zA-Z][a-zA-Z0-9_-]{2,19}$');

                                // if (value == null ||
                                //     value.isEmpty ||
                                //     !userNameRegExp.hasMatch(value)) {
                                //   return 'Enter a valid user name';
                                // }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(Icons.contact_page_outlined),
                                hintText: "hello@example.com",
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 50, color: Colors.black)),
                              ),
                            ),
                            const YMargin(height: 10),
                            const Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const YMargin(),
                            TextFormField(
                              controller: passwordController,
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
                                      : const Icon(
                                          Icons.visibility_off_outlined),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 50, color: Colors.black),
                                ),
                              ),
                              validator: (value) {
                                final RegExp passwordRegExp = RegExp(
                                    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-]).{8,}$');
                                // if (value == null ||
                                //     value.isEmpty ||
                                //     !passwordRegExp.hasMatch(value)) {
                                //   return 'Password must be of atleast 8 characters and must contain\ndigits, special character annd uppercase and lowercase\nletters';
                                // }
                                return null;
                              },
                            ),
                          ],
                        )),
                    const YMargin(height: 10),
                    loading
                        ? const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: CircularProgressIndicator(),
                          )
                        : IndividualButton(
                            buttonFunction: () =>
                                validateLogin(isRememberMeToggled),
                            buttonText: 'Log in',
                            backgroundColor:
                                const Color.fromRGBO(47, 78, 255, 0.8),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Colors.transparent;
                                  },
                                ),
                              ),
                              child: const Text(
                                "Remember me?",
                                style: TextStyle(fontSize: 14),
                              ),
                              onPressed: () {
                                setState(() {
                                  isRememberMeToggled = !isRememberMeToggled;
                                });
                              },
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.1,
                              child: Switch(
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey,
                                activeColor: Colors.black,
                                activeTrackColor: Colors.grey,
                                value: isRememberMeToggled,
                                onChanged: (value) => setState(() {
                                  isRememberMeToggled = value;
                                }),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            NavigatorWidget().screenReplacement(
                                context, const ForgotPasswordScreen());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TextButton(
                child: const Text('Create an account'),
                onPressed: () {
                  NavigatorWidget()
                      .screenReplacement(context, const RegisterScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
