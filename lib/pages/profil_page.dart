import 'package:flutter/material.dart';
import 'package:gymtactx/constants/app_color.dart';
import 'package:gymtactx/constants/app_texts.dart';
import 'package:gymtactx/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            children: [
              // ÜST PROFİL KARTI
              SizedBox(
                width: double.infinity,
                height: 180,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  color: AppColors.background,
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
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppTexts.myNickname,
                                style: AppTextStyles.title,
                              ),
                              Text(
                                AppTexts.myNameSurname,
                                style: AppTextStyles.subtitle,
                              ),
                              Text(AppTexts.myGym, style: AppTextStyles.body),
                              Text(AppTexts.myPoint, style: AppTextStyles.body),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 6 ALT KART
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    const double spacing = 12;

                    // 2 sütun olduğu için kart genişliği
                    final double cardWidth =
                        (constraints.maxWidth - spacing) / 2;

                    // 3 sıra olduğu için kart yüksekliği
                    // İki adet 12px sıra boşluğunu çıkarıyoruz
                    final double cardHeight =
                        (constraints.maxHeight - (spacing * 2)) / 3;

                    return GridView.count(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),

                      crossAxisCount: 2,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,

                      // Kalan alanı tam doldur
                      childAspectRatio: cardWidth / cardHeight,

                      children: [
                        AppCard(
                          title: AppTexts.myWorkout,
                          imagePath: 'myWorkout',
                          onTap: () {},
                        ),

                        AppCard(
                          title: AppTexts.myAchievements,
                          imagePath: 'myAchievements',
                          onTap: () {},
                        ),

                        AppCard(
                          title: AppTexts.myMeasurements,
                          imagePath: 'myMeasurements',
                          onTap: () {},
                        ),

                        AppCard(
                          title: AppTexts.mycalori,
                          imagePath: 'mycalori',
                          onTap: () {},
                        ),

                        AppCard(
                          title: AppTexts.myGym,
                          imagePath: 'myGym',
                          onTap: () {},
                        ),

                        AppCard(
                          title: AppTexts.myDiet,
                          imagePath: 'myDiet',
                          onTap: () {},
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
