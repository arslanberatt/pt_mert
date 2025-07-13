import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pt_mert/components/strings.dart';
import 'package:pt_mert/components/text_field.dart';
import 'package:pt_mert/screens/authentication/sign_up_screen.dart';
import 'package:pt_mert/utils/constants/colors.dart';
import 'package:pt_mert/utils/constants/sizes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? _errorMsg;
  bool obscurePassword = true;
  IconData iconPassword = Icons.visibility_rounded;
  bool signInRequired = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          setState(() {
            signInRequired = false;
          });
        } else if (state is SignInProcess) {
          setState(() {
            signInRequired = true;
          });
        } else if (state is SignInFailure) {
          setState(() {
            signInRequired = false;
            _errorMsg = "Email veya Şifre Hatalı!";
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppSizes.paddingPage),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSizes.spacingXL),
                  Center(
                    child: Image.asset('assets/images/logo.png', height: 220),
                  ),
                  SizedBox(height: AppSizes.spacingXL),
                  Text(
                    'Giriş',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryTextColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lütfen bilgilerinizi giriniz.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.inputFieldColor,
                    ),
                  ),
                  SizedBox(height: AppSizes.spacingL),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.person_outline),
                    errorMsg: _errorMsg,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Lütfen bir email giriniz!';
                      } else if (!emailRegExp.hasMatch(val)) {
                        return 'Lütfen geçerli bir email giriniz!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: AppSizes.spacingM),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Şifre',
                    obscureText: obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icon(Icons.lock_outline),
                    errorMsg: _errorMsg,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Lütfen bir şifre giriniz!';
                      } else if (!passwordRegExp.hasMatch(val)) {
                        return 'Lütfen geçerli bir şifre giriniz!';
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                          if (obscurePassword) {
                            iconPassword = Icons.visibility_off;
                          } else {
                            iconPassword = Icons.visibility_rounded;
                          }
                        });
                      },
                      icon: Icon(iconPassword),
                    ),
                  ),
                  SizedBox(height: AppSizes.spacingM),
                  !signInRequired
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<SignInBloc>().add(
                                  SignInRequired(
                                    emailController.text,
                                    passwordController.text,
                                  ),
                                );
                              }
                            },
                            child: Text('Giriş yap'),
                          ),
                        )
                      : const CircularProgressIndicator(),
                  SizedBox(height: AppSizes.spacingL),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hesabın yok mu? ",
                        style: TextStyle(color: AppColors.inputFieldColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Kayıt Ol",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
