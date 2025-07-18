import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:pt_mert/components/classic_appbar.dart';
import 'package:pt_mert/components/strings.dart';
import 'package:pt_mert/components/text_field.dart';
import 'package:pt_mert/utils/constants/colors.dart';
import 'package:pt_mert/utils/constants/sizes.dart';
import 'package:user_repository/user_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? _errorMsg;
  bool obscurePassword = true;
  IconData iconPassword = Icons.visibility_rounded;
  bool signUpRequired = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
        } else if (state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          setState(() {
            return;
          });
        }
      },
      child: Scaffold(
        appBar: ClassicAppBar(),
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppSizes.paddingPage),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/boxing-logo.jpg',
                      height: 220,
                    ),
                  ),
                  Text(
                    'Kayıt Ol',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryTextColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lütfen bilgilerinizi doldurun.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.inputFieldColor,
                    ),
                  ),
                  SizedBox(height: AppSizes.spacingL),
                  MyTextField(
                    controller: nameController,
                    label: Text('İsim'),
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    prefixIcon: Icon(Icons.person_outline),
                    errorMsg: _errorMsg,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Lütfen isminizi giriniz!';
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    controller: emailController,
                    label: Text('Email'),
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.email_outlined),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Lütfen email giriniz!';
                      } else if (!emailRegExp.hasMatch(val)) {
                        return 'Geçerli bir email giriniz!';
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    controller: passwordController,
                    label: Text('Şifre'),
                    obscureText: obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icon(Icons.lock_outline),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Lütfen şifre giriniz!';
                      } else if (!passwordRegExp.hasMatch(val)) {
                        return 'Şifre en az 6 karakter olmalı!';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                          iconPassword = obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility_rounded;
                        });
                      },
                      icon: Icon(iconPassword),
                    ),
                  ),
                  MyTextField(
                    controller: confirmPasswordController,
                    label: Text('Şifre'),
                    obscureText: obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icon(Icons.lock_reset_outlined),
                    errorMsg: _errorMsg,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Lütfen şifreyi tekrar giriniz!';
                      } else if (val != passwordController.text) {
                        return 'Şifreler uyuşmuyor!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppSizes.spacingL),
                  !signUpRequired
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                MyUser myUser = MyUser.empty;
                                myUser = myUser.copyWith(
                                  email: emailController.text,
                                  name: nameController.text,
                                );
                                setState(() {
                                  context.read<SignUpBloc>().add(
                                    SignUpRequired(
                                      myUser,
                                      passwordController.text,
                                    ),
                                  );
                                  signUpRequired = true;
                                });
                              }
                            },
                            child: Text('Kayıt Ol'),
                          ),
                        )
                      : Center(child: CircularProgressIndicator()),
                  SizedBox(height: AppSizes.spacingL),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
