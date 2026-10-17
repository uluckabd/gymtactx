import 'package:flutter/material.dart';
import 'package:gymtactx/constants/app_color.dart';

class Myprogram extends StatelessWidget {
  const Myprogram({super.key});

  // SADECE BU LİSTEYİ DÜZENLE
  static const List<Map<String, dynamic>> kategoriler = [
    {
      'kategori': 'Kuvvet Antrenmanı',
      'hareketler': [
        {'ad': 'Bench Press', 'set': 4, 'tekrar': 12},
        {'ad': 'Lat Pulldown', 'set': 3, 'tekrar': 12},
        {'ad': 'Squat', 'set': 4, 'tekrar': 10},
      ],
    },
    {
      'kategori': 'Kardiyo',
      'hareketler': [
        {'ad': 'Koşu Bandı', 'set': 1, 'tekrar': 20},
        {'ad': 'Bisiklet', 'set': 1, 'tekrar': 15},
      ],
    },
    {
      'kategori': 'Esneklik ve Mobilite',
      'hareketler': [
        {'ad': 'Stretching', 'set': 3, 'tekrar': 12},
      ],
    },
    {
      'kategori': 'Fonksiyonel Antrenman',
      'hareketler': [
        {'ad': 'Kettlebell Swing', 'set': 3, 'tekrar': 15},
      ],
    },
    {
      'kategori': 'HIIT',
      'hareketler': [
        {'ad': 'Burpee', 'set': 3, 'tekrar': 12},
        {'ad': 'Jumping Jack', 'set': 3, 'tekrar': 20},
      ],
    },
    {
      'kategori': 'Karın ve Core',
      'hareketler': [
        {'ad': 'Plank', 'set': 3, 'tekrar': 30},
        {'ad': 'Crunch', 'set': 3, 'tekrar': 15},
      ],
    },
    {
      'kategori': 'Vücut Ağırlığı',
      'hareketler': [
        {'ad': 'Push Up', 'set': 3, 'tekrar': 12},
        {'ad': 'Pull Up', 'set': 3, 'tekrar': 8},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Programım',
          style: TextStyle(color: AppColors.buttonBackColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: kategoriler.length,
        itemBuilder: (context, index) {
          final kategori = kategoriler[index];

          final String kategoriAdi = kategori['kategori'] as String;

          final List<Map<String, dynamic>> hareketler =
              List<Map<String, dynamic>>.from(kategori['hareketler']);

          return Card(
            key: ValueKey(kategoriAdi),
            margin: const EdgeInsets.only(bottom: 12),
            color: const Color(0xFF1C1C1C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: AppColors.buttonBackColor),
            ),
            clipBehavior: Clip.antiAlias,
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  kategoriAdi,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                iconColor: const Color(0xFFEFFF14),
                collapsedIconColor: Colors.white,
                tilePadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                childrenPadding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 12,
                ),
                children: [
                  const Divider(color: Colors.white12),

                  ...hareketler.map((hareket) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              hareket['ad'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          _bilgiKutusu(
                            '${hareket['set']} Set',
                            const Color(0xFFEFFF14),
                          ),
                          const SizedBox(width: 8),
                          _bilgiKutusu(
                            '${hareket['tekrar']} Tekrar',
                            Colors.white,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _bilgiKutusu(String yazi, Color renk) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF303030),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        yazi,
        style: TextStyle(
          color: renk,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
