import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Mymeasurements extends StatelessWidget {
  const Mymeasurements({super.key});

  static const List<Map<String, dynamic>> olcumler = [
    {
      'tarih': '2026-05-01',
      'kilo': 82.0,
      'bel': 94.0,
      'gogus': 98.0,
      'kol': 32.0,
      'bacak': 54.0,
      'kalca': 101.0,
    },
    {
      'tarih': '2026-06-01',
      'kilo': 80.5,
      'bel': 92.0,
      'gogus': 99.0,
      'kol': 33.0,
      'bacak': 55.0,
      'kalca': 100.0,
    },
    {
      'tarih': '2026-07-01',
      'kilo': 79.0,
      'bel': 90.0,
      'gogus': 100.0,
      'kol': 34.0,
      'bacak': 56.0,
      'kalca': 99.0,
    },
    {
      'tarih': '2026-08-01',
      'kilo': 77.5,
      'bel': 88.0,
      'gogus': 101.0,
      'kol': 34.5,
      'bacak': 56.5,
      'kalca': 98.0,
    },
    {
      'tarih': '2026-09-01',
      'kilo': 76.0,
      'bel': 86.0,
      'gogus': 102.0,
      'kol': 35.0,
      'bacak': 57.0,
      'kalca': 97.0,
    },
    {
      'tarih': '2026-10-01',
      'kilo': 75.0,
      'bel': 84.0,
      'gogus': 103.0,
      'kol': 35.5,
      'bacak': 57.5,
      'kalca': 96.0,
    },
  ];

  static const Color background = Colors.black;
  static const Color surface = Color(0xFF1C1C1C);
  static const Color yellow = Color(0xFFEFFF14);

  static const Map<String, String> kategoriler = {
    'kilo': 'Kilo',
    'bel': 'Bel',
    'gogus': 'Göğüs',
    'kol': 'Kol',
    'bacak': 'Bacak',
    'kalca': 'Kalça',
  };

  @override
  Widget build(BuildContext context) {
    final siraliOlcumler = [...olcumler];

    siraliOlcumler.sort(
      (a, b) => DateTime.parse(
        a['tarih'].toString(),
      ).compareTo(DateTime.parse(b['tarih'].toString())),
    );

    return DefaultTabController(
      length: kategoriler.length,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          title: const Text('Değişimim'),
          centerTitle: true,
          backgroundColor: background,
          foregroundColor: Colors.white,
          bottom: TabBar(
            isScrollable: false,
            tabAlignment: TabAlignment.fill,
            indicatorColor: yellow,
            labelColor: yellow,
            labelPadding: EdgeInsets.zero,
            unselectedLabelColor: Colors.white70,
            tabs: kategoriler.values
                .map((kategori) => Tab(text: kategori))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: kategoriler.entries.map((kategori) {
            return _grafikSayfasi(kategori.key, kategori.value, siraliOlcumler);
          }).toList(),
        ),
      ),
    );
  }

  Widget _grafikSayfasi(
    String alan,
    String baslik,
    List<Map<String, dynamic>> veriler,
  ) {
    final List<Map<String, dynamic>> gecerliVeriler = veriler.where((olcum) {
      return olcum[alan] is num;
    }).toList();

    if (gecerliVeriler.isEmpty) {
      return const Center(
        child: Text(
          'Henüz ölçüm eklenmemiş.',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    final List<double> degerler = gecerliVeriler
        .map((olcum) => (olcum[alan] as num).toDouble())
        .toList();

    final double ilk = degerler.first;
    final double son = degerler.last;
    final double fark = son - ilk;

    final String birim = alan == 'kilo' ? 'kg' : 'cm';

    final double enKucuk = degerler.reduce((a, b) => a < b ? a : b);

    final double enBuyuk = degerler.reduce((a, b) => a > b ? a : b);

    final double aralik = enBuyuk - enKucuk;
    final double bosluk = aralik == 0 ? 5 : aralik * 0.2;

    final double minY = enKucuk - bosluk;
    final double maxY = enBuyuk + bosluk;

    final List<FlSpot> noktalar = List.generate(
      degerler.length,
      (index) => FlSpot(index.toDouble(), degerler[index]),
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$baslik Değişimi',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '${son.toStringAsFixed(1)} $birim',
                    style: const TextStyle(
                      color: yellow,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${fark > 0 ? '+' : ''}'
                    '${fark.toStringAsFixed(1)} $birim',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // AYLIK DEĞİŞİM GRAFİĞİ
              SizedBox(
                height: 260,
                child: LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: noktalar.length > 1
                        ? (noktalar.length - 1).toDouble()
                        : 1,
                    minY: minY,
                    maxY: maxY,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) {
                        return const FlLine(
                          color: Colors.white12,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 42,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toStringAsFixed(0),
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 11,
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 35,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();

                            if (value != index.toDouble() ||
                                index < 0 ||
                                index >= gecerliVeriler.length) {
                              return const SizedBox.shrink();
                            }

                            final tarih = DateTime.parse(
                              gecerliVeriler[index]['tarih'].toString(),
                            );

                            const aylar = [
                              'Oca',
                              'Şub',
                              'Mar',
                              'Nis',
                              'May',
                              'Haz',
                              'Tem',
                              'Ağu',
                              'Eyl',
                              'Eki',
                              'Kas',
                              'Ara',
                            ];

                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                aylar[tarih.month - 1],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: noktalar,
                        isCurved: true,
                        color: yellow,
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, bar, index) {
                            return FlDotCirclePainter(
                              radius: 4,
                              color: yellow,
                              strokeColor: surface,
                              strokeWidth: 2,
                            );
                          },
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          color: yellow.withValues(alpha: 0.08),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // İLK VE SON ÖLÇÜM
        Row(
          children: [
            Expanded(
              child: _bilgiKarti(
                'İlk Ölçüm',
                '${ilk.toStringAsFixed(1)} $birim',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _bilgiKarti(
                'Son Ölçüm',
                '${son.toStringAsFixed(1)} $birim',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        const Text(
          'Ölçüm Geçmişi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // ÖLÇÜM GEÇMİŞİ
        ...gecerliVeriler.reversed.map((olcum) {
          final tarih = DateTime.parse(olcum['tarih'].toString());

          return Card(
            color: surface,
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(
                '${tarih.day.toString().padLeft(2, '0')}.'
                '${tarih.month.toString().padLeft(2, '0')}.'
                '${tarih.year}',
                style: const TextStyle(color: Colors.white),
              ),
              trailing: Text(
                '${(olcum[alan] as num).toStringAsFixed(1)} '
                '$birim',
                style: const TextStyle(
                  color: yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _bilgiKarti(String baslik, String deger) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            baslik,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            deger,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
