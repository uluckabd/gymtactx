import 'package:flutter/material.dart';
import 'package:gymtactx/constants/app_color.dart';
import 'package:gymtactx/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // BÜYÜK PROFİL CARD
              SizedBox(
                width: double.infinity,
                height: 180,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        // PROFİL FOTOĞRAFI
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.person,
                            size: 55,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 24),

                        // KULLANICI BİLGİLERİ
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // KULLANICI ADI
                              const Text(
                                '@kullaniciadi',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              // AD SOYAD
                              const Text(
                                'Ad Soyad',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 16),

                              // DÜZENLE BUTONU
                              ElevatedButton(
                                onPressed: () {
                                  // Profil düzenleme
                                },
                                child: const Text('Düzenle'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ALT CARDLAR
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    const double spacing = 12;

                    // 3 sıra arasındaki 2 boşluğu çıkarıp
                    // kalan yüksekliği tam 3'e bölüyoruz.
                    final double cardHeight =
                        (constraints.maxHeight - (spacing * 2)) / 3;

                    final double cardWidth =
                        (constraints.maxWidth - spacing) / 2;

                    return GridView.count(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),

                      crossAxisCount: 2,

                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,

                      childAspectRatio: cardWidth / cardHeight,

                      children: [
                        AppCard(
                          title: 'Antrenmanlarım',
                          icon: Icons.fitness_center,
                          onTap: () {},
                          color: AppColors.workout,
                        ),

                        AppCard(
                          title: 'Programım',
                          icon: Icons.calendar_month_outlined,
                          onTap: () {},
                          color: AppColors.program,
                        ),

                        AppCard(
                          title: 'Ölçümlerim',
                          icon: Icons.monitor_weight_outlined,
                          onTap: () {},
                          color: AppColors.measurement,
                        ),

                        AppCard(
                          title: 'İstatistikler',
                          icon: Icons.bar_chart,
                          onTap: () {},
                          color: AppColors.statistics,
                        ),

                        AppCard(
                          title: 'Salonum',
                          icon: Icons.apartment,
                          onTap: () {},
                          color: AppColors.gym,
                        ),

                        AppCard(
                          title: 'cartcurt',
                          icon: Icons.apartment,
                          onTap: () {},
                          color: AppColors.appBarIcon,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
