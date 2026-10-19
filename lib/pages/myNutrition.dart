import 'package:flutter/material.dart';

class FoodItem {
  final String id;
  final String name;
  final String amount;
  final int calories;
  bool isCompleted;

  FoodItem({
    required this.id,
    required this.name,
    required this.amount,
    required this.calories,
    this.isCompleted = false,
  });
}

class DietMeal {
  final String id;
  final String title;
  final String time;
  final IconData icon;
  final List<FoodItem> foods;

  DietMeal({
    required this.id,
    required this.title,
    required this.time,
    required this.icon,
    required this.foods,
  });
}

class Mynutrition extends StatefulWidget {
  const Mynutrition({super.key});

  @override
  State<Mynutrition> createState() => _MynutritionState();
}

class _MynutritionState extends State<Mynutrition> {
  int expandedIndex = 0;

  // API'den gelecek örnek günlük diyet programı
  final List<DietMeal> meals = [
    DietMeal(
      id: 'meal_1',
      title: 'Kahvaltı',
      time: '08:00',
      icon: Icons.wb_sunny_outlined,
      foods: [
        FoodItem(
          id: 'food_1',
          name: 'Haşlanmış yumurta',
          amount: '2 adet',
          calories: 156,
        ),
        FoodItem(
          id: 'food_2',
          name: 'Tam buğday ekmeği',
          amount: '2 dilim',
          calories: 140,
        ),
        FoodItem(
          id: 'food_3',
          name: 'Beyaz peynir',
          amount: '50 gram',
          calories: 130,
        ),
      ],
    ),
    DietMeal(
      id: 'meal_2',
      title: 'Ara Öğün',
      time: '10:30',
      icon: Icons.apple_outlined,
      foods: [
        FoodItem(id: 'food_4', name: 'Muz', amount: '1 adet', calories: 105),
        FoodItem(
          id: 'food_5',
          name: 'Çiğ badem',
          amount: '30 gram',
          calories: 175,
        ),
      ],
    ),
    DietMeal(
      id: 'meal_3',
      title: 'Öğle Yemeği',
      time: '13:00',
      icon: Icons.restaurant_outlined,
      foods: [
        FoodItem(
          id: 'food_6',
          name: 'Izgara tavuk',
          amount: '150 gram',
          calories: 250,
        ),
        FoodItem(
          id: 'food_7',
          name: 'Bulgur pilavı',
          amount: '150 gram',
          calories: 180,
        ),
        FoodItem(
          id: 'food_8',
          name: 'Mevsim salatası',
          amount: '1 porsiyon',
          calories: 70,
        ),
      ],
    ),
    DietMeal(
      id: 'meal_4',
      title: 'Ara Öğün',
      time: '16:00',
      icon: Icons.local_cafe_outlined,
      foods: [
        FoodItem(
          id: 'food_9',
          name: 'Yoğurt',
          amount: '200 gram',
          calories: 120,
        ),
        FoodItem(id: 'food_10', name: 'Elma', amount: '1 adet', calories: 95),
      ],
    ),
    DietMeal(
      id: 'meal_5',
      title: 'Akşam Yemeği',
      time: '19:00',
      icon: Icons.dinner_dining_outlined,
      foods: [
        FoodItem(
          id: 'food_11',
          name: 'Izgara balık',
          amount: '150 gram',
          calories: 280,
        ),
        FoodItem(
          id: 'food_12',
          name: 'Haşlanmış sebze',
          amount: '1 porsiyon',
          calories: 100,
        ),
      ],
    ),
  ];

  List<FoodItem> get allFoods => meals.expand((meal) => meal.foods).toList();

  int get totalCalories => allFoods.fold(0, (sum, food) => sum + food.calories);

  int get consumedCalories => allFoods
      .where((food) => food.isCompleted)
      .fold(0, (sum, food) => sum + food.calories);

  int get completedFoods => allFoods.where((food) => food.isCompleted).length;

  double get progress =>
      allFoods.isEmpty ? 0 : completedFoods / allFoods.length;

