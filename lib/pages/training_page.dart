import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:gymtactx/constants/app_color.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});
  @override
  State<TrainingPage> createState() => _WorkoutPageState();
}

class Exercise {
  Exercise(this.name, this.reps, this.weight, this.restSeconds, int count)
    : sets = List<bool>.filled(count, false);
  final String name;
  final int reps;
  double weight;
  final int restSeconds;
  final List<bool> sets;
  int get completed => sets.where((value) => value).length;
}

class _WorkoutPageState extends State<TrainingPage> {
  bool workoutStarted = false;
  bool workoutPaused = false;

  static const surface = Color(0xFF222222);
  final exercises = <Exercise>[
    Exercise('Bench Press', 12, 40, 90, 4),
    Exercise('Incline Dumbbell Press', 10, 16, 90, 3),
    Exercise('Chest Fly', 12, 12, 60, 3),
    Exercise('Triceps Pushdown', 15, 20, 60, 3),
    Exercise('Overhead Extension', 12, 14, 60, 3),
    Exercise('Dips', 10, 0, 90, 3),
  ];
  Timer? ticker;
  int elapsed = 0;
  int restRemaining = 0;
  bool running = false;
  int selectedDay = 0;
  int expandedIndex = 0;

  int get totalSets => exercises.fold(0, (sum, e) => sum + e.sets.length);
  int get doneSets => exercises.fold(0, (sum, e) => sum + e.completed);
  double get progress => totalSets == 0 ? 0 : doneSets / totalSets;
  // Demo only: approximate energy expenditure using MET=4.5, weight=75 kg.
  double get estimatedKcal =>
      running || elapsed > 0 ? 4.5 * 3.5 * 75 / 200 * (elapsed / 60) : 0;

  @override
  void dispose() {
    ticker?.cancel();
    super.dispose();
  }

  void toggleTimer() {
    setState(() => running = !running);
    if (running) {
      ticker?.cancel();
      ticker = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() {
          elapsed++;
          if (restRemaining > 0) restRemaining--;
        });
      });
    } else {
      ticker?.cancel();
    }
  }

  String clock(int seconds) =>
      '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';

  void toggleSet(int exerciseIndex, int setIndex) {
    setState(() {
      final e = exercises[exerciseIndex];
      e.sets[setIndex] = !e.sets[setIndex];
      if (e.sets[setIndex]) restRemaining = e.restSeconds;
    });
  }

  void showVideoPlaceholder(String name) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: surface,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_outline,
                      size: 64,
                      color: AppColors.buttonBackground,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Video oynatıcı daha sonra bağlanacak.',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void finishWorkout() {
    ticker?.cancel();
    setState(() => running = false);
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: surface,
        title: const Text(
          'Antrenman Özeti',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Tamamlanan set: $doneSets/$totalSets\nSüre: ${clock(elapsed)}\nTahmini kalori: ${estimatedKcal.round()} kcal',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Kapat',
              style: TextStyle(color: AppColors.buttonBackground),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          'Antrenmanım',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.calendar_month,
              color: AppColors.buttonBackground,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: const BoxDecoration(
            color: surface,
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
                    label: const Text('Antrenmanı Başlat'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonBackground,
                      foregroundColor: Colors.black,
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
                        const Icon(
                          Icons.local_fire_department,
                          color: AppColors.buttonBackground,
                          size: 34,
                        ),
                        const SizedBox(width: 8),

                        // SOL: KALORİ
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'YAKILAN KALORİ',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                '0 kcal',
                                style: TextStyle(
                                  color: AppColors.buttonBackground,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // SAĞ: SÜRE
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'ANTRENMAN SÜRESİ',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
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
                      ],
                    ),

                    const SizedBox(height: 10),

                    // KALORİ İLERLEME ÇUBUĞU
                    LinearProgressIndicator(
                      value: 0,
                      minHeight: 7,
                      backgroundColor: Colors.white24,
                      color: AppColors.buttonBackground,
                      borderRadius: BorderRadius.circular(8),
                    ),

                    const SizedBox(height: 14),

                    // BUTONLAR
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
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
                              foregroundColor: Colors.white,
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
                              backgroundColor: AppColors.buttonBackground,
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'GÖĞÜS TRICEPS',
                  style: TextStyle(
                    color: AppColors.buttonBackground,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Güç Antrenmanı',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${exercises.length} hareket  •  $totalSets set',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Set ilerlemesi',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '$doneSets/$totalSets',
                      style: const TextStyle(color: AppColors.buttonBackground),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  color: AppColors.buttonBackground,
                  backgroundColor: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Hareketlerim',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(exercises.length, (index) {
            final e = exercises[index];
            final expanded = expandedIndex == index;
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              color: surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  color: e.completed == e.sets.length
                      ? AppColors.buttonBackground
                      : Colors.white12,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () =>
                          setState(() => expandedIndex = expanded ? -1 : index),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => showVideoPlaceholder(e.name),
                            child: Container(
                              width: 66,
                              height: 66,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.play_circle_outline,
                                color: AppColors.buttonBackground,
                                size: 36,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${e.sets.length} set × ${e.reps} tekrar',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${e.completed}/${e.sets.length} set tamamlandı',
                                  style: const TextStyle(
                                    color: AppColors.buttonBackground,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            expanded ? Icons.expand_less : Icons.expand_more,
                            color: Colors.white70,
                          ),
                        ],
                      ),
                    ),
                    if (expanded) ...[
                      const Divider(color: Colors.white24, height: 24),
                      Row(
                        children: [
                          const Text(
                            'Tavsiye edilen ağırlık',
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${e.weight.toStringAsFixed(1)} kg',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: List.generate(e.sets.length, (setIndex) {
                            final checked = e.sets[setIndex];
                            return FilterChip(
                              label: Text(
                                checked
                                    ? '✓ Set ${setIndex + 1}'
                                    : 'Set ${setIndex + 1}',
                              ),
                              selected: checked,
                              onSelected: (_) => toggleSet(index, setIndex),
                              selectedColor: AppColors.buttonBackground,
                              backgroundColor: const Color(0xFF363636),
                              labelStyle: TextStyle(
                                color: checked ? Colors.black : Colors.white,
                              ),
                              side: BorderSide.none,
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Dinlenme: ${e.restSeconds} sn',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
