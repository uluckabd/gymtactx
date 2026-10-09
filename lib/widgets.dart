import 'package:flutter/material.dart';
import 'package:gymtactx/constants/app_color.dart';

// =====================================================
// APP BUTTON
// =====================================================

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const AppButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final buttonTextStyle = theme.textTheme.labelLarge?.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.5,
    );

    final ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: AppColors.buttonBackColor,
      foregroundColor: AppColors.buttonForeColor,

      disabledBackgroundColor: colors.primary.withValues(alpha: 0.3),
      disabledForegroundColor: Colors.white54,

      shadowColor: colors.primary,
      elevation: 8,

      minimumSize: const Size(double.infinity, 56),

      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),

      textStyle: buttonTextStyle,
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: customButtonStyle,
      child: Text(text),
    );
  }
}

// =====================================================
// APP TEXT FIELD
// =====================================================

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData icon;
  final String? Function(String?)? validator;
  final InputBorder border;

  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final bool enabled;

  const AppTextFormField({
    super.key,

    // Kullanıldığı sayfadan alınacak zorunlu değerler
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.validator,

    // İsteğe bağlı değerler
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.enabled = true,
    this.border = const OutlineInputBorder(),
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      enabled: enabled,

      style: const TextStyle(
        color: AppColors.textFieldText,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),

      decoration: InputDecoration(
        // Label ve Hint
        labelText: labelText,
        hintText: hintText,

        // Arka plan
        filled: false,
        fillColor: Colors.grey,

        // Label
        labelStyle: const TextStyle(color: AppColors.textFieldLabel),

        // Hint
        hintStyle: const TextStyle(color: AppColors.textFieldHint),

        // Sol ikon
        prefixIcon: Icon(icon, color: AppColors.textFieldIcon),

        // Sağ ikon
        suffixIcon: suffixIcon,

        // Genel Border
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: AppColors.textFieldBorder, width: 1),
        ),

        // Normal durum
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: AppColors.textFieldBorder, width: 1),
        ),

        // TextField seçildiğinde
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            color: AppColors.textFieldFocusedBorder,
            width: 1.5,
          ),
        ),

        // Hata olduğunda
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            color: AppColors.textFieldErrorBorder,
            width: 1,
          ),
        ),

        // Hata varken seçildiğinde
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            color: AppColors.textFieldErrorBorder,
            width: 1.5,
          ),
        ),

        // İç boşluk
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
      ),

      validator: validator,
    );
  }
}

class AppCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final VoidCallback? onTap;

  const AppCard({super.key, required this.title, this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        color: Colors.grey.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // FOTOĞRAF
            if (imagePath != null && imagePath!.isNotEmpty)
              Image.asset(
                'assets/images/cards/$imagePath.png',
                fit: BoxFit.cover,
              ),

            // Fotoğraf varsa yazının okunması için hafif gölge
            if (imagePath != null && imagePath!.isNotEmpty)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black54],
                  ),
                ),
              ),

            // BAŞLIK - SAĞ ALT
            Positioned(
              right: 12,
              bottom: 10,
              left: 12,
              child: Text(
                title,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppTextStyles {
  AppTextStyles._();

  // SAYFA BAŞLIĞI
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // ALT BAŞLIK
  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // NORMAL YAZI
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.white70,
  );
}
