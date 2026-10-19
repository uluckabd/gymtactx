import 'package:flutter/material.dart';

import 'myGym.dart'; // AppColors, AppSizes, AppStyles, AppIcon, AppText, AppCard, SectionTitle, AppBadge, InfoRow, StatCard, AppOutlinedButton

/* ===================== SAYFAYA ÖZEL SABİTLER ===================== */

class RankColors {
  static const gold = Color(0xFFFFD700);
  static const silver = Color(0xFFC0C0C0);
  static const bronze = Color(0xFFCD7F32);

  static Color? of(int rank) => switch (rank) {
        1 => gold,
        2 => silver,
        3 => bronze,
        _ => null,
      };
}

class AchievementSizes {
  static const rankBadge = 36.0;
}

class PointFormat {
  static String number(int value) => value
      .toString()
      .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '.');
}

/* ===================== MODELLER (API'DEN DOLACAK) ===================== */

class UserScore {
  final int points;
  final int rank;
  final int pointsToNextRank;
  final int completedWorkouts;
  final int streakDays;

  const UserScore({
    required this.points,
    required this.rank,
    required this.pointsToNextRank,
    required this.completedWorkouts,
    required this.streakDays,
  });

  double get progress => points / (points + pointsToNextRank);
}

class Competition {
  final String title;
  final String prize;
  final int participantCount;
  final DateTime endDate;
  final bool isJoined;

  const Competition({
    required this.title,
    required this.prize,
    required this.participantCount,
    required this.endDate,
    required this.isJoined,
  });

  int get remainingDays => endDate.difference(DateTime.now()).inDays;
}

class LeaderboardEntry {
  final int rank;
  final String name;
  final int points;
  final bool isMe;

  const LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.points,
    this.isMe = false,
  });
}

class Achievement {
  final IconData icon;
  final String title;
  final String description;
  final int rewardPoints;
  final int current;
  final int target;

  const Achievement({
    required this.icon,
    required this.title,
    required this.description,
    required this.rewardPoints,
    required this.current,
    required this.target,
  });

  bool get isUnlocked => current >= target;
  double get progress => (current / target).clamp(0.0, 1.0);
}

/* ===================== SAHTE VERİ ===================== */

class MockAchievementData {
  static const score = UserScore(
    points: 2450,
    rank: 4,
    pointsToNextRank: 655,
    completedWorkouts: 38,
    streakDays: 5,
  );

  static final competition = Competition(
    title: 'Ekim Ayı Yarışması',
    prize: '3 aylık Premium üyelik',
    participantCount: 86,
    endDate: DateTime(2026, 10, 31),
    isJoined: false,
  );

  static const leaderboard = [
    LeaderboardEntry(rank: 1, name: 'Burak Kaya', points: 3820),
    LeaderboardEntry(rank: 2, name: 'Zeynep Aydın', points: 3470),
    LeaderboardEntry(rank: 3, name: 'Emre Çelik', points: 3105),
    LeaderboardEntry(rank: 4, name: 'Ahmet Yıldız', points: 2450, isMe: true),
    LeaderboardEntry(rank: 5, name: 'Selin Koç', points: 2310),
  ];

  static const achievements = [
    Achievement(
      icon: Icons.flag_outlined,
      title: 'İlk Adım',
      description: 'İlk antrenmanını tamamla',
      rewardPoints: 50,
      current: 1,
      target: 1,
    ),
    Achievement(
      icon: Icons.local_fire_department_outlined,
      title: '7 Günlük Seri',
      description: '7 gün üst üste antrenman yap',
      rewardPoints: 150,
      current: 5,
      target: 7,
    ),
    Achievement(
      icon: Icons.fitness_center,
      title: '50 Antrenman',
      description: 'Toplam 50 antrenman tamamla',
      rewardPoints: 300,
      current: 38,
      target: 50,
    ),
    Achievement(
      icon: Icons.emoji_events_outlined,
      title: 'Salon Şampiyonu',
      description: 'Bir yarışmada ilk 3\'e gir',
      rewardPoints: 500,
      current: 0,
      target: 1,
    ),
  ];
}

/* ===================== SAYFAYA ÖZEL WIDGETLAR ===================== */

class AppFilledButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const AppFilledButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: AppSizes.buttonHeight,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusFull),
            ),
          ),
          child: Text(
            label,
            style: AppStyles.title.copyWith(color: AppColors.background),
          ),
        ),
      );
}

class AppProgressBar extends StatelessWidget {
  final double value;

  const AppProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        child: LinearProgressIndicator(
          value: value,
          minHeight: AppSizes.progressHeight,
          color: AppColors.primary,
          backgroundColor: AppColors.border,
        ),
      );
}

class RankBadge extends StatelessWidget {
  final int rank;

  const RankBadge({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    final medal = RankColors.of(rank);
    return Container(
      width: AchievementSizes.rankBadge,
      height: AchievementSizes.rankBadge,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: medal ?? AppColors.background,
        shape: BoxShape.circle,
        border: Border.all(
          color: medal ?? AppColors.border,
          width: AppSizes.borderWidth,
        ),
      ),
      child: Text(
        '$rank',
        style: AppStyles.title.copyWith(
          color: medal == null ? AppColors.text : AppColors.background,
        ),
      ),
    );
  }
}

/* ===================== BÖLÜM WIDGETLARI ===================== */

