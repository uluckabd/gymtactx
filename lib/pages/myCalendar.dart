import 'package:flutter/material.dart';

class CalendarWorkout {
  final String id;
  final DateTime date;
  final String title;
  final String time;
  final List<CalendarExercise> exercises;
  final bool isCompleted;

  const CalendarWorkout({
    required this.id,
    required this.date,
    required this.title,
    required this.time,
    required this.exercises,
    this.isCompleted = false,
  });
}

class CalendarExercise {
  final String name;
  final int sets;
  final int reps;

  const CalendarExercise({
    required this.name,
    required this.sets,
    required this.reps,
  });
}

class Mycalendar extends StatefulWidget {
  const Mycalendar({super.key});

  @override
  State<Mycalendar> createState() => _MycalendarState();
}

class _MycalendarState extends State<Mycalendar> {
  static const yellow = Color(0xFFEFFF14);
  static const surface = Color(0xFF202126);

  DateTime selectedDay = DateUtils.dateOnly(DateTime.now());
  late DateTime focusedMonth = DateTime(selectedDay.year, selectedDay.month);

  bool showExercises = false;

  // API'den gelecek örnek antrenman verileri
  late final List<CalendarWorkout> workouts = [
    CalendarWorkout(
      id: 'workout_1',
      date: DateTime(2026, 10, 19),
      title: 'Göğüs & Triceps',
      time: '18:00',
      exercises: const [
        CalendarExercise(name: 'Bench Press', sets: 4, reps: 12),
        CalendarExercise(name: 'Incline Dumbbell Press', sets: 3, reps: 12),
        CalendarExercise(name: 'Cable Fly', sets: 3, reps: 15),
        CalendarExercise(name: 'Triceps Pushdown', sets: 3, reps: 12),
      ],
    ),
    CalendarWorkout(
      id: 'workout_2',
      date: DateTime(2026, 10, 20),
      title: 'Sırt & Biceps',
      time: '18:00',
      exercises: const [
        CalendarExercise(name: 'Lat Pulldown', sets: 4, reps: 12),
        CalendarExercise(name: 'Seated Row', sets: 3, reps: 12),
        CalendarExercise(name: 'Barbell Curl', sets: 3, reps: 10),
      ],
    ),
    CalendarWorkout(
      id: 'workout_3',
      date: DateTime(2026, 10, 22),
      title: 'Bacak & Omuz',
      time: '17:30',
      exercises: const [
        CalendarExercise(name: 'Squat', sets: 4, reps: 10),
        CalendarExercise(name: 'Leg Press', sets: 3, reps: 12),
        CalendarExercise(name: 'Shoulder Press', sets: 3, reps: 12),
      ],
    ),
  ];

  bool isSameDay(DateTime a, DateTime b) {
    return DateUtils.isSameDay(a, b);
  }

  List<CalendarWorkout> workoutsForDay(DateTime day) {
    return workouts.where((workout) => isSameDay(workout.date, day)).toList();
  }

  void changeMonth(int offset) {
    setState(() {
      focusedMonth = DateTime(focusedMonth.year, focusedMonth.month + offset);
      selectedDay = focusedMonth;
      showExercises = false;
    });
  }

  String get monthTitle {
    const months = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık',
    ];

    return '${months[focusedMonth.month - 1]} ${focusedMonth.year}';
  }

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(focusedMonth.year, focusedMonth.month);

    final daysInMonth = DateUtils.getDaysInMonth(
      focusedMonth.year,
      focusedMonth.month,
    );

    final leadingDays = firstDay.weekday - 1;
    final cellCount = ((leadingDays + daysInMonth + 6) ~/ 7) * 7;

    final selectedWorkouts = workoutsForDay(selectedDay);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Takvimim',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // TAKVİM
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white24),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        monthTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => changeMonth(-1),
                            icon: const Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () => changeMonth(1),
                            icon: const Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // HAFTANIN GÜNLERİ
                  Row(
                    children: ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz']
                        .map((day) {
                          return Expanded(
                            child: Center(
                              child: Text(
                                day,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        })
                        .toList(),
                  ),

                  const SizedBox(height: 12),

                  // TAKVİM GÜNLERİ
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 4,
                          childAspectRatio: 1,
                        ),
                    itemCount: cellCount,
                    itemBuilder: (context, index) {
                      final dayNumber = index - leadingDays + 1;

                      if (dayNumber < 1 || dayNumber > daysInMonth) {
                        return const SizedBox.shrink();
                      }

                      final date = DateTime(
                        focusedMonth.year,
                        focusedMonth.month,
                        dayNumber,
                      );

                      final isSelected = isSameDay(date, selectedDay);

                      final hasWorkout = workoutsForDay(date).isNotEmpty;

                      return InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          setState(() {
                            selectedDay = date;
                            showExercises = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? yellow : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$dayNumber',
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: hasWorkout
                                      ? (isSelected ? Colors.black : yellow)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      Icon(Icons.circle, size: 8, color: yellow),
                      SizedBox(width: 8),
                      Text(
                        'Antrenman günü',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // SEÇİLEN GÜN
            Text(
              '${selectedDay.day}.${selectedDay.month}.${selectedDay.year} Programı',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            if (selectedWorkouts.isEmpty)
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.self_improvement, color: yellow, size: 44),
                    SizedBox(height: 12),
                    Text(
                      'Dinlenme Günü',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Bu gün için planlanmış bir antrenman bulunmuyor.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              )
            else
              ...selectedWorkouts.map(
                (workout) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.fitness_center,
                            color: yellow,
                            size: 30,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  workout.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${workout.time} • ${workout.exercises.length} hareket',
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (workout.isCompleted)
                            const Icon(Icons.check_circle, color: yellow),
                        ],
                      ),

                      if (showExercises) ...[
                        const SizedBox(height: 16),
                        const Divider(color: Colors.white12),
                        ...workout.exercises.map(
                          (exercise) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  size: 7,
                                  color: yellow,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    exercise.name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                Text(
                                  '${exercise.sets} x ${exercise.reps}',
                                  style: const TextStyle(
                                    color: yellow,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 18),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: yellow,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              showExercises = !showExercises;
                            });
                          },
                          child: Text(
                            showExercises
                                ? 'Hareketleri Gizle'
                                : 'Programı Görüntüle',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
