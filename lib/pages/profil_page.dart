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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // ÜST PROFİL KARTI
              SizedBox(
                width: double.infinity,
                height: 180,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  color: Colors.black,
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
                              const Text(
                                '@kullaniciadi',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              const Text(
                                'Ad Soyad',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 16),

                              ElevatedButton(
                                onPressed: () {},
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
                          imagePath: 'assets/images/cards/antremanim.png',
                          onTap: () {},
                        ),

                        AppCard(
                          title: AppTexts.myProgram,
                          imagePath: 'assets/images/cards/basarilarim.png',
                          onTap: () {},
                        ),

                        AppCard(
                          title: AppTexts.myMeasurements,
                          imagePath: 'assets/images/cards/olculerim.png',
                          onTap: () {},
                        ),

                        AppCard(
                          title: AppTexts.myStatics,
                          imagePath: '',
                          onTap: () {},
                        ),

                        AppCard(
                          title: AppTexts.myGym,
                          imagePath: 'assets/images/cards/salonum.png',
                          onTap: () {},
                        ),

                        AppCard(
                          title: AppTexts.myDiet,
                          imagePath: 'assets/images/cards/beslenmem.png',
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