  int get completedMeals => meals
      .where(
        (meal) =>
            meal.foods.isNotEmpty &&
            meal.foods.every((food) => food.isCompleted),
      )
      .length;

  void toggleFood(FoodItem food) {
    setState(() {
      food.isCompleted = !food.isCompleted;
    });

    // TODO: API'ye tüketim durumunu kaydet.
  }

  @override
  @override
  Widget build(BuildContext context) {
    const yellow = Color(0xFFEFFF14);
    const surface = Color(0xFF202126);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Beslenme Programım',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // GÜNLÜK KALORİ VE İLERLEME ALANI
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: surface,
                border: Border(bottom: BorderSide(color: Colors.white24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'GÜNLÜK BESLENME TAKİBİ',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: 105,
                        height: 105,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox.expand(
                              child: CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 9,
                                backgroundColor: Colors.white12,
                                color: yellow,
                              ),
                            ),
                            Text(
                              '${(progress * 100).round()}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tüketilen Kalori',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$consumedCalories / $totalCalories kcal',
                              style: const TextStyle(
                                color: yellow,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            LinearProgressIndicator(
                              value: totalCalories == 0
                                  ? 0
                                  : consumedCalories / totalCalories,
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(10),
                              backgroundColor: Colors.white12,
                              color: yellow,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '$completedMeals / ${meals.length} öğün tamamlandı',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ÖĞÜNLER BAŞLIĞI
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Günlük Öğünlerim',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${meals.length} Öğün',
                    style: const TextStyle(color: yellow, fontSize: 13),
                  ),
                ],
              ),
            ),

            // SAYFANIN KALANINI KAPLAYAN ÖĞÜNLER
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                itemCount: meals.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  final expanded = expandedIndex == index;

                  final mealCalories = meal.foods.fold<int>(
                    0,
                    (sum, food) => sum + food.calories,
                  );

                  final mealConsumed = meal.foods
                      .where((food) => food.isCompleted)
                      .fold<int>(0, (sum, food) => sum + food.calories);

                  final completedCount = meal.foods
                      .where((food) => food.isCompleted)
                      .length;

                  final mealProgress = meal.foods.isEmpty
                      ? 0.0
                      : completedCount / meal.foods.length;

                  final isMealCompleted =
                      meal.foods.isNotEmpty && mealProgress == 1;

                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: surface,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isMealCompleted ? yellow : Colors.white24,
                      ),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () {
                            setState(() {
                              expandedIndex = expanded ? -1 : index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(meal.icon, color: yellow, size: 28),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            meal.title,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '${meal.time} • $mealCalories kcal',
                                            style: const TextStyle(
                                              color: Colors.white54,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isMealCompleted)
                                      const Icon(
                                        Icons.check_circle,
                                        color: yellow,
                                      )
                                    else
                                      Icon(
                                        expanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: Colors.white70,
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                LinearProgressIndicator(
                                  value: mealProgress,
                                  minHeight: 6,
                                  borderRadius: BorderRadius.circular(10),
                                  backgroundColor: Colors.white12,
                                  color: yellow,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '$completedCount / ${meal.foods.length} tamamlandı',
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      '$mealConsumed / $mealCalories kcal',
                                      style: const TextStyle(
                                        color: yellow,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // AÇILAN YİYECEK LİSTESİ
                        if (expanded) ...[
                          const Divider(color: Colors.white12, height: 1),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Column(
                              children: meal.foods.map((food) {
                                return CheckboxListTile(
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  activeColor: yellow,
                                  checkColor: Colors.black,
                                  value: food.isCompleted,
                                  onChanged: (_) => toggleFood(food),
                                  title: Text(
                                    food.name,
                                    style: TextStyle(
                                      color: food.isCompleted
                                          ? Colors.white54
                                          : Colors.white,
                                      fontSize: 14,
                                      decoration: food.isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                      decorationColor: Colors.white54,
                                    ),
                                  ),
                                  subtitle: Text(
                                    food.amount,
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                  secondary: Text(
                                    '${food.calories} kcal',
                                    style: const TextStyle(
                                      color: yellow,
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