class ScoreCard extends StatelessWidget {
  final UserScore score;

  const ScoreCard({super.key, required this.score});

  @override
  Widget build(BuildContext context) => AppCard(
        borderColor: AppColors.primaryFaded,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText.caption('Toplam puanım'),
                AppBadge('Salonda #${score.rank}'),
              ],
            ),
            const SizedBox(height: AppSizes.gapS),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                AppText.display(PointFormat.number(score.points)),
                const SizedBox(width: AppSizes.gapS),
                const AppText.caption('puan'),
              ],
            ),
            const SizedBox(height: AppSizes.gapS),
            AppProgressBar(value: score.progress),
            const SizedBox(height: AppSizes.gapS),
            AppText.caption('Bir üst sıraya ${score.pointsToNextRank} puan kaldı'),
          ],
        ),
      );
}

class CompetitionCard extends StatelessWidget {
  final Competition competition;

  const CompetitionCard({super.key, required this.competition});

  @override
  Widget build(BuildContext context) => AppCard(
        borderColor: AppColors.primaryFaded,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.title(competition.title),
                const AppBadge('Aktif'),
              ],
            ),
            const SizedBox(height: AppSizes.gapM),
            InfoRow(icon: Icons.card_giftcard, text: 'Ödül: ${competition.prize}'),
            const SizedBox(height: AppSizes.gapS),
            InfoRow(icon: Icons.groups_outlined, text: '${competition.participantCount} katılımcı'),
            const SizedBox(height: AppSizes.gapS),
            InfoRow(icon: Icons.timer_outlined, text: '${competition.remainingDays} gün kaldı'),
            const SizedBox(height: AppSizes.gapL),
            AppFilledButton(
              label: competition.isJoined ? 'Yarışmaya Katıldın' : 'Yarışmaya Katıl',
              onPressed: () {},
            ),
          ],
        ),
      );
}

class LeaderboardTile extends StatelessWidget {
  final LeaderboardEntry entry;

  const LeaderboardTile({super.key, required this.entry});

  @override
  Widget build(BuildContext context) => AppCard(
        borderColor: entry.isMe ? AppColors.primary : AppColors.border,
        child: Row(
          children: [
            RankBadge(rank: entry.rank),
            const SizedBox(width: AppSizes.gapM),
            Expanded(child: AppText.title(entry.name)),
            if (entry.isMe) ...[
              const AppBadge('Sen'),
              const SizedBox(width: AppSizes.gapM),
            ],
            AppText.price('${PointFormat.number(entry.points)} p'),
          ],
        ),
      );
}

class AchievementCard extends StatelessWidget {
  final Achievement achievement;

  const AchievementCard({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    final unlocked = achievement.isUnlocked;
    return AppCard(
      borderColor: unlocked ? AppColors.primary : AppColors.border,
      child: Row(
        children: [
          Container(
            width: AppSizes.avatar,
            height: AppSizes.avatar,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
            ),
            child: AppIcon(
              achievement.icon,
              size: AppSizes.iconL,
              color: unlocked ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: AppSizes.gapM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.title(achievement.title),
                const SizedBox(height: AppSizes.gapXS),
                AppText.caption(achievement.description),
                if (!unlocked) ...[
                  const SizedBox(height: AppSizes.gapS),
                  AppProgressBar(value: achievement.progress),
                  const SizedBox(height: AppSizes.gapXS),
                  AppText.accent('${achievement.current}/${achievement.target}'),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSizes.gapM),
          unlocked
              ? AppBadge('+${achievement.rewardPoints}')
              : AppText.caption('+${achievement.rewardPoints}'),
        ],
      ),
    );
  }
}

/* ===================== SAYFA ===================== */

class MyAchievementsPage extends StatelessWidget {
  const MyAchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const score = MockAchievementData.score;
    final competition = MockAchievementData.competition;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const AppText.heading('Başarılarım'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(icon: Icons.stars_outlined, title: 'Puanım'),
            const SizedBox(height: AppSizes.gapM),
            const ScoreCard(score: score),
            const SizedBox(height: AppSizes.gapM),
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    icon: Icons.fitness_center,
                    value: '${score.completedWorkouts}',
                    label: 'Tamamlanan antrenman',
                  ),
                ),
                const SizedBox(width: AppSizes.gapM),
                Expanded(
                  child: StatCard(
                    icon: Icons.local_fire_department_outlined,
                    value: '${score.streakDays}',
                    label: 'Günlük seri',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.gapXL),

            const SectionTitle(icon: Icons.emoji_events_outlined, title: 'Yarışma'),
            const SizedBox(height: AppSizes.gapM),
            CompetitionCard(competition: competition),
            const SizedBox(height: AppSizes.gapXL),

            const SectionTitle(icon: Icons.leaderboard_outlined, title: 'Salon sıralaması'),
            const SizedBox(height: AppSizes.gapM),
            ...MockAchievementData.leaderboard.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.gapM),
                child: LeaderboardTile(entry: e),
              ),
            ),
            const SizedBox(height: AppSizes.gapS),

            const SectionTitle(icon: Icons.military_tech_outlined, title: 'Rozetlerim'),
            const SizedBox(height: AppSizes.gapM),
            ...MockAchievementData.achievements.map(
              (a) => Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.gapM),
                child: AchievementCard(achievement: a),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
