import 'package:flutter/material.dart';
import 'package:gymtactx/constants/app_texts.dart';
import 'package:gymtactx/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _onGymSave() {}

  void _onUserSave() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppButton(text: AppTexts.gymSave, onPressed: _onGymSave),
                const SizedBox(height: 20),
                AppButton(text: AppTexts.userSave, onPressed: _onUserSave),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
