import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _onSalonKayit() {}

  void _onUyeKayit() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final buttonBackColor = Color.fromARGB(255, 239, 255, 20);
    final buttonForeColor = Colors.black;
    final buttonTextStyle = theme.textTheme.labelLarge?.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.5,
    );
    final ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: buttonBackColor,
      foregroundColor: buttonForeColor,
      disabledBackgroundColor: colors.primary.withValues(alpha: 0.3),
      disabledForegroundColor: Colors.white54,
      shadowColor: colors.primary,
      elevation: 8,
      minimumSize: const Size(double.infinity, 56),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      textStyle: buttonTextStyle,
    );

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
                ElevatedButton(
                  style: customButtonStyle,
                  onPressed: _onSalonKayit,
                  child: const Text('Salon Kayıt'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: customButtonStyle,
                  onPressed: _onUyeKayit,
                  child: const Text('Üye Kayıt'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
