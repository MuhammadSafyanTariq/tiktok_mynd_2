import 'package:flutter/material.dart';
import 'package:insta_clone/Resource/Auth_Methods.dart';
import 'package:insta_clone/Screens/sign_up_screen.dart';
import 'package:insta_clone/Widgets/app_bar.dart';
import 'package:insta_clone/Widgets/text_input_feilds.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_screen_layout.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthMethods _authMethods = AuthMethods();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void LoginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await _authMethods.loginUser(
        email: _emailController.text, password: _passwordController.text);
    setState(() {
      _isLoading = false;
    });
    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout()),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
  }

  void goTOSignUpScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const MyAppBar(
                backButton: false,
                title: "Sign In",
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Please enter the email',
                      style: TextStyle(fontSize: 15, color: Colors.black87),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextInputFeilds(
                      textEditingController: _emailController,
                      hintText: "Email",
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      ' Please enter the email',
                      style: TextStyle(fontSize: 15, color: Colors.black87),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextInputFeilds(
                      textEditingController: _passwordController,
                      hintText: "Please enter the password",
                      isPass: true,
                      textInputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: LoginUser,
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          color: buttonColor,
                        ),
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              )
                            : const Text(
                                "Log in",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                    // Spacer(),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
