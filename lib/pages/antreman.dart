import 'package:flutter/material.dart';
import 'package:gymtactx/constants/app_color.dart';
import 'package:gymtactx/constants/app_texts.dart';
import 'package:gymtactx/widgets.dart';

class Antreman extends StatefulWidget {
  const Antreman({super.key});

  @override
  State<Antreman> createState() => _AntremanState();
}

class _AntremanState extends State<Antreman> {
  static const surface = Color(0xFF222222);
  bool workoutStarted = false;
  bool workoutPaused = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.appBarForeground,
        foregroundColor: AppColors.appBarBackground,
        title: Text(AppTexts.trainingTitle, style: AppTextStyles.title),
        actions: [],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: const BoxDecoration(
            color: AppColors.black,
            border: Border(top: BorderSide(color: Colors.white24)),
          ),
          child: !workoutStarted
              ? SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        workoutStarted = true;
                        workoutPaused = false;
                      });
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text(AppTexts.trainingStart),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonBackground,
                      foregroundColor: AppColors.buttonForeColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // KALORİ VE SÜRE
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: const Icon(
                            Icons.local_fire_department,
                            color: AppColors.buttonBackColor,
                            size: 34,
                          ),
                        ),

                        // SOL: KALORİ
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppTexts.trainingCalori,
                                style: AppTextStyles.body,
                              ),
                              Text(
                                AppTexts.calorieCounting,
                                style: AppTextStyles.title,
                              ),
                            ],
                          ),
                        ),
                        // SAĞ: SÜRE
                        Row(
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  AppTexts.trainingTime,
                                  style: AppTextStyles.body,
                                ),
                                Text(
                                  '00:00',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Icon(
                                Icons.access_time,
                                color: AppColors.buttonBackColor,
                                size: 34,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // BUTONLAR
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                workoutPaused = !workoutPaused;
                              });
                            },
                            icon: Icon(
                              workoutPaused ? Icons.play_arrow : Icons.pause,
                            ),
                            label: Text(
                              workoutPaused ? 'Devam Et' : 'Antrenmanı Durdur',
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: AppColors.buttonBackColor,
                              side: const BorderSide(color: Colors.white38),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                workoutStarted = false;
                                workoutPaused = false;
                              });
                            },
                            icon: const Icon(Icons.check),
                            label: const Text('Antrenmanı Bitir'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttonBackColor,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            color: surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: Colors.white12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      // VİDEO ALANI
                      Container(
                        width: 66,
                        height: 66,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.play_circle_outline,
                          color: Colors.yellow,
                          size: 36,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // HAREKET BİLGİLERİ
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hareket ${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '4 set × 12 tekrar',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '0/4 set tamamlandı',
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(Icons.expand_more, color: Colors.white70),
                    ],
                  ),

                  const Divider(color: Colors.white24, height: 24),

                  // AĞIRLIK BİLGİSİ
                  const Row(
                    children: [
                      Text(
                        'Ağırlık (kg)',
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(width: 12),
                      Text(
                        '20.0 kg',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // SET BUTONLARI
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(4, (setIndex) {
                        return FilterChip(
                          label: Text('Set ${setIndex + 1}'),
                          selected: false,
                          onSelected: null,
                          backgroundColor: const Color(0xFF363636),
                          disabledColor: const Color(0xFF363636),
                          selectedColor: Colors.yellow,
                          labelStyle: const TextStyle(color: Colors.white),
                          side: BorderSide.none,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
