import 'package:flutter/material.dart';
import 'package:pt_mert/utils/constants/colors.dart';
import 'package:pt_mert/utils/constants/sizes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.paddingPage),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSizes.spacingXL),
              Center(child: Image.asset('assets/images/logo.png', height: 220)),

              const SizedBox(height: AppSizes.spacingXL),
              const Text(
                'Giriş',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Lütfen bilgilerinizi giriniz.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.inputFieldColor,
                ),
              ),
              const SizedBox(height: AppSizes.spacingL),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: 'Email',
                ),
              ),
              SizedBox(height: AppSizes.spacingM),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  hintText: 'Parola',
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              const SizedBox(height: AppSizes.spacingM),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Sign In'),
                ),
              ),
              const SizedBox(height: AppSizes.spacingL),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Hesabın yok mu? ",
                    style: TextStyle(color: AppColors.inputFieldColor),
                  ),
                  Text(
                    "Kayıt Ol",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
