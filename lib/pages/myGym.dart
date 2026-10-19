import 'package:flutter/material.dart';
import 'package:gymtactx/constants/app_color.dart';

// Sample data. Replace these values with your gym's actual data later.
class GymInfo {
  final String name;
  final String location;
  final String phone;
  final String openingHours;
  final int memberCount;
  final DateTime membershipStart;
  final DateTime membershipEnd;
  final String membershipPlan;

  const GymInfo({
    required this.name,
    required this.location,
    required this.phone,
    required this.openingHours,
    required this.memberCount,
    required this.membershipStart,
    required this.membershipEnd,
    required this.membershipPlan,
  });
}

class GymPackage {
  final String name;
  final String duration;
  final String price;
  final String description;
  final bool highlighted;

  const GymPackage({
    required this.name,
    required this.duration,
    required this.price,
    required this.description,
    this.highlighted = false,
  });
}

class GymTrainer {
  final String name;
  final String specialty;
  final String experience;
  final IconData icon;

  const GymTrainer({
    required this.name,
    required this.specialty,
    required this.experience,
    this.icon = Icons.person_outline,
  });
}

class GymAnnouncement {
  final String title;
  final String description;
  final String date;

  const GymAnnouncement({
    required this.title,
    required this.description,
    required this.date,
  });
}

class MyGymPage extends StatelessWidget {
  const MyGymPage({super.key});

  static const Color _background = Colors.black;
  static const Color _surface = Color(0xFF202020);
  static const Color _yellow = AppColors.buttonBackColor;

  static final GymInfo _gym = GymInfo(
    name: 'GYMTACTX FITNESS CLUB',
    location: 'Merkez Şube · Konum bilgisi',
    phone: '+90 5XX XXX XX XX',
    openingHours: 'Hafta içi 07.00–23.00',
    memberCount: 1248,
    membershipStart: DateTime(2026, 9, 1),
    membershipEnd: DateTime(2027, 3, 1),
    membershipPlan: '6 Aylık Premium',
  );

  static const List<GymPackage> _packages = [
    GymPackage(
      name: 'Standart',
      duration: '1 Ay',
      price: '₺1.200',
      description: 'Fitness alanına erişim',
    ),
    GymPackage(
      name: 'Avantaj',
      duration: '3 Ay',
      price: '₺3.000',
      description: 'Fitness + grup dersleri',
      highlighted: true,
    ),
    GymPackage(
      name: 'Premium',
      duration: '12 Ay',
      price: '₺9.600',
      description: 'Tüm alanlar + özel avantajlar',
    ),
  ];

  static const List<GymTrainer> _trainers = [
    GymTrainer(
      name: 'Mert Yılmaz',
      specialty: 'Kuvvet ve kondisyon',
      experience: '6 yıl deneyim',
    ),
    GymTrainer(
      name: 'Ece Demir',
      specialty: 'Fonksiyonel antrenman',
      experience: '5 yıl deneyim',
    ),
    GymTrainer(
      name: 'Can Arslan',
      specialty: 'Vücut geliştirme',
      experience: '8 yıl deneyim',
    ),
  ];

  static const List<(IconData, String)> _amenities = [
    (Icons.shower_outlined, 'Duş'),
    (Icons.wifi, 'Wi-Fi'),
    (Icons.lock_outline, 'Dolap'),
    (Icons.local_parking_outlined, 'Otopark'),
    (Icons.groups_outlined, 'Grup dersleri'),
    (Icons.fitness_center, 'Serbest ağırlık'),
  ];

  static const List<GymAnnouncement> _announcements = [
    GymAnnouncement(
      title: 'Yeni grup dersleri',
      description: 'Güncel ders programını resepsiyondan öğrenebilirsiniz.',
      date: '12 Ekim',
    ),
    GymAnnouncement(
      title: 'Hafta sonu çalışma saatleri',
      description: 'Cumartesi ve pazar: 09.00–21.00.',
      date: '8 Ekim',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text(
          'Salonum',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: _background,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          GymHeroCard(gym: _gym),
          const SizedBox(height: 20),
          const GymSectionTitle(
            title: 'Üyeliğim',
            icon: Icons.workspace_premium_outlined,
          ),
          const SizedBox(height: 10),
          GymMembershipCard(gym: _gym),
          const SizedBox(height: 22),
          const GymSectionTitle(
            title: 'Salon istatistikleri',
            icon: Icons.bar_chart_outlined,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GymStatCard(
                  icon: Icons.people_alt_outlined,
                  value: '${_gym.memberCount}',
                  label: 'Toplam üye',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GymStatCard(
                  icon: Icons.sports_gymnastics,
                  value: '${_trainers.length}',
                  label: 'Antrenör',
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const GymSectionTitle(
            title: 'Üyelik paketleri',
            icon: Icons.sell_outlined,
          ),
          const SizedBox(height: 10),
          ..._packages.map(
            (package) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GymPackageCard(package: package),
            ),
          ),
          const SizedBox(height: 12),
          const GymSectionTitle(
            title: 'Antrenörlerimiz',
            icon: Icons.badge_outlined,
          ),
          const SizedBox(height: 10),
          ..._trainers.map(
            (trainer) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GymTrainerCard(trainer: trainer),
            ),
          ),
          const SizedBox(height: 12),
          const GymSectionTitle(
            title: 'Salon olanakları',
            icon: Icons.grid_view_outlined,
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _amenities
                .map(
                  (amenity) =>
                      GymAmenityChip(icon: amenity.$1, label: amenity.$2),
                )
                .toList(),
          ),
          const SizedBox(height: 22),
          const GymSectionTitle(
            title: 'Duyurular',
            icon: Icons.campaign_outlined,
          ),
          const SizedBox(height: 10),
          ..._announcements.map(
            (announcement) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GymAnnouncementCard(announcement: announcement),
            ),
          ),
          const SizedBox(height: 12),
          const GymSectionTitle(
            title: 'İletişim ve çalışma saatleri',
            icon: Icons.info_outline,
          ),
          const SizedBox(height: 10),
          GymContactCard(gym: _gym),
        ],
      ),
    );
  }
}

class GymSectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  const GymSectionTitle({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: AppColors.buttonBackColor, size: 21),
      const SizedBox(width: 8),
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

class GymPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;
  const GymPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: padding,
    decoration: BoxDecoration(
      color: const Color(0xFF202020),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderColor ?? Colors.white12),
    ),
    child: child,
  );
}

class GymHeroCard extends StatelessWidget {
  final GymInfo gym;
  const GymHeroCard({super.key, required this.gym});

  @override
  Widget build(BuildContext context) => Container(
    height: 180,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF343434), Color(0xFF111111)],
      ),
      border: Border.all(color: Colors.white24),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Align(
          alignment: Alignment.topRight,
          child: Icon(
            Icons.fitness_center,
            size: 48,
            color: AppColors.buttonBackColor,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SPOR SALONUM',
              style: TextStyle(
                color: AppColors.buttonBackColor,
                fontSize: 11,
                letterSpacing: 2,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              gym.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 15,
                  color: Colors.white70,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    gym.location,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

class GymMembershipCard extends StatelessWidget {
  final GymInfo gym;
  const GymMembershipCard({super.key, required this.gym});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final start = DateUtils.dateOnly(gym.membershipStart);
    final end = DateUtils.dateOnly(gym.membershipEnd);
    final current = DateUtils.dateOnly(today);
    final totalDays = end.difference(start).inDays;
    final elapsedDays = current.difference(start).inDays;
    final remainingDays = end.difference(current).inDays.clamp(0, 999999);
    final progress = totalDays > 0
        ? (elapsedDays / totalDays).clamp(0.0, 1.0)
        : 0.0;
    final status = current.isBefore(start)
        ? 'Henüz başlamadı'
        : current.isAfter(end)
        ? 'Süresi doldu'
        : 'Aktif';

    return GymPanel(
      borderColor: AppColors.buttonBackColor.withValues(alpha: 0.45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  gym.membershipPlan,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: AppColors.buttonBackColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _MembershipDate(label: 'Başlangıç', date: start),
              ),
              Expanded(
                child: _MembershipDate(label: 'Bitiş', date: end),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$remainingDays',
                style: const TextStyle(
                  color: AppColors.buttonBackColor,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 6, bottom: 7),
                child: Text(
                  'gün kaldı',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.white12,
            color: AppColors.buttonBackColor,
          ),
          const SizedBox(height: 8),
          const Text(
            'Üyelik süresi ilerlemesi',
            style: TextStyle(color: Colors.white54, fontSize: 11),
          ),
          const SizedBox(height: 16),

          const Divider(color: Colors.white24, height: 1),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                // Üyelik dondurma işlemi daha sonra eklenecek.
              },
              icon: const Icon(Icons.ac_unit, size: 20),
              label: const Text('Üyeliği Dondur'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.buttonBackColor,
                side: const BorderSide(color: AppColors.buttonBackColor),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MembershipDate extends StatelessWidget {
  final String label;
  final DateTime date;
  const _MembershipDate({required this.label, required this.date});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      const SizedBox(height: 5),
      Text(
        '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

class GymStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const GymStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) => GymPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.buttonBackColor, size: 26),
        const SizedBox(height: 12),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    ),
  );
}

class GymPackageCard extends StatelessWidget {
  final GymPackage package;
  const GymPackageCard({super.key, required this.package});

  @override
  Widget build(BuildContext context) => GymPanel(
    borderColor: package.highlighted ? AppColors.buttonBackColor : null,
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      package.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  if (package.highlighted) ...[
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.star,
                      color: AppColors.buttonBackColor,
                      size: 16,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 5),
              Text(
                '${package.duration} · ${package.description}',
                style: const TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          package.price,
          style: const TextStyle(
            color: AppColors.buttonBackColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

class GymTrainerCard extends StatelessWidget {
  final GymTrainer trainer;
  const GymTrainerCard({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) => GymPanel(
    child: Row(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(trainer.icon, color: AppColors.buttonBackColor, size: 32),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trainer.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                trainer.specialty,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 3),
              Text(
                trainer.experience,
                style: const TextStyle(
                  color: AppColors.buttonBackColor,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, color: Colors.white38),
      ],
    ),
  );
}

class GymAmenityChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const GymAmenityChip({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
    decoration: BoxDecoration(
      color: const Color(0xFF202020),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white12),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.buttonBackColor, size: 18),
        const SizedBox(width: 7),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    ),
  );
}

class GymAnnouncementCard extends StatelessWidget {
  final GymAnnouncement announcement;
  const GymAnnouncementCard({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) => GymPanel(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.notifications_none, color: AppColors.buttonBackColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      announcement.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    announcement.date,
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                announcement.description,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class GymContactCard extends StatelessWidget {
  final GymInfo gym;
  const GymContactCard({super.key, required this.gym});

  @override
  Widget build(BuildContext context) => GymPanel(
    child: Column(
      children: [
        _ContactLine(icon: Icons.location_on_outlined, value: gym.location),
        const SizedBox(height: 14),
        _ContactLine(icon: Icons.call_outlined, value: gym.phone),
        const SizedBox(height: 14),
        _ContactLine(icon: Icons.access_time, value: gym.openingHours),
      ],
    ),
  );
}

class _ContactLine extends StatelessWidget {
  final IconData icon;
  final String value;
  const _ContactLine({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: AppColors.buttonBackColor, size: 20),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ),
    ],
  );
}
