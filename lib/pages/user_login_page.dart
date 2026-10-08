import 'package:flutter/material.dart';
import 'package:gymtactx/constants/app_color.dart';
import 'package:gymtactx/constants/app_texts.dart';
import 'package:gymtactx/widgets.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  // Şifre görünürlüğü
  bool _obscurePassword = true;
  bool _obscureCode = true;

  // Seçilen değerler
  String? _selectedCity;
  String? _selectedDistrict;
  String? _selectedGym;

  // Örnek il ve ilçeler
  final Map<String, List<String>> _cityDistricts = {
    'İstanbul': ['Kadıköy', 'Beşiktaş', 'Üsküdar', 'Bakırköy'],
    'Ankara': ['Çankaya', 'Keçiören', 'Mamak', 'Etimesgut'],
    'İzmir': ['Bornova', 'Karşıyaka', 'Konak', 'Buca'],
  };

  // Örnek salonlar
  final List<String> _gyms = [
    'GymTactX Fitness',
    'Power Gym',
    'Iron Gym',
    'Fit Center',
  ];

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _codeController.dispose();

    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      debugPrint('Kullanıcı adı: ${_usernameController.text}');
      debugPrint('İsim: ${_nameController.text}');
      debugPrint('Soyisim: ${_surnameController.text}');
      debugPrint('İl: $_selectedCity');
      debugPrint('İlçe: $_selectedDistrict');
      debugPrint('Salon: $_selectedGym');
      debugPrint('Kod: ${_codeController.text}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kayıt bilgileri başarıyla alındı.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppTexts.kullaniciKaydi),
        titleTextStyle: TextStyle(color: AppColors.TextColor),
        centerTitle: true,
        backgroundColor: AppColors.background,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // =====================================
                // KİŞİSEL BİLGİLER
                // =====================================
                const Text(
                  AppTexts.personalInformation,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.TextColor,
                  ),
                ),

                const SizedBox(height: 20),

                AppTextFormField(
                  controller: _usernameController,
                  labelText: "Kullanıcı Adı",
                  hintText: 'Kullanıcı adınızı girin',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Kullanıcı adı zorunludur.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                AppTextFormField(
                  controller: _passwordController,
                  labelText: 'Şifre',
                  hintText: 'Şifrenizi girin',
                  icon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Şifre zorunludur.';
                    }

                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AppTextFormField(
                  controller: _nameController,
                  labelText: 'İsim',
                  hintText: 'İsminizi girin',
                  icon: Icons.badge_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'İsim zorunludur.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                AppTextFormField(
                  controller: _surnameController,
                  labelText: 'Soyisim',
                  hintText: 'Soyisminizi girin',
                  icon: Icons.badge_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Soyisim zorunludur.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 35),

                // =====================================
                // SALON BİLGİLERİ
                // =====================================
                const Text(
                  AppTexts.gymInformation,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.TextColor,
                  ),
                ),

                const SizedBox(height: 20),

                // İL
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.black,
                  style: TextStyle(color: AppColors.appBarText),
                  value: _selectedCity,
                  decoration: const InputDecoration(
                    labelText: 'İl',
                    prefixIcon: Icon(Icons.location_city_outlined),
                    border: OutlineInputBorder(),
                  ),
                  items: _cityDistricts.keys.map((city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value;

                      // İl değiştiğinde ilçe sıfırlanır.
                      _selectedDistrict = null;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Lütfen bir il seçin.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // İLÇE
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.black,
                  style: TextStyle(color: AppColors.appBarText),
                  value: _selectedDistrict,
                  decoration: const InputDecoration(
                    labelText: 'İlçe',
                    prefixIcon: Icon(Icons.location_on_outlined),
                    border: OutlineInputBorder(),
                  ),
                  items: _selectedCity == null
                      ? []
                      : _cityDistricts[_selectedCity]!.map((district) {
                          return DropdownMenuItem<String>(
                            value: district,
                            child: Text(district),
                          );
                        }).toList(),
                  onChanged: _selectedCity == null
                      ? null
                      : (value) {
                          setState(() {
                            _selectedDistrict = value;
                          });
                        },
                  validator: (value) {
                    if (value == null) {
                      return 'Lütfen bir ilçe seçin.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // SALON
                DropdownButtonFormField<String>(
                  style: TextStyle(color: AppColors.appBarText),
                  dropdownColor: Colors.black,
                  value: _selectedGym,
                  decoration: const InputDecoration(
                    labelText: 'Salon',
                    prefixIcon: Icon(Icons.fitness_center),
                    border: OutlineInputBorder(),
                  ),
                  items: _gyms.map((gym) {
                    return DropdownMenuItem<String>(
                      value: gym,
                      child: Text(gym),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGym = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Lütfen bir salon seçin.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                AppTextFormField(
                  controller: _codeController,
                  labelText: 'Kod',
                  hintText: 'Salon kodunuzu girin',
                  icon: Icons.key,
                  obscureText: _obscureCode,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Salon kodu zorunludur.';
                    }

                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureCode = !_obscureCode;
                      });
                    },
                    icon: Icon(
                      _obscureCode
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                AppButton(text: 'Kayıt Ol', onPressed: _register),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
